From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 30 Oct 2015 15:21:00 +0100
Subject: [PATCH 14/19] ARM: sun5i: dt: Add pll3 and pll7 clocks
In-Reply-To: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1446214865-3972-15-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the pll3 and pll7 clocks in the DT that are used to drive the
display-related clocks.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 59a9426e3bd4..bde9a545b79f 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -88,6 +88,15 @@
 			clock-output-names = "osc24M";
 		};
 
+		osc3M: osc3M_clk {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clock-div = <8>;
+			clock-mult = <1>;
+			clocks = <&osc24M>;
+			clock-output-names = "osc3M";
+		};
+
 		osc32k: clk at 0 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
@@ -112,6 +121,14 @@
 					     "pll2-4x", "pll2-8x";
 		};
 
+		pll3: clk at 01c20010 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-pll3-clk";
+			reg = <0x01c20010 0x4>;
+			clocks = <&osc3M>;
+			clock-output-names = "pll3";
+		};
+
 		pll4: clk at 01c20018 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-pll1-clk";
@@ -136,6 +153,14 @@
 			clock-output-names = "pll6_sata", "pll6_other", "pll6";
 		};
 
+		pll7: clk at 01c20030 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-pll3-clk";
+			reg = <0x01c20030 0x4>;
+			clocks = <&osc3M>;
+			clock-output-names = "pll7";
+		};
+
 		/* dummy is 200M */
 		cpu: cpu at 01c20054 {
 			#clock-cells = <0>;
-- 
2.6.2
