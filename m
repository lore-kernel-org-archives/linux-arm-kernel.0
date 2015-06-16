From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Jun 2015 09:58:51 +0200
Subject: [PATCH 2/2] ARM: ep93xx: enable SIM.ONE MMC/SD hardware
Message-ID: <1434441531-18647-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SIM.ONE has a MMC card connected to the SPI host. This card
usually hosts an EXT4 root file system. Enable these options in
the defconfig so the default ompiled kernel will work
out-of-the-box.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/ep93xx_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/ep93xx_defconfig b/arch/arm/configs/ep93xx_defconfig
index 7838cb8919e6..b3c32d0d4573 100644
--- a/arch/arm/configs/ep93xx_defconfig
+++ b/arch/arm/configs/ep93xx_defconfig
@@ -85,6 +85,8 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_DEBUG_CORE=y
 CONFIG_I2C_DEBUG_ALGO=y
 CONFIG_I2C_DEBUG_BUS=y
+CONFIG_SPI=y
+CONFIG_SPI_EP93XX=y
 CONFIG_WATCHDOG=y
 CONFIG_EP93XX_WATCHDOG=y
 CONFIG_USB=y
@@ -95,6 +97,8 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_SERIAL=y
 CONFIG_USB_SERIAL_CONSOLE=y
 CONFIG_USB_SERIAL_PL2303=y
+CONFIG_MMC=y
+CONFIG_MMC_SPI=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_M48T86=y
@@ -102,6 +106,7 @@ CONFIG_RTC_DRV_EP93XX=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
+CONFIG_EXT4_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
-- 
1.9.3
