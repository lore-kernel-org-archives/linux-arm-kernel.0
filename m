From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue,  2 Sep 2014 10:50:02 +0200
Subject: [PATCH 6/7] ARM: at91: at91sam9rl: update defconfig
In-Reply-To: <1409647803-8054-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1409647803-8054-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1409647803-8054-7-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update defconfig, adding:
 - USB gadget
 - PWM support using the generic framework
 - generic PWM leds
 - LEDs triggers
 - Power/reset

and removing deprecated config options.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/configs/at91sam9rl_defconfig | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/arm/configs/at91sam9rl_defconfig b/arch/arm/configs/at91sam9rl_defconfig
index 5d7797d43d23..4c26d344ae88 100644
--- a/arch/arm/configs/at91sam9rl_defconfig
+++ b/arch/arm/configs/at91sam9rl_defconfig
@@ -2,8 +2,8 @@
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_EMBEDDED=y
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_EMBEDDED=y
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
@@ -37,7 +37,6 @@ CONFIG_BLK_DEV_RAM_COUNT=4
 CONFIG_BLK_DEV_RAM_SIZE=24576
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
-CONFIG_SCSI_MULTI_LUN=y
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_MOUSEDEV_SCREEN_X=320
 CONFIG_INPUT_MOUSEDEV_SCREEN_Y=240
@@ -54,20 +53,31 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_GPIO=y
 CONFIG_SPI=y
 CONFIG_SPI_ATMEL=y
+CONFIG_POWER_SUPPLY=y
+CONFIG_POWER_RESET=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_WATCHDOG_NOWAYOUT=y
 CONFIG_AT91SAM9X_WATCHDOG=y
 CONFIG_FB=y
 CONFIG_FB_ATMEL=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_ATMEL_USBA=y
 CONFIG_MMC=y
 CONFIG_MMC_ATMELMCI=m
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_PWM=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_AT91SAM9=y
 CONFIG_IIO=y
 CONFIG_AT91_ADC=y
-CONFIG_EXT2_FS=y
-CONFIG_MSDOS_FS=y
+CONFIG_PWM=y
+CONFIG_PWM_ATMEL=y
+CONFIG_EXT4_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_UBIFS_FS=y
@@ -77,7 +87,6 @@ CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_UTF8=y
-CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
-- 
1.9.1
