From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  7 Dec 2017 10:53:17 +0100
Subject: [PATCH 14/54] arm64: dts: renesas: r8a7796: Enable IPMMU-DS0, DS1, MP,
 VI0, VC0 and MM
In-Reply-To: <cover.1512640145.git.horms+renesas@verge.net.au>
References: <cover.1512640145.git.horms+renesas@verge.net.au>
Message-ID: <88d1eb0c99cc1c055b3a65fe1afafe36478abb57.1512640145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Enable the r8a7795 device nodes for IPMMU-DS0, IPMMU-DS1, IPMMU-MP,
IPMMU-VI0, IPMMU-VC0 and the shared IPMMU-MM device.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 7e5fef780786..cc0cca7c0494 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -363,7 +363,6 @@
 			renesas,ipmmu-main = <&ipmmu_mm 9>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_vc0: mmu at fe6b0000 {
@@ -381,7 +380,6 @@
 			renesas,ipmmu-main = <&ipmmu_mm 5>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_pv1: mmu at fd950000 {
@@ -426,7 +424,6 @@
 			renesas,ipmmu-main = <&ipmmu_mm 4>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_ds0: mmu at e6740000 {
@@ -435,7 +432,6 @@
 			renesas,ipmmu-main = <&ipmmu_mm 0>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_ds1: mmu at e7740000 {
@@ -444,7 +440,6 @@
 			renesas,ipmmu-main = <&ipmmu_mm 1>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_mm: mmu at e67b0000 {
@@ -454,7 +449,6 @@
 				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		cpg: clock-controller at e6150000 {
-- 
2.11.0
