From: eric.miao@canonical.com (Eric Miao)
Date: Thu,  3 Jun 2010 15:36:50 +0800
Subject: [PATCH 2/5] [ARM] Remove unused INITRD_PHYS from
	arch/arm/boot/compressed
In-Reply-To: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
Message-ID: <1275550613-9553-3-git-send-email-eric.miao@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Original patch from Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/boot/compressed/Makefile |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index b58a589..dbd3fe8 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -79,16 +79,11 @@ endif
 EXTRA_CFLAGS  := -fpic -fno-builtin
 EXTRA_AFLAGS  := -Wa,-march=all
 
-# Supply ZRELADDR, INITRD_PHYS to the decompressor via
-# linker symbols.  We only define initrd_phys if the
-# machine class defined the corresponding makefile variable.
+# Supply ZRELADDR to the decompressor via linker symbols.
 LDFLAGS_vmlinux := --defsym zreladdr=$(ZRELADDR)
 ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux += --be8
 endif
-ifneq ($(INITRD_PHYS),)
-LDFLAGS_vmlinux += --defsym initrd_phys=$(INITRD_PHYS)
-endif
 # ?
 LDFLAGS_vmlinux += -p
 # Report unresolved symbol references
-- 
1.7.0.4
