From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Nov 2017 14:25:31 +0100
Subject: [PATCH v5 14/15] arm64: dts: renesas: r8a7795: Enable IPMMU-VI0, VP1,
 DS0, DS1 and MM
In-Reply-To: <20171110132532.1202-1-horms+renesas@verge.net.au>
References: <20171110132532.1202-1-horms+renesas@verge.net.au>
Message-ID: <20171110132532.1202-15-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Enable the r8a7795 device nodes for IPMMU-VI0, IPMMU-VP1, IPMMU-DS0,
IPMMU-DS1 and the shared IPMMU-MM device.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5 [Simon Horman]
* Update changelog to reflect new IPMMU names
* Added reviewed by tag from Geert Uytterhoeven

v4 [Simon Horman]
* Broke out of larger patch

v1 - v3 [Magnus Damm]
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index f42387473a9c..6aa00d9b1d50 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -427,7 +427,6 @@
 			renesas,ipmmu-main = <&ipmmu_mm 14>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_vi1: mmu at febe0000 {
@@ -454,7 +453,6 @@
 			renesas,ipmmu-main = <&ipmmu_mm 17>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_vc0: mmu at fe6b0000 {
@@ -544,7 +542,6 @@
 			renesas,ipmmu-main = <&ipmmu_mm 0>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_ds1: mmu at e7740000 {
@@ -553,7 +550,6 @@
 			renesas,ipmmu-main = <&ipmmu_mm 1>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_mm: mmu at e67b0000 {
@@ -563,7 +559,6 @@
 				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		dmac0: dma-controller at e6700000 {
-- 
2.11.0
