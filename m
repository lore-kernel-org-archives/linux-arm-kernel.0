From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Nov 2017 14:26:12 +0100
Subject: [PATCH v2 7/7] arm64: dts: renesas: r8a7796: Enable IPMMU-DS0, DS1, MP,
 VI0, VC0 and MM
In-Reply-To: <20171110132612.1589-1-horms+renesas@verge.net.au>
References: <20171110132612.1589-1-horms+renesas@verge.net.au>
Message-ID: <20171110132612.1589-8-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Enable the r8a7795 device nodes for IPMMU-DS0, IPMMU-DS1, IPMMU-MP,
IPMMU-VI0, IPMMU-VC0 and the shared IPMMU-MM device.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2 [Simon Horman]
* Added reviewed by tag from Geert Uytterhoeven

v1 [Simon Horman]
* Enable IPMMU-MP, VI0 and VC0

v0 [Magnus Damm]
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 530de7176a6f..0db69add3f74 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -363,7 +363,6 @@
 			renesas,ipmmu-main = <&ipmmu_mm 9>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_vc0: mmu at fe6b0000 {
@@ -372,7 +371,6 @@
 			renesas,ipmmu-main = <&ipmmu_mm 8>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_pv0: mmu at fd800000 {
@@ -426,7 +424,6 @@
 			renesas,ipmmu-main = <&ipmmu_mm 4>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_ds0: mmu at e6740000 {
@@ -434,7 +431,6 @@
 			reg = <0 0xe6740000 0 0x1000>;
 			renesas,ipmmu-main = <&ipmmu_mm 0>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_ds1: mmu at e7740000 {
@@ -443,7 +439,6 @@
 			renesas,ipmmu-main = <&ipmmu_mm 1>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_mm: mmu at e67b0000 {
@@ -453,7 +448,6 @@
 				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		cpg: clock-controller at e6150000 {
-- 
2.11.0
