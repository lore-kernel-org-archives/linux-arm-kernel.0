From: dinguyen@kernel.org (Dinh Nguyen)
Date: Fri,  6 Jan 2017 14:50:16 -0600
Subject: [PATCH] ARM: socfpga_defconfig: update defconfig for SoCFPGA
Message-ID: <1483735816-24888-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MARVELL_PHY - support for the Marvell PHY that is on most of the devkits
EEPROM_AT24 - support for I2C EEPROMs on the devkits
GPIO_ALTERA - support for Altera's GPIO driver
NAND - support for the Denali NAND controller along with MTD subsystem
SPI_DESIGNWARE - support for SPI that is on SoCFPGA
SPI_DW_MMIO - support for the memory-mapped io interface for the DW SPI core
OF_CONFIGFS - SoCFPGA makes use of DT overlays using configfs, enable it
GPIO_ALTERA_A10SR - support for the newly added Altera HWMON driver
LEDS - support for the GPIO LEDs on the SoCFPGA devkits
RTC - support for the DS1307 RTC
JFFS2_FS - support for the JFFS2 filesystem
NFS_V4 - supports for v4 NFS
FUNCTION_TRACER - supports debug function tracing

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm/configs/socfpga_defconfig | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 2e1d254..030264c 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -52,14 +52,20 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_M25P80=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_DENALI_DT=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_SPI_CADENCE_QUADSPI=y
 CONFIG_OF_OVERLAY=y
+CONFIG_OF_CONFIGFS=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=2
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_BLK_DEV_NVME=m
 CONFIG_SRAM=y
+CONFIG_EEPROM_AT24=y
 CONFIG_SCSI=y
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=y
@@ -69,6 +75,7 @@ CONFIG_E1000E=m
 CONFIG_IGB=m
 CONFIG_IXGBE=m
 CONFIG_STMMAC_ETH=y
+CONFIG_MARVELL_PHY=y
 CONFIG_MICREL_PHY=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_INPUT_TOUCHSCREEN=y
@@ -84,14 +91,22 @@ CONFIG_SERIAL_8250_DW=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
+CONFIG_SPI=y
+CONFIG_SPI_DESIGNWARE=y
+CONFIG_SPI_DW_MMIO=y
+CONFIG_SPI_SPIDEV=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_ALTERA=y
 CONFIG_GPIO_DWAPB=y
+CONFIG_GPIO_ALTERA_A10SR=y
+CONFIG_SENSORS_MAX1619=y
 CONFIG_PMBUS=y
 CONFIG_SENSORS_LTC2978=y
 CONFIG_SENSORS_LTC2978_REGULATOR=y
 CONFIG_WATCHDOG=y
 CONFIG_DW_WATCHDOG=y
+CONFIG_MFD_ALTERA_A10SR=y
 CONFIG_MFD_STMPE=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
@@ -102,6 +117,14 @@ CONFIG_NOP_USB_XCEIV=y
 CONFIG_USB_GADGET=y
 CONFIG_MMC=y
 CONFIG_MMC_DW=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_TIMER=y
+CONFIG_LEDS_TRIGGER_CPU=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS1307=y
 CONFIG_DMADEVICES=y
 CONFIG_PL330_DMA=y
 CONFIG_DMATEST=m
@@ -121,9 +144,10 @@ CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
 CONFIG_NTFS_RW=y
 CONFIG_TMPFS=y
-CONFIG_CONFIGFS_FS=y
+CONFIG_JFFS2_FS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
 CONFIG_NFSD_V3_ACL=y
@@ -135,5 +159,5 @@ CONFIG_DEBUG_INFO=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_SCHED_DEBUG is not set
-CONFIG_ENABLE_DEFAULT_TRACERS=y
+CONFIG_FUNCTION_TRACER=y
 CONFIG_DEBUG_USER=y
-- 
2.7.4
