From: CARLOS.PALMINHA@synopsys.com (Carlos Palminha)
Date: Mon, 15 Feb 2016 12:59:23 +0000
Subject: [PATCH v2 07/17] drm/cirrus: removed optional dummy encoder
 mode_fixup function.
In-Reply-To: <cover.1455540137.git.palminha@synopsys.com>
References: <cover.1455540137.git.palminha@synopsys.com>
Message-ID: <a53767402bd4a69c3d2a546b7f4d4d122134b545.1455540137.git.palminha@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mode_fixup function for encoder drivers became optional with patch
http://patchwork.freedesktop.org/patch/msgid/1455106522-32307-1-git-send-email-palminha at synopsys.com

This patch set nukes all the dummy mode_fixup implementations.

(made on top of Daniel topic/drm-misc branch)

Signed-off-by: Carlos Palminha <palminha@synopsys.com>
---
 drivers/gpu/drm/cirrus/cirrus_mode.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/cirrus/cirrus_mode.c b/drivers/gpu/drm/cirrus/cirrus_mode.c
index 4a02854..432ce94 100644
--- a/drivers/gpu/drm/cirrus/cirrus_mode.c
+++ b/drivers/gpu/drm/cirrus/cirrus_mode.c
@@ -430,14 +430,6 @@ void cirrus_crtc_fb_gamma_get(struct drm_crtc *crtc, u16 *red, u16 *green,
 	*blue = cirrus_crtc->lut_b[regno];
 }
 
-
-static bool cirrus_encoder_mode_fixup(struct drm_encoder *encoder,
-				      const struct drm_display_mode *mode,
-				      struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void cirrus_encoder_mode_set(struct drm_encoder *encoder,
 				struct drm_display_mode *mode,
 				struct drm_display_mode *adjusted_mode)
@@ -466,7 +458,6 @@ static void cirrus_encoder_destroy(struct drm_encoder *encoder)
 
 static const struct drm_encoder_helper_funcs cirrus_encoder_helper_funcs = {
 	.dpms = cirrus_encoder_dpms,
-	.mode_fixup = cirrus_encoder_mode_fixup,
 	.mode_set = cirrus_encoder_mode_set,
 	.prepare = cirrus_encoder_prepare,
 	.commit = cirrus_encoder_commit,
-- 
2.5.0
