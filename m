From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Jul 2015 14:29:18 +0200
Subject: [PATCH] ARM: integrator: add some defconfig options
Message-ID: <1438172958-11800-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The integrator needs syscon LEDs, physmap MTD and we might
as well throw in EXT4, as this is nice to have for MMC/SD
card rootfs.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/integrator_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/integrator_defconfig b/arch/arm/configs/integrator_defconfig
index 71f14675d009..c2e4526827db 100644
--- a/arch/arm/configs/integrator_defconfig
+++ b/arch/arm/configs/integrator_defconfig
@@ -51,7 +51,7 @@ CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_ADV_OPTIONS=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_PHYSMAP=y
-CONFIG_PROC_DEVICETREE=y
+CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
@@ -71,12 +71,14 @@ CONFIG_MMC=y
 CONFIG_MMC_ARMMMCI=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_SYSCON=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_PL030=y
 CONFIG_EXT2_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
-- 
2.4.3
