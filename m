From: mfm@muteddisk.com (matt mooney)
Date: Wed, 22 Sep 2010 23:50:18 -0700
Subject: [PATCH 04/20] arm: change to new flag variables
Message-ID: <1285224618-29564-1-git-send-email-mfm@muteddisk.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace EXTRA_CFLAGS with ccflags-y and EXTRA_AFLAGS with asflags-y.

Signed-off-by: matt mooney <mfm@muteddisk.com>
---
 arch/arm/boot/compressed/Makefile |    4 ++--
 arch/arm/vfp/Makefile             |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index b23f6bc..9ba5726 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -76,8 +76,8 @@ ORIG_CFLAGS := $(KBUILD_CFLAGS)
 KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
 endif
 
-EXTRA_CFLAGS  := -fpic -fno-builtin
-EXTRA_AFLAGS  := -Wa,-march=all
+ccflags-y := -fpic -fno-builtin
+asflags-y := -Wa,-march=all
 
 # Supply ZRELADDR to the decompressor via a linker symbol.
 ifneq ($(CONFIG_AUTO_ZRELADDR),y)
diff --git a/arch/arm/vfp/Makefile b/arch/arm/vfp/Makefile
index 39f6d8e..6de73aa 100644
--- a/arch/arm/vfp/Makefile
+++ b/arch/arm/vfp/Makefile
@@ -4,8 +4,8 @@
 # Copyright (C) 2001 ARM Limited
 #
 
-# EXTRA_CFLAGS := -DDEBUG
-# EXTRA_AFLAGS := -DDEBUG
+# ccflags-y := -DDEBUG
+# asflags-y := -DDEBUG
 
 KBUILD_AFLAGS	:=$(KBUILD_AFLAGS:-msoft-float=-Wa,-mfpu=softvfp+vfp)
 LDFLAGS		+=--no-warn-mismatch
-- 
1.7.2.1
