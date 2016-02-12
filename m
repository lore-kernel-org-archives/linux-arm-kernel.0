From: CARLOS.PALMINHA@synopsys.com (Carlos Palminha)
Date: Fri, 12 Feb 2016 13:50:03 +0000
Subject: [PATCH 03/17] drm/exynos: removed optional dummy encoder mode_fixup
 function.
In-Reply-To: <1455285017-2771-1-git-send-email-palminha@synopsys.com>
References: <1455285017-2771-1-git-send-email-palminha@synopsys.com>
Message-ID: <1455285017-2771-4-git-send-email-palminha@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index e977a81..736115c 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1597,13 +1597,6 @@ static int exynos_dsi_create_connector(struct drm_encoder *encoder)
 	return 0;
 }
 
-static bool exynos_dsi_mode_fixup(struct drm_encoder *encoder,
-				  const struct drm_display_mode *mode,
-				  struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void exynos_dsi_mode_set(struct drm_encoder *encoder,
 				struct drm_display_mode *mode,
 				struct drm_display_mode *adjusted_mode)
@@ -1623,7 +1616,6 @@ static void exynos_dsi_mode_set(struct drm_encoder *encoder,
 }
 
 static const struct drm_encoder_helper_funcs exynos_dsi_encoder_helper_funcs = {
-	.mode_fixup = exynos_dsi_mode_fixup,
 	.mode_set = exynos_dsi_mode_set,
 	.enable = exynos_dsi_enable,
 	.disable = exynos_dsi_disable,
-- 
2.5.0
