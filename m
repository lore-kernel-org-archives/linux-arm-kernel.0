From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 10 Jul 2017 15:28:17 +0200
Subject: [PATCH 4/9] ARM: shmobile: defconfig: Replace DRM_RCAR_HDMI by
 generic bridge options
In-Reply-To: <1499693302-25120-1-git-send-email-geert+renesas@glider.be>
References: <1499693302-25120-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1499693302-25120-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The manual bridge implementation was removed in favor of the generic
one, so now we need to enable standard bridge drivers like
DRM_DUMB_VGA_DAC and DRM_I2C_ADV7511.
DRM_I2C_ADV7511 was already enabled, but the (newer) audio part wasn't.

Fixes: 5c602531feb3db39 ("drm: rcar-du: Replace manual bridge implementation with DRM bridge")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/configs/shmobile_defconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index ab9a45938c3cd34f..b8d2dcbc9cc745b6 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -154,10 +154,11 @@ CONFIG_VIDEO_ADV7180=y
 CONFIG_VIDEO_ADV7604=y
 CONFIG_VIDEO_ML86V7667=y
 CONFIG_DRM=y
-CONFIG_DRM_I2C_ADV7511=y
 CONFIG_DRM_RCAR_DU=y
-CONFIG_DRM_RCAR_HDMI=y
 CONFIG_DRM_RCAR_LVDS=y
+CONFIG_DRM_DUMB_VGA_DAC=y
+CONFIG_DRM_I2C_ADV7511=y
+CONFIG_DRM_I2C_ADV7511_AUDIO=y
 CONFIG_FB_SH_MOBILE_LCDC=y
 CONFIG_FB_SH_MOBILE_MERAM=y
 # CONFIG_LCD_CLASS_DEVICE is not set
-- 
2.7.4
