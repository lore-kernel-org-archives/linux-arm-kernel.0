From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Thu, 19 Jul 2018 15:23:28 +0900
Subject: [PATCH 2/3] ARM: dts: uniphier: add SPI node for UniPhier 32bit SoCs
In-Reply-To: <1531981409-28396-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1531981409-28396-1-git-send-email-hayashibara.keiji@socionext.com>
Message-ID: <1531981409-28396-3-git-send-email-hayashibara.keiji@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Add nodes of SPI controller for LD4, Pro4, sLD8, Pro5 and PXs2.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-ld4.dtsi  | 11 +++++++++++
 arch/arm/boot/dts/uniphier-pro4.dtsi | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-pro5.dtsi | 33 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-sld8.dtsi | 11 +++++++++++
 5 files changed, 99 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index 37950ad..b7849be 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -63,6 +63,17 @@
 			cache-level = <2>;
 		};
 
+		spi: spi at 54006000 {
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
 		serial0: serial at 54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index 49539f0..d0c3e4a 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -71,6 +71,17 @@
 			cache-level = <2>;
 		};
 
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
 		serial0: serial at 54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
@@ -115,6 +126,17 @@
 			resets = <&peri_rst 3>;
 		};
 
+		spi1: spi at 54007000 {
+			compatible = "socionext,uniphier-mcssi";
+			status = "disabled";
+			reg = <0x54007000 0x2000>;
+			interrupts = <0 38 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi1>;
+			clocks = <&peri_clk 12>;
+			resets = <&peri_rst 12>;
+		};
+
 		gpio: gpio at 55000000 {
 			compatible = "socionext,uniphier-gpio";
 			reg = <0x55000000 0x200>;
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index 06c2cef..606573c 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -156,6 +156,28 @@
 			cache-level = <3>;
 		};
 
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
@@ -200,6 +222,17 @@
 			resets = <&peri_rst 3>;
 		};
 
+		spi2: spi at 54007000 {
+			compatible = "socionext,uniphier-mcssi";
+			status = "disabled";
+			reg = <0x54007000 0x2000>;
+			interrupts = <0 38 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi2>;
+			clocks = <&peri_clk 12>;
+			resets = <&peri_rst 12>;
+		};
+
 		gpio: gpio at 55000000 {
 			compatible = "socionext,uniphier-gpio";
 			reg = <0x55000000 0x200>;
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index 641d961..15b4f75 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -164,6 +164,28 @@
 			cache-level = <2>;
 		};
 
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
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index e9b9b4f..83f832b 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -63,6 +63,17 @@
 			cache-level = <2>;
 		};
 
+		spi: spi at 54006000 {
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
 		serial0: serial at 54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
-- 
2.7.4
