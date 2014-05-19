From: b38611@freescale.com (Fugang Duan)
Date: Mon, 19 May 2014 15:46:41 +0800
Subject: [PATCH 1/2] ARM: imx6sl: add missing enet clock for imx6sl
Message-ID: <1400485601-2896-1-git-send-email-b38611@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's a enet clock gate missing in clock tree, thus add it.

Signed-off-by: Fugang Duan <B38611@freescale.com>
---
 arch/arm/mach-imx/clk-imx6sl.c           |    1 +
 include/dt-bindings/clock/imx6sl-clock.h |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6sl.c b/arch/arm/mach-imx/clk-imx6sl.c
index 21cf06c..5408ca7 100644
--- a/arch/arm/mach-imx/clk-imx6sl.c
+++ b/arch/arm/mach-imx/clk-imx6sl.c
@@ -312,6 +312,7 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SL_CLK_ECSPI2]       = imx_clk_gate2("ecspi2",       "ecspi_root",        base + 0x6c, 2);
 	clks[IMX6SL_CLK_ECSPI3]       = imx_clk_gate2("ecspi3",       "ecspi_root",        base + 0x6c, 4);
 	clks[IMX6SL_CLK_ECSPI4]       = imx_clk_gate2("ecspi4",       "ecspi_root",        base + 0x6c, 6);
+	clks[IMX6SL_CLK_ENET]         = imx_clk_gate2("enet",         "ipg",               base + 0x6c, 10);
 	clks[IMX6SL_CLK_EPIT1]        = imx_clk_gate2("epit1",        "perclk",            base + 0x6c, 12);
 	clks[IMX6SL_CLK_EPIT2]        = imx_clk_gate2("epit2",        "perclk",            base + 0x6c, 14);
 	clks[IMX6SL_CLK_EXTERN_AUDIO] = imx_clk_gate2("extern_audio", "extern_audio_podf", base + 0x6c, 16);
diff --git a/include/dt-bindings/clock/imx6sl-clock.h b/include/dt-bindings/clock/imx6sl-clock.h
index 7cf5c99..b91dd46 100644
--- a/include/dt-bindings/clock/imx6sl-clock.h
+++ b/include/dt-bindings/clock/imx6sl-clock.h
@@ -145,6 +145,7 @@
 #define IMX6SL_CLK_USDHC4		132
 #define IMX6SL_CLK_PLL4_AUDIO_DIV	133
 #define IMX6SL_CLK_SPBA			134
-#define IMX6SL_CLK_END			135
+#define IMX6SL_CLK_ENET			135
+#define IMX6SL_CLK_END			136
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6SL_H */
-- 
1.7.8
