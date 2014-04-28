From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 28 Apr 2014 15:54:42 +0200
Subject: [PATCH] ARM: imx: imx6q, Add i2c4 clock to the clock tree
Message-ID: <1398693282-5286-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This clock was missing for imx6dl SoCs. This patch adds the missing
clock so we can use i2c4.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 Documentation/devicetree/bindings/clock/imx6q-clock.txt | 1 +
 arch/arm/mach-imx/clk-imx6q.c                           | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
index 90ec91f..c6dd7a5 100644
--- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
+++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
@@ -221,6 +221,7 @@ clocks and IDs.
 	lvds1_gate		206
 	lvds2_gate		207
 	esai_ahb		208
+	i2c4			209
 
 Examples:
 
diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index eab2781..8b0e284 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -107,7 +107,7 @@ enum mx6q_clks {
 	sata_ref, sata_ref_100m, pcie_ref, pcie_ref_125m, enet_ref, usbphy1_gate,
 	usbphy2_gate, pll4_post_div, pll5_post_div, pll5_video_div, eim_slow,
 	spdif, cko2_sel, cko2_podf, cko2, cko, vdoa, pll4_audio_div,
-	lvds1_sel, lvds2_sel, lvds1_gate, lvds2_gate, esai_ahb, clk_max
+	lvds1_sel, lvds2_sel, lvds1_gate, lvds2_gate, esai_ahb, i2c4, clk_max
 };
 
 static struct clk *clk[clk_max];
@@ -378,6 +378,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[i2c1]         = imx_clk_gate2("i2c1",          "ipg_per",           base + 0x70, 6);
 	clk[i2c2]         = imx_clk_gate2("i2c2",          "ipg_per",           base + 0x70, 8);
 	clk[i2c3]         = imx_clk_gate2("i2c3",          "ipg_per",           base + 0x70, 10);
+	clk[i2c4]         = imx_clk_gate2("i2c4",          "ipg_per",           base + 0x6c, 8);
 	clk[iim]          = imx_clk_gate2("iim",           "ipg",               base + 0x70, 12);
 	clk[enfc]         = imx_clk_gate2("enfc",          "enfc_podf",         base + 0x70, 14);
 	clk[vdoa]         = imx_clk_gate2("vdoa",          "vdo_axi",           base + 0x70, 26);
-- 
1.9.1
