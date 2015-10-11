From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 11 Oct 2015 22:40:41 +0200
Subject: [PATCH] ARM: configs: update lpc18xx defconfig
Message-ID: <1444596042-31904-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Enable SPIFI Flash and JFFS2 to support rootfs on Flash memory
- Enable USB Phy, mass storage and SCSI to support USB memory
- Enable PCF857x and JC42 I2C devices found on Hitex board
- Enable PL172 to support memory mapped NOR Flash
- New LPC18xx drivers: I2C, Watchdog, SCT PWM and RTC

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
Hi arm-soc team,

Please apply this single defconfig update for lpc18xx to
arm-soc/defconfig for v4.4.

 arch/arm/configs/lpc18xx_defconfig | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index 1c47f86c3970..b758a808d310 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -52,15 +52,22 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_FW_LOADER is not set
 CONFIG_MTD=y
+CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_STAA=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_MTD_SPI_NOR=y
+# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
+CONFIG_SPI_NXP_SPIFI=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_SRAM=y
 CONFIG_EEPROM_AT24=y
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+# CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_ARC is not set
 # CONFIG_NET_CADENCE is not set
@@ -102,14 +109,17 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
+CONFIG_I2C_LPC2K=y
 CONFIG_SPI=y
 CONFIG_SPI_PL022=y
+CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_74XX_MMIO=y
+CONFIG_GPIO_PCF857X=y
+CONFIG_SENSORS_JC42=y
 CONFIG_SENSORS_LM75=y
 CONFIG_WATCHDOG=y
-CONFIG_WATCHDOG_CORE=y
-CONFIG_MFD_SYSCON=y
+CONFIG_LPC18XX_WATCHDOG=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_FB=y
@@ -117,6 +127,8 @@ CONFIG_FB_ARMCLCD=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
+CONFIG_USB_EHCI_HCD_PLATFORM=y
+CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_IDMAC=y
@@ -128,12 +140,20 @@ CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_LPC24XX=y
 CONFIG_DMADEVICES=y
 CONFIG_AMBA_PL08X=y
+CONFIG_LPC18XX_DMAMUX=y
+CONFIG_MEMORY=y
+CONFIG_ARM_PL172_MPMC=y
+CONFIG_PWM=y
+CONFIG_PWM_LPC18XX_SCT=y
+CONFIG_PHY_LPC18XX_USB_OTG=y
 CONFIG_EXT2_FS=y
 # CONFIG_FILE_LOCKING is not set
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY_USER is not set
+CONFIG_JFFS2_FS=y
 # CONFIG_NETWORK_FILESYSTEMS is not set
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
@@ -143,8 +163,6 @@ CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
-# CONFIG_RCU_CPU_STALL_INFO is not set
-# CONFIG_FTRACE is not set
 CONFIG_DEBUG_LL=y
 CONFIG_EARLY_PRINTK=y
 CONFIG_CRC_ITU_T=y
-- 
1.8.0
