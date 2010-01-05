From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed,  6 Jan 2010 00:08:59 +0100
Subject: [PATCH] Update U300 defconfig
Message-ID: <1262732939-14896-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates the U300 defconfig to include the DMA driver merged
in 2.6.33-rc1 and adds a codepage that's needed to mount VFAT MMC
cards as default. The rest is new config options.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/configs/u300_defconfig |   81 ++++++++++++++++++++++++++++++++++-----
 1 files changed, 71 insertions(+), 10 deletions(-)

diff --git a/arch/arm/configs/u300_defconfig b/arch/arm/configs/u300_defconfig
index 610ac3c..9155196 100644
--- a/arch/arm/configs/u300_defconfig
+++ b/arch/arm/configs/u300_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.32-rc5
-# Sat Oct 17 23:32:24 2009
+# Linux kernel version: 2.6.33-rc2
+# Wed Jan  6 00:01:36 2010
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -46,6 +46,7 @@ CONFIG_SYSVIPC_SYSCTL=y
 #
 CONFIG_TREE_RCU=y
 # CONFIG_TREE_PREEMPT_RCU is not set
+# CONFIG_TINY_RCU is not set
 # CONFIG_RCU_TRACE is not set
 CONFIG_RCU_FANOUT=32
 # CONFIG_RCU_FANOUT_EXACT is not set
@@ -119,14 +120,41 @@ CONFIG_BLOCK=y
 # IO Schedulers
 #
 CONFIG_IOSCHED_NOOP=y
-# CONFIG_IOSCHED_AS is not set
 CONFIG_IOSCHED_DEADLINE=y
 # CONFIG_IOSCHED_CFQ is not set
-# CONFIG_DEFAULT_AS is not set
 CONFIG_DEFAULT_DEADLINE=y
 # CONFIG_DEFAULT_CFQ is not set
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="deadline"
+# CONFIG_INLINE_SPIN_TRYLOCK is not set
+# CONFIG_INLINE_SPIN_TRYLOCK_BH is not set
+# CONFIG_INLINE_SPIN_LOCK is not set
+# CONFIG_INLINE_SPIN_LOCK_BH is not set
+# CONFIG_INLINE_SPIN_LOCK_IRQ is not set
+# CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set
+# CONFIG_INLINE_SPIN_UNLOCK is not set
+# CONFIG_INLINE_SPIN_UNLOCK_BH is not set
+# CONFIG_INLINE_SPIN_UNLOCK_IRQ is not set
+# CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
+# CONFIG_INLINE_READ_TRYLOCK is not set
+# CONFIG_INLINE_READ_LOCK is not set
+# CONFIG_INLINE_READ_LOCK_BH is not set
+# CONFIG_INLINE_READ_LOCK_IRQ is not set
+# CONFIG_INLINE_READ_LOCK_IRQSAVE is not set
+# CONFIG_INLINE_READ_UNLOCK is not set
+# CONFIG_INLINE_READ_UNLOCK_BH is not set
+# CONFIG_INLINE_READ_UNLOCK_IRQ is not set
+# CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set
+# CONFIG_INLINE_WRITE_TRYLOCK is not set
+# CONFIG_INLINE_WRITE_LOCK is not set
+# CONFIG_INLINE_WRITE_LOCK_BH is not set
+# CONFIG_INLINE_WRITE_LOCK_IRQ is not set
+# CONFIG_INLINE_WRITE_LOCK_IRQSAVE is not set
+# CONFIG_INLINE_WRITE_UNLOCK is not set
+# CONFIG_INLINE_WRITE_UNLOCK_BH is not set
+# CONFIG_INLINE_WRITE_UNLOCK_IRQ is not set
+# CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set
+# CONFIG_MUTEX_SPIN_ON_OWNER is not set
 # CONFIG_FREEZER is not set
 
 #
@@ -155,6 +183,7 @@ CONFIG_MMU=y
 # CONFIG_ARCH_IXP2000 is not set
 # CONFIG_ARCH_IXP4XX is not set
 # CONFIG_ARCH_L7200 is not set
+# CONFIG_ARCH_DOVE is not set
 # CONFIG_ARCH_KIRKWOOD is not set
 # CONFIG_ARCH_LOKI is not set
 # CONFIG_ARCH_MV78XX0 is not set
@@ -177,6 +206,7 @@ CONFIG_ARCH_U300=y
 # CONFIG_ARCH_DAVINCI is not set
 # CONFIG_ARCH_OMAP is not set
 # CONFIG_ARCH_BCMRING is not set
+# CONFIG_ARCH_U8500 is not set
 
 #
 # ST-Ericsson AB U300/U330/U335/U365 Platform
@@ -265,12 +295,10 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 CONFIG_PAGEFLAGS_EXTENDED=y
-CONFIG_SPLIT_PTLOCK_CPUS=4096
+CONFIG_SPLIT_PTLOCK_CPUS=999999
 # CONFIG_PHYS_ADDR_T_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=0
 CONFIG_VIRT_TO_BUS=y
-CONFIG_HAVE_MLOCK=y
-CONFIG_HAVE_MLOCKED_PAGE_BIT=y
 # CONFIG_KSM is not set
 CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
 CONFIG_ALIGNMENT_TRAP=y
@@ -499,14 +527,21 @@ CONFIG_MTD_NAND_IDS=y
 CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 # CONFIG_BLK_DEV_LOOP is not set
+
+#
+# DRBD disabled because PROC_FS, INET or CONNECTOR not selected
+#
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_RAM is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 CONFIG_MISC_DEVICES=y
+# CONFIG_AD525X_DPOT is not set
 # CONFIG_ICS932S401 is not set
 # CONFIG_ENCLOSURE_SERVICES is not set
 # CONFIG_ISL29003 is not set
+# CONFIG_DS1682 is not set
+# CONFIG_TI_DAC7512 is not set
 # CONFIG_C2PORT is not set
 
 #
@@ -517,6 +552,7 @@ CONFIG_MISC_DEVICES=y
 # CONFIG_EEPROM_LEGACY is not set
 # CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_EEPROM_93CX6 is not set
+# CONFIG_IWMC3200TOP is not set
 CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set
 
@@ -539,6 +575,7 @@ CONFIG_HAVE_IDE=y
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
 # CONFIG_INPUT_POLLDEV is not set
+# CONFIG_INPUT_SPARSEKMAP is not set
 
 #
 # Userland interfaces
@@ -645,7 +682,6 @@ CONFIG_I2C_STU300=y
 #
 # Miscellaneous I2C Chip support
 #
-# CONFIG_DS1682 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
@@ -661,6 +697,8 @@ CONFIG_SPI_MASTER=y
 # CONFIG_SPI_BITBANG is not set
 # CONFIG_SPI_GPIO is not set
 CONFIG_SPI_PL022=y
+# CONFIG_SPI_XILINX is not set
+# CONFIG_SPI_DESIGNWARE is not set
 
 #
 # SPI Protocol Masters
@@ -708,6 +746,7 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_MFD_T7L66XB is not set
 # CONFIG_MFD_TC6387XB is not set
 # CONFIG_PMIC_DA903X is not set
+# CONFIG_PMIC_ADP5520 is not set
 # CONFIG_MFD_WM8400 is not set
 # CONFIG_MFD_WM831X is not set
 # CONFIG_MFD_WM8350_I2C is not set
@@ -716,6 +755,8 @@ CONFIG_SSB_POSSIBLE=y
 CONFIG_AB3100_CORE=y
 CONFIG_AB3100_OTP=y
 # CONFIG_EZX_PCAP is not set
+# CONFIG_MFD_88PM8607 is not set
+# CONFIG_AB4500_CORE is not set
 CONFIG_REGULATOR=y
 # CONFIG_REGULATOR_DEBUG is not set
 # CONFIG_REGULATOR_FIXED_VOLTAGE is not set
@@ -723,6 +764,7 @@ CONFIG_REGULATOR=y
 # CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
 # CONFIG_REGULATOR_BQ24022 is not set
 # CONFIG_REGULATOR_MAX1586 is not set
+# CONFIG_REGULATOR_MAX8660 is not set
 # CONFIG_REGULATOR_LP3971 is not set
 CONFIG_REGULATOR_AB3100=y
 # CONFIG_REGULATOR_TPS65023 is not set
@@ -840,7 +882,9 @@ CONFIG_LEDS_CLASS=y
 # CONFIG_LEDS_LP3944 is not set
 # CONFIG_LEDS_PCA955X is not set
 # CONFIG_LEDS_DAC124S085 is not set
+# CONFIG_LEDS_REGULATOR is not set
 # CONFIG_LEDS_BD2802 is not set
+# CONFIG_LEDS_LT3593 is not set
 
 #
 # LED Triggers
@@ -882,6 +926,7 @@ CONFIG_RTC_INTF_DEV=y
 # CONFIG_RTC_DRV_PCF8563 is not set
 # CONFIG_RTC_DRV_PCF8583 is not set
 # CONFIG_RTC_DRV_M41T80 is not set
+# CONFIG_RTC_DRV_BQ32K is not set
 # CONFIG_RTC_DRV_S35390A is not set
 # CONFIG_RTC_DRV_FM3130 is not set
 # CONFIG_RTC_DRV_RX8581 is not set
@@ -911,7 +956,9 @@ CONFIG_RTC_INTF_DEV=y
 # CONFIG_RTC_DRV_M48T86 is not set
 # CONFIG_RTC_DRV_M48T35 is not set
 # CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_MSM6242 is not set
 # CONFIG_RTC_DRV_BQ4802 is not set
+# CONFIG_RTC_DRV_RP5C01 is not set
 # CONFIG_RTC_DRV_V3020 is not set
 CONFIG_RTC_DRV_AB3100=y
 
@@ -926,6 +973,15 @@ CONFIG_DMADEVICES=y
 #
 # DMA Devices
 #
+CONFIG_COH901318=y
+CONFIG_DMA_ENGINE=y
+
+#
+# DMA Clients
+#
+# CONFIG_NET_DMA is not set
+# CONFIG_ASYNC_TX_DMA is not set
+# CONFIG_DMATEST is not set
 # CONFIG_AUXDISPLAY is not set
 # CONFIG_UIO is not set
 
@@ -1018,7 +1074,7 @@ CONFIG_MISC_FILESYSTEMS=y
 CONFIG_MSDOS_PARTITION=y
 CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
-# CONFIG_NLS_CODEPAGE_437 is not set
+CONFIG_NLS_CODEPAGE_437=y
 # CONFIG_NLS_CODEPAGE_737 is not set
 # CONFIG_NLS_CODEPAGE_775 is not set
 # CONFIG_NLS_CODEPAGE_850 is not set
@@ -1135,6 +1191,7 @@ CONFIG_ARM_UNWIND=y
 # CONFIG_DEBUG_ERRORS is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
 # CONFIG_DEBUG_LL is not set
+# CONFIG_OC_ETM is not set
 
 #
 # Security options
@@ -1142,7 +1199,11 @@ CONFIG_ARM_UNWIND=y
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 # CONFIG_SECURITYFS is not set
-# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+# CONFIG_DEFAULT_SECURITY_SELINUX is not set
+# CONFIG_DEFAULT_SECURITY_SMACK is not set
+# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_DEFAULT_SECURITY=""
 # CONFIG_CRYPTO is not set
 # CONFIG_BINARY_PRINTF is not set
 
-- 
1.6.3.3
