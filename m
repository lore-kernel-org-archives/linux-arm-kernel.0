From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  8 Sep 2016 09:43:05 +0200
Subject: [PATCH 09/30] arm64: dts: renesas: r8a7795: Add VSP instances
In-Reply-To: <cover.1473320411.git.horms+renesas@verge.net.au>
References: <cover.1473320411.git.horms+renesas@verge.net.au>
Message-ID: <9f8573e38a0b377aa092db96be140be4d59a7fae.1473320411.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The r8a7795 has 9 VSP instances.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 90 ++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index fe7725d1d131..19daa6a88312 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -1295,6 +1295,16 @@
 			status = "disabled";
 		};
 
+		vspbc: vsp at fe920000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfe920000 0 0x8000>;
+			interrupts = <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 624>;
+			power-domains = <&sysc R8A7795_PD_A3VP>;
+
+			renesas,fcp = <&fcpvb1>;
+		};
+
 		fcpvb1: fcp at fe92f000 {
 			compatible = "renesas,r8a7795-fcpv", "renesas,fcpv";
 			reg = <0 0xfe92f000 0 0x200>;
@@ -1323,6 +1333,16 @@
 			power-domains = <&sysc R8A7795_PD_A3VP>;
 		};
 
+		vspbd: vsp at fe960000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfe960000 0 0x8000>;
+			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 626>;
+			power-domains = <&sysc R8A7795_PD_A3VP>;
+
+			renesas,fcp = <&fcpvb0>;
+		};
+
 		fcpvb0: fcp at fe96f000 {
 			compatible = "renesas,r8a7795-fcpv", "renesas,fcpv";
 			reg = <0 0xfe96f000 0 0x200>;
@@ -1330,6 +1350,16 @@
 			power-domains = <&sysc R8A7795_PD_A3VP>;
 		};
 
+		vspi0: vsp at fe9a0000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfe9a0000 0 0x8000>;
+			interrupts = <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 631>;
+			power-domains = <&sysc R8A7795_PD_A3VP>;
+
+			renesas,fcp = <&fcpvi0>;
+		};
+
 		fcpvi0: fcp at fe9af000 {
 			compatible = "renesas,r8a7795-fcpv", "renesas,fcpv";
 			reg = <0 0xfe9af000 0 0x200>;
@@ -1337,6 +1367,16 @@
 			power-domains = <&sysc R8A7795_PD_A3VP>;
 		};
 
+		vspi1: vsp at fe9b0000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfe9b0000 0 0x8000>;
+			interrupts = <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 630>;
+			power-domains = <&sysc R8A7795_PD_A3VP>;
+
+			renesas,fcp = <&fcpvi1>;
+		};
+
 		fcpvi1: fcp at fe9bf000 {
 			compatible = "renesas,r8a7795-fcpv", "renesas,fcpv";
 			reg = <0 0xfe9bf000 0 0x200>;
@@ -1344,6 +1384,16 @@
 			power-domains = <&sysc R8A7795_PD_A3VP>;
 		};
 
+		vspi2: vsp at fe9c0000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfe9c0000 0 0x8000>;
+			interrupts = <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 629>;
+			power-domains = <&sysc R8A7795_PD_A3VP>;
+
+			renesas,fcp = <&fcpvi2>;
+		};
+
 		fcpvi2: fcp at fe9cf000 {
 			compatible = "renesas,r8a7795-fcpv", "renesas,fcpv";
 			reg = <0 0xfe9cf000 0 0x200>;
@@ -1351,6 +1401,16 @@
 			power-domains = <&sysc R8A7795_PD_A3VP>;
 		};
 
+		vspd0: vsp at fea20000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfea20000 0 0x4000>;
+			interrupts = <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 623>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+
+			renesas,fcp = <&fcpvd0>;
+		};
+
 		fcpvd0: fcp at fea27000 {
 			compatible = "renesas,r8a7795-fcpv", "renesas,fcpv";
 			reg = <0 0xfea27000 0 0x200>;
@@ -1358,6 +1418,16 @@
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 		};
 
+		vspd1: vsp at fea28000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfea28000 0 0x4000>;
+			interrupts = <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 622>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+
+			renesas,fcp = <&fcpvd1>;
+		};
+
 		fcpvd1: fcp at fea2f000 {
 			compatible = "renesas,r8a7795-fcpv", "renesas,fcpv";
 			reg = <0 0xfea2f000 0 0x200>;
@@ -1365,6 +1435,16 @@
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 		};
 
+		vspd2: vsp at fea30000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfea30000 0 0x4000>;
+			interrupts = <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 621>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+
+			renesas,fcp = <&fcpvd2>;
+		};
+
 		fcpvd2: fcp at fea37000 {
 			compatible = "renesas,r8a7795-fcpv", "renesas,fcpv";
 			reg = <0 0xfea37000 0 0x200>;
@@ -1372,6 +1452,16 @@
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 		};
 
+		vspd3: vsp at fea38000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfea38000 0 0x4000>;
+			interrupts = <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 620>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+
+			renesas,fcp = <&fcpvd3>;
+		};
+
 		fcpvd3: fcp at fea3f000 {
 			compatible = "renesas,r8a7795-fcpv", "renesas,fcpv";
 			reg = <0 0xfea3f000 0 0x200>;
-- 
2.7.0.rc3.207.g0ac5344
