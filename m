From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 13 May 2016 15:44:26 +0200
Subject: [PATCH] arm64: dts: exynos: Use human-friendly symbols for timer
 interrupt flags
Message-ID: <1463147066-8902-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace hex flags with human-readable symbols from arm-gic.h header
which makes it easier to recognize what is configured.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos7.dtsi | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index ca663dfe5189..8d7ce97c0ddb 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -10,6 +10,7 @@
  */
 
 #include <dt-bindings/clock/exynos7-clk.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
 	compatible = "samsung,exynos7";
@@ -473,10 +474,14 @@
 
 		timer {
 			compatible = "arm,armv8-timer";
-			interrupts = <1 13 0xff01>,
-				     <1 14 0xff01>,
-				     <1 11 0xff01>,
-				     <1 10 0xff01>;
+			interrupts = <GIC_PPI 13
+					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_EDGE_RISING)>,
+				     <GIC_PPI 14
+					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_EDGE_RISING)>,
+				     <GIC_PPI 11
+					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_EDGE_RISING)>,
+				     <GIC_PPI 10
+					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_EDGE_RISING)>;
 		};
 
 		pmu_system_controller: system-controller at 105c0000 {
-- 
1.9.1
