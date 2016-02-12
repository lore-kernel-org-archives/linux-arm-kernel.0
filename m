From: CARLOS.PALMINHA@synopsys.com (Carlos Palminha)
Date: Fri, 12 Feb 2016 13:54:04 +0000
Subject: [PATCH 06/17] drm/bochs: removed optional dummy encoder mode_fixup
 function.
Message-ID: <1455285244-2978-1-git-send-email-palminha@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 drivers/gpu/drm/bochs/bochs_kms.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 2849f1b..317c27f 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -152,13 +152,6 @@ static void bochs_crtc_init(struct drm_device *dev)
 	drm_crtc_helper_add(crtc, &bochs_helper_funcs);
 }
 
-static bool bochs_encoder_mode_fixup(struct drm_encoder *encoder,
-				     const struct drm_display_mode *mode,
-				     struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void bochs_encoder_mode_set(struct drm_encoder *encoder,
 				   struct drm_display_mode *mode,
 				   struct drm_display_mode *adjusted_mode)
@@ -179,7 +172,6 @@ static void bochs_encoder_commit(struct drm_encoder *encoder)
 
 static const struct drm_encoder_helper_funcs bochs_encoder_helper_funcs = {
 	.dpms = bochs_encoder_dpms,
-	.mode_fixup = bochs_encoder_mode_fixup,
 	.mode_set = bochs_encoder_mode_set,
 	.prepare = bochs_encoder_prepare,
 	.commit = bochs_encoder_commit,
-- 
2.5.0
