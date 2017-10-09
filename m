From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon,  9 Oct 2017 22:22:53 +0200
Subject: [PATCH v2 4/5] ARM: dts: sun9i: Change node names to remove
 underscores
In-Reply-To: <cover.e7363fd7884334063590603c0b0de566f66e0c18.1507580565.git-series.maxime.ripard@free-electrons.com>
References: <cover.e7363fd7884334063590603c0b0de566f66e0c18.1507580565.git-series.maxime.ripard@free-electrons.com>
Message-ID: <d3fc745b27878626daea22bca8e402d445f0741d.1507580565.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some node names in the A80 DTSI still have underscores in them. Remove them
in favour of hyphens to remove DTC warnings.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index f9cb701f29b0..90eac0b2a193 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -139,7 +139,7 @@
 		 * would also throw all the PLL clock rates off, or just the
 		 * downstream clocks in the PRCM.
 		 */
-		osc24M: osc24M_clk {
+		osc24M: clk-24M {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <24000000>;
@@ -151,7 +151,7 @@
 		 * AC100 codec/RTC chip. This serves as a placeholder for
 		 * board dts files to specify the source.
 		 */
-		osc32k: osc32k_clk {
+		osc32k: clk-32k {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clock-div = <1>;
@@ -169,7 +169,7 @@
 			clock-output-names = "cpus";
 		};
 
-		ahbs: ahbs_clk {
+		ahbs: clk-ahbs {
 			compatible = "fixed-factor-clock";
 			#clock-cells = <0>;
 			clock-div = <1>;
@@ -708,12 +708,12 @@
 			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
-			r_ir_pins: r_ir {
+			r_ir_pins: r-ir-pins {
 				pins = "PL6";
 				function = "s_cir_rx";
 			};
 
-			r_rsb_pins: r_rsb {
+			r_rsb_pins: r-rsb-pins {
 				pins = "PN0", "PN1";
 				function = "s_rsb";
 				drive-strength = <20>;
-- 
git-series 0.9.1
