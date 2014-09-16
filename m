From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 16 Sep 2014 10:16:28 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig updates
Message-ID: <1410833788-18060-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

The rtc isl1208 driver is used by mx6 nitrogen board, so let's enable it by
default.

The fsl sai driver is used by the vf610-twr board, so let's enable it by
default.

simple-audio-card driver is used by the vf610-twr board, so let's enable it by
default.

Generated this patch by doing:

- make imx_v6_v7_defconfig
- make menuconfig and manually select options
- make savedefconfig
- cp defconfig arch/arm/configs/imx_v6_v7_defconfig

,which results in some additional cleanups.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
This is a squash of a few imx_v6_v7_defconfig update patches.

Shawn

 arch/arm/configs/imx_v6_v7_defconfig | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 16cfec4385c8..8fca6e276b69 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -32,8 +32,8 @@ CONFIG_MACH_IMX35_DT=y
 CONFIG_MACH_PCM043=y
 CONFIG_MACH_MX35_3DS=y
 CONFIG_MACH_VPR200=y
-CONFIG_SOC_IMX51=y
 CONFIG_SOC_IMX50=y
+CONFIG_SOC_IMX51=y
 CONFIG_SOC_IMX53=y
 CONFIG_SOC_IMX6Q=y
 CONFIG_SOC_IMX6SL=y
@@ -105,7 +105,6 @@ CONFIG_EEPROM_AT24=y
 CONFIG_EEPROM_AT25=y
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=y
-CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SCAN_ASYNC=y
@@ -153,14 +152,12 @@ CONFIG_SERIAL_IMX_CONSOLE=y
 CONFIG_SERIAL_FSL_LPUART=y
 CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
 CONFIG_HW_RANDOM=y
-CONFIG_HW_RANDOM_MXC_RNGA=y
 # CONFIG_I2C_COMPAT is not set
 CONFIG_I2C_CHARDEV=y
 # CONFIG_I2C_HELPER_AUTO is not set
 CONFIG_I2C_ALGOPCF=m
 CONFIG_I2C_ALGOPCA=m
 CONFIG_I2C_IMX=y
-CONFIG_SPI=y
 CONFIG_SPI_IMX=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_MC9S08DZ60=y
@@ -198,7 +195,6 @@ CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_L4F00242T03=y
 CONFIG_LCD_PLATFORM=y
-CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_PWM=y
 CONFIG_BACKLIGHT_GPIO=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
@@ -206,6 +202,7 @@ CONFIG_LOGO=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SOC=y
+CONFIG_SND_SOC_FSL_SAI=y
 CONFIG_SND_IMX_SOC=y
 CONFIG_SND_SOC_PHYCORE_AC97=y
 CONFIG_SND_SOC_EUKREA_TLV320=y
@@ -213,6 +210,7 @@ CONFIG_SND_SOC_IMX_WM8962=y
 CONFIG_SND_SOC_IMX_SGTL5000=y
 CONFIG_SND_SOC_IMX_SPDIF=y
 CONFIG_SND_SOC_IMX_MC13783=y
+CONFIG_SND_SIMPLE_CARD=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MXC=y
@@ -240,6 +238,7 @@ CONFIG_LEDS_TRIGGER_BACKLIGHT=y
 CONFIG_LEDS_TRIGGER_GPIO=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_INTF_DEV_UIE_EMUL=y
+CONFIG_RTC_DRV_ISL1208=y
 CONFIG_RTC_DRV_PCF8563=y
 CONFIG_RTC_DRV_MC13XXX=y
 CONFIG_RTC_DRV_MXC=y
@@ -254,7 +253,6 @@ CONFIG_DRM_IMX_FB_HELPER=y
 CONFIG_DRM_IMX_PARALLEL_DISPLAY=y
 CONFIG_DRM_IMX_TVE=y
 CONFIG_DRM_IMX_LDB=y
-CONFIG_DRM_IMX_IPUV3_CORE=y
 CONFIG_DRM_IMX_IPUV3=y
 CONFIG_DRM_IMX_HDMI=y
 # CONFIG_IOMMU_SUPPORT is not set
-- 
1.9.1
