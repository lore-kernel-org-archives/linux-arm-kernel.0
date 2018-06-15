From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Fri, 15 Jun 2018 11:51:04 +0200
Subject: [PATCH v2 1/4] clk: imx7d: add IMX7D_MU_ROOT_CLK
In-Reply-To: <20180615095107.24610-1-o.rempel@pengutronix.de>
References: <20180615095107.24610-1-o.rempel@pengutronix.de>
Message-ID: <20180615095107.24610-2-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This clock is needed for iMX mailbox driver

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/clk/imx/clk-imx7d.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 975a20d3cc94..c7159bfac77a 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -795,6 +795,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_DRAM_ALT_ROOT_CLK] = imx_clk_gate4("dram_alt_root_clk", "dram_alt_post_div", base + 0x4130, 0);
 	clks[IMX7D_OCOTP_CLK] = imx_clk_gate4("ocotp_clk", "ipg_root_clk", base + 0x4230, 0);
 	clks[IMX7D_SNVS_CLK] = imx_clk_gate4("snvs_clk", "ipg_root_clk", base + 0x4250, 0);
+	clks[IMX7D_MU_ROOT_CLK] = imx_clk_gate4("mu_root_clk", "ipg_root_clk", base + 0x4270, 0);
 	clks[IMX7D_CAAM_CLK] = imx_clk_gate4("caam_clk", "ipg_root_clk", base + 0x4240, 0);
 	clks[IMX7D_USB_HSIC_ROOT_CLK] = imx_clk_gate4("usb_hsic_root_clk", "usb_hsic_post_div", base + 0x4690, 0);
 	clks[IMX7D_SDMA_CORE_CLK] = imx_clk_gate4("sdma_root_clk", "ahb_root_clk", base + 0x4480, 0);
-- 
2.17.1
