From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2018 13:54:13 +0100
Subject: [PATCH 11/16] ARM: dts: r8a77470: Add CMT SoC specific support
In-Reply-To: <cover.1543236456.git.horms+renesas@verge.net.au>
References: <cover.1543236456.git.horms+renesas@verge.net.au>
Message-ID: <be8f6b8eca0f11096acf6e2d6641f6a027218d69.1543236456.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Add CMT[01] support to r8a77470 SoC DT.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a77470.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
index 0a7ca2ff4dc4..5c0e48d0449a 100644
--- a/arch/arm/boot/dts/r8a77470.dtsi
+++ b/arch/arm/boot/dts/r8a77470.dtsi
@@ -615,6 +615,38 @@
 			compatible = "renesas,prr";
 			reg = <0 0xff000044 0 4>;
 		};
+
+		cmt0: timer at ffca0000 {
+			compatible = "renesas,r8a77470-cmt0",
+				     "renesas,rcar-gen2-cmt0";
+			reg = <0 0xffca0000 0 0x1004>;
+			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 124>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A77470_PD_ALWAYS_ON>;
+			resets = <&cpg 124>;
+			status = "disabled";
+		};
+
+		cmt1: timer at e6130000 {
+			compatible = "renesas,r8a77470-cmt1",
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
+			power-domains = <&sysc R8A77470_PD_ALWAYS_ON>;
+			resets = <&cpg 329>;
+			status = "disabled";
+		};
 	};
 
 	timer {
-- 
2.11.0
