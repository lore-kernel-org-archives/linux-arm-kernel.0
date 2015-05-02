From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat,  2 May 2015 13:24:37 +0200
Subject: [PATCH 6/8] ARM: sunxi: Add PLL2 support
In-Reply-To: <1430565879-28113-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1430565879-28113-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1430565879-28113-7-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Emilio L?pez <emilio@elopez.com.ar>

This commit adds the PLL2 definition to the sun4i, sun5i and sun7i device
trees. PLL2 is used to clock audio devices.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 9 +++++++++
 arch/arm/boot/dts/sun5i.dtsi     | 9 +++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi | 9 +++++++++
 3 files changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 1d7fd68bea1d..2ed3a0b43131 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -198,6 +198,15 @@
 			clock-output-names = "pll1";
 		};
 
+		pll2: clk at 01c20008 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-b-pll2-clk";
+			reg = <0x01c20008 0x8>;
+			clocks = <&osc24M>;
+			clock-output-names = "pll2-1x", "pll2-2x",
+					     "pll2-4x", "pll2-8x";
+		};
+
 		pll4: clk at 01c20018 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-pll1-clk";
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 8c04f240f2e9..b291c165966f 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -107,6 +107,15 @@
 			clock-output-names = "pll1";
 		};
 
+		pll2: clk at 01c20008 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-b-pll2-clk";
+			reg = <0x01c20008 0x8>;
+			clocks = <&osc24M>;
+			clock-output-names = "pll2-1x", "pll2-2x",
+					     "pll2-4x", "pll2-8x";
+		};
+
 		pll4: clk at 01c20018 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-pll1-clk";
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 4163ade867cb..7c850dc1b197 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -203,6 +203,15 @@
 			clock-output-names = "pll1";
 		};
 
+		pll2: clk at 01c20008 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-b-pll2-clk";
+			reg = <0x01c20008 0x8>;
+			clocks = <&osc24M>;
+			clock-output-names = "pll2-1x", "pll2-2x",
+					     "pll2-4x", "pll2-8x";
+		};
+
 		pll4: clk at 01c20018 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun7i-a20-pll4-clk";
-- 
2.3.6
