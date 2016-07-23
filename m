From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 23 Jul 2016 21:11:26 +0300
Subject: [PATCH v2 2/2] ARM: dts: r8a7792: add SDHI support
In-Reply-To: <4468057.gGDuR4B4DF@wasted.cogentembedded.com>
References: <4468057.gGDuR4B4DF@wasted.cogentembedded.com>
Message-ID: <1922758.B8NbWTKjoY@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the generic R8A7792 part of the SDHI0 device node.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- fixed up the size in the "reg" property.

 arch/arm/boot/dts/r8a7792.dtsi |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7792.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792.dtsi
+++ renesas/arch/arm/boot/dts/r8a7792.dtsi
@@ -435,6 +435,18 @@
 			status = "disabled";
 		};
 
+		sdhi0: sd at ee100000 {
+			compatible = "renesas,sdhi-r8a7792";
+			reg = <0 0xee100000 0 0x328>;
+			interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
+			       <&dmac1 0xcd>, <&dmac1 0xce>;
+			dma-names = "tx", "rx", "tx", "rx";
+			clocks = <&mstp3_clks R8A7792_CLK_SDHI0>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
 		jpu: jpeg-codec at fe980000 {
 			compatible = "renesas,jpu-r8a7792",
 				     "renesas,rcar-gen2-jpu";
