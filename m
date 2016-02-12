From: CARLOS.PALMINHA@synopsys.com (Carlos Palminha)
Date: Fri, 12 Feb 2016 13:55:50 +0000
Subject: [PATCH 14/17] drm/radeon: removed optional dummy encoder mode_fixup
 function.
Message-ID: <1455285350-3403-1-git-send-email-palminha@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 drivers/gpu/drm/radeon/atombios_encoders.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
index 01b20e1..1603751 100644
--- a/drivers/gpu/drm/radeon/atombios_encoders.c
+++ b/drivers/gpu/drm/radeon/atombios_encoders.c
@@ -2623,16 +2623,8 @@ radeon_atom_ext_dpms(struct drm_encoder *encoder, int mode)
 
 }
 
-static bool radeon_atom_ext_mode_fixup(struct drm_encoder *encoder,
-				       const struct drm_display_mode *mode,
-				       struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static const struct drm_encoder_helper_funcs radeon_atom_ext_helper_funcs = {
 	.dpms = radeon_atom_ext_dpms,
-	.mode_fixup = radeon_atom_ext_mode_fixup,
 	.prepare = radeon_atom_ext_prepare,
 	.mode_set = radeon_atom_ext_mode_set,
 	.commit = radeon_atom_ext_commit,
-- 
2.5.0
