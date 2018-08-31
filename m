From: Anson.Huang@nxp.com (Anson Huang)
Date: Fri, 31 Aug 2018 15:53:14 +0800
Subject: [PATCH 3/7] clk: imx6sx: add mmdc1 ipg clock
In-Reply-To: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
References: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1535701998-20443-4-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6SX has MMDC1 ipg clock in CCM CCGR, add it into
clock tree for clock management.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx6sx.c             | 1 +
 include/dt-bindings/clock/imx6sx-clock.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index d9f2890..18527a3 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -431,6 +431,7 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SX_CLK_MLB]          = imx_clk_gate2("mlb",           "ahb",               base + 0x74, 18);
 	clks[IMX6SX_CLK_MMDC_P0_FAST] = imx_clk_gate2_flags("mmdc_p0_fast", "mmdc_podf", base + 0x74, 20, CLK_IS_CRITICAL);
 	clks[IMX6SX_CLK_MMDC_P0_IPG]  = imx_clk_gate2_flags("mmdc_p0_ipg", "ipg", base + 0x74, 24, CLK_IS_CRITICAL);
+	clks[IMX6SX_CLK_MMDC_P1_IPG]  = imx_clk_gate2("mmdc_p1_ipg", "ipg", base + 0x74, 26);
 	clks[IMX6SX_CLK_OCRAM]        = imx_clk_gate2_flags("ocram", "ocram_podf", base + 0x74, 28, CLK_IS_CRITICAL);
 
 	/* CCGR4 */
diff --git a/include/dt-bindings/clock/imx6sx-clock.h b/include/dt-bindings/clock/imx6sx-clock.h
index cd2d6c5..fb420c7 100644
--- a/include/dt-bindings/clock/imx6sx-clock.h
+++ b/include/dt-bindings/clock/imx6sx-clock.h
@@ -279,6 +279,7 @@
 #define IMX6SX_CLK_LVDS2_OUT		266
 #define IMX6SX_CLK_LVDS2_IN		267
 #define IMX6SX_CLK_ANACLK2		268
-#define IMX6SX_CLK_CLK_END		269
+#define IMX6SX_CLK_MMDC_P1_IPG		269
+#define IMX6SX_CLK_CLK_END		270
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6SX_H */
-- 
2.7.4
