From: vince@kyllikki.org (Vincent Sanders)
Date: Mon, 13 Sep 2010 16:13:48 +0100
Subject: [PATCH 5/9] Remove unused omap generic 2420 default configuration
In-Reply-To: <1284390832-7181-1-git-send-email-vince@kyllikki.org>
References: <1284390832-7181-1-git-send-email-vince@kyllikki.org>
Message-ID: <1284390832-7181-6-git-send-email-vince@kyllikki.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vincent Sanders <vince@simtec.co.uk>

The omap_generic_2420 default configuration has not built throughout
the 2.6.36 series (since 2.6.35-git1). The link has failed with

arch/arm/plat-omap/built-in.o: In function `newled_init':
/var/tmp/kernel-orig/arch/arm/plat-omap/debug-leds.c:249: undefined reference to `led_classdev_register'

In addition there is a modpost warning about six section mismatches

This configuration appers to be unused by the maintainer so remove it.

Signed-off-by: Vincent Sanders <vince@kyllikki.org>
---
 arch/arm/configs/omap_generic_2420_defconfig |   37 --------------------------
 1 files changed, 0 insertions(+), 37 deletions(-)
 delete mode 100644 arch/arm/configs/omap_generic_2420_defconfig

diff --git a/arch/arm/configs/omap_generic_2420_defconfig b/arch/arm/configs/omap_generic_2420_defconfig
deleted file mode 100644
index ac08e51..0000000
--- a/arch/arm/configs/omap_generic_2420_defconfig
+++ /dev/null
@@ -1,37 +0,0 @@
-CONFIG_EXPERIMENTAL=y
-CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_OMAP=y
-CONFIG_ARCH_OMAP2=y
-# CONFIG_OMAP_MUX is not set
-CONFIG_MACH_OMAP_GENERIC=y
-CONFIG_ARCH_OMAP2420=y
-CONFIG_LEDS=y
-CONFIG_ZBOOT_ROM_TEXT=0x10C08000
-CONFIG_ZBOOT_ROM_BSS=0x10200000
-CONFIG_FPE_NWFPE=y
-CONFIG_BLK_DEV_RAM=y
-CONFIG_INPUT_EVDEV=y
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-# CONFIG_LEGACY_PTYS is not set
-CONFIG_WATCHDOG=y
-CONFIG_WATCHDOG_NOWAYOUT=y
-CONFIG_VIDEO_OUTPUT_CONTROL=m
-# CONFIG_VGA_CONSOLE is not set
-CONFIG_EXT2_FS=y
-CONFIG_EXT2_FS_XATTR=y
-CONFIG_INOTIFY=y
-CONFIG_ROMFS_FS=y
-CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_ERRORS=y
-CONFIG_DEBUG_LL=y
-CONFIG_CRC_CCITT=y
-- 
1.7.0.4
