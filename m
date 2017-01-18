From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Wed, 18 Jan 2017 15:53:57 -0200
Subject: [PATCH 2/2] clk: imx7d: Add the IPG root clock
In-Reply-To: <1484762037-10737-1-git-send-email-fabio.estevam@nxp.com>
References: <1484762037-10737-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <1484762037-10737-2-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an entry for the IMX7D_IPG_ROOT clock.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index ae1d31b..1705f44 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -788,7 +788,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_WRCLK_ROOT_DIV] = imx_clk_divider2("wrclk_post_div", "wrclk_pre_div", base + 0xbd00, 0, 6);
 	clks[IMX7D_CLKO1_ROOT_DIV] = imx_clk_divider2("clko1_post_div", "clko1_pre_div", base + 0xbd80, 0, 6);
 	clks[IMX7D_CLKO2_ROOT_DIV] = imx_clk_divider2("clko2_post_div", "clko2_pre_div", base + 0xbe00, 0, 6);
-
+	clks[IMX7D_IPG_ROOT_CLK] = imx_clk_divider2("ipg_root_clk", "ahb_root_clk", base + 0x9080, 0, 2);
 	clks[IMX7D_ARM_A7_ROOT_CLK] = imx_clk_gate4("arm_a7_root_clk", "arm_a7_div", base + 0x4000, 0);
 	clks[IMX7D_ARM_M4_ROOT_CLK] = imx_clk_gate4("arm_m4_root_clk", "arm_m4_div", base + 0x4010, 0);
 	clks[IMX7D_ARM_M0_ROOT_CLK] = imx_clk_gate4("arm_m0_root_clk", "arm_m0_div", base + 0x4020, 0);
-- 
2.7.4
