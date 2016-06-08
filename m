From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 09 Jun 2016 00:31:50 +0300
Subject: [PATCH v3 09/12] ARM: dts: r8a7792: add IRQC support
In-Reply-To: <12536856.AsKMEpuejQ@wasted.cogentembedded.com>
References: <12536856.AsKMEpuejQ@wasted.cogentembedded.com>
Message-ID: <1560973.LULnaQ41Pv@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe the IRQC interrupt controller in the R8A7792 device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
Changes in version 3:
- refreshed the patch.

Changes in version 2:
- resolved reject, indenting the IRQC node that is now under the "soc" node;
- added Geert's tag.

 arch/arm/boot/dts/r8a7792.dtsi |   13 +++++++++++++
 1 file changed, 13 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7792.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792.dtsi
+++ renesas/arch/arm/boot/dts/r8a7792.dtsi
@@ -70,6 +70,19 @@
 				      IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		irqc: interrupt-controller at e61c0000 {
+			compatible = "renesas,irqc-r8a7792", "renesas,irqc";
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			reg = <0 0xe61c0000 0 0x200>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp4_clks R8A7792_CLK_IRQC>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+		};
+
 		timer {
 			compatible = "arm,armv7-timer";
 			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
