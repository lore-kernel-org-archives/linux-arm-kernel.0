From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 05 Sep 2016 23:55:57 +0300
Subject: [PATCH 2/2] ARM: dts: r8a7792: add MSIOF support
In-Reply-To: <2481458.x1iQg26kO7@wasted.cogentembedded.com>
References: <2481458.x1iQg26kO7@wasted.cogentembedded.com>
Message-ID: <2787067.j1BQ6sZInq@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the generic R8A7792 parts of the MSIOF0/1 device nodes.

Based  on the original (and large) patch by Vladimir Barinov
<vladimir.barinov@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7792.dtsi |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7792.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792.dtsi
+++ renesas/arch/arm/boot/dts/r8a7792.dtsi
@@ -26,6 +26,8 @@
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
 		spi0 = &qspi;
+		spi1 = &msiof0;
+		spi2 = &msiof1;
 		vin0 = &vin0;
 		vin1 = &vin1;
 		vin2 = &vin2;
@@ -570,6 +572,34 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
+		};
+
+		msiof0: spi at e6e20000 {
+			compatible = "renesas,msiof-r8a7792";
+			reg = <0 0xe6e20000 0 0x0064>;
+			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp0_clks R8A7792_CLK_MSIOF0>;
+			dmas = <&dmac0 0x51>, <&dmac0 0x52>,
+			       <&dmac1 0x51>, <&dmac1 0x52>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		msiof1: spi at e6e10000 {
+			compatible = "renesas,msiof-r8a7792";
+			reg = <0 0xe6e10000 0 0x0064>;
+			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp2_clks R8A7792_CLK_MSIOF1>;
+			dmas = <&dmac0 0x55>, <&dmac0 0x56>,
+			       <&dmac1 0x55>, <&dmac1 0x56>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
 		};
 
 		du: display at feb00000 {
