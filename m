From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 27 Jul 2010 18:29:21 +0900
Subject: [PATCH] ARM: clean files in arch/arm/boot/compressed/
Message-ID: <20100727092921.3620.51711.sendpatchset@t400s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Update the compressed boot Makefile for ARM to
remove files during clean.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Perhaps there is a better way to do this?

 arch/arm/boot/compressed/Makefile |    3 +++
 1 file changed, 3 insertions(+)

--- 0001/arch/arm/boot/compressed/Makefile
+++ work/arch/arm/boot/compressed/Makefile	2010-07-27 18:18:19.000000000 +0900
@@ -67,6 +67,9 @@ targets       := vmlinux vmlinux.lds \
 		 piggy.$(suffix_y) piggy.$(suffix_y).o \
 		 font.o font.c head.o misc.o $(OBJS)
 
+# Make sure files are removed during clean
+extra-y       += piggy.gzip piggy.lzo piggy.lzma lib1funcs.S
+
 ifeq ($(CONFIG_FUNCTION_TRACER),y)
 ORIG_CFLAGS := $(KBUILD_CFLAGS)
 KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
