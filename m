From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 26 Apr 2016 17:01:27 +0200
Subject: [PATCH] ARM: at91/defconfig: add HLCDC driver to sama5_defconfig
Message-ID: <1461682887-28014-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the LCD DRM driver with all its dependencies:
- the MFD driver
- the backlight PWM
- the simple panel driver

Remove the CONFIG_FB as it is not needed on any sama5 device.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/configs/sama5_defconfig | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index e002b3bba5b4..f5a3966f6793 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -133,6 +133,7 @@ CONFIG_WATCHDOG=y
 CONFIG_AT91SAM9X_WATCHDOG=y
 CONFIG_SAMA5D4_WATCHDOG=y
 CONFIG_MFD_ATMEL_FLEXCOM=y
+CONFIG_MFD_ATMEL_HLCDC=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_ACT8865=y
@@ -142,11 +143,14 @@ CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_SOC_CAMERA=y
 CONFIG_VIDEO_ATMEL_ISI=y
 CONFIG_SOC_CAMERA_OV2640=y
-CONFIG_FB=y
+CONFIG_DRM=y
+CONFIG_DRM_ATMEL_HLCDC=y
+CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
-# CONFIG_LCD_CLASS_DEVICE is not set
+CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 # CONFIG_BACKLIGHT_GENERIC is not set
+CONFIG_BACKLIGHT_PWM=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_SOUND=y
 CONFIG_SND=y
@@ -191,6 +195,7 @@ CONFIG_AT91_ADC=y
 CONFIG_AT91_SAMA5D2_ADC=y
 CONFIG_PWM=y
 CONFIG_PWM_ATMEL=y
+CONFIG_PWM_ATMEL_HLCDC_PWM=y
 CONFIG_PWM_ATMEL_TCB=y
 CONFIG_EXT4_FS=y
 CONFIG_FANOTIFY=y
-- 
2.1.3
