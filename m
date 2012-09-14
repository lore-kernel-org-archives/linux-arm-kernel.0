From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 14 Sep 2012 15:25:45 -0300
Subject: [PATCH v2] ARM: imx_v6_v7_defconfig: Enable CONFIG_GPIO_MC9S08DZ60
Message-ID: <1347647145-23798-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On mx35pdk board there is an 8-bit microcontroller that controls several IOs, such
as backlight enable pin, USB host VBUS, etc.

Let it build by default.

mx35pdk also needs CONFIG_LCD_PLATFORM to be selected to activate the display,
so also make this the default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Also select CONFIG_LCD_PLATFORM
 arch/arm/configs/imx_v6_v7_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 565132d..8cfd747 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -140,6 +140,7 @@ CONFIG_I2C_IMX=y
 CONFIG_SPI=y
 CONFIG_SPI_IMX=y
 CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_MC9S08DZ60=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_IMX2_WDT=y
@@ -156,6 +157,7 @@ CONFIG_SOC_CAMERA=y
 CONFIG_SOC_CAMERA_OV2640=y
 CONFIG_VIDEO_MX3=y
 CONFIG_FB=y
+CONFIG_LCD_PLATFORM=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_L4F00242T03=y
-- 
1.7.9.5
