From: Anson.Huang@nxp.com (Anson Huang)
Date: Tue, 10 Jul 2018 16:39:38 +0800
Subject: [PATCH 1/2] clk: imx: add ocram_s clock for i.mx6sx
Message-ID: <1531211979-2179-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6SX has a 16KB always-on ocram bank called
ocram_s, and its clock gate in CCM CCGR1 CG14
needs to be enabled before access, add it to
clock tree.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx6sx.c             | 1 +
 include/dt-bindings/clock/imx6sx-clock.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

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
diff --git a/include/dt-bindings/clock/imx6sx-clock.h b/include/dt-bindings/clock/imx6sx-clock.h
index cd2d6c5..c1ccff8 100644
--- a/include/dt-bindings/clock/imx6sx-clock.h
+++ b/include/dt-bindings/clock/imx6sx-clock.h
@@ -279,6 +279,7 @@
 #define IMX6SX_CLK_LVDS2_OUT		266
 #define IMX6SX_CLK_LVDS2_IN		267
 #define IMX6SX_CLK_ANACLK2		268
-#define IMX6SX_CLK_CLK_END		269
+#define IMX6SX_CLK_OCRAM_S		269
+#define IMX6SX_CLK_CLK_END		270
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6SX_H */
-- 
2.7.4
