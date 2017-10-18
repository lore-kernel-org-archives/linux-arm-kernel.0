From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 18 Oct 2017 13:24:33 +0900
Subject: [PATCH 2/6] arm64: dts: uniphier: add GPIO controller nodes
In-Reply-To: <1508300677-23190-1-git-send-email-yamada.masahiro@socionext.com>
References: <1508300677-23190-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1508300677-23190-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIO controller also acts as an interrupt controller and the
interrupt lines are connected to the AIDET block.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 25 ++++++++++++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 19 ++++++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 19 ++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index ee4aff5..99f14cc 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -161,6 +161,31 @@
 			};
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
+				      <&pinctrl 43 0 0>,
+				      <&pinctrl 51 0 0>,
+				      <&pinctrl 96 0 0>,
+				      <&pinctrl 160 0 0>,
+				      <&pinctrl 184 0 0>;
+			gpio-ranges-group-names = "gpio_range0",
+						  "gpio_range1",
+						  "gpio_range2",
+						  "gpio_range3",
+						  "gpio_range4",
+						  "gpio_range5";
+			ngpios = <200>;
+			socionext,interrupt-ranges = <0 48 16>, <16 154 5>,
+						     <21 217 3>;
+		};
+
 		i2c0: i2c at 58780000 {
 			compatible = "socionext,uniphier-fi2c";
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index a29c279..17c1c92 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -230,6 +230,25 @@
 			};
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
+				      <&pinctrl 96 0 0>,
+				      <&pinctrl 160 0 0>;
+			gpio-ranges-group-names = "gpio_range0",
+						  "gpio_range1",
+						  "gpio_range2";
+			ngpios = <205>;
+			socionext,interrupt-ranges = <0 48 16>, <16 154 5>,
+						     <21 217 3>;
+		};
+
 		i2c0: i2c at 58780000 {
 			compatible = "socionext,uniphier-fi2c";
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index 384729f..87cb290 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -178,6 +178,25 @@
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
+				      <&pinctrl 96 0 0>,
+				      <&pinctrl 160 0 0>;
+			gpio-ranges-group-names = "gpio_range0",
+						  "gpio_range1",
+						  "gpio_range2";
+			ngpios = <286>;
+			socionext,interrupt-ranges = <0 48 16>, <16 154 5>,
+						     <21 217 3>;
+		};
+
 		i2c0: i2c at 58780000 {
 			compatible = "socionext,uniphier-fi2c";
 			status = "disabled";
-- 
2.7.4
