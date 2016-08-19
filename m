From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 20 Aug 2016 01:19:48 +0300
Subject: [PATCH 2/2] ARM: dts: r8a7792: add VSP1V support
In-Reply-To: <1635089.v8k0jcJkvb@wasted.cogentembedded.com>
References: <1635089.v8k0jcJkvb@wasted.cogentembedded.com>
Message-ID: <1764210.GiXQZXIJDz@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe  3 instances (VSPS, VSPD0, and VSPD1) of the VSP1V in the R8A7792
device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7792.dtsi |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7792.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792.dtsi
+++ renesas/arch/arm/boot/dts/r8a7792.dtsi
@@ -668,6 +668,30 @@
 			status = "disabled";
 		};
 
+		vsp1 at fe928000 {
+			compatible = "renesas,vsp1";
+			reg = <0 0xfe928000 0 0x8000>;
+			interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp1_clks R8A7792_CLK_VSP1_SY>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+		};
+
+		vsp1 at fe930000 {
+			compatible = "renesas,vsp1";
+			reg = <0 0xfe930000 0 0x8000>;
+			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp1_clks R8A7792_CLK_VSP1DU0>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+		};
+
+		vsp1 at fe938000 {
+			compatible = "renesas,vsp1";
+			reg = <0 0xfe938000 0 0x8000>;
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp1_clks R8A7792_CLK_VSP1DU1>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+		};
+
 		/* Special CPG clocks */
 		cpg_clocks: cpg_clocks at e6150000 {
 			compatible = "renesas,r8a7792-cpg-clocks",
