From: CARLOS.PALMINHA@synopsys.com (Carlos Palminha)
Date: Mon, 15 Feb 2016 13:01:25 +0000
Subject: [PATCH v2 16/17] drm/sti: removed optional dummy encoder mode_fixup
 function.
In-Reply-To: <cover.1455540137.git.palminha@synopsys.com>
References: <cover.1455540137.git.palminha@synopsys.com>
Message-ID: <7f47c6a7b00e4f16af672ebf3a277e31ad117e21.1455540137.git.palminha@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mode_fixup function for encoder drivers became optional with patch
http://patchwork.freedesktop.org/patch/msgid/1455106522-32307-1-git-send-email-palminha at synopsys.com

This patch set nukes all the dummy mode_fixup implementations.

(made on top of Daniel topic/drm-misc branch)

Signed-off-by: Carlos Palminha <palminha@synopsys.com>
---
 drivers/gpu/drm/sti/sti_tvout.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_tvout.c b/drivers/gpu/drm/sti/sti_tvout.c
index f2afcf5..24a3735 100644
--- a/drivers/gpu/drm/sti/sti_tvout.c
+++ b/drivers/gpu/drm/sti/sti_tvout.c
@@ -440,13 +440,6 @@ static void sti_tvout_encoder_dpms(struct drm_encoder *encoder, int mode)
 {
 }
 
-static bool sti_tvout_encoder_mode_fixup(struct drm_encoder *encoder,
-				       const struct drm_display_mode *mode,
-				       struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void sti_tvout_encoder_mode_set(struct drm_encoder *encoder,
 				       struct drm_display_mode *mode,
 				       struct drm_display_mode *adjusted_mode)
@@ -486,7 +479,6 @@ static void sti_dvo_encoder_disable(struct drm_encoder *encoder)
 
 static const struct drm_encoder_helper_funcs sti_dvo_encoder_helper_funcs = {
 	.dpms = sti_tvout_encoder_dpms,
-	.mode_fixup = sti_tvout_encoder_mode_fixup,
 	.mode_set = sti_tvout_encoder_mode_set,
 	.prepare = sti_tvout_encoder_prepare,
 	.commit = sti_dvo_encoder_commit,
@@ -540,7 +532,6 @@ static void sti_hda_encoder_disable(struct drm_encoder *encoder)
 
 static const struct drm_encoder_helper_funcs sti_hda_encoder_helper_funcs = {
 	.dpms = sti_tvout_encoder_dpms,
-	.mode_fixup = sti_tvout_encoder_mode_fixup,
 	.mode_set = sti_tvout_encoder_mode_set,
 	.prepare = sti_tvout_encoder_prepare,
 	.commit = sti_hda_encoder_commit,
@@ -589,7 +580,6 @@ static void sti_hdmi_encoder_disable(struct drm_encoder *encoder)
 
 static const struct drm_encoder_helper_funcs sti_hdmi_encoder_helper_funcs = {
 	.dpms = sti_tvout_encoder_dpms,
-	.mode_fixup = sti_tvout_encoder_mode_fixup,
 	.mode_set = sti_tvout_encoder_mode_set,
 	.prepare = sti_tvout_encoder_prepare,
 	.commit = sti_hdmi_encoder_commit,
-- 
2.5.0
