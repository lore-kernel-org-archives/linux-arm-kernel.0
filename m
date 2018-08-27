From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Aug 2018 15:27:08 +0200
Subject: [PATCH] ARM: defconfig: Update the ARM Versatile defconfig
Message-ID: <20180827132708.31446-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates the ARM Versatile defconfig to the latest
Kconfig structural changes and adds the DUMB VGA bridge
driver so that VGA works out of the box, e.g. with QEMU.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks:
Please apply this directly wherever post-mergewindow
defconfig changes should go.
---
 arch/arm/configs/versatile_defconfig | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/versatile_defconfig b/arch/arm/configs/versatile_defconfig
index df68dc4056e5..5282324c7cef 100644
--- a/arch/arm/configs/versatile_defconfig
+++ b/arch/arm/configs/versatile_defconfig
@@ -5,19 +5,19 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_PARTITION_ADVANCED=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_VERSATILE=y
 CONFIG_AEABI=y
 CONFIG_OABI_COMPAT=y
-CONFIG_CMA=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=1f03 mem=32M"
 CONFIG_FPE_NWFPE=y
 CONFIG_VFP=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_CMA=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -59,6 +59,7 @@ CONFIG_GPIO_PL061=y
 CONFIG_DRM=y
 CONFIG_DRM_PANEL_ARM_VERSATILE=y
 CONFIG_DRM_PANEL_SIMPLE=y
+CONFIG_DRM_DUMB_VGA_DAC=y
 CONFIG_DRM_PL111=y
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
@@ -89,9 +90,10 @@ CONFIG_NFSD=y
 CONFIG_NFSD_V3=y
 CONFIG_NLS_CODEPAGE_850=m
 CONFIG_NLS_ISO8859_1=m
+CONFIG_FONTS=y
+CONFIG_FONT_ACORN_8x8=y
+CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
-CONFIG_FONTS=y
-CONFIG_FONT_ACORN_8x8=y
-- 
2.17.1
