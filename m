From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 23 Jul 2016 22:17:42 +0300
Subject: [PATCH 2/2] ARM: dts: r8a7792: add VIN support
In-Reply-To: <17288006.ERHB6654v5@wasted.cogentembedded.com>
References: <17288006.ERHB6654v5@wasted.cogentembedded.com>
Message-ID: <2505176.7Q9RZuLBta@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the generic R8A7792 parts of the VIN[0-5] device nodes.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7792.dtsi |   66 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7792.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792.dtsi
+++ renesas/arch/arm/boot/dts/r8a7792.dtsi
@@ -25,6 +25,12 @@
 		i2c3 = &i2c3;
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
+		vin0 = &vin0;
+		vin1 = &vin1;
+		vin2 = &vin2;
+		vin3 = &vin3;
+		vin4 = &vin4;
+		vin5 = &vin5;
 };
 
 	cpus {
@@ -573,6 +579,66 @@
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
+
+		vin0: video at e6ef0000 {
+			compatible = "renesas,vin-r8a7792",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef0000 0 0x1000>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A7792_CLK_VIN0>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		vin1: video at e6ef1000 {
+			compatible = "renesas,vin-r8a7792",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef1000 0 0x1000>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A7792_CLK_VIN1>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		vin2: video at e6ef2000 {
+			compatible = "renesas,vin-r8a7792",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef2000 0 0x1000>;
+			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A7792_CLK_VIN2>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		vin3: video at e6ef3000 {
+			compatible = "renesas,vin-r8a7792",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef3000 0 0x1000>;
+			interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A7792_CLK_VIN3>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		vin4: video at e6ef4000 {
+			compatible = "renesas,vin-r8a7792",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef4000 0 0x1000>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A7792_CLK_VIN4>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		vin5: video at e6ef5000 {
+			compatible = "renesas,vin-r8a7792",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef5000 0 0x1000>;
+			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A7792_CLK_VIN5>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
 
 		/* Special CPG clocks */
 		cpg_clocks: cpg_clocks at e6150000 {
