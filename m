From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Sun, 29 Sep 2013 00:49:39 -0300
Subject: [PATCH 10/10] ARM: sunxi: dt: add nodes for the mbus clock
In-Reply-To: <1380426579-32458-1-git-send-email-emilio@elopez.com.ar>
References: <1380426579-32458-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1380426579-32458-11-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mbus is the memory bus clock, and it is present on both sun5i and sun7i
machines. Its register layout is compatible with the mod0 one.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 7 +++++++
 arch/arm/boot/dts/sun5i-a13.dtsi  | 7 +++++++
 arch/arm/boot/dts/sun7i-a20.dtsi  | 7 +++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 2756378..ae5807f 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -246,6 +246,13 @@
 			reg = <0x01c200b0 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 		};
+
+		mbus: mbus at 01c2015c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c2015c 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+		};
 	};
 
 	soc at 01c00000 {
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index c26cd6d..efa941a 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -247,6 +247,13 @@
 			reg = <0x01c200b0 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 		};
+
+		mbus: mbus at 01c2015c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c2015c 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+		};
 	};
 
 	soc at 01c00000 {
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index d75eb53..73a21a1 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -275,6 +275,13 @@
 			reg = <0x01c200d4 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 		};
+
+		mbus: mbus at 01c2015c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c2015c 0x4>;
+			clocks = <&osc24M>, <&pll6 2>, <&pll5 1>;
+		};
 	};
 
 	soc at 01c00000 {
-- 
1.8.4
