From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 20 Jan 2016 11:09:07 +0100
Subject: [PATCHv2 14/16] clk: imx: add kpp clock for i.MX6UL
In-Reply-To: <1453284549-16363-1-git-send-email-LW@KARO-electronics.de>
References: <1452619291-13625-1-git-send-email-LW@KARO-electronics.de>
 <1453284549-16363-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1453284549-16363-15-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the necessary clock to use the KPP interface on i.MX6UL.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/clk/imx/clk-imx6ul.c             | 1 +
 include/dt-bindings/clock/imx6ul-clock.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 3e31ec0..1ee28d3 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -365,6 +365,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	/* CCGR5 */
 	clks[IMX6UL_CLK_ROM]		= imx_clk_gate2("rom",		"ahb",		base + 0x7c,	0);
 	clks[IMX6UL_CLK_SDMA]		= imx_clk_gate2("sdma",		"ahb",		base + 0x7c,	6);
+	clks[IMX6UL_CLK_KPP]		= imx_clk_gate2("kpp",		"ipg",		base + 0x7c,	8);
 	clks[IMX6UL_CLK_WDOG2]		= imx_clk_gate2("wdog2",	"ipg",		base + 0x7c,	10);
 	clks[IMX6UL_CLK_SPBA]		= imx_clk_gate2("spba",		"ipg",		base + 0x7c,	12);
 	clks[IMX6UL_CLK_SPDIF]		= imx_clk_gate2_shared("spdif",		"spdif_podf",	base + 0x7c,	14, &share_count_audio);
diff --git a/include/dt-bindings/clock/imx6ul-clock.h b/include/dt-bindings/clock/imx6ul-clock.h
index 08ce4a7..fd8aee8 100644
--- a/include/dt-bindings/clock/imx6ul-clock.h
+++ b/include/dt-bindings/clock/imx6ul-clock.h
@@ -234,7 +234,8 @@
 #define IMX6UL_CLK_CSI_SEL		221
 #define IMX6UL_CLK_CSI_PODF		222
 #define IMX6UL_CLK_PLL3_120M		223
+#define IMX6UL_CLK_KPP			224
 
-#define IMX6UL_CLK_END			224
+#define IMX6UL_CLK_END			225
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6UL_H */
-- 
2.1.4
