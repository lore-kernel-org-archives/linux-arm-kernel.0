From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Fri, 15 Oct 2010 12:15:05 +0200
Subject: [PATCH v2 3/5] mx27: update defconfig
In-Reply-To: <20101015070731.GF6747@pengutronix.de>
References: <20101015070731.GF6747@pengutronix.de>
Message-ID: <1287137707-9548-3-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* input : add keyboard and compile ads7846 in kernel
* serial : compile 8250 in kernel
* gpio : add sysfs support
* media : add soc camera support
* sound : add soc audio support
* usb host : add ehci, mass storage support
* usb device : add eth gadget support
* leds : add gpio led support and heartbeat trigger

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
v2 : add details change log
 arch/arm/configs/mx27_defconfig |   60 ++++++++++++++++++++++++++++++++++----
 1 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/arch/arm/configs/mx27_defconfig b/arch/arm/configs/mx27_defconfig
index 813cfb3..9623f42 100644
--- a/arch/arm/configs/mx27_defconfig
+++ b/arch/arm/configs/mx27_defconfig
@@ -72,6 +72,10 @@ CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_MXC=y
 CONFIG_MTD_UBI=y
 CONFIG_EEPROM_AT24=y
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_SCSI_MULTI_LUN=y
+# CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_FEC=y
@@ -79,12 +83,12 @@ CONFIG_FEC=y
 # CONFIG_NETDEV_10000 is not set
 # CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
-# CONFIG_INPUT_KEYBOARD is not set
+CONFIG_KEYBOARD_IMX=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
-CONFIG_TOUCHSCREEN_ADS7846=m
-# CONFIG_SERIO is not set
-CONFIG_SERIAL_8250=m
+CONFIG_TOUCHSCREEN_ADS7846=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_IMX=y
 CONFIG_SERIAL_IMX_CONSOLE=y
 # CONFIG_LEGACY_PTYS is not set
@@ -94,21 +98,64 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_IMX=y
 CONFIG_SPI=y
 CONFIG_SPI_IMX=y
+CONFIG_GPIO_SYSFS=y
 CONFIG_W1=y
 CONFIG_W1_MASTER_MXC=y
 CONFIG_W1_SLAVE_THERM=y
 # CONFIG_HWMON is not set
+CONFIG_WATCHDOG=y
+CONFIG_IMX2_WDT=y
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_VIDEO_DEV=y
+CONFIG_SOC_CAMERA=y
+CONFIG_SOC_CAMERA_MT9M001=y
+CONFIG_SOC_CAMERA_MT9M111=y
+CONFIG_SOC_CAMERA_MT9T031=y
+CONFIG_SOC_CAMERA_MT9T112=y
+CONFIG_SOC_CAMERA_MT9V022=y
+CONFIG_SOC_CAMERA_RJ54N1=y
+CONFIG_SOC_CAMERA_TW9910=y
+CONFIG_SOC_CAMERA_PLATFORM=y
+CONFIG_SOC_CAMERA_OV772X=y
+CONFIG_SOC_CAMERA_OV9640=y
+CONFIG_VIDEO_MX2=y
+# CONFIG_RADIO_ADAPTERS is not set
 CONFIG_FB=y
 CONFIG_FB_IMX=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
-# CONFIG_HID_SUPPORT is not set
-CONFIG_USB=m
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SEQUENCER=y
+CONFIG_SND_MIXER_OSS=y
+CONFIG_SND_PCM_OSS=y
+CONFIG_SND_SEQUENCER_OSS=y
+# CONFIG_SND_DRIVERS is not set
+# CONFIG_SND_ARM is not set
+# CONFIG_SND_SPI is not set
+# CONFIG_SND_USB is not set
+CONFIG_SND_SOC=y
+CONFIG_SND_IMX_SOC=y
+CONFIG_SND_SOC_PHYCORE_AC97=y
+CONFIG_SND_SOC_EUKREA_TLV320=y
+# CONFIG_USB_HID is not set
+CONFIG_USB=y
 # CONFIG_USB_DEVICE_CLASS is not set
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_MXC=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_ETH=y
 CONFIG_USB_ULPI=y
+CONFIG_NOP_USB_XCEIV=y
 CONFIG_MMC=y
 CONFIG_MMC_MXC=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_PCF8563=y
 # CONFIG_DNOTIFY is not set
@@ -119,7 +166,6 @@ CONFIG_UBIFS_FS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
-CONFIG_NLS=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_850=m
 CONFIG_NLS_ISO8859_1=y
-- 
1.7.0.4
