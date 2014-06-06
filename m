From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 6 Jun 2014 17:37:05 +0800
Subject: [PATCH 1/2] ARM: at91/at91_dt_defconfig: enable sound support
Message-ID: <1402047426-4058-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As sound support depends on ssc, i2c and dma, so also enable them.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 arch/arm/configs/at91_dt_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 300ded9..bd0a307 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -77,6 +77,7 @@ CONFIG_BLK_DEV_RAM_COUNT=4
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_ATMEL_PWM=y
 CONFIG_ATMEL_TCLIB=y
+CONFIG_ATMEL_SSC=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_MULTI_LUN=y
@@ -128,6 +129,7 @@ CONFIG_SERIAL_ATMEL=y
 CONFIG_SERIAL_ATMEL_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_I2C=y
+CONFIG_I2C_AT91=y
 CONFIG_I2C_GPIO=y
 CONFIG_SPI=y
 CONFIG_SPI_ATMEL=y
@@ -149,6 +151,13 @@ CONFIG_FONT_8x8=y
 CONFIG_FONT_ACORN_8x8=y
 CONFIG_FONT_MINI_4x6=y
 CONFIG_LOGO=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SOC=y
+CONFIG_SND_ATMEL_SOC=y
+CONFIG_SND_AT91_SOC_SAM9G20_WM8731=y
+CONFIG_SND_ATMEL_SOC_WM8904=y
+CONFIG_SND_AT91_SOC_SAM9X5_WM8731=y
 CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_EHCI_HCD=y
@@ -178,6 +187,7 @@ CONFIG_RTC_DRV_RV3029C2=y
 CONFIG_RTC_DRV_AT91RM9200=y
 CONFIG_RTC_DRV_AT91SAM9=y
 CONFIG_DMADEVICES=y
+CONFIG_AT_HDMAC=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT4_FS=y
 CONFIG_FANOTIFY=y
-- 
1.8.5.2
