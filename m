From: CARLOS.PALMINHA@synopsys.com (Carlos Palminha)
Date: Mon, 15 Feb 2016 12:57:58 +0000
Subject: [PATCH v2 02/17] drm/udl: removed optional dummy encoder mode_fixup
 function.
In-Reply-To: <cover.1455540137.git.palminha@synopsys.com>
References: <cover.1455540137.git.palminha@synopsys.com>
Message-ID: <a7ebfb6c6c333056d0a77d2684c539107ee63589.1455540137.git.palminha@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mode_fixup function for encoder drivers became optional with patch
http://patchwork.freedesktop.org/patch/msgid/1455106522-32307-1-git-send-email-palminha at synopsys.com

This patch set nukes all the dummy mode_fixup implementations.

(made on top of Daniel topic/drm-misc branch)

Signed-off-by: Carlos Palminha <palminha@synopsys.com>
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
