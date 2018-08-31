From: Anson.Huang@nxp.com (Anson Huang)
Date: Fri, 31 Aug 2018 15:53:16 +0800
Subject: [PATCH 5/7] clk: imx6sl: add mmdc ipg clocks
In-Reply-To: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
References: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1535701998-20443-6-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6SL has MMDC0 and MMDC1 ipg clock in CCM CCGR, add them into
clock tree for clock management.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx6sl.c             | 2 ++
 include/dt-bindings/clock/imx6sl-clock.h | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
index eb6bcbf..6fcfbbd 100644
--- a/drivers/clk/imx/clk-imx6sl.c
+++ b/drivers/clk/imx/clk-imx6sl.c
@@ -386,6 +386,8 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SL_CLK_LCDIF_AXI]    = imx_clk_gate2("lcdif_axi",    "lcdif_axi_podf",    base + 0x74, 6);
 	clks[IMX6SL_CLK_LCDIF_PIX]    = imx_clk_gate2("lcdif_pix",    "lcdif_pix_podf",    base + 0x74, 8);
 	clks[IMX6SL_CLK_EPDC_PIX]     = imx_clk_gate2("epdc_pix",     "epdc_pix_podf",     base + 0x74, 10);
+	clks[IMX6SL_CLK_MMDC_P0_IPG]  = imx_clk_gate2_flags("mmdc_p0_ipg",  "ipg",         base + 0x74,	24, CLK_IS_CRITICAL);
+	clks[IMX6SL_CLK_MMDC_P1_IPG]  = imx_clk_gate2("mmdc_p1_ipg",  "ipg",	  	   base + 0x74,	26);
 	clks[IMX6SL_CLK_OCRAM]        = imx_clk_gate2("ocram",        "ocram_podf",        base + 0x74, 28);
 	clks[IMX6SL_CLK_PWM1]         = imx_clk_gate2("pwm1",         "perclk",            base + 0x78, 16);
 	clks[IMX6SL_CLK_PWM2]         = imx_clk_gate2("pwm2",         "perclk",            base + 0x78, 18);
diff --git a/include/dt-bindings/clock/imx6sl-clock.h b/include/dt-bindings/clock/imx6sl-clock.h
index e14573e..cfbfc39 100644
--- a/include/dt-bindings/clock/imx6sl-clock.h
+++ b/include/dt-bindings/clock/imx6sl-clock.h
@@ -175,6 +175,8 @@
 #define IMX6SL_CLK_SSI2_IPG		162
 #define IMX6SL_CLK_SSI3_IPG		163
 #define IMX6SL_CLK_SPDIF_GCLK		164
-#define IMX6SL_CLK_END			165
+#define IMX6SL_CLK_MMDC_P0_IPG		165
+#define IMX6SL_CLK_MMDC_P1_IPG		166
+#define IMX6SL_CLK_END			167
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6SL_H */
-- 
2.7.4
