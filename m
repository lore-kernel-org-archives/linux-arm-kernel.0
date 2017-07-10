From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 10 Jul 2017 15:28:21 +0200
Subject: [PATCH 8/9] ARM: multi_v7_defconfig: Replace DRM_RCAR_HDMI by generic
 bridge options
In-Reply-To: <1499693302-25120-1-git-send-email-geert+renesas@glider.be>
References: <1499693302-25120-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1499693302-25120-9-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The manual bridge implementation was removed in favor of the generic
one, so now we need to enable standard bridge drivers like
DRM_DUMB_VGA_DAC and DRM_I2C_ADV7511.
Both were already enabled, but the (newer) ADV7511 audio part wasn't.

Fixes: 5c602531feb3db39 ("drm: rcar-du: Replace manual bridge implementation with DRM bridge")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
multi_v7_defconfig is in desperate need of a refresh.

To reduce conflicts, I went for the simple option of adding
CONFIG_DRM_I2C_ADV7511_AUDIO below CONFIG_DRM_I2C_ADV7511, instead of
moving CONFIG_DRM_I2C_ADV7511 and CONFIG_DRM_DUMB_VGA_DAC around.
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 7fa1746970ecc531..ea2075d8e185f7aa 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -584,6 +584,7 @@ CONFIG_VIDEO_ADV7180=m
 CONFIG_VIDEO_ML86V7667=m
 CONFIG_DRM=y
 CONFIG_DRM_I2C_ADV7511=m
+CONFIG_DRM_I2C_ADV7511_AUDIO=y
 # CONFIG_DRM_I2C_CH7006 is not set
 # CONFIG_DRM_I2C_SIL164 is not set
 CONFIG_DRM_DUMB_VGA_DAC=m
@@ -603,7 +604,6 @@ CONFIG_ROCKCHIP_DW_MIPI_DSI=y
 CONFIG_ROCKCHIP_INNO_HDMI=y
 CONFIG_DRM_ATMEL_HLCDC=m
 CONFIG_DRM_RCAR_DU=m
-CONFIG_DRM_RCAR_HDMI=y
 CONFIG_DRM_RCAR_LVDS=y
 CONFIG_DRM_SUN4I=m
 CONFIG_DRM_TEGRA=y
-- 
2.7.4
