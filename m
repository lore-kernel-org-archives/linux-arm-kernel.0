From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Tue, 17 Dec 2013 21:45:03 -0300
Subject: [PATCH v2 11/11] ARM: sunxi: dt: add nodes for the mbus clock
In-Reply-To: <1387327503-15651-1-git-send-email-emilio@elopez.com.ar>
References: <1387327503-15651-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1387327503-15651-12-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mbus is the memory bus clock, and it is present on both sun5i and sun7i
machines. Its register layout is compatible with the mod0 one.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 7 +++++++
 arch/arm/boot/dts/sun5i-a13.dtsi  | 7 +++++++
 arch/arm/boot/dts/sun7i-a20.dtsi  | 7 +++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 82b5ce6..60bd3f7 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -250,6 +250,13 @@
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
index 938e6d3..3e616a0 100644
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
index 41df384..8c88f7d 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -279,6 +279,13 @@
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
1.8.5.1
