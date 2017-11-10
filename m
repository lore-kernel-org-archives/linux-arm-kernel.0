From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Nov 2017 14:25:53 +0100
Subject: [PATCH v2 5/5] arm64: dts: renesas: r8a77970: Enable IPMMU-DS1,
 RT and MM
In-Reply-To: <20171110132553.1461-1-horms+renesas@verge.net.au>
References: <20171110132553.1461-1-horms+renesas@verge.net.au>
Message-ID: <20171110132553.1461-6-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the r8a77970 device nodes for IPMMU-DS1, IPMMU-RT
and the shared IPMMU-MM device.

Based on work for the r8a7796 by Magnus Damm.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2
* Added reviewed by tag from Geert Uytterhoeven
---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970.dtsi b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
index 0f93484e650a..636b57a2edde 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -159,7 +159,6 @@
 			renesas,ipmmu-main = <&ipmmu_mm 7>;
 			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_ds1: mmu at e7740000 {
@@ -168,7 +167,6 @@
 			renesas,ipmmu-main = <&ipmmu_mm 1>;
 			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		ipmmu_mm: mmu at e67b0000 {
@@ -178,7 +176,6 @@
 				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		intc_ex: interrupt-controller at e61c0000 {
-- 
2.11.0
