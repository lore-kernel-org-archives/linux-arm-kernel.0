From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 05 Nov 2016 00:59:37 +0300
Subject: [PATCH v2 08/11] ARM: dts: r8a7745: add IRQC support
In-Reply-To: <2368353.xfo5beGC5E@wasted.cogentembedded.com>
References: <2368353.xfo5beGC5E@wasted.cogentembedded.com>
Message-ID: <2945818.yZ5dZgkJFz@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe the IRQC interrupt controller in the R8A7745 device tree.

Based on the original (and large) patch by Dmitry Shifrin
<dmitry.shifrin@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
Changes in version 2:
- added Geert's tag;
- refreshed the patch.

 arch/arm/boot/dts/r8a7745.dtsi |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7745.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7745.dtsi
+++ renesas/arch/arm/boot/dts/r8a7745.dtsi
@@ -62,6 +62,25 @@
 						 IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		irqc: interrupt-controller at e61c0000 {
+			compatible = "renesas,irqc-r8a7745", "renesas,irqc";
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			reg = <0 0xe61c0000 0 0x200>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 407>;
+			power-domains = <&sysc R8A7745_PD_ALWAYS_ON>;
+		};
+
 		timer {
 			compatible = "arm,armv7-timer";
 			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
