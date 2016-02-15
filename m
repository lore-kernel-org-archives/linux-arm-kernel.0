From: CARLOS.PALMINHA@synopsys.com (Carlos Palminha)
Date: Mon, 15 Feb 2016 13:00:54 +0000
Subject: [PATCH v2 13/17] drm/qxl: removed optional dummy encoder mode_fixup
 function.
In-Reply-To: <cover.1455540137.git.palminha@synopsys.com>
References: <cover.1455540137.git.palminha@synopsys.com>
Message-ID: <f35bc322f7af69ba0fea734d58b4daf5e0cd9786.1455540137.git.palminha@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mode_fixup function for encoder drivers became optional with patch
http://patchwork.freedesktop.org/patch/msgid/1455106522-32307-1-git-send-email-palminha at synopsys.com

This patch set nukes all the dummy mode_fixup implementations.

(made on top of Daniel topic/drm-misc branch)

Signed-off-by: Carlos Palminha <palminha@synopsys.com>
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
