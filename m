From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Sun,  1 Mar 2015 21:53:45 +0530
Subject: [PATCH 2/3] arm64: dts: Fix interrupt active level for the generic
 timer on exynos7
In-Reply-To: <1425227026-5336-1-git-send-email-a.kesavan@samsung.com>
References: <1425227026-5336-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1425227026-5336-3-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the exynos7 device tree to indicate that the arm generic timers
provide an active low interrupt output. Also, update the CPU mask to
match the number of CPUs on the SoC.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos7.dtsi | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index 749c4b3..c5687f9 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -10,6 +10,7 @@
  */
 
 #include <dt-bindings/clock/exynos7-clk.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
 	compatible = "samsung,exynos7";
@@ -440,10 +441,10 @@
 
 		timer {
 			compatible = "arm,armv8-timer";
-			interrupts = <1 13 0xff01>,
-				     <1 14 0xff01>,
-				     <1 11 0xff01>,
-				     <1 10 0xff01>;
+			interrupts = <1 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				     <1 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				     <1 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				     <1 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 		};
 
 		pmu_system_controller: system-controller at 105c0000 {
-- 
2.1.0
