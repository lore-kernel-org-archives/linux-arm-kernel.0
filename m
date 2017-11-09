From: xuyiping@hisilicon.com (Xu YiPing)
Date: Thu, 9 Nov 2017 19:18:23 +0800
Subject: [PATCH v2] arm64: dts: hi3660: improve pmu description
Message-ID: <1510226303-20950-1-git-send-email-xuyiping@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cortex-a73 pmu driver is supported now. hi3660 is 4*a73 + 4*a53, so it
should use "cortex-a73-pmu" and "cortex-a53-pmu" instead of "armpmu-v3",
then we can use the a73 and a53 events in perf tool directly.

Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 13ae69f..f4882d3 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -203,21 +203,25 @@
 					 IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
-	pmu {
-		compatible = "arm,armv8-pmuv3";
+	a53-pmu {
+		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-affinity = <&cpu0>,
 				     <&cpu1>,
 				     <&cpu2>,
-				     <&cpu3>,
-				     <&cpu4>,
+				     <&cpu3>;
+	};
+
+	a73-pmu {
+		compatible = "arm,cortex-a73-pmu";
+		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu4>,
 				     <&cpu5>,
 				     <&cpu6>,
 				     <&cpu7>;
-- 
2.7.4
