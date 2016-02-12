From: CARLOS.PALMINHA@synopsys.com (Carlos Palminha)
Date: Fri, 12 Feb 2016 13:50:54 +0000
Subject: [PATCH 02/17] drm/udl: removed optional dummy encoder mode_fixup
 function.
In-Reply-To: <1455285069-2819-1-git-send-email-palminha@synopsys.com>
References: <daniel.vetter@ffwll.ch,>
 <1455285069-2819-1-git-send-email-palminha@synopsys.com>
Message-ID: <1455285069-2819-3-git-send-email-palminha@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 drivers/gpu/drm/udl/udl_encoder.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_encoder.c b/drivers/gpu/drm/udl/udl_encoder.c
index a181a64..59a4b34 100644
--- a/drivers/gpu/drm/udl/udl_encoder.c
+++ b/drivers/gpu/drm/udl/udl_encoder.c
@@ -26,13 +26,6 @@ static void udl_encoder_disable(struct drm_encoder *encoder)
 {
 }
 
-static bool udl_mode_fixup(struct drm_encoder *encoder,
-			   const struct drm_display_mode *mode,
-			   struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void udl_encoder_prepare(struct drm_encoder *encoder)
 {
 }
@@ -54,7 +47,6 @@ udl_encoder_dpms(struct drm_encoder *encoder, int mode)
 
 static const struct drm_encoder_helper_funcs udl_helper_funcs = {
 	.dpms = udl_encoder_dpms,
-	.mode_fixup = udl_mode_fixup,
 	.prepare = udl_encoder_prepare,
 	.mode_set = udl_encoder_mode_set,
 	.commit = udl_encoder_commit,
-- 
2.5.0
