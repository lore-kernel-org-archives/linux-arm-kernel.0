From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 30 Nov 2017 10:10:03 +0100
Subject: [PATCH 1/2] ARM: exynos_defconfig: Enable missing drivers for
 supported Exynos boards
References: <CGME20171130091008eucas1p1968966968d4a0d5cc98d5f481744cd72@eucas1p1.samsung.com>
Message-ID: <20171130091004.22971-1-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable following drivers for recently merged devices:
- perf events and ARM PMU (Performance Measurement Unit) driver for all
  Exynos boards
- CEC and S5P CEC driver for all Exynos4 and Exynos5 boards with HDMI
- Sii9234 DRM HDMI-MHL bridge for Trats2
- dedicated Odroid ASoC machine driver for Odroid XU3/XU4

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/configs/exynos_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index f1d7834990ec..189877f923f8 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -3,6 +3,7 @@ CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_PERF_EVENTS=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
@@ -179,6 +180,7 @@ CONFIG_REGULATOR_TPS65090=y
 CONFIG_REGULATOR_WM8994=y
 CONFIG_MEDIA_SUPPORT=m
 CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_MEDIA_CEC_SUPPORT=y
 CONFIG_MEDIA_CONTROLLER=y
 CONFIG_VIDEO_V4L2_SUBDEV_API=y
 CONFIG_MEDIA_USB_SUPPORT=y
@@ -195,6 +197,8 @@ CONFIG_VIDEO_SAMSUNG_S5P_MFC=m
 CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC=m
 CONFIG_V4L_TEST_DRIVERS=y
 CONFIG_VIDEO_VIVID=m
+CONFIG_CEC_PLATFORM_DRIVERS=y
+CONFIG_VIDEO_SAMSUNG_S5P_CEC=m
 CONFIG_DRM=y
 CONFIG_DRM_EXYNOS=y
 CONFIG_DRM_EXYNOS_FIMD=y
@@ -207,6 +211,7 @@ CONFIG_DRM_PANEL_SAMSUNG_LD9040=y
 CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
 CONFIG_DRM_NXP_PTN3460=y
 CONFIG_DRM_PARADE_PS8622=y
+CONFIG_DRM_SII9234=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_PLATFORM=y
 CONFIG_BACKLIGHT_PWM=y
@@ -218,6 +223,7 @@ CONFIG_SND_SOC_SAMSUNG=y
 CONFIG_SND_SOC_SAMSUNG_SMDK_WM8994=y
 CONFIG_SND_SOC_SMDK_WM8994_PCM=y
 CONFIG_SND_SOC_SNOW=y
+CONFIG_SND_SOC_ODROID=y
 CONFIG_SND_SIMPLE_CARD=y
 CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
-- 
2.15.0
