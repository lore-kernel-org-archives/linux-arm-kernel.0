From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 18 Dec 2017 17:39:03 +0000
Subject: [PATCH v2 3/3] ARM: dts: r8a7745: Add CMT SoC specific support
In-Reply-To: <1513618743-4773-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1513618743-4773-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1513618743-4773-4-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CMT[01] support to SoC DT.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
v1->v2:
* status "okay"->"disabled"

 arch/arm/boot/dts/r8a7745.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 0fa7861..0b67ee5 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -235,6 +235,38 @@
 						  IRQ_TYPE_LEVEL_LOW)>;
 		};
 
+		cmt0: timer at ffca0000 {
+			compatible = "renesas,r8a7745-cmt0",
+				     "renesas,rcar-gen2-cmt0";
+			reg = <0 0xffca0000 0 0x1004>;
+			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 124>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A7745_PD_ALWAYS_ON>;
+			resets = <&cpg 124>;
+			status = "disabled";
+		};
+
+		cmt1: timer at e6130000 {
+			compatible = "renesas,r8a7745-cmt1",
+				     "renesas,rcar-gen2-cmt1";
+			reg = <0 0xe6130000 0 0x1004>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 329>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A7745_PD_ALWAYS_ON>;
+			resets = <&cpg 329>;
+			status = "disabled";
+		};
+
 		cpg: clock-controller at e6150000 {
 			compatible = "renesas,r8a7745-cpg-mssr";
 			reg = <0 0xe6150000 0 0x1000>;
-- 
2.7.4
