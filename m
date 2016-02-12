From: CARLOS.PALMINHA@synopsys.com (Carlos Palminha)
Date: Fri, 12 Feb 2016 13:56:02 +0000
Subject: [PATCH 15/17] drm/rockchip: removed optional dummy encoder mode_fixup
 function.
Message-ID: <1455285362-3450-1-git-send-email-palminha@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index f8f8f29..7766206 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -875,13 +875,6 @@ static void dw_mipi_dsi_encoder_disable(struct drm_encoder *encoder)
 	clk_disable_unprepare(dsi->pclk);
 }
 
-static bool dw_mipi_dsi_encoder_mode_fixup(struct drm_encoder *encoder,
-					const struct drm_display_mode *mode,
-					struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void dw_mipi_dsi_encoder_commit(struct drm_encoder *encoder)
 {
 	struct dw_mipi_dsi *dsi = encoder_to_dsi(encoder);
@@ -931,7 +924,6 @@ static void dw_mipi_dsi_encoder_commit(struct drm_encoder *encoder)
 
 static struct drm_encoder_helper_funcs
 dw_mipi_dsi_encoder_helper_funcs = {
-	.mode_fixup = dw_mipi_dsi_encoder_mode_fixup,
 	.commit = dw_mipi_dsi_encoder_commit,
 	.mode_set = dw_mipi_dsi_encoder_mode_set,
 	.disable = dw_mipi_dsi_encoder_disable,
-- 
2.5.0
