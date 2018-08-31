From: Anson.Huang@nxp.com (Anson Huang)
Date: Fri, 31 Aug 2018 15:53:13 +0800
Subject: [PATCH 2/7] clk: imx6ul: add mmdc1 ipg clock
In-Reply-To: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
References: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1535701998-20443-3-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6UL has MMDC1 ipg clock in CCM CCGR, add it into
clock tree for clock management.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx6ul.c             | 1 +
 include/dt-bindings/clock/imx6ul-clock.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 361b43f..fd60d15 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -408,6 +408,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_WDOG1]		= imx_clk_gate2("wdog1",	"ipg",		base + 0x74,	16);
 	clks[IMX6UL_CLK_MMDC_P0_FAST]	= imx_clk_gate_flags("mmdc_p0_fast", "mmdc_podf", base + 0x74,	20, CLK_IS_CRITICAL);
 	clks[IMX6UL_CLK_MMDC_P0_IPG]	= imx_clk_gate2_flags("mmdc_p0_ipg",	"ipg",		base + 0x74,	24, CLK_IS_CRITICAL);
+	clks[IMX6UL_CLK_MMDC_P1_IPG]	= imx_clk_gate2("mmdc_p1_ipg",	"ipg",		base + 0x74,	26);
 	clks[IMX6UL_CLK_AXI]		= imx_clk_gate_flags("axi",	"axi_podf",	base + 0x74,	28, CLK_IS_CRITICAL);
 
 	/* CCGR4 */
diff --git a/include/dt-bindings/clock/imx6ul-clock.h b/include/dt-bindings/clock/imx6ul-clock.h
index f8e0476..f718aac 100644
--- a/include/dt-bindings/clock/imx6ul-clock.h
+++ b/include/dt-bindings/clock/imx6ul-clock.h
@@ -259,7 +259,8 @@
 #define IMX6UL_CLK_GPIO3		246
 #define IMX6UL_CLK_GPIO4		247
 #define IMX6UL_CLK_GPIO5		248
+#define IMX6UL_CLK_MMDC_P1_IPG		249
 
-#define IMX6UL_CLK_END			249
+#define IMX6UL_CLK_END			250
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6UL_H */
-- 
2.7.4
