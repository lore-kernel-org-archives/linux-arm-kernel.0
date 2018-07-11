From: Anson.Huang@nxp.com (Anson Huang)
Date: Wed, 11 Jul 2018 08:58:58 +0800
Subject: [PATCH V2 1/2] clk: imx: add ocram_s clock for i.mx6sx
Message-ID: <1531270739-3075-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6SX has a 16KB always-on ocram bank called
ocram_s, and its clock gate in CCM CCGR1 CG14
needs to be enabled before access, add it to
clock tree.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	remove redefinition of IMX6SX_CLK_OCRAM_S to avoid build warning
 drivers/clk/imx/clk-imx6sx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index 10c771b..691db26 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -411,6 +411,7 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SX_CLK_GPT_BUS]      = imx_clk_gate2("gpt_bus",       "perclk",            base + 0x6c, 20);
 	clks[IMX6SX_CLK_GPT_SERIAL]   = imx_clk_gate2("gpt_serial",    "perclk",            base + 0x6c, 22);
 	clks[IMX6SX_CLK_GPU]          = imx_clk_gate2("gpu",           "gpu_core_podf",     base + 0x6c, 26);
+	clks[IMX6SX_CLK_OCRAM_S]      = imx_clk_gate2("ocram_s",       "ahb",               base + 0x6c, 28);
 	clks[IMX6SX_CLK_CANFD]        = imx_clk_gate2("canfd",         "can_podf",          base + 0x6c, 30);
 
 	/* CCGR2 */
-- 
2.7.4
