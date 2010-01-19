From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 19 Jan 2010 09:43:41 +0100
Subject: [PATCH] arm: don't define unused symbol initrd_phys for zImage
In-Reply-To: <20100119083803.GA17904@pengutronix.de>
References: <20100119083803.GA17904@pengutronix.de>
Message-ID: <1263890623-14952-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only user of initrd_phys is arch/arm/boot/bootp/init.S which still
gets the value passed to.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/compressed/Makefile |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 2d4d88b..470adae 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -78,16 +78,13 @@ endif
 EXTRA_CFLAGS  := -fpic -fno-builtin
 EXTRA_AFLAGS  := -Wa,-march=all
 
-# Supply ZRELADDR, INITRD_PHYS and PARAMS_PHYS to the decompressor via
-# linker symbols.  We only define initrd_phys and params_phys if the
-# machine class defined the corresponding makefile variable.
+# Supply ZRELADDR and PARAMS_PHYS to the decompressor via linker symbols.  We
+# only define params_phys if the machine class defined the corresponding
+# makefile variable.
 LDFLAGS_vmlinux := --defsym zreladdr=$(ZRELADDR)
 ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux += --be8
 endif
-ifneq ($(INITRD_PHYS),)
-LDFLAGS_vmlinux += --defsym initrd_phys=$(INITRD_PHYS)
-endif
 ifneq ($(PARAMS_PHYS),)
 LDFLAGS_vmlinux += --defsym params_phys=$(PARAMS_PHYS)
 endif
-- 
1.6.6
