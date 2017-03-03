From: robin@protonic.nl (Robin van der Gracht)
Date: Fri,  3 Mar 2017 13:36:53 +0100
Subject: [PATCH] clk: imx: correct uart4_serial clock name in driver for
 i.MX6UL
Message-ID: <20170303123653.8931-1-robin@protonic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Robin van der Gracht <robin@protonic.nl>
---
 drivers/clk/imx/clk-imx6ul.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 0f1f17a..4dcd107 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -325,7 +325,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_GPT1_BUS]	= imx_clk_gate2("gpt1_bus",	"perclk",	base + 0x6c,	20);
 	clks[IMX6UL_CLK_GPT1_SERIAL]	= imx_clk_gate2("gpt1_serial",	"perclk",	base + 0x6c,	22);
 	clks[IMX6UL_CLK_UART4_IPG]	= imx_clk_gate2("uart4_ipg",	"ipg",		base + 0x6c,	24);
-	clks[IMX6UL_CLK_UART4_SERIAL]	= imx_clk_gate2("uart4_serail",	"uart_podf",	base + 0x6c,	24);
+	clks[IMX6UL_CLK_UART4_SERIAL]	= imx_clk_gate2("uart4_serial",	"uart_podf",	base + 0x6c,	24);
 
 	/* CCGR2 */
 	clks[IMX6UL_CLK_CSI]		= imx_clk_gate2("csi",		"csi_podf",		base + 0x70,	2);
-- 
2.9.3
