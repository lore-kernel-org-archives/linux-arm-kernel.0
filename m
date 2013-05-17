From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 17 May 2013 15:49:02 +0200
Subject: [PATCH 1/2] ARM i.MX53: Add SATA clock
Message-ID: <1368798543-23285-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 Documentation/devicetree/bindings/clock/imx5-clock.txt | 1 +
 arch/arm/mach-imx/clk-imx51-imx53.c                    | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/imx5-clock.txt b/Documentation/devicetree/bindings/clock/imx5-clock.txt
index d71b4b2..b66cf36 100644
--- a/Documentation/devicetree/bindings/clock/imx5-clock.txt
+++ b/Documentation/devicetree/bindings/clock/imx5-clock.txt
@@ -184,6 +184,7 @@ clocks and IDs.
 	cko2			170
 	srtc_gate		171
 	pata_gate		172
+	sata_gate		173
 
 Examples (for mx53):
 
diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 6fc486b..fbc15f2 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -110,7 +110,7 @@ enum imx5_clks {
 	owire_gate, gpu3d_s, gpu2d_s, gpu3d_gate, gpu2d_gate, garb_gate,
 	cko1_sel, cko1_podf, cko1,
 	cko2_sel, cko2_podf, cko2,
-	srtc_gate, pata_gate,
+	srtc_gate, pata_gate, sata_gate,
 	clk_max
 };
 
@@ -485,6 +485,7 @@ int __init mx53_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 	clk[can2_serial_gate] = imx_clk_gate2("can2_serial_gate", "can_sel", MXC_CCM_CCGR4, 8);
 	clk[can2_ipg_gate] = imx_clk_gate2("can2_ipg_gate", "ipg", MXC_CCM_CCGR4, 6);
 	clk[i2c3_gate] = imx_clk_gate2("i2c3_gate", "per_root", MXC_CCM_CCGR1, 22);
+	clk[sata_gate] = imx_clk_gate2("sata_gate", "ipg", MXC_CCM_CCGR4, 2);
 
 	clk[cko1_sel] = imx_clk_mux("cko1_sel", MXC_CCM_CCOSR, 0, 4,
 				mx53_cko1_sel, ARRAY_SIZE(mx53_cko1_sel));
-- 
1.8.2.rc2
