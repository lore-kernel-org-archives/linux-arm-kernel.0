From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:15:45 +0200
Subject: [PATCH 25/41] ARM: dts: r8a7792: add IRQC support
In-Reply-To: <cover.1467294011.git.horms+renesas@verge.net.au>
References: <cover.1467294011.git.horms+renesas@verge.net.au>
Message-ID: <56efdbe56bc674208d01e3afdfb47f6b5b90da3d.1467294011.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Describe the IRQC interrupt controller in the R8A7792 device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7792.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index b6e34b431a51..18b4e50521c3 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -61,6 +61,19 @@
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
-- 
2.7.0.rc3.207.g0ac5344
