From: CARLOS.PALMINHA@synopsys.com (Carlos Palminha)
Date: Mon, 15 Feb 2016 12:58:31 +0000
Subject: [PATCH v2 04/17] drm/amdgpu: removed optional dummy encoder
 mode_fixup function.
In-Reply-To: <cover.1455540137.git.palminha@synopsys.com>
References: <cover.1455540137.git.palminha@synopsys.com>
Message-ID: <8c4710ee930d2ab3a505b8d3cd724f4f4c79b3df.1455540137.git.palminha@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mode_fixup function for encoder drivers became optional with patch
http://patchwork.freedesktop.org/patch/msgid/1455106522-32307-1-git-send-email-palminha at synopsys.com

This patch set nukes all the dummy mode_fixup implementations.

(made on top of Daniel topic/drm-misc branch)

Signed-off-by: Carlos Palminha <palminha@synopsys.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 8 --------
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c | 8 --------
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 8 --------
 3 files changed, 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 093599a..3483018 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -3624,16 +3624,8 @@ dce_v10_0_ext_dpms(struct drm_encoder *encoder, int mode)
 
 }
 
-static bool dce_v10_0_ext_mode_fixup(struct drm_encoder *encoder,
-				    const struct drm_display_mode *mode,
-				    struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static const struct drm_encoder_helper_funcs dce_v10_0_ext_helper_funcs = {
 	.dpms = dce_v10_0_ext_dpms,
-	.mode_fixup = dce_v10_0_ext_mode_fixup,
 	.prepare = dce_v10_0_ext_prepare,
 	.mode_set = dce_v10_0_ext_mode_set,
 	.commit = dce_v10_0_ext_commit,
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index 8e67249..36deea1 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -3619,16 +3619,8 @@ dce_v11_0_ext_dpms(struct drm_encoder *encoder, int mode)
 
 }
 
-static bool dce_v11_0_ext_mode_fixup(struct drm_encoder *encoder,
-				    const struct drm_display_mode *mode,
-				    struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static const struct drm_encoder_helper_funcs dce_v11_0_ext_helper_funcs = {
 	.dpms = dce_v11_0_ext_dpms,
-	.mode_fixup = dce_v11_0_ext_mode_fixup,
 	.prepare = dce_v11_0_ext_prepare,
 	.mode_set = dce_v11_0_ext_mode_set,
 	.commit = dce_v11_0_ext_commit,
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index d0e128c..25dd8b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -3554,16 +3554,8 @@ dce_v8_0_ext_dpms(struct drm_encoder *encoder, int mode)
 
 }
 
-static bool dce_v8_0_ext_mode_fixup(struct drm_encoder *encoder,
-				    const struct drm_display_mode *mode,
-				    struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static const struct drm_encoder_helper_funcs dce_v8_0_ext_helper_funcs = {
 	.dpms = dce_v8_0_ext_dpms,
-	.mode_fixup = dce_v8_0_ext_mode_fixup,
 	.prepare = dce_v8_0_ext_prepare,
 	.mode_set = dce_v8_0_ext_mode_set,
 	.commit = dce_v8_0_ext_commit,
-- 
2.5.0
