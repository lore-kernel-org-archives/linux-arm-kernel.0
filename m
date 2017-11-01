From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  1 Nov 2017 11:35:04 +0100
Subject: [PATCH 4/4] arm64: dts: renesas: r8a77970: Enable IPMMU-DS1, RT and MM
In-Reply-To: <20171101103504.7658-1-horms+renesas@verge.net.au>
References: <20171101103504.7658-1-horms+renesas@verge.net.au>
Message-ID: <20171101103504.7658-5-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the r8a77970 device nodes for IPMMU-DS1, IPMMU-RT
and the shared IPMMU-MM device.

Based on work for the r8a7796 by Magnus Damm.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970.dtsi b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
index fa59ee54a888..548257a92629 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -155,7 +155,6 @@
 			reg = <0 0xffc80000 0 0x1000>; /* IPMMU-RT */
 			renesas,ipmmu-main = <&ipmmu_mm 7>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_ds1: mmu at e7740000 {
@@ -163,7 +162,6 @@
 			reg = <0 0xe7740000 0 0x1000>; /* IPMMU-DS1 */
 			renesas,ipmmu-main = <&ipmmu_mm 1>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_mm: mmu at e67b0000 {
@@ -172,7 +170,6 @@
 			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		intc_ex: interrupt-controller at e61c0000 {
-- 
2.11.0
