From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 03 Sep 2016 01:08:45 +0300
Subject: [PATCH 2/3] ARM: dts: r8a7792: add QSPI support
In-Reply-To: <1648590.FPpmBRoQyh@wasted.cogentembedded.com>
References: <1648590.FPpmBRoQyh@wasted.cogentembedded.com>
Message-ID: <16566445.LA832Ff91Q@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the generic R8A7792 part of the QSPI device node.

Based  on the original (and large) patch by Vladimir Barinov
<vladimir.barinov@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7792.dtsi |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7792.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792.dtsi
+++ renesas/arch/arm/boot/dts/r8a7792.dtsi
@@ -25,6 +25,7 @@
 		i2c3 = &i2c3;
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
+		spi0 = &qspi;
 		vin0 = &vin0;
 		vin1 = &vin1;
 		vin2 = &vin2;
@@ -554,6 +555,21 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
+		};
+
+		qspi: spi at e6b10000 {
+			compatible = "renesas,qspi-r8a7792", "renesas,qspi";
+			reg = <0 0xe6b10000 0 0x2c>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7792_CLK_QSPI_MOD>;
+			dmas = <&dmac0 0x17>, <&dmac0 0x18>,
+			       <&dmac1 0x17>, <&dmac1 0x18>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
 		};
 
 		du: display at feb00000 {
