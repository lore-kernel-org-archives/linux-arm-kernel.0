From: Guangyu.Chen@freescale.com (Nicolin Chen)
Date: Fri, 13 Dec 2013 23:44:08 +0800
Subject: [PATCH 2/2] ARM: imx6sl: Add missing spba clock to clock tree
In-Reply-To: <cover.1386949189.git.Guangyu.Chen@freescale.com>
References: <cover.1386949189.git.Guangyu.Chen@freescale.com>
Message-ID: <af095eb33a2e5083bde4066bc1c910276d72daa1.1386949189.git.Guangyu.Chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are missing spba clock in imx6sl's clock tree, thus add it.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 arch/arm/mach-imx/clk-imx6sl.c           | 1 +
 include/dt-bindings/clock/imx6sl-clock.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx6sl.c b/arch/arm/mach-imx/clk-imx6sl.c
index 5eb5522..3781a18 100644
--- a/arch/arm/mach-imx/clk-imx6sl.c
+++ b/arch/arm/mach-imx/clk-imx6sl.c
@@ -233,6 +233,7 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SL_CLK_PWM3]         = imx_clk_gate2("pwm3",         "perclk",            base + 0x78, 20);
 	clks[IMX6SL_CLK_PWM4]         = imx_clk_gate2("pwm4",         "perclk",            base + 0x78, 22);
 	clks[IMX6SL_CLK_SDMA]         = imx_clk_gate2("sdma",         "ipg",               base + 0x7c, 6);
+	clks[IMX6SL_CLK_SPBA]         = imx_clk_gate2("spba",         "ipg",               base + 0x7c, 12);
 	clks[IMX6SL_CLK_SPDIF]        = imx_clk_gate2("spdif",        "spdif0_podf",       base + 0x7c, 14);
 	clks[IMX6SL_CLK_SSI1]         = imx_clk_gate2("ssi1",         "ssi1_podf",         base + 0x7c, 18);
 	clks[IMX6SL_CLK_SSI2]         = imx_clk_gate2("ssi2",         "ssi2_podf",         base + 0x7c, 20);
diff --git a/include/dt-bindings/clock/imx6sl-clock.h b/include/dt-bindings/clock/imx6sl-clock.h
index 4735e84..7cf5c99 100644
--- a/include/dt-bindings/clock/imx6sl-clock.h
+++ b/include/dt-bindings/clock/imx6sl-clock.h
@@ -144,6 +144,7 @@
 #define IMX6SL_CLK_USDHC3		131
 #define IMX6SL_CLK_USDHC4		132
 #define IMX6SL_CLK_PLL4_AUDIO_DIV	133
-#define IMX6SL_CLK_END			134
+#define IMX6SL_CLK_SPBA			134
+#define IMX6SL_CLK_END			135
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6SL_H */
-- 
1.8.4
