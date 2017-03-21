From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 21 Mar 2017 19:49:05 -0000
Subject: [PATCH 2/2] ARM: dts: r8a7792: add IMR-L[S]X3 support
Message-ID: <20170321194830.621344167@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe the IMR-LX3 and 6 IMR-LSX3 devices in the R8A7792 device tree.

Based on the original patch by Roman Meshkevich
<roman.meshkevich@cogentembedded.com>

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7792.dtsi |   63 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7792.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792.dtsi
+++ renesas/arch/arm/boot/dts/r8a7792.dtsi
@@ -734,6 +734,69 @@
 			status = "disabled";
 		};
 
+		imr-lsx3 at fe840000 {
+			compatible = "renesas,r8a7792-imr-lsx3",
+				     "renesas,imr-lsx3";
+			reg = <0 0xfe840000 0 0x2000>;
+			interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A7792_CLK_IMR_LSX3_0>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+		};
+
+		imr-lsx3 at fe850000 {
+			compatible = "renesas,r8a7792-imr-lsx3",
+				     "renesas,imr-lsx3";
+			reg = <0 0xfe850000 0 0x2000>;
+			interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A7792_CLK_IMR_LSX3_1>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+		};
+
+		imr-lsx3 at fe860000 {
+			compatible = "renesas,r8a7792-imr-lsx3",
+				     "renesas,imr-lsx3";
+			reg = <0 0xfe860000 0 0x2000>;
+			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A7792_CLK_IMR_LSX3_2>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+		};
+
+		imr-lsx3 at fe870000 {
+			compatible = "renesas,r8a7792-imr-lsx3",
+				     "renesas,imr-lsx3";
+			reg = <0 0xfe870000 0 0x2000>;
+			interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A7792_CLK_IMR_LSX3_3>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+		};
+
+		imr-lsx3 at fe880000 {
+			compatible = "renesas,r8a7792-imr-lsx3",
+				     "renesas,imr-lsx3";
+			reg = <0 0xfe880000 0 0x2000>;
+			interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A7792_CLK_IMR_LSX3_4>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+		};
+
+		imr-lsx3 at fe890000 {
+			compatible = "renesas,r8a7792-imr-lsx3",
+				     "renesas,imr-lsx3";
+			reg = <0 0xfe890000 0 0x2000>;
+			interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A7792_CLK_IMR_LSX3_5>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+		};
+
+		imr-lx3 at fead0000 {
+			compatible = "renesas,r8a7792-imr-lx3",
+				     "renesas,imr-lx3";
+			reg = <0 0xfead0000 0 0x2000>;
+			interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A7792_CLK_IMR_LX3>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+		};
+
 		vsp1 at fe928000 {
 			compatible = "renesas,vsp1";
 			reg = <0 0xfe928000 0 0x8000>;
