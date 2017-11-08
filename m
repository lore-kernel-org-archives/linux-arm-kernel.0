From: xuyiping@hisilicon.com (Xu YiPing)
Date: Wed, 8 Nov 2017 16:59:38 +0800
Subject: [PATCH] arm64: dts: hi3660: improve pmu description
Message-ID: <1510131578-84235-1-git-send-email-xuyiping@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cortex a73 pmu is supported, use it instead of armpmu-v3

---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 13ae69f..f638897 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -203,21 +203,25 @@
 					 IRQ_TYPE_LEVEL_HIGH)>;
 	};

-	pmu {
-		compatible = "arm,armv8-pmuv3";
+	pmu_a53 {
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
+	pmu_a73 {
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
