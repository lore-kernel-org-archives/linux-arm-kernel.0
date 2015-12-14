From: dirk.behme@gmail.com (Dirk Behme)
Date: Mon, 14 Dec 2015 18:37:51 +0100
Subject: [PATCH] arm64: dts: r8a7795: pmu: switch to Cortex specific device
 nodes
Message-ID: <1450114671-10711-1-git-send-email-dirk.behme@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of using the generic armv8-pmuv3 compatibility use the more
specific Cortex A57 and A53 compatibility.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
---
Note: This patch applies on top of

https://patchwork.kernel.org/patch/7834201/

https://patchwork.kernel.org/patch/7834211/

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 30ebc08..590c510 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -287,21 +287,26 @@
 			power-domains = <&cpg>;
 		};
 
-		pmu {
-			compatible = "arm,armv8-pmuv3";
+		pmu_a57 {
+			compatible = "arm,cortex-a57-pmu";
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-affinity = <&a57_0>,
 					     <&a57_1>,
 					     <&a57_2>,
-					     <&a57_3>,
-					     <&a53_0>,
+					     <&a57_3>;
+
+		};
+
+		pmu_a53 {
+			compatible = "arm,cortex-a53-pmu";
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-affinity = <&a53_0>,
 					     <&a53_1>,
 					     <&a53_2>,
 					     <&a53_3>;
-- 
2.6.4
