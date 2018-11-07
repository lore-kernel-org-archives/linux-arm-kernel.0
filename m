From: contact@paulk.fr (Paul Kocialkowski)
Date: Wed,  7 Nov 2018 19:18:36 +0100
Subject: [PATCH v3 1/8] drm/sun4i: tcon: Pass encoder to RGB setup function
In-Reply-To: <20181107181843.27628-1-contact@paulk.fr>
References: <20181107181843.27628-1-contact@paulk.fr>
Message-ID: <20181107181843.27628-2-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Passing the encoder to the TCON RGB setup functions allows accessing the
connector from the encoder directly instead of relying on the panel.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index f949287d926c..5e1f762fc3db 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -478,6 +478,7 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
 }
 
 static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
+				     const struct drm_encoder *encoder,
 				     const struct drm_display_mode *mode)
 {
 	unsigned int bp, hsync, vsync;
@@ -684,7 +685,7 @@ void sun4i_tcon_mode_set(struct sun4i_tcon *tcon,
 		sun4i_tcon0_mode_set_lvds(tcon, encoder, mode);
 		break;
 	case DRM_MODE_ENCODER_NONE:
-		sun4i_tcon0_mode_set_rgb(tcon, mode);
+		sun4i_tcon0_mode_set_rgb(tcon, encoder, mode);
 		sun4i_tcon_set_mux(tcon, 0, encoder);
 		break;
 	case DRM_MODE_ENCODER_TVDAC:
-- 
2.19.1
