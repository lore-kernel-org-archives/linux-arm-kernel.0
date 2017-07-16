From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 16 Jul 2017 20:26:42 -0300
Subject: [PATCH v2] ARM: imx_v6_v7_defconfig: Enable staging video4linux
 drivers
Message-ID: <1500247602-3364-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Longerbeam <steve_longerbeam@mentor.com>

Enable i.MX v4l2 media staging driver. For video capture on i.MX, the
video multiplexer subdev is required. On the SabreAuto, the ADV7180
video decoder is required along with i2c-mux-gpio. The Sabrelite
and SabreSD require the OV5640 and the SabreLite requires PWM clocks
for the OV5640.

Increase max zoneorder to allow larger video buffer allocations.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Rebased against Shawn Guo's for-next tree.

 arch/arm/configs/imx_v6_v7_defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 49e7969..3a48ad8 100644
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
@@ -186,6 +187,7 @@ CONFIG_SERIAL_FSL_LPUART=y
 CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
 # CONFIG_I2C_COMPAT is not set
 CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_GPIO=y
 # CONFIG_I2C_HELPER_AUTO is not set
 CONFIG_I2C_ALGOPCF=m
@@ -229,14 +231,20 @@ CONFIG_REGULATOR_PFUZE100=y
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
+CONFIG_VIDEO_MUX=y
 CONFIG_SOC_CAMERA=y
 CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_CODA=m
+# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
+CONFIG_VIDEO_ADV7180=m
+CONFIG_VIDEO_OV5640=m
 CONFIG_SOC_CAMERA_OV2640=y
 CONFIG_IMX_IPUV3_CORE=y
 CONFIG_DRM=y
@@ -346,6 +354,9 @@ CONFIG_FSL_EDMA=y
 CONFIG_IMX_SDMA=y
 CONFIG_MXS_DMA=y
 CONFIG_STAGING=y
+CONFIG_STAGING_MEDIA=y
+CONFIG_VIDEO_IMX_MEDIA=y
+CONFIG_COMMON_CLK_PWM=y
 CONFIG_IIO=y
 CONFIG_IMX7D_ADC=y
 CONFIG_VF610_ADC=y
-- 
2.7.4
