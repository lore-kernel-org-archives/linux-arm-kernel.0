From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  2 Nov 2016 10:23:45 +0100
Subject: [PATCH] arm64: defconfig: Enable DRM DU and V4L2 FCP + VSP modules
In-Reply-To: <cover.1478078567.git.horms+renesas@verge.net.au>
References: <cover.1478078567.git.horms+renesas@verge.net.au>
Message-ID: <833c97254724a620d1d9fb9a580681fb52536fbf.1478078567.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Extend the ARM64 defconfig to enable the DU DRM device as module
together with required dependencies of V4L2 FCP and VSP modules.

This enables VGA output on the r8a7795 Salvator-X board.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/configs/defconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index dab2cb0c1f1c..6eaf937ef5a4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -292,8 +292,22 @@ CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_QCOM_SMD_RPM=y
 CONFIG_REGULATOR_QCOM_SPMI=y
 CONFIG_REGULATOR_S2MPS11=y
+CONFIG_MEDIA_SUPPORT=m
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
+CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
+CONFIG_MEDIA_CONTROLLER=y
+CONFIG_VIDEO_V4L2_SUBDEV_API=y
+# CONFIG_DVB_NET is not set
+CONFIG_V4L_MEM2MEM_DRIVERS=y
+CONFIG_VIDEO_RENESAS_FCP=m
+CONFIG_VIDEO_RENESAS_VSP1=m
 CONFIG_DRM=m
 CONFIG_DRM_NOUVEAU=m
+CONFIG_DRM_RCAR_DU=m
+CONFIG_DRM_RCAR_HDMI=y
+CONFIG_DRM_RCAR_LVDS=y
+CONFIG_DRM_RCAR_VSP=y
 CONFIG_DRM_TEGRA=m
 CONFIG_DRM_PANEL_SIMPLE=m
 CONFIG_DRM_I2C_ADV7511=m
-- 
2.7.0.rc3.207.g0ac5344
