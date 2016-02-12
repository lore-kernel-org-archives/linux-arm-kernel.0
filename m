From: CARLOS.PALMINHA@synopsys.com (Carlos Palminha)
Date: Fri, 12 Feb 2016 13:53:28 +0000
Subject: [PATCH 05/17] drm/ast: removed optional dummy encoder mode_fixup
 function.
Message-ID: <1455285208-2889-1-git-send-email-palminha@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 drivers/gpu/drm/ast/ast_mode.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 0123458..f221e2d 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -710,13 +710,6 @@ static void ast_encoder_dpms(struct drm_encoder *encoder, int mode)
 
 }
 
-static bool ast_mode_fixup(struct drm_encoder *encoder,
-			   const struct drm_display_mode *mode,
-			   struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void ast_encoder_mode_set(struct drm_encoder *encoder,
 			       struct drm_display_mode *mode,
 			       struct drm_display_mode *adjusted_mode)
@@ -736,7 +729,6 @@ static void ast_encoder_commit(struct drm_encoder *encoder)
 
 static const struct drm_encoder_helper_funcs ast_enc_helper_funcs = {
 	.dpms = ast_encoder_dpms,
-	.mode_fixup = ast_mode_fixup,
 	.prepare = ast_encoder_prepare,
 	.commit = ast_encoder_commit,
 	.mode_set = ast_encoder_mode_set,
-- 
2.5.0
