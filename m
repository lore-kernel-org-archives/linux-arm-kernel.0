From: Anson.Huang@nxp.com (Anson Huang)
Date: Thu, 17 May 2018 13:00:48 +0800
Subject: [PATCH] clk: imx6sl: correct ocram_podf clock type
In-Reply-To: <1526533248-21990-1-git-send-email-Anson.Huang@nxp.com>
References: <1526533248-21990-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1526533248-21990-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IMX6SL_CLK_OCRAM_PODF is a busy divider, its name in
CCM_CDHIPR register of Reference Manual CCM chapter
is axi_podf_busy, correct its clock type.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx6sl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
index 9642cdf..66b1dd1 100644
--- a/drivers/clk/imx/clk-imx6sl.c
+++ b/drivers/clk/imx/clk-imx6sl.c
@@ -330,7 +330,7 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SL_CLK_PERIPH2] = imx_clk_busy_mux("periph2", base + 0x14, 26,  1,   base + 0x48, 3,  periph2_sels, ARRAY_SIZE(periph2_sels));
 
 	/*                                                   name                 parent_name          reg       shift width */
-	clks[IMX6SL_CLK_OCRAM_PODF]        = imx_clk_divider("ocram_podf",        "ocram_sel",         base + 0x14, 16, 3);
+	clks[IMX6SL_CLK_OCRAM_PODF]        = imx_clk_busy_divider("ocram_podf",   "ocram_sel",         base + 0x14, 16, 3, base + 0x48, 0);
 	clks[IMX6SL_CLK_PERIPH_CLK2_PODF]  = imx_clk_divider("periph_clk2_podf",  "periph_clk2_sel",   base + 0x14, 27, 3);
 	clks[IMX6SL_CLK_PERIPH2_CLK2_PODF] = imx_clk_divider("periph2_clk2_podf", "periph2_clk2_sel",  base + 0x14, 0,  3);
 	clks[IMX6SL_CLK_IPG]               = imx_clk_divider("ipg",               "ahb",               base + 0x14, 8,  2);
-- 
2.7.4
