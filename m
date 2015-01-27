From: mpeg.blue@free.fr (Mason)
Date: Tue, 27 Jan 2015 10:44:41 +0100
Subject: Embedded white space in out-of-tree module full pathname
Message-ID: <54C75E09.6050002@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'd like some confirmation that this is either not supported, or that
I'm doing something obviously wrong. (Kernel 3.14 if it matters.)

Suppose the source code for an out-of-tree kernel module is stored e.g.
in "/tmp/foo bar/module" (note the embedded space in the path name)

Here is the Makefile template I'm using. (Maybe it's wrong.)

/tmp/foo bar/module$ cat Makefile
KDIR          ?= /home/mason/linux-3.14
ARCH          ?= arm
CROSS_COMPILE ?= arm-none-linux-gnueabi-

obj-m += mytest.o

all:
	make -C $(KDIR) M="$$PWD"

clean:
	make -C $(KDIR) M="$$PWD" clean

/tmp/foo bar/module$ make
make -C /home/mason/linux-3.14 M="$PWD"
make[1]: Entering directory `/home/mason/linux-3.14'
scripts/Makefile.build:44: /tmp/foo/Makefile: No such file or directory
make[2]: *** No rule to make target `/tmp/foo/Makefile'.  Stop.
make[1]: *** [_module_/tmp/foo] Error 2
make[1]: Leaving directory `/home/mason/linux-3.14'
make: *** [all] Error 2


Does the kernel build system support building an out-of-tree module whose
full pathname contains embedded white space, like in my example?

Do I have an obvious mistake in my Makefile?

Regards.
