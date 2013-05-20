From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 20 May 2013 13:07:19 -0600
Subject: [PATCH] ARM: tegra: defconfig fixes
Message-ID: <1369076839-31787-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexandre Courbot <gnurou@gmail.com>

The AK8975 Kconfig option was renamed during the 3.10 merge window.
Adjust tegra_defconfig to enable the new name, so it's not missing
useful features.

Tegra DRM support used to be enabled in the default Tegra configuration,
but it now depends on CONFIG_TEGRA_HOST1X which is disabled by default.
Enable CONFIG_TEGRA_HOST1X so that DRM support is compiled in again.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
[swarren, squashed Alex's and my changes together]
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Olof, Arnd,

Can this be taken into 3.10? Hopefully Linus won't mind defconfig changes
sneaking in now. If not, let me know, and I'll for it into Tegra's
for-3.11/dt branch instead. Thanks.

 arch/arm/configs/tegra_defconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index a5f0485..f7ba3161 100644
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
@@ -202,7 +203,7 @@ CONFIG_TEGRA20_APB_DMA=y
 CONFIG_STAGING=y
 CONFIG_SENSORS_ISL29018=y
 CONFIG_SENSORS_ISL29028=y
-CONFIG_SENSORS_AK8975=y
+CONFIG_AK8975=y
 CONFIG_MFD_NVEC=y
 CONFIG_KEYBOARD_NVEC=y
 CONFIG_SERIO_NVEC_PS2=y
-- 
1.7.10.4
