From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  1 Nov 2017 11:34:58 +0100
Subject: [PATCH 7/7] arm64: dts: renesas: r8a7796: Enable IPMMU-DS0, DS1, MP,
 VI0, VC0 and MM
In-Reply-To: <20171101103458.7582-1-horms+renesas@verge.net.au>
References: <20171101103458.7582-1-horms+renesas@verge.net.au>
Message-ID: <20171101103458.7582-8-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Enable the r8a7795 device nodes for IPMMU-DS0, IPMMU-DS1, IPMMU-MP,
IPMMU-VI0, IPMMU-VC0 and the shared IPMMU-MM device.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
[simon: enable IPMMU-MP, VI0 and VC0]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 78160b4a380c..f0800f501116 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -362,7 +362,6 @@
 			reg = <0 0xfebd0000 0 0x1000>; /* IPMMU-VI0 */
 			renesas,ipmmu-main = <&ipmmu_mm 9>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_vc0: mmu at fe6b0000 {
@@ -370,7 +369,6 @@
 			reg = <0 0xfe6b0000 0 0x1000>; /* IPMMU-VC0 */
 			renesas,ipmmu-main = <&ipmmu_mm 8>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_pv0: mmu at fd800000 {
@@ -418,7 +416,6 @@
 			reg = <0 0xec670000 0 0x1000>; /* IPMMU-MP */
 			renesas,ipmmu-main = <&ipmmu_mm 4>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_ds0: mmu at e6740000 {
@@ -426,7 +423,6 @@
 			reg = <0 0xe6740000 0 0x1000>; /* IPMMU-DS0 */
 			renesas,ipmmu-main = <&ipmmu_mm 0>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_ds1: mmu at e7740000 {
@@ -434,7 +430,6 @@
 			reg = <0 0xe7740000 0 0x1000>; /* IPMMU-DS1 */
 			renesas,ipmmu-main = <&ipmmu_mm 1>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_mm: mmu at e67b0000 {
@@ -443,7 +438,6 @@
 			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		cpg: clock-controller at e6150000 {
-- 
2.11.0
