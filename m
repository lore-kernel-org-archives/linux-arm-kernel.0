From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Tue, 26 Mar 2013 23:39:18 -0300
Subject: [PATCH 2/2] arm: sunxi: rename clock compatible strings
In-Reply-To: <1364351958-14503-1-git-send-email-emilio@elopez.com.ar>
References: <1364351958-14503-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1364351958-14503-3-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During the introduction of the Allwinner SoC platforms, sunxi was
initially meant as a generic name for all the variants of the Allwinner
SoC.

It was ok at the time of the support of only the A10 and A13 that
look pretty much the same; but it's beginning to be troublesome with
the future addition of the Allwinner A31 (sun6i) that is quite
different, and would introduce some weird logic, where sunxi would
actually mean in some case sun4i and sun5i but without sun6i...

Moreover, it makes the compatible strings naming scheme not consistent
with other architectures, where usually for this kind of compability, we
just use the oldest SoC name that has this IP, so let's do just this.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---

These compatible strings have never been on a released kernel, so
changing them now shouldn't cause any issues. Also see Maxime's
"ARM: sunxi: Architecture cleanups and rework" which does the same for
the rest of sunxi code.

 arch/arm/boot/dts/sunxi.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi.dtsi b/arch/arm/boot/dts/sunxi.dtsi
index cafd393..40392de 100644
--- a/arch/arm/boot/dts/sunxi.dtsi
+++ b/arch/arm/boot/dts/sunxi.dtsi
@@ -47,7 +47,7 @@
 
 		osc24M: osc24M at 01c20050 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sunxi-osc-clk";
+			compatible = "allwinner,sun4i-osc-clk";
 			reg = <0x01c20050 0x4>;
 			clocks = <&osc24M_fixed>;
 		};
@@ -60,7 +60,7 @@
 
 		pll1: pll1 at 01c20000 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sunxi-pll1-clk";
+			compatible = "allwinner,sun4i-pll1-clk";
 			reg = <0x01c20000 0x4>;
 			clocks = <&osc24M>;
 		};
@@ -68,28 +68,28 @@
 		/* dummy is 200M */
 		cpu: cpu at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sunxi-cpu-clk";
+			compatible = "allwinner,sun4i-cpu-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&osc32k>, <&osc24M>, <&pll1>, <&dummy>;
 		};
 
 		axi: axi at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sunxi-axi-clk";
+			compatible = "allwinner,sun4i-axi-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&cpu>;
 		};
 
 		ahb: ahb at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sunxi-ahb-clk";
+			compatible = "allwinner,sun4i-ahb-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&axi>;
 		};
 
 		apb0: apb0 at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sunxi-apb0-clk";
+			compatible = "allwinner,sun4i-apb0-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&ahb>;
 		};
@@ -97,14 +97,14 @@
 		/* dummy is pll62 */
 		apb1_mux: apb1_mux at 01c20058 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sunxi-apb1-mux-clk";
+			compatible = "allwinner,sun4i-apb1-mux-clk";
 			reg = <0x01c20058 0x4>;
 			clocks = <&osc24M>, <&dummy>, <&osc32k>;
 		};
 
 		apb1: apb1 at 01c20058 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sunxi-apb1-clk";
+			compatible = "allwinner,sun4i-apb1-clk";
 			reg = <0x01c20058 0x4>;
 			clocks = <&apb1_mux>;
 		};
-- 
1.8.2
