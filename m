From: zyw@rock-chips.com (Chris Zhong)
Date: Wed, 15 Mar 2017 16:42:32 +0800
Subject: [PATCH 3/3] drm/rockchip/dsi: correct the grf_switch_reg name
In-Reply-To: <1489567352-3333-1-git-send-email-zyw@rock-chips.com>
References: <1489567352-3333-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1489567352-3333-3-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the RK3399, the grf_switch_reg name should be RK3399_GRF_SOC_CON20,
not RK3399_GRF_SOC_CON19.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index d8f24f2..ddd5dba 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -34,7 +34,7 @@
 #define RK3288_DSI0_SEL_VOP_LIT		BIT(6)
 #define RK3288_DSI1_SEL_VOP_LIT		BIT(9)
 
-#define RK3399_GRF_SOC_CON19		0x6250
+#define RK3399_GRF_SOC_CON20		0x6250
 #define RK3399_DSI0_SEL_VOP_LIT		BIT(0)
 #define RK3399_DSI1_SEL_VOP_LIT		BIT(4)
 
@@ -1146,7 +1146,7 @@ static struct dw_mipi_dsi_plat_data rk3288_mipi_dsi_drv_data = {
 static struct dw_mipi_dsi_plat_data rk3399_mipi_dsi_drv_data = {
 	.dsi0_en_bit = RK3399_DSI0_SEL_VOP_LIT,
 	.dsi1_en_bit = RK3399_DSI1_SEL_VOP_LIT,
-	.grf_switch_reg = RK3399_GRF_SOC_CON19,
+	.grf_switch_reg = RK3399_GRF_SOC_CON20,
 	.grf_dsi0_mode = RK3399_GRF_DSI_MODE,
 	.grf_dsi0_mode_reg = RK3399_GRF_SOC_CON22,
 	.max_data_lanes = 4,
-- 
2.6.3
