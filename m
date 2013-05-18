From: gnurou@gmail.com (Alexandre Courbot)
Date: Sat, 18 May 2013 18:17:46 +0900
Subject: [PATCH] ARM: tegra: enable host1x support by default
Message-ID: <1368868666-24754-1-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tegra DRM support used to be enabled in the default Tegra configuration,
but it now depends on CONFIG_TEGRA_HOST1X which is disabled by default.
Enable CONFIG_TEGRA_HOST1X so that DRM support is compiled in again.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index a5f0485..dbf83db 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -153,6 +153,7 @@ CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
 CONFIG_DRM=y
+CONFIG_TEGRA_HOST1X=y
 CONFIG_DRM_TEGRA=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 # CONFIG_LCD_CLASS_DEVICE is not set
-- 
1.8.2.3
