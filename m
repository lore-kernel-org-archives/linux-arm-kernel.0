From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 23 Dec 2013 00:32:44 -0300
Subject: [PATCH v3 13/13] ARM: sunxi: dt: add nodes for the mbus clock
In-Reply-To: <1387769564-12894-1-git-send-email-emilio@elopez.com.ar>
References: <1387769564-12894-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1387769564-12894-14-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mbus is the memory bus clock, and it is present on both sun5i and sun7i
machines. Its register layout is compatible with the mod0 one.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 8 ++++++++
 arch/arm/boot/dts/sun5i-a13.dtsi  | 8 ++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi  | 8 ++++++++
 3 files changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 5012c27..50f34fd 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -261,6 +261,14 @@
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ir0";
 		};
+
+		mbus_clk: clk at 01c2015c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c2015c 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+			clock-output-names = "mbus";
+		};
 	};
 
 	soc at 01c00000 {
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index c46ac65..227be94 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -258,6 +258,14 @@
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ir0";
 		};
+
+		mbus_clk: clk at 01c2015c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c2015c 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+			clock-output-names = "mbus";
+		};
 	};
 
 	soc at 01c00000 {
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 9a2e356..1ba8532 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -294,6 +294,14 @@
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi3";
 		};
+
+		mbus_clk: clk at 01c2015c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c2015c 0x4>;
+			clocks = <&osc24M>, <&pll6 2>, <&pll5 1>;
+			clock-output-names = "mbus";
+		};
 	};
 
 	soc at 01c00000 {
-- 
1.8.5.2
