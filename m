From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:14:53 +0200
Subject: [PATCH 031/102] arm64: dts: renesas: r8a7796: Enable IPMMU devices
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <330f2dc009e937efe6618096718f12a4a5a847f8.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Remove 'status = "disabled"' to make sure all IPMMU devices are enabled
in DT on the r8a7796 SoC.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index e6254711556c..f33063dd7cd7 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -881,7 +881,6 @@
 			renesas,ipmmu-main = <&ipmmu_mm 2>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_ir: mmu at ff8b0000 {
@@ -890,7 +889,6 @@
 			renesas,ipmmu-main = <&ipmmu_mm 3>;
 			power-domains = <&sysc R8A7796_PD_A3IR>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_mm: mmu at e67b0000 {
@@ -924,7 +922,6 @@
 			renesas,ipmmu-main = <&ipmmu_mm 6>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_rt: mmu at ffc80000 {
@@ -933,7 +930,6 @@
 			renesas,ipmmu-main = <&ipmmu_mm 7>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_vc0: mmu at fe6b0000 {
@@ -942,7 +938,6 @@
 			renesas,ipmmu-main = <&ipmmu_mm 8>;
 			power-domains = <&sysc R8A7796_PD_A3VC>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_vi0: mmu at febd0000 {
-- 
2.11.0
