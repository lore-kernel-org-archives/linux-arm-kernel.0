From: Anson.Huang@nxp.com (Anson Huang)
Date: Fri, 31 Aug 2018 15:53:15 +0800
Subject: [PATCH 4/7] clk: imx6sll: add mmdc1 ipg clock
In-Reply-To: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
References: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1535701998-20443-5-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6SLL has MMDC1 ipg clock in CCM CCGR, add it into
clock tree for clock management.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx6sll.c             | 1 +
 include/dt-bindings/clock/imx6sll-clock.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6sll.c b/drivers/clk/imx/clk-imx6sll.c
index 52379ee..3bd2044 100644
--- a/drivers/clk/imx/clk-imx6sll.c
+++ b/drivers/clk/imx/clk-imx6sll.c
@@ -293,6 +293,7 @@ static void __init imx6sll_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SLL_CLK_WDOG1]		= imx_clk_gate2("wdog1",	"ipg",		base + 0x74, 16);
 	clks[IMX6SLL_CLK_MMDC_P0_FAST]	= imx_clk_gate_flags("mmdc_p0_fast", "mmdc_podf",  base + 0x74,	20, CLK_IS_CRITICAL);
 	clks[IMX6SLL_CLK_MMDC_P0_IPG]	= imx_clk_gate2_flags("mmdc_p0_ipg", "ipg",	   base + 0x74,	24, CLK_IS_CRITICAL);
+	clks[IMX6SLL_CLK_MMDC_P1_IPG]	= imx_clk_gate2("mmdc_p1_ipg", "ipg",	   base + 0x74,	26);
 	clks[IMX6SLL_CLK_OCRAM]		= imx_clk_gate_flags("ocram","ahb",		   base + 0x74,	28, CLK_IS_CRITICAL);
 
 	/* CCGR4 */
diff --git a/include/dt-bindings/clock/imx6sll-clock.h b/include/dt-bindings/clock/imx6sll-clock.h
index 1036475..f446710 100644
--- a/include/dt-bindings/clock/imx6sll-clock.h
+++ b/include/dt-bindings/clock/imx6sll-clock.h
@@ -203,7 +203,8 @@
 #define IMX6SLL_CLK_GPIO4               176
 #define IMX6SLL_CLK_GPIO5               177
 #define IMX6SLL_CLK_GPIO6               178
+#define IMX6SLL_CLK_MMDC_P1_IPG		179
 
-#define IMX6SLL_CLK_END			179
+#define IMX6SLL_CLK_END			180
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6SLL_H */
-- 
2.7.4
