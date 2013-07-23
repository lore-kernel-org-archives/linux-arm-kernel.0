From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 22 Jul 2013 22:01:08 -0300
Subject: [PATCH RFC 4/8] ARM: sunxi: add PLL4 support
In-Reply-To: <1374541272-32173-1-git-send-email-emilio@elopez.com.ar>
References: <1374541272-32173-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1374541272-32173-5-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the PLL4 definition to the sun4i and sun5i device
trees. PLL4 is compatible with PLL1.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 7 +++++++
 arch/arm/boot/dts/sun5i-a10s.dtsi | 7 +++++++
 arch/arm/boot/dts/sun5i-a13.dtsi  | 7 +++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index b2bd6e1..6d569fd 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -66,6 +66,13 @@
 			clocks = <&osc24M>;
 		};
 
+		pll4: pll4 at 01c20018 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-pll1-clk";
+			reg = <0x01c20018 0x4>;
+			clocks = <&osc24M>;
+		};
+
 		/* dummy is 200M */
 		cpu: cpu at 01c20054 {
 			#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 2307ce8..9c1a2b9 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -63,6 +63,13 @@
 			clocks = <&osc24M>;
 		};
 
+		pll4: pll4 at 01c20018 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-pll1-clk";
+			reg = <0x01c20018 0x4>;
+			clocks = <&osc24M>;
+		};
+
 		/* dummy is 200M */
 		cpu: cpu at 01c20054 {
 			#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 7363211..67889cf 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -67,6 +67,13 @@
 			clocks = <&osc24M>;
 		};
 
+		pll4: pll4 at 01c20018 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-pll1-clk";
+			reg = <0x01c20018 0x4>;
+			clocks = <&osc24M>;
+		};
+
 		/* dummy is 200M */
 		cpu: cpu at 01c20054 {
 			#clock-cells = <0>;
-- 
1.8.3.3
