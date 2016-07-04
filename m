From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 05 Jul 2016 00:23:30 +0300
Subject: [PATCH 2/2] ARM: dts: r8a7792: add EtherAVB support
In-Reply-To: <3308853.O8HBuWdbK9@wasted.cogentembedded.com>
References: <3308853.O8HBuWdbK9@wasted.cogentembedded.com>
Message-ID: <3067320.66EgKDGBA3@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the generic R8A7792 part of the EtherAVB device node.

Based on the commit 89aac8af1a60 ("ARM: dts: r8a7794: add EtherAVB support").

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7792.dtsi |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7792.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792.dtsi
+++ renesas/arch/arm/boot/dts/r8a7792.dtsi
@@ -444,6 +444,18 @@
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 		};
 
+		avb: ethernet at e6800000 {
+			compatible = "renesas,etheravb-r8a7792",
+				     "renesas,etheravb-rcar-gen2";
+			reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
+			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A7792_CLK_ETHERAVB>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		/* Special CPG clocks */
 		cpg_clocks: cpg_clocks at e6150000 {
 			compatible = "renesas,r8a7792-cpg-clocks",
