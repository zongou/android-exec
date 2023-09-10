PREFIX := /system
BASE_DIR := /data/data/com.termux/files
CFLAGS += -Wall -Wextra -Werror -Oz

libandroid-exec.so: android-exec.c
	$(CC) $(CFLAGS) $(LDFLAGS) android-exec.c -DPREFIX=\"$(PREFIX)\" -DBASE_DIR=\"$(BASE_DIR)\" -shared -fPIC -o libandroid-exec.so

install: libandroid-exec.so
	install libandroid-exec.so $(DESTDIR)$(PREFIX)/lib/libandroid-exec.so

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/lib/libandroid-exec.so

test: libandroid-exec.so
	@LD_PRELOAD=${CURDIR}/libandroid-exec.so ./run-tests.sh

clean:
	rm -f libandroid-exec.so tests/*-actual

.PHONY: clean install test uninstall
