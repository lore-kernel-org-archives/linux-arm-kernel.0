From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Wed, 15 Feb 2017 18:19:27 -0800
Subject: [PATCH v4 25/36] ARM: imx_v6_v7_defconfig: Enable staging video4linux
 drivers
In-Reply-To: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1487211578-11360-26-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable i.MX v4l2 media staging driver. For video capture on i.MX, the
video multiplexer subdev is required. On the SabreAuto, the ADV7180
video decoder is required along with i2c-mux-gpio. The Sabrelite
and SabreSD require the OV5640 and the SabreLite requires PWM clocks
for the OV5640.

Increase max zoneorder to allow larger video buffer allocations.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index cbe7faf..daeb164 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -51,6 +51,7 @@ CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_CMA=y
+CONFIG_FORCE_MAX_ZONEORDER=14
 CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
 CONFIG_KEXEC=y
 CONFIG_CPU_FREQ=y
@@ -174,13 +175,13 @@ CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MMA8450=y
 CONFIG_SERIO_SERPORT=m
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_IMX=y
 CONFIG_SERIAL_IMX_CONSOLE=y
 CONFIG_SERIAL_FSL_LPUART=y
 CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
 # CONFIG_I2C_COMPAT is not set
 CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_GPIO=y
 # CONFIG_I2C_HELPER_AUTO is not set
 CONFIG_I2C_ALGOPCF=m
@@ -194,11 +195,11 @@ CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_MC9S08DZ60=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_STMPE=y
-CONFIG_POWER_SUPPLY=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_IMX=y
 CONFIG_POWER_RESET_SYSCON=y
 CONFIG_POWER_RESET_SYSCON_POWEROFF=y
+CONFIG_POWER_SUPPLY=y
 CONFIG_SENSORS_GPIO_FAN=y
 CONFIG_SENSORS_IIO_HWMON=y
 CONFIG_THERMAL=y
@@ -221,14 +222,20 @@ CONFIG_REGULATOR_PFUZE100=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_MEDIA_RC_SUPPORT=y
+CONFIG_MEDIA_CONTROLLER=y
+CONFIG_VIDEO_V4L2_SUBDEV_API=y
 CONFIG_RC_DEVICES=y
 CONFIG_IR_GPIO_CIR=y
 CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_VIDEO_MULTIPLEXER=y
 CONFIG_SOC_CAMERA=y
 CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_CODA=y
+# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
+CONFIG_VIDEO_ADV7180=m
+CONFIG_VIDEO_OV5640=m
 CONFIG_SOC_CAMERA_OV2640=y
 CONFIG_IMX_IPUV3_CORE=y
 CONFIG_DRM=y
@@ -338,6 +345,9 @@ CONFIG_FSL_EDMA=y
 CONFIG_IMX_SDMA=y
 CONFIG_MXS_DMA=y
 CONFIG_STAGING=y
+CONFIG_STAGING_MEDIA=y
+CONFIG_VIDEO_IMX_MEDIA=y
+CONFIG_COMMON_CLK_PWM=y
 CONFIG_IIO=y
 CONFIG_VF610_ADC=y
 CONFIG_MPL3115=y
-- 
2.7.4
