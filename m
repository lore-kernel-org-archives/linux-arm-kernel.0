From: khiem.nguyen.xt@rvc.renesas.com (Khiem Nguyen)
Date: Sun, 19 Jun 2016 11:16:45 +0700
Subject: [PATCH/RFC 3/3] arm64: dts: r8a7795: Support shared irq for thermal
 sensors
In-Reply-To: <57661BB1.3060401@rvc.renesas.com>
References: <57661211.7010900@rvc.renesas.com>
 <57661BB1.3060401@rvc.renesas.com>
Message-ID: <57661CAD.8040807@rvc.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the shared interrupts for thermal sensors
TSC1/TSC2/TSC3.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index db203db..761df2b 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -1628,7 +1628,8 @@
 			compatible = "renesas,thermal-r8a7795",
 				"renesas,rcar-gen3-thermal";
 			reg = <0 0xe6198000 0 0x5c>;
-			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 522>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			#thermal-sensor-cells = <0>;
@@ -1639,7 +1640,8 @@
 			compatible = "renesas,thermal-r8a7795",
 				"renesas,rcar-gen3-thermal";
 			reg = <0 0xe61a0000 0 0x5c>;
-			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 522>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			#thermal-sensor-cells = <0>;
@@ -1650,7 +1652,8 @@
 			compatible = "renesas,thermal-r8a7795",
 				"renesas,rcar-gen3-thermal";
 			reg = <0 0xe61a8000 0 0x5c>;
-			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 522>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			#thermal-sensor-cells = <0>;
-- 
1.9.1
