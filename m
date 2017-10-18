From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 18 Oct 2017 13:24:32 +0900
Subject: [PATCH 1/6] ARM: dts: uniphier: add GPIO controller nodes
In-Reply-To: <1508300677-23190-1-git-send-email-yamada.masahiro@socionext.com>
References: <1508300677-23190-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1508300677-23190-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIO controller also acts as an interrupt controller and the
interrupt lines are connected to the AIDET block.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ld4.dtsi  | 14 ++++++++++++++
 arch/arm/boot/dts/uniphier-pro4.dtsi | 14 ++++++++++++++
 arch/arm/boot/dts/uniphier-pro5.dtsi | 14 ++++++++++++++
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 17 +++++++++++++++++
 arch/arm/boot/dts/uniphier-sld8.dtsi | 18 ++++++++++++++++++
 5 files changed, 77 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index 79183db..b0151c4 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -103,6 +103,20 @@
 			clocks = <&peri_clk 3>;
 		};
 
+		gpio: gpio at 55000000 {
+			compatible = "socionext,uniphier-gpio";
+			reg = <0x55000000 0x200>;
+			interrupt-parent = <&aidet>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 0 0>;
+			gpio-ranges-group-names = "gpio_range";
+			ngpios = <136>;
+			socionext,interrupt-ranges = <0 48 13>, <14 62 2>;
+		};
+
 		i2c0: i2c at 58400000 {
 			compatible = "socionext,uniphier-i2c";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index b3dbbd9b..2921729 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -111,6 +111,20 @@
 			clocks = <&peri_clk 3>;
 		};
 
+		gpio: gpio at 55000000 {
+			compatible = "socionext,uniphier-gpio";
+			reg = <0x55000000 0x200>;
+			interrupt-parent = <&aidet>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 0 0>;
+			gpio-ranges-group-names = "gpio_range";
+			ngpios = <248>;
+			socionext,interrupt-ranges = <0 48 16>, <16 154 5>;
+		};
+
 		i2c0: i2c at 58780000 {
 			compatible = "socionext,uniphier-fi2c";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index b026bcd..c5d9501 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -198,6 +198,20 @@
 			clocks = <&peri_clk 3>;
 		};
 
+		gpio: gpio at 55000000 {
+			compatible = "socionext,uniphier-gpio";
+			reg = <0x55000000 0x200>;
+			interrupt-parent = <&aidet>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 0 0>;
+			gpio-ranges-group-names = "gpio_range";
+			ngpios = <248>;
+			socionext,interrupt-ranges = <0 48 16>, <16 154 5>;
+		};
+
 		i2c0: i2c at 58780000 {
 			compatible = "socionext,uniphier-fi2c";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index 90b020c..4d83001 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -173,6 +173,23 @@
 			clocks = <&peri_clk 3>;
 		};
 
+		gpio: gpio at 55000000 {
+			compatible = "socionext,uniphier-gpio";
+			reg = <0x55000000 0x200>;
+			interrupt-parent = <&aidet>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 0 0>,
+				      <&pinctrl 96 0 0>;
+			gpio-ranges-group-names = "gpio_range0",
+						  "gpio_range1";
+			ngpios = <232>;
+			socionext,interrupt-ranges = <0 48 16>, <16 154 5>,
+						     <21 217 3>;
+		};
+
 		i2c0: i2c at 58780000 {
 			compatible = "socionext,uniphier-fi2c";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index b083903..09e52c8 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -103,6 +103,24 @@
 			clocks = <&peri_clk 3>;
 		};
 
+		gpio: gpio at 55000000 {
+			compatible = "socionext,uniphier-gpio";
+			reg = <0x55000000 0x200>;
+			interrupt-parent = <&aidet>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 0 0>,
+				      <&pinctrl 104 0 0>,
+				      <&pinctrl 112 0 0>;
+			gpio-ranges-group-names = "gpio_range0",
+						  "gpio_range1",
+						  "gpio_range2";
+			ngpios = <136>;
+			socionext,interrupt-ranges = <0 48 13>, <14 62 2>;
+		};
+
 		i2c0: i2c at 58400000 {
 			compatible = "socionext,uniphier-i2c";
 			status = "disabled";
-- 
2.7.4
