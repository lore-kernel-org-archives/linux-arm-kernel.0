From: CARLOS.PALMINHA@synopsys.com (Carlos Palminha)
Date: Fri, 12 Feb 2016 13:55:37 +0000
Subject: [PATCH 13/17] drm/qxl: removed optional dummy encoder mode_fixup
 function.
Message-ID: <1455285337-3356-1-git-send-email-palminha@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 drivers/gpu/drm/qxl/qxl_display.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 8627651..43e5f50 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -734,14 +734,6 @@ static void qxl_enc_dpms(struct drm_encoder *encoder, int mode)
 	DRM_DEBUG("\n");
 }
 
-static bool qxl_enc_mode_fixup(struct drm_encoder *encoder,
-			       const struct drm_display_mode *mode,
-			       struct drm_display_mode *adjusted_mode)
-{
-	DRM_DEBUG("\n");
-	return true;
-}
-
 static void qxl_enc_prepare(struct drm_encoder *encoder)
 {
 	DRM_DEBUG("\n");
@@ -864,7 +856,6 @@ static struct drm_encoder *qxl_best_encoder(struct drm_connector *connector)
 
 static const struct drm_encoder_helper_funcs qxl_enc_helper_funcs = {
 	.dpms = qxl_enc_dpms,
-	.mode_fixup = qxl_enc_mode_fixup,
 	.prepare = qxl_enc_prepare,
 	.mode_set = qxl_enc_mode_set,
 	.commit = qxl_enc_commit,
-- 
2.5.0
