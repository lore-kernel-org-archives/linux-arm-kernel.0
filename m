From: erin.lo@mediatek.com (Erin Lo)
Date: Fri, 13 Jan 2017 16:42:53 +0800
Subject: [PATCH v2 1/6] arm: dts: mt2701: Add spi device node
In-Reply-To: <1484296978-18572-1-git-send-email-erin.lo@mediatek.com>
References: <1484296978-18572-1-git-send-email-erin.lo@mediatek.com>
Message-ID: <1484296978-18572-2-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leilk Liu <leilk.liu@mediatek.com>

Add spi device node for MT2701.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 arch/arm/boot/dts/mt2701-evb.dts | 50 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/mt2701.dtsi    | 39 +++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701-evb.dts b/arch/arm/boot/dts/mt2701-evb.dts
index 082ca88..879f1eb 100644
--- a/arch/arm/boot/dts/mt2701-evb.dts
+++ b/arch/arm/boot/dts/mt2701-evb.dts
@@ -24,6 +24,56 @@
 	};
 };
 
+&pio {
+	spi_pins_a: spi0 at 0 {
+		pins_spi {
+			pinmux = <MT2701_PIN_53_SPI0_CSN__FUNC_SPI0_CS>,
+				 <MT2701_PIN_54_SPI0_CK__FUNC_SPI0_CK>,
+				 <MT2701_PIN_55_SPI0_MI__FUNC_SPI0_MI>,
+				 <MT2701_PIN_56_SPI0_MO__FUNC_SPI0_MO>;
+			bias-disable;
+		};
+	};
+
+	spi_pins_b: spi1 at 0 {
+		pins_spi {
+			pinmux = <MT2701_PIN_7_SPI1_CSN__FUNC_SPI1_CS>,
+				 <MT2701_PIN_8_SPI1_MI__FUNC_SPI1_MI>,
+				 <MT2701_PIN_9_SPI1_MO__FUNC_SPI1_MO>,
+				 <MT2701_PIN_199_SPI1_CLK__FUNC_SPI1_CK>;
+			bias-disable;
+		};
+	};
+
+	spi_pins_c: spi2 at 0 {
+		pins_spi {
+			pinmux = <MT2701_PIN_101_SPI2_CSN__FUNC_SPI2_CS>,
+				 <MT2701_PIN_102_SPI2_MI__FUNC_SPI2_MI>,
+				 <MT2701_PIN_103_SPI2_MO__FUNC_SPI2_MO>,
+				 <MT2701_PIN_104_SPI2_CLK__FUNC_SPI2_CK>;
+			bias-disable;
+		};
+	};
+};
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_pins_a>;
+	status = "disabled";
+};
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_pins_b>;
+	status = "disabled";
+};
+
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_pins_c>;
+	status = "disabled";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index bdf8954..eb4c6fd 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -227,6 +227,45 @@
 		status = "disabled";
 	};
 
+	spi0: spi at 1100a000 {
+		compatible = "mediatek,mt2701-spi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0 0x1100a000 0 0x100>;
+		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_SYSPLL3_D2>,
+			 <&topckgen CLK_TOP_SPI0_SEL>,
+			 <&pericfg CLK_PERI_SPI0>;
+		clock-names = "parent-clk", "sel-clk", "spi-clk";
+		status = "disabled";
+	};
+
+	spi1: spi at 11016000 {
+		compatible = "mediatek,mt2701-spi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0 0x11016000 0 0x100>;
+		interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_SYSPLL3_D2>,
+			 <&topckgen CLK_TOP_SPI1_SEL>,
+			 <&pericfg CLK_PERI_SPI1>;
+		clock-names = "parent-clk", "sel-clk", "spi-clk";
+		status = "disabled";
+	};
+
+	spi2: spi at 11017000 {
+		compatible = "mediatek,mt2701-spi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0 0x11017000 0 0x1000>;
+		interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_SYSPLL3_D2>,
+			 <&topckgen CLK_TOP_SPI2_SEL>,
+			 <&pericfg CLK_PERI_SPI2>;
+		clock-names = "parent-clk", "sel-clk", "spi-clk";
+		status = "disabled";
+	};
+
 	mmsys: syscon at 14000000 {
 		compatible = "mediatek,mt2701-mmsys", "syscon";
 		reg = <0 0x14000000 0 0x1000>;
-- 
1.9.1
