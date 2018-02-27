From: stefan@agner.ch (Stefan Agner)
Date: Tue, 27 Feb 2018 17:05:43 +0100
Subject: [PATCH 1/2] clk: imx: imx7d: add the Keypad Port module clock
Message-ID: <20180227160544.11446-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the i.MX7D Reference Manual, the Keypad Port module
(KPP) requires this clock gate to be enabled.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/clk/imx/clk-imx7d.c             | 1 +
 include/dt-bindings/clock/imx7d-clock.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index f34f1ecc4690..6b6e8851eabb 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -858,6 +858,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_WDOG2_ROOT_CLK] = imx_clk_gate4("wdog2_root_clk", "wdog_post_div", base + 0x49d0, 0);
 	clks[IMX7D_WDOG3_ROOT_CLK] = imx_clk_gate4("wdog3_root_clk", "wdog_post_div", base + 0x49e0, 0);
 	clks[IMX7D_WDOG4_ROOT_CLK] = imx_clk_gate4("wdog4_root_clk", "wdog_post_div", base + 0x49f0, 0);
+	clks[IMX7D_KPP_ROOT_CLK] = imx_clk_gate4("kpp_root_clk", "ipg_root_clk", base + 0x4aa0, 0);
 	clks[IMX7D_CSI_MCLK_ROOT_CLK] = imx_clk_gate4("csi_mclk_root_clk", "csi_mclk_post_div", base + 0x4490, 0);
 	clks[IMX7D_AUDIO_MCLK_ROOT_CLK] = imx_clk_gate4("audio_mclk_root_clk", "audio_mclk_post_div", base + 0x4790, 0);
 	clks[IMX7D_WRCLK_ROOT_CLK] = imx_clk_gate4("wrclk_root_clk", "wrclk_post_div", base + 0x47a0, 0);
diff --git a/include/dt-bindings/clock/imx7d-clock.h b/include/dt-bindings/clock/imx7d-clock.h
index dc51904435d8..7653c8536b64 100644
--- a/include/dt-bindings/clock/imx7d-clock.h
+++ b/include/dt-bindings/clock/imx7d-clock.h
@@ -453,5 +453,6 @@
 #define IMX7D_NAND_RAWNAND_CLK		440
 #define IMX7D_NAND_USDHC_BUS_RAWNAND_CLK 441
 #define IMX7D_SNVS_CLK			442
-#define IMX7D_CLK_END			443
+#define IMX7D_KPP_ROOT_CLK		443
+#define IMX7D_CLK_END			444
 #endif /* __DT_BINDINGS_CLOCK_IMX7D_H */
-- 
2.16.2
