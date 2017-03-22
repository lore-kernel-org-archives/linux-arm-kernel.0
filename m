From: zyw@rock-chips.com (Chris Zhong)
Date: Wed, 22 Mar 2017 09:54:51 +0800
Subject: [PATCH v4 4/4] drm/rockchip/dsi: correct the grf_switch_reg name
In-Reply-To: <1490147691-4489-1-git-send-email-zyw@rock-chips.com>
References: <1490147691-4489-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1490147691-4489-5-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the RK3399, the grf_switch_reg name should be RK3399_GRF_SOC_CON20,
not RK3399_GRF_SOC_CON19.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index dc8fd22..3aedcba 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -34,7 +34,7 @@
 #define RK3288_DSI0_SEL_VOP_LIT		BIT(6)
 #define RK3288_DSI1_SEL_VOP_LIT		BIT(9)
 
-#define RK3399_GRF_SOC_CON19		0x6250
+#define RK3399_GRF_SOC_CON20		0x6250
 #define RK3399_DSI0_SEL_VOP_LIT		BIT(0)
 #define RK3399_DSI1_SEL_VOP_LIT		BIT(4)
 
@@ -1151,7 +1151,7 @@ static struct dw_mipi_dsi_plat_data rk3288_mipi_dsi_drv_data = {
 static struct dw_mipi_dsi_plat_data rk3399_mipi_dsi_drv_data = {
 	.dsi0_en_bit = RK3399_DSI0_SEL_VOP_LIT,
 	.dsi1_en_bit = RK3399_DSI1_SEL_VOP_LIT,
-	.grf_switch_reg = RK3399_GRF_SOC_CON19,
+	.grf_switch_reg = RK3399_GRF_SOC_CON20,
 	.grf_dsi0_mode = RK3399_GRF_DSI_MODE,
 	.grf_dsi0_mode_reg = RK3399_GRF_SOC_CON22,
 	.flags = DW_MIPI_NEEDS_PHY_CFG_CLK | DW_MIPI_NEEDS_GRF_CLK,
-- 
2.6.3
