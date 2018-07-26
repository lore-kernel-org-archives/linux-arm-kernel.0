From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Thu, 26 Jul 2018 16:10:00 +0900
Subject: [PATCH v2 3/3] arm64: dts: uniphier: add SPI node for LD20,
 LD11 and PXs3
In-Reply-To: <1532589000-19602-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1532589000-19602-1-git-send-email-hayashibara.keiji@socionext.com>
Message-ID: <1532589000-19602-4-git-send-email-hayashibara.keiji@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Add nodes of SPI controller for UniPhier SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 22 ++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 44 ++++++++++++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 22 ++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index d63b56e..0edab17 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -116,6 +116,28 @@
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
 
+		spi0: spi at 54006000 {
+			compatible = "socionext,uniphier-scssi";
+			status = "disabled";
+			reg = <0x54006000 0x100>;
+			interrupts = <0 39 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi0>;
+			clocks = <&peri_clk 11>;
+			resets = <&peri_rst 11>;
+		};
+
+		spi1: spi at 54006100 {
+			compatible = "socionext,uniphier-scssi";
+			status = "disabled";
+			reg = <0x54006100 0x100>;
+			interrupts = <0 216 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi1>;
+			clocks = <&peri_clk 11>;
+			resets = <&peri_rst 11>;
+		};
+
 		serial0: serial at 54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 0298bd0..1213101 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -222,6 +222,50 @@
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
 
+		spi0: spi at 54006000 {
+			compatible = "socionext,uniphier-scssi";
+			status = "disabled";
+			reg = <0x54006000 0x100>;
+			interrupts = <0 39 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi0>;
+			clocks = <&peri_clk 11>;
+			resets = <&peri_rst 11>;
+		};
+
+		spi1: spi at 54006100 {
+			compatible = "socionext,uniphier-scssi";
+			status = "disabled";
+			reg = <0x54006100 0x100>;
+			interrupts = <0 216 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi1>;
+			clocks = <&peri_clk 11>;
+			resets = <&peri_rst 11>;
+		};
+
+		spi2: spi at 54006200 {
+			compatible = "socionext,uniphier-scssi";
+			status = "disabled";
+			reg = <0x54006200 0x100>;
+			interrupts = <0 229 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi2>;
+			clocks = <&peri_clk 11>;
+			resets = <&peri_rst 11>;
+		};
+
+		spi3: spi at 54006300 {
+			compatible = "socionext,uniphier-scssi";
+			status = "disabled";
+			reg = <0x54006300 0x100>;
+			interrupts = <0 230 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi3>;
+			clocks = <&peri_clk 11>;
+			resets = <&peri_rst 11>;
+		};
+
 		serial0: serial at 54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index 2a4cf42..5b40ec7 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -144,6 +144,28 @@
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
 
+		spi0: spi at 54006000 {
+			compatible = "socionext,uniphier-scssi";
+			status = "disabled";
+			reg = <0x54006000 0x100>;
+			interrupts = <0 39 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi0>;
+			clocks = <&peri_clk 11>;
+			resets = <&peri_rst 11>;
+		};
+
+		spi1: spi at 54006100 {
+			compatible = "socionext,uniphier-scssi";
+			status = "disabled";
+			reg = <0x54006100 0x100>;
+			interrupts = <0 216 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi1>;
+			clocks = <&peri_clk 11>;
+			resets = <&peri_rst 11>;
+		};
+
 		serial0: serial at 54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
-- 
2.7.4
