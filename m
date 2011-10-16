From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 16 Oct 2011 22:58:21 +0200
Subject: [PATCH 2/2] ARM: at91: drop specific Kconfig for at91sam9g20/g10
In-Reply-To: <1318798701-2799-1-git-send-email-plagnioj@jcrosoft.com>
References: <1318798701-2799-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1318798701-2799-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

as the both SoC are an evolution of the 9260 and 9261

they share the same register mapping and for the diffence can be detected
at runtime

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/configs/at91sam9260_defconfig     |   62 +++++++++-
 arch/arm/configs/at91sam9g20_defconfig     |  124 --------------------
 arch/arm/configs/cpu9g20_defconfig         |    2 +-
 arch/arm/configs/pcontrol_g20_defconfig    |    2 +-
 arch/arm/configs/stamp9g20_defconfig       |    2 +-
 arch/arm/mach-at91/Kconfig                 |  174 ++++++++++++----------------
 arch/arm/mach-at91/Makefile                |    2 -
 arch/arm/mach-at91/include/mach/board.h    |    2 +-
 arch/arm/mach-at91/include/mach/cpu.h      |   12 +--
 arch/arm/mach-at91/include/mach/hardware.h |    4 +-
 arch/arm/mach-at91/soc.h                   |    4 +-
 11 files changed, 140 insertions(+), 250 deletions(-)
 delete mode 100644 arch/arm/configs/at91sam9g20_defconfig

diff --git a/arch/arm/configs/at91sam9260_defconfig b/arch/arm/configs/at91sam9260_defconfig
index fb7fca7..2590051 100644
--- a/arch/arm/configs/at91sam9260_defconfig
+++ b/arch/arm/configs/at91sam9260_defconfig
@@ -21,9 +21,21 @@ CONFIG_MACH_USB_A9260=y
 CONFIG_MACH_QIL_A9260=y
 CONFIG_MACH_CPU9260=y
 CONFIG_MACH_FLEXIBITY=y
+CONFIG_MACH_AT91SAM9G20EK=y
+CONFIG_MACH_AT91SAM9G20EK_2MMC=y
+CONFIG_MACH_CPU9G20=y
+CONFIG_MACH_ACMENETUSFOXG20=y
+CONFIG_MACH_PORTUXG20=y
+CONFIG_MACH_STAMP9G20=y
+CONFIG_MACH_PCONTROL_G20=y
+CONFIG_MACH_GSIA18S=y
+CONFIG_MACH_USB_A9G20=y
 CONFIG_MACH_SNAPPER_9260=y
 CONFIG_AT91_PROGRAMMABLE_CLOCKS=y
 # CONFIG_ARM_THUMB is not set
+CONFIG_AEABI=y
+CONFIG_LEDS=y
+CONFIG_LEDS_CPU=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="mem=64M console=ttyS0,115200 initrd=0x21100000,3145728 root=/dev/ram0 rw"
@@ -40,26 +52,52 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_DATAFLASH=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_ATMEL=y
+CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_MULTI_LUN=y
+# CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
 CONFIG_MII=y
 CONFIG_NET_ETHERNET=y
 CONFIG_MACB=y
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
-# CONFIG_INPUT_KEYBOARD is not set
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=320
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=240
+CONFIG_INPUT_EVDEV=y
+# CONFIG_KEYBOARD_ATKBD is not set
+CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
+CONFIG_LEGACY_PTY_COUNT=16
 CONFIG_SERIAL_ATMEL=y
 CONFIG_SERIAL_ATMEL_CONSOLE=y
-# CONFIG_HW_RANDOM is not set
+CONFIG_HW_RANDOM=y
+CONFIG_SPI=y
+CONFIG_SPI_ATMEL=y
+CONFIG_SPI_SPIDEV=y
+## CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_GPIO=y
 # CONFIG_HWMON is not set
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SEQUENCER=y
+CONFIG_SND_MIXER_OSS=y
+CONFIG_SND_PCM_OSS=y
+CONFIG_SND_SEQUENCER_OSS=y
+# CONFIG_SND_VERBOSE_PROCFS is not set
 CONFIG_WATCHDOG=y
 CONFIG_WATCHDOG_NOWAYOUT=y
 CONFIG_AT91SAM9X_WATCHDOG=y
@@ -69,21 +107,37 @@ CONFIG_USB_DEVICEFS=y
 CONFIG_USB_MON=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_STORAGE=y
-CONFIG_USB_STORAGE_DEBUG=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_ZERO=m
 CONFIG_USB_GADGETFS=m
 CONFIG_USB_FILE_STORAGE=m
 CONFIG_USB_G_SERIAL=m
+CONFIG_MMC=y
+CONFIG_MMC_AT91=m
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_TIMER=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_AT91SAM9=y
 CONFIG_EXT2_FS=y
+CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_SUMMARY=y
 CONFIG_CRAMFS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_ISO8859_15=y
+CONFIG_NLS_UTF8=y
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
diff --git a/arch/arm/configs/at91sam9g20_defconfig b/arch/arm/configs/at91sam9g20_defconfig
deleted file mode 100644
index d5d6c97..0000000
--- a/arch/arm/configs/at91sam9g20_defconfig
+++ /dev/null
@@ -1,124 +0,0 @@
-CONFIG_EXPERIMENTAL=y
-# CONFIG_LOCALVERSION_AUTO is not set
-# CONFIG_SWAP is not set
-CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_AT91=y
-CONFIG_ARCH_AT91SAM9G20=y
-CONFIG_MACH_AT91SAM9G20EK=y
-CONFIG_MACH_AT91SAM9G20EK_2MMC=y
-CONFIG_MACH_CPU9G20=y
-CONFIG_MACH_ACMENETUSFOXG20=y
-CONFIG_MACH_PORTUXG20=y
-CONFIG_MACH_STAMP9G20=y
-CONFIG_MACH_PCONTROL_G20=y
-CONFIG_MACH_GSIA18S=y
-CONFIG_MACH_USB_A9G20=y
-CONFIG_MACH_SNAPPER_9260=y
-CONFIG_AT91_PROGRAMMABLE_CLOCKS=y
-# CONFIG_ARM_THUMB is not set
-CONFIG_AEABI=y
-CONFIG_LEDS=y
-CONFIG_LEDS_CPU=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="mem=64M console=ttyS0,115200 initrd=0x21100000,3145728 root=/dev/ram0 rw"
-CONFIG_FPE_NWFPE=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_BOOTP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
-# CONFIG_IPV6 is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_MTD=y
-CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_CHAR=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_DATAFLASH=y
-CONFIG_MTD_NAND=y
-CONFIG_MTD_NAND_ATMEL=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=8192
-CONFIG_SCSI=y
-CONFIG_BLK_DEV_SD=y
-CONFIG_SCSI_MULTI_LUN=y
-# CONFIG_SCSI_LOWLEVEL is not set
-CONFIG_NETDEVICES=y
-CONFIG_MII=y
-CONFIG_NET_ETHERNET=y
-CONFIG_MACB=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
-CONFIG_INPUT_MOUSEDEV_SCREEN_X=320
-CONFIG_INPUT_MOUSEDEV_SCREEN_Y=240
-CONFIG_INPUT_EVDEV=y
-# CONFIG_KEYBOARD_ATKBD is not set
-CONFIG_KEYBOARD_GPIO=y
-# CONFIG_INPUT_MOUSE is not set
-CONFIG_LEGACY_PTY_COUNT=16
-CONFIG_SERIAL_ATMEL=y
-CONFIG_SERIAL_ATMEL_CONSOLE=y
-CONFIG_HW_RANDOM=y
-CONFIG_SPI=y
-CONFIG_SPI_ATMEL=y
-CONFIG_SPI_SPIDEV=y
-# CONFIG_HWMON is not set
-CONFIG_SOUND=y
-CONFIG_SND=y
-CONFIG_SND_SEQUENCER=y
-CONFIG_SND_MIXER_OSS=y
-CONFIG_SND_PCM_OSS=y
-CONFIG_SND_SEQUENCER_OSS=y
-# CONFIG_SND_VERBOSE_PROCFS is not set
-CONFIG_USB=y
-CONFIG_USB_DEVICEFS=y
-# CONFIG_USB_DEVICE_CLASS is not set
-CONFIG_USB_MON=y
-CONFIG_USB_OHCI_HCD=y
-CONFIG_USB_STORAGE=y
-CONFIG_USB_GADGET=y
-CONFIG_USB_ZERO=m
-CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
-CONFIG_USB_G_SERIAL=m
-CONFIG_MMC=y
-CONFIG_MMC_AT91=m
-CONFIG_NEW_LEDS=y
-CONFIG_LEDS_CLASS=y
-CONFIG_LEDS_GPIO=y
-CONFIG_LEDS_TRIGGERS=y
-CONFIG_LEDS_TRIGGER_TIMER=y
-CONFIG_LEDS_TRIGGER_HEARTBEAT=y
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_AT91SAM9=y
-CONFIG_EXT2_FS=y
-CONFIG_MSDOS_FS=y
-CONFIG_VFAT_FS=y
-CONFIG_TMPFS=y
-CONFIG_JFFS2_FS=y
-CONFIG_JFFS2_SUMMARY=y
-CONFIG_CRAMFS=y
-CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
-CONFIG_ROOT_NFS=y
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_CODEPAGE_850=y
-CONFIG_NLS_ISO8859_1=y
-CONFIG_NLS_ISO8859_15=y
-CONFIG_NLS_UTF8=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
diff --git a/arch/arm/configs/cpu9g20_defconfig b/arch/arm/configs/cpu9g20_defconfig
index e7d7942..6aad925 100644
--- a/arch/arm/configs/cpu9g20_defconfig
+++ b/arch/arm/configs/cpu9g20_defconfig
@@ -9,7 +9,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_AT91=y
-CONFIG_ARCH_AT91SAM9G20=y
+CONFIG_ARCH_AT91SAM9260=y
 CONFIG_MACH_CPU9G20=y
 # CONFIG_ARM_THUMB is not set
 CONFIG_PREEMPT=y
diff --git a/arch/arm/configs/pcontrol_g20_defconfig b/arch/arm/configs/pcontrol_g20_defconfig
index c75c9fc..c5a78cd 100644
--- a/arch/arm/configs/pcontrol_g20_defconfig
+++ b/arch/arm/configs/pcontrol_g20_defconfig
@@ -22,7 +22,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_DEFAULT_DEADLINE=y
 CONFIG_ARCH_AT91=y
-CONFIG_ARCH_AT91SAM9G20=y
+CONFIG_ARCH_AT91SAM9260=y
 CONFIG_MACH_PCONTROL_G20=y
 CONFIG_AT91_PROGRAMMABLE_CLOCKS=y
 CONFIG_NO_HZ=y
diff --git a/arch/arm/configs/stamp9g20_defconfig b/arch/arm/configs/stamp9g20_defconfig
index d5e260b..c2cb583 100644
--- a/arch/arm/configs/stamp9g20_defconfig
+++ b/arch/arm/configs/stamp9g20_defconfig
@@ -12,7 +12,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 CONFIG_ARCH_AT91=y
-CONFIG_ARCH_AT91SAM9G20=y
+CONFIG_ARCH_AT91SAM9260=y
 CONFIG_MACH_PORTUXG20=y
 CONFIG_MACH_STAMP9G20=y
 CONFIG_AT91_PROGRAMMABLE_CLOCKS=y
diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 04a85c5..c187c8b 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -24,7 +24,7 @@ config ARCH_AT91RM9200
 	select HAVE_AT91_USART3
 
 config ARCH_AT91SAM9260
-	bool "AT91SAM9260 or AT91SAM9XE"
+	bool "AT91SAM9260 or AT91SAM9XE or AT91SAM9G20"
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
 	select HAVE_AT91_USART3
@@ -33,13 +33,7 @@ config ARCH_AT91SAM9260
 	select HAVE_NET_MACB
 
 config ARCH_AT91SAM9261
-	bool "AT91SAM9261"
-	select CPU_ARM926T
-	select GENERIC_CLOCKEVENTS
-	select HAVE_FB_ATMEL
-
-config ARCH_AT91SAM9G10
-	bool "AT91SAM9G10"
+	bool "AT91SAM9261 or AT91SAM9G10"
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
 	select HAVE_FB_ATMEL
@@ -58,15 +52,6 @@ config ARCH_AT91SAM9RL
 	select HAVE_AT91_USART3
 	select HAVE_FB_ATMEL
 
-config ARCH_AT91SAM9G20
-	bool "AT91SAM9G20"
-	select CPU_ARM926T
-	select GENERIC_CLOCKEVENTS
-	select HAVE_AT91_USART3
-	select HAVE_AT91_USART4
-	select HAVE_AT91_USART5
-	select HAVE_NET_MACB
-
 config ARCH_AT91SAM9G45
 	bool "AT91SAM9G45"
 	select CPU_ARM926T
@@ -255,82 +240,6 @@ config MACH_FLEXIBITY
 	  Select this if you are using Flexibity Connect board
 	  <http://www.flexibity.com>
 
-endif
-
-# ----------------------------------------------------------
-
-if ARCH_AT91SAM9261
-
-comment "AT91SAM9261 Board Type"
-
-config MACH_AT91SAM9261EK
-	bool "Atmel AT91SAM9261-EK Evaluation Kit"
-	select HAVE_AT91_DATAFLASH_CARD
-	help
-	  Select this if you are using Atmel's AT91SAM9261-EK Evaluation Kit.
-	  <http://www.atmel.com/dyn/products/tools_card.asp?tool_id=3820>
-
-endif
-
-# ----------------------------------------------------------
-
-if ARCH_AT91SAM9G10
-
-comment "AT91SAM9G10 Board Type"
-
-config MACH_AT91SAM9G10EK
-	bool "Atmel AT91SAM9G10-EK Evaluation Kit"
-	select HAVE_AT91_DATAFLASH_CARD
-	help
-	  Select this if you are using Atmel's AT91SAM9G10-EK Evaluation Kit.
-	  <http://www.atmel.com/dyn/products/tools_card.asp?tool_id=4588>
-
-endif
-
-# ----------------------------------------------------------
-
-if ARCH_AT91SAM9263
-
-comment "AT91SAM9263 Board Type"
-
-config MACH_AT91SAM9263EK
-	bool "Atmel AT91SAM9263-EK Evaluation Kit"
-	select HAVE_AT91_DATAFLASH_CARD
-	help
-	  Select this if you are using Atmel's AT91SAM9263-EK Evaluation Kit.
-	  <http://www.atmel.com/dyn/products/tools_card.asp?tool_id=4057>
-
-config MACH_USB_A9263
-	bool "CALAO USB-A9263"
-	help
-	  Select this if you are using a Calao Systems USB-A9263.
-	  <http://www.calao-systems.com>
-
-config MACH_NEOCORE926
-	bool "Adeneo NEOCORE926"
-	select HAVE_AT91_DATAFLASH_CARD
-	help
-	  Select this if you are using the Adeneo Neocore 926 board.
-
-endif
-
-# ----------------------------------------------------------
-
-if ARCH_AT91SAM9RL
-
-comment "AT91SAM9RL Board Type"
-
-config MACH_AT91SAM9RLEK
-	bool "Atmel AT91SAM9RL-EK Evaluation Kit"
-	help
-	  Select this if you are using Atmel's AT91SAM9RL-EK Evaluation Kit.
-
-endif
-
-# ----------------------------------------------------------
-
-if ARCH_AT91SAM9G20
-
 comment "AT91SAM9G20 Board Type"
 
 config MACH_AT91SAM9G20EK
@@ -389,22 +298,83 @@ config MACH_GSIA18S
 
 config MACH_USB_A9G20
 	bool "CALAO USB-A9G20"
-	depends on ARCH_AT91SAM9G20
 	help
 	  Select this if you are using a Calao Systems USB-A9G20.
 	  <http://www.calao-systems.com>
 
-endif
-
-if (ARCH_AT91SAM9260 || ARCH_AT91SAM9G20)
 comment "AT91SAM9260/AT91SAM9G20 boards"
 
 config MACH_SNAPPER_9260
-        bool "Bluewater Systems Snapper 9260/9G20 module"
-        help
-          Select this if you are using the Bluewater Systems Snapper 9260 or
-          Snapper 9G20 modules.
-          <http://www.bluewatersys.com/>
+	bool "Bluewater Systems Snapper 9260/9G20 module"
+	help
+	  Select this if you are using the Bluewater Systems Snapper 9260 or
+	  Snapper 9G20 modules.
+	  <http://www.bluewatersys.com/>
+
+endif
+
+# ----------------------------------------------------------
+
+if ARCH_AT91SAM9261
+
+comment "AT91SAM9261 Board Type"
+
+config MACH_AT91SAM9261EK
+	bool "Atmel AT91SAM9261-EK Evaluation Kit"
+	select HAVE_AT91_DATAFLASH_CARD
+	help
+	  Select this if you are using Atmel's AT91SAM9261-EK Evaluation Kit.
+	  <http://www.atmel.com/dyn/products/tools_card.asp?tool_id=3820>
+
+comment "AT91SAM9G10 Board Type"
+
+config MACH_AT91SAM9G10EK
+	bool "Atmel AT91SAM9G10-EK Evaluation Kit"
+	select HAVE_AT91_DATAFLASH_CARD
+	help
+	  Select this if you are using Atmel's AT91SAM9G10-EK Evaluation Kit.
+	  <http://www.atmel.com/dyn/products/tools_card.asp?tool_id=4588>
+
+endif
+
+# ----------------------------------------------------------
+
+if ARCH_AT91SAM9263
+
+comment "AT91SAM9263 Board Type"
+
+config MACH_AT91SAM9263EK
+	bool "Atmel AT91SAM9263-EK Evaluation Kit"
+	select HAVE_AT91_DATAFLASH_CARD
+	help
+	  Select this if you are using Atmel's AT91SAM9263-EK Evaluation Kit.
+	  <http://www.atmel.com/dyn/products/tools_card.asp?tool_id=4057>
+
+config MACH_USB_A9263
+	bool "CALAO USB-A9263"
+	help
+	  Select this if you are using a Calao Systems USB-A9263.
+	  <http://www.calao-systems.com>
+
+config MACH_NEOCORE926
+	bool "Adeneo NEOCORE926"
+	select HAVE_AT91_DATAFLASH_CARD
+	help
+	  Select this if you are using the Adeneo Neocore 926 board.
+
+endif
+
+# ----------------------------------------------------------
+
+if ARCH_AT91SAM9RL
+
+comment "AT91SAM9RL Board Type"
+
+config MACH_AT91SAM9RLEK
+	bool "Atmel AT91SAM9RL-EK Evaluation Kit"
+	help
+	  Select this if you are using Atmel's AT91SAM9RL-EK Evaluation Kit.
+
 endif
 
 # ----------------------------------------------------------
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index d992dd5..f956925 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -13,10 +13,8 @@ obj-$(CONFIG_AT91_PMC_UNIT)	+= clock.o
 obj-$(CONFIG_ARCH_AT91RM9200)	+= at91rm9200.o at91rm9200_time.o at91rm9200_devices.o
 obj-$(CONFIG_ARCH_AT91SAM9260)	+= at91sam9260.o at91sam926x_time.o at91sam9260_devices.o sam9_smc.o at91sam9_alt_reset.o
 obj-$(CONFIG_ARCH_AT91SAM9261)	+= at91sam9261.o at91sam926x_time.o at91sam9261_devices.o sam9_smc.o at91sam9_alt_reset.o
-obj-$(CONFIG_ARCH_AT91SAM9G10)	+= at91sam9261.o at91sam926x_time.o at91sam9261_devices.o sam9_smc.o at91sam9_alt_reset.o
 obj-$(CONFIG_ARCH_AT91SAM9263)	+= at91sam9263.o at91sam926x_time.o at91sam9263_devices.o sam9_smc.o at91sam9_alt_reset.o
 obj-$(CONFIG_ARCH_AT91SAM9RL)	+= at91sam9rl.o at91sam926x_time.o at91sam9rl_devices.o sam9_smc.o at91sam9_alt_reset.o
-obj-$(CONFIG_ARCH_AT91SAM9G20)	+= at91sam9260.o at91sam926x_time.o at91sam9260_devices.o sam9_smc.o at91sam9_alt_reset.o
 obj-$(CONFIG_ARCH_AT91SAM9G45)	+= at91sam9g45.o at91sam926x_time.o at91sam9g45_devices.o sam9_smc.o
 obj-$(CONFIG_ARCH_AT91CAP9)	+= at91cap9.o at91sam926x_time.o at91cap9_devices.o sam9_smc.o
 obj-$(CONFIG_ARCH_AT91X40)	+= at91x40.o at91x40_time.o
diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
index d07767f..b18567b 100644
--- a/arch/arm/mach-at91/include/mach/board.h
+++ b/arch/arm/mach-at91/include/mach/board.h
@@ -89,7 +89,7 @@ struct at91_eth_data {
 };
 extern void __init at91_add_device_eth(struct at91_eth_data *data);
 
-#if defined(CONFIG_ARCH_AT91SAM9260) || defined(CONFIG_ARCH_AT91SAM9263) || defined(CONFIG_ARCH_AT91SAM9G20) || defined(CONFIG_ARCH_AT91CAP9) \
+#if defined(CONFIG_ARCH_AT91SAM9260) || defined(CONFIG_ARCH_AT91SAM9263) || defined(CONFIG_ARCH_AT91CAP9) \
 	|| defined(CONFIG_ARCH_AT91SAM9G45)
 #define eth_platform_data	at91_eth_data
 #endif
diff --git a/arch/arm/mach-at91/include/mach/cpu.h b/arch/arm/mach-at91/include/mach/cpu.h
index f6ce936..82d9676 100644
--- a/arch/arm/mach-at91/include/mach/cpu.h
+++ b/arch/arm/mach-at91/include/mach/cpu.h
@@ -130,26 +130,18 @@ static inline int at91_soc_is_detected(void)
 #ifdef CONFIG_ARCH_AT91SAM9260
 #define cpu_is_at91sam9xe()	(at91_soc_initdata.subtype == AT91_SOC_SAM9XE)
 #define cpu_is_at91sam9260()	(at91_soc_initdata.type == AT91_SOC_SAM9260)
+#define cpu_is_at91sam9g20()	(at91_soc_initdata.type == AT91_SOC_SAM9G20)
 #else
 #define cpu_is_at91sam9xe()	(0)
 #define cpu_is_at91sam9260()	(0)
-#endif
-
-#ifdef CONFIG_ARCH_AT91SAM9G20
-#define cpu_is_at91sam9g20()	(at91_soc_initdata.type == AT91_SOC_SAM9G20)
-#else
 #define cpu_is_at91sam9g20()	(0)
 #endif
 
 #ifdef CONFIG_ARCH_AT91SAM9261
 #define cpu_is_at91sam9261()	(at91_soc_initdata.type == AT91_SOC_SAM9261)
-#else
-#define cpu_is_at91sam9261()	(0)
-#endif
-
-#ifdef CONFIG_ARCH_AT91SAM9G10
 #define cpu_is_at91sam9g10()	(at91_soc_initdata.type == AT91_SOC_SAM9G10)
 #else
+#define cpu_is_at91sam9261()	(0)
 #define cpu_is_at91sam9g10()	(0)
 #endif
 
diff --git a/arch/arm/mach-at91/include/mach/hardware.h b/arch/arm/mach-at91/include/mach/hardware.h
index 483478d..d0f634e 100644
--- a/arch/arm/mach-at91/include/mach/hardware.h
+++ b/arch/arm/mach-at91/include/mach/hardware.h
@@ -18,9 +18,9 @@
 
 #if defined(CONFIG_ARCH_AT91RM9200)
 #include <mach/at91rm9200.h>
-#elif defined(CONFIG_ARCH_AT91SAM9260) || defined(CONFIG_ARCH_AT91SAM9G20)
+#elif defined(CONFIG_ARCH_AT91SAM9260)
 #include <mach/at91sam9260.h>
-#elif defined(CONFIG_ARCH_AT91SAM9261) || defined(CONFIG_ARCH_AT91SAM9G10)
+#elif defined(CONFIG_ARCH_AT91SAM9261)
 #include <mach/at91sam9261.h>
 #elif defined(CONFIG_ARCH_AT91SAM9263)
 #include <mach/at91sam9263.h>
diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
index 050eda7..9a5b993 100644
--- a/arch/arm/mach-at91/soc.h
+++ b/arch/arm/mach-at91/soc.h
@@ -35,11 +35,11 @@ static inline int at91_soc_is_enabled(void)
 #define at91rm9200_soc	at91_boot_soc
 #endif
 
-#if !(defined(CONFIG_ARCH_AT91SAM9260) || defined(CONFIG_ARCH_AT91SAM9G20))
+#if !defined(CONFIG_ARCH_AT91SAM9260)
 #define at91sam9260_soc	at91_boot_soc
 #endif
 
-#if !(defined(CONFIG_ARCH_AT91SAM9261) || defined(CONFIG_ARCH_AT91SAM9G10))
+#if !defined(CONFIG_ARCH_AT91SAM9261)
 #define at91sam9261_soc	at91_boot_soc
 #endif
 
-- 
1.7.7
