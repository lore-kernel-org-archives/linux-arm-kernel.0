From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Fri, 15 Oct 2010 12:15:06 +0200
Subject: [PATCH v2 4/5] mx3: update defconfig
In-Reply-To: <20101015070731.GF6747@pengutronix.de>
References: <20101015070731.GF6747@pengutronix.de>
Message-ID: <1287137707-9548-4-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* add ARM errata 411920
* can : add flexcan support
* input : add imx keyuboard, gpio and tsc2007 support
* video : add lcd and backlight support
* sound : add soc audio support
* usb host : add ehci, mass storage support
* usb device : add eth gadget support
* leds : add gpio led support and heartbeat trigger
* rtc : add PCF8563 support

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
v2 : add details change log
 arch/arm/configs/mx3_defconfig |   60 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/mx3_defconfig b/arch/arm/configs/mx3_defconfig
index f0c339f..5a3240e 100644
--- a/arch/arm/configs/mx3_defconfig
+++ b/arch/arm/configs/mx3_defconfig
@@ -27,6 +27,7 @@ CONFIG_MACH_KZM_ARM11_01=y
 CONFIG_MACH_EUKREA_CPUIMX35=y
 CONFIG_MXC_IRQ_PRIOR=y
 CONFIG_MXC_PWM=y
+CONFIG_ARM_ERRATA_411920=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
@@ -49,6 +50,13 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
+CONFIG_CAN=y
+CONFIG_CAN_RAW=y
+CONFIG_CAN_BCM=y
+CONFIG_CAN_VCAN=y
+CONFIG_CAN_DEV=y
+CONFIG_CAN_CALC_BITTIMING=y
+CONFIG_CAN_FLEXCAN=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_FW_LOADER=m
 CONFIG_MTD=y
@@ -63,6 +71,10 @@ CONFIG_MTD_NAND_MXC=y
 CONFIG_MTD_UBI=y
 # CONFIG_BLK_DEV is not set
 CONFIG_EEPROM_AT24=y
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_SCSI_MULTI_LUN=y
+# CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
 CONFIG_SMSC_PHY=y
 CONFIG_NET_ETHERNET=y
@@ -71,8 +83,12 @@ CONFIG_DNET=y
 CONFIG_FEC=y
 # CONFIG_NETDEV_1000 is not set
 # CONFIG_NETDEV_10000 is not set
-# CONFIG_INPUT is not set
-# CONFIG_SERIO is not set
+CONFIG_INPUT_EVDEV=y
+CONFIG_INPUT_EVBUG=m
+CONFIG_KEYBOARD_GPIO=y
+CONFIG_KEYBOARD_IMX=y
+CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_TSC2007=y
 # CONFIG_VT is not set
 CONFIG_SERIAL_8250=m
 CONFIG_SERIAL_8250_EXTENDED=y
@@ -84,6 +100,9 @@ CONFIG_SERIAL_IMX_CONSOLE=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_IMX=y
+CONFIG_SPI=y
+CONFIG_SPI_IMX=y
+CONFIG_GPIO_SYSFS=y
 CONFIG_W1=y
 CONFIG_W1_MASTER_MXC=y
 CONFIG_W1_SLAVE_THERM=y
@@ -104,9 +123,44 @@ CONFIG_SOC_CAMERA_OV772X=y
 CONFIG_VIDEO_MX3=y
 # CONFIG_RADIO_ADAPTERS is not set
 CONFIG_FB=y
-# CONFIG_USB_SUPPORT is not set
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_LCD_CLASS_DEVICE=y
+CONFIG_LCD_PLATFORM=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
+CONFIG_BACKLIGHT_PWM=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SEQUENCER=y
+CONFIG_SND_MIXER_OSS=y
+CONFIG_SND_PCM_OSS=y
+# CONFIG_SND_DRIVERS is not set
+# CONFIG_SND_ARM is not set
+# CONFIG_SND_SPI is not set
+CONFIG_SND_SOC=y
+CONFIG_SND_IMX_SOC=y
+CONFIG_SND_MXC_SOC_WM1133_EV1=y
+CONFIG_SND_SOC_PHYCORE_AC97=y
+CONFIG_SND_SOC_EUKREA_TLV320=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_MXC=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_ETH=y
+CONFIG_USB_ULPI=y
+CONFIG_NOP_USB_XCEIV=y
 CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_ESDHC_IMX=y
 CONFIG_MMC_MXC=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_PCF8563=y
 CONFIG_DMADEVICES=y
 # CONFIG_DNOTIFY is not set
 CONFIG_TMPFS=y
-- 
1.7.0.4
