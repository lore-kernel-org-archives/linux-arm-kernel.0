From: kieran.bingham+renesas@ideasonboard.com (Kieran Bingham)
Date: Fri, 27 Apr 2018 17:57:18 +0100
Subject: [PATCH v2 07/11] arm64: dts: r8a77965: Add VSP instances
In-Reply-To: <20180427165722.19445-1-kieran.bingham+renesas@ideasonboard.com>
References: <20180427165722.19445-1-kieran.bingham+renesas@ideasonboard.com>
Message-ID: <20180427165722.19445-8-kieran.bingham+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The r8a77965 has 4 VSP instances.

Based on a similar patch of the R8A7796 device tree
by Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[Kieran: Rebased to top of tree, fixed sort orders]
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 44 +++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 74a7ae4ebccc..362eddc6b3d1 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -1009,6 +1009,17 @@
 			resets = <&cpg 615>;
 		};
 
+		vspb: vsp at fe960000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfe960000 0 0x8000>;
+			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 626>;
+			power-domains = <&sysc R8A77965_PD_A3VP>;
+			resets = <&cpg 626>;
+
+			renesas,fcp = <&fcpvb0>;
+		};
+
 		fcpvb0: fcp at fe96f000 {
 			compatible = "renesas,fcpv";
 			reg = <0 0xfe96f000 0 0x200>;
@@ -1017,6 +1028,17 @@
 			resets = <&cpg 607>;
 		};
 
+		vspi0: vsp at fe9a0000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfe9a0000 0 0x8000>;
+			interrupts = <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 631>;
+			power-domains = <&sysc R8A77965_PD_A3VP>;
+			resets = <&cpg 631>;
+
+			renesas,fcp = <&fcpvi0>;
+		};
+
 		fcpvi0: fcp at fe9af000 {
 			compatible = "renesas,fcpv";
 			reg = <0 0xfe9af000 0 0x200>;
@@ -1025,6 +1047,17 @@
 			resets = <&cpg 611>;
 		};
 
+		vspd0: vsp at fea20000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfea20000 0 0x8000>;
+			interrupts = <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 623>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
+			resets = <&cpg 623>;
+
+			renesas,fcp = <&fcpvd0>;
+		};
+
 		fcpvd0: fcp at fea27000 {
 			compatible = "renesas,fcpv";
 			reg = <0 0xfea27000 0 0x200>;
@@ -1033,6 +1066,17 @@
 			resets = <&cpg 603>;
 		};
 
+		vspd1: vsp at fea28000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfea28000 0 0x8000>;
+			interrupts = <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 622>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
+			resets = <&cpg 622>;
+
+			renesas,fcp = <&fcpvd1>;
+		};
+
 		fcpvd1: fcp at fea2f000 {
 			compatible = "renesas,fcpv";
 			reg = <0 0xfea2f000 0 0x200>;
-- 
2.17.0
