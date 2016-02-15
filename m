From: CARLOS.PALMINHA@synopsys.com (Carlos Palminha)
Date: Mon, 15 Feb 2016 13:00:35 +0000
Subject: [PATCH v2 12/17] drm/mgag200: removed optional dummy encoder
 mode_fixup function.
In-Reply-To: <cover.1455540137.git.palminha@synopsys.com>
References: <cover.1455540137.git.palminha@synopsys.com>
Message-ID: <c5852d59a8890c3570ce97d16c0714a71eb61651.1455540137.git.palminha@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mode_fixup function for encoder drivers became optional with patch
http://patchwork.freedesktop.org/patch/msgid/1455106522-32307-1-git-send-email-palminha at synopsys.com

This patch set nukes all the dummy mode_fixup implementations.

(made on top of Daniel topic/drm-misc branch)

Signed-off-by: Carlos Palminha <palminha@synopsys.com>
---
 drivers/gpu/drm/mgag200/mgag200_mode.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index dc13c48..af8b4c1 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -1479,13 +1479,6 @@ void mga_crtc_fb_gamma_get(struct drm_crtc *crtc, u16 *red, u16 *green,
  * These functions are analagous to those in the CRTC code, but are intended
  * to handle any encoder-specific limitations
  */
-static bool mga_encoder_mode_fixup(struct drm_encoder *encoder,
-				   const struct drm_display_mode *mode,
-				   struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void mga_encoder_mode_set(struct drm_encoder *encoder,
 				struct drm_display_mode *mode,
 				struct drm_display_mode *adjusted_mode)
@@ -1515,7 +1508,6 @@ static void mga_encoder_destroy(struct drm_encoder *encoder)
 
 static const struct drm_encoder_helper_funcs mga_encoder_helper_funcs = {
 	.dpms = mga_encoder_dpms,
-	.mode_fixup = mga_encoder_mode_fixup,
 	.mode_set = mga_encoder_mode_set,
 	.prepare = mga_encoder_prepare,
 	.commit = mga_encoder_commit,
-- 
2.5.0
