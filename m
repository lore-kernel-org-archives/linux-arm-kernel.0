From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 16 May 2013 20:49:28 -0600
Subject: [PATCH] ARM: bcm2835: enable CONFIG_LEDS_GPIO
Message-ID: <1368758969-26339-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable CONFIG_LEDS_GPIO and all options required to enable it, or make
the option useful.

This patch also regenerated bcm2835_defconfig, which removes two HW_RANDOM
entries, since they're enabled by default.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 arch/arm/configs/bcm2835_defconfig |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index ce98721..898c030 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -61,8 +61,6 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_TTY_PRINTK=y
-CONFIG_HW_RANDOM=y
-CONFIG_HW_RANDOM_BCM2835=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_BCM2835=y
@@ -75,6 +73,18 @@ CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_BCM2835=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_TIMER=y
+CONFIG_LEDS_TRIGGER_ONESHOT=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_LEDS_TRIGGER_CPU=y
+CONFIG_LEDS_TRIGGER_GPIO=y
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
+CONFIG_LEDS_TRIGGER_TRANSIENT=y
+CONFIG_LEDS_TRIGGER_CAMERA=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
-- 
1.7.10.4
