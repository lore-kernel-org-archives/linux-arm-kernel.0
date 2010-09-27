From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:50:41 +0200
Subject: [PATCH 05/40] ARM: mx27_defconfig: enable switches used in mx27 code
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- enable all mx27 machines (MACH_CPUIMX27, MACH_IMX27_VISSTRIM_M10,
  MACH_PCA100, MACH_MXT_TD60) including optional features for
  CPUIMX27
- eukrea_mbimx27-baseboard.c uses TOUCHSCREEN_ADS7846
- mach-cpuimx27.c uses SERIAL_8250
- several machines make use of SPI_IMX (selects SPI_BITBANG)
- drop VGA_CONSOLE as this isn't selectable anymore since fb78b51cb11e
- several machines make use of USB_ULPI (depends on USB, but don't
  enable USB_DEVICE_CLASS as it's deprecated)

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/configs/mx27_defconfig |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/mx27_defconfig b/arch/arm/configs/mx27_defconfig
index b2038b0..813cfb3 100644
--- a/arch/arm/configs/mx27_defconfig
+++ b/arch/arm/configs/mx27_defconfig
@@ -21,8 +21,14 @@ CONFIG_ARCH_MX2=y
 CONFIG_MACH_MX27=y
 CONFIG_MACH_MX27ADS=y
 CONFIG_MACH_PCM038=y
+CONFIG_MACH_CPUIMX27=y
+CONFIG_MACH_EUKREA_CPUIMX27_USESDHC2=y
+CONFIG_MACH_EUKREA_CPUIMX27_USEUART4=y
 CONFIG_MACH_MX27_3DS=y
+CONFIG_MACH_IMX27_VISSTRIM_M10=y
 CONFIG_MACH_IMX27LITE=y
+CONFIG_MACH_PCA100=y
+CONFIG_MACH_MXT_TD60=y
 CONFIG_MXC_IRQ_PRIOR=y
 CONFIG_MXC_PWM=y
 CONFIG_NO_HZ=y
@@ -76,7 +82,9 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_ADS7846=m
 # CONFIG_SERIO is not set
+CONFIG_SERIAL_8250=m
 CONFIG_SERIAL_IMX=y
 CONFIG_SERIAL_IMX_CONSOLE=y
 # CONFIG_LEGACY_PTYS is not set
@@ -85,19 +93,20 @@ CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_IMX=y
 CONFIG_SPI=y
-CONFIG_SPI_BITBANG=y
+CONFIG_SPI_IMX=y
 CONFIG_W1=y
 CONFIG_W1_MASTER_MXC=y
 CONFIG_W1_SLAVE_THERM=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
 CONFIG_FB_IMX=y
-# CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
 # CONFIG_HID_SUPPORT is not set
-# CONFIG_USB_SUPPORT is not set
+CONFIG_USB=m
+# CONFIG_USB_DEVICE_CLASS is not set
+CONFIG_USB_ULPI=y
 CONFIG_MMC=y
 CONFIG_MMC_MXC=y
 CONFIG_RTC_CLASS=y
-- 
1.7.2.3
