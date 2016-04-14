From: akurz@blala.de (Alexander Kurz)
Date: Thu, 14 Apr 2016 23:30:49 +0200
Subject: [PATCH 1/2] ARM: dts: imx35: restore existing used clock enumeration
Message-ID: <1460669450-11729-1-git-send-email-akurz@blala.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new element got inserted into enum mx35_clks with commit 3713e3f5e927
("clk: imx35: define two clocks for rtc"). This insertion shifted most
nummerical clock assignments to a new nummerical value which in turn
rendered most hardcoded nummeric values in imx35.dtsi incorrect.

Restore the existing order by moving the newly introduced clock to the
end of the enum. Update the dts documentation accordingly.

Signed-off-by: Alexander Kurz <akurz@blala.de>
---
 Documentation/devicetree/bindings/clock/imx35-clock.txt | 1 +
 drivers/clk/imx/clk-imx35.c                             | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/imx35-clock.txt b/Documentation/devicetree/bindings/clock/imx35-clock.txt
index a703564..f497832 100644
--- a/Documentation/devicetree/bindings/clock/imx35-clock.txt
+++ b/Documentation/devicetree/bindings/clock/imx35-clock.txt
@@ -94,6 +94,7 @@ clocks and IDs.
 	csi_sel			79
 	iim_gate		80
 	gpu2d_gate		81
+	ckli_gate		82
 
 Examples:
 
diff --git a/drivers/clk/imx/clk-imx35.c b/drivers/clk/imx/clk-imx35.c
index a71d24c..b0978d3 100644
--- a/drivers/clk/imx/clk-imx35.c
+++ b/drivers/clk/imx/clk-imx35.c
@@ -66,7 +66,7 @@ static const char *std_sel[] = {"ppll", "arm"};
 static const char *ipg_per_sel[] = {"ahb_per_div", "arm_per_div"};
 
 enum mx35_clks {
-	ckih, ckil, mpll, ppll, mpll_075, arm, hsp, hsp_div, hsp_sel, ahb, ipg,
+	ckih, mpll, ppll, mpll_075, arm, hsp, hsp_div, hsp_sel, ahb, ipg,
 	arm_per_div, ahb_per_div, ipg_per, uart_sel, uart_div, esdhc_sel,
 	esdhc1_div, esdhc2_div, esdhc3_div, spdif_sel, spdif_div_pre,
 	spdif_div_post, ssi_sel, ssi1_div_pre, ssi1_div_post, ssi2_div_pre,
@@ -79,7 +79,7 @@ enum mx35_clks {
 	rtc_gate, rtic_gate, scc_gate, sdma_gate, spba_gate, spdif_gate,
 	ssi1_gate, ssi2_gate, uart1_gate, uart2_gate, uart3_gate, usbotg_gate,
 	wdog_gate, max_gate, admux_gate, csi_gate, csi_div, csi_sel, iim_gate,
-	gpu2d_gate, clk_max
+	gpu2d_gate, ckil, clk_max
 };
 
 static struct clk *clk[clk_max];
-- 
2.1.4
