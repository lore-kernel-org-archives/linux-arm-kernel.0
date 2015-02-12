From: Ying.Liu@freescale.com (Liu Ying)
Date: Thu, 12 Feb 2015 14:01:41 +0800
Subject: [PATCH RFC v9 18/20] ARM: imx_v6_v7_defconfig: Cleanup for imx drm
 being moved out of staging
In-Reply-To: <1423720903-24806-1-git-send-email-Ying.Liu@freescale.com>
References: <1423720903-24806-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <1423720903-24806-19-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new imx_v6_v7_defconfig is generated in this way:
* make ARCH=arm imx_v6_v7_defconfig
* make ARCH=arm savedefconfig
* cp defconfig arch/arm/configs/imx_v6_v7_defconfig

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
v8->v9:
 * Rebase onto the imx-drm/next branch of Philipp Zabel's open git repository,
   so the patch content is different from v8.

v7->v8:
 * None.

v6->v7:
 * None.

v5->v6:
 * None.

v4->v5:
 * None.

v3->v4:
 * None.

v2->v3:
 * None.

v1->v2:
 * None.

 arch/arm/configs/imx_v6_v7_defconfig | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 7c2075a..ec4b255 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -54,7 +54,6 @@ CONFIG_ARM_IMX6Q_CPUFREQ=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_BINFMT_MISC=m
-CONFIG_PM=y
 CONFIG_PM_DEBUG=y
 CONFIG_PM_TEST_SUSPEND=y
 CONFIG_NET=y
@@ -163,13 +162,13 @@ CONFIG_SPI_IMX=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_MC9S08DZ60=y
 CONFIG_GPIO_STMPE=y
+CONFIG_POWER_SUPPLY=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_IMX=y
 CONFIG_SENSORS_GPIO_FAN=y
 CONFIG_THERMAL=y
 CONFIG_CPU_THERMAL=y
 CONFIG_IMX_THERMAL=y
-CONFIG_POWER_SUPPLY=y
-CONFIG_POWER_RESET=y
-CONFIG_POWER_RESET_IMX=y
 CONFIG_WATCHDOG=y
 CONFIG_IMX2_WDT=y
 CONFIG_MFD_DA9052_I2C=y
@@ -198,7 +197,12 @@ CONFIG_SOC_CAMERA_OV2640=y
 CONFIG_IMX_IPUV3_CORE=y
 CONFIG_DRM=y
 CONFIG_DRM_PANEL_SIMPLE=y
-CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_DRM_IMX=y
+CONFIG_DRM_IMX_FB_HELPER=y
+CONFIG_DRM_IMX_PARALLEL_DISPLAY=y
+CONFIG_DRM_IMX_TVE=y
+CONFIG_DRM_IMX_LDB=y
+CONFIG_DRM_IMX_HDMI=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_L4F00242T03=y
 CONFIG_LCD_PLATFORM=y
@@ -257,13 +261,6 @@ CONFIG_IMX_SDMA=y
 CONFIG_MXS_DMA=y
 CONFIG_FSL_EDMA=y
 CONFIG_STAGING=y
-CONFIG_DRM_IMX=y
-CONFIG_DRM_IMX_FB_HELPER=y
-CONFIG_DRM_IMX_PARALLEL_DISPLAY=y
-CONFIG_DRM_IMX_TVE=y
-CONFIG_DRM_IMX_LDB=y
-CONFIG_DRM_IMX_IPUV3=y
-CONFIG_DRM_IMX_HDMI=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_PWM=y
 CONFIG_PWM_IMX=y
-- 
2.1.0
