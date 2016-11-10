From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Thu, 10 Nov 2016 09:00:43 +0530
Subject: [PATCH] arm64: dts: Add ARM PMU node for exynos7
Message-ID: <1478748643-3081-1-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds ARM Performance Monitor Unit dt node for exynos7.
PMU provides various statistics on the operation of the CPU and
memory system at runtime, which are very useful when debugging or
profiling code. This enables the same.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos7.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index e0d0d01..53ce4be 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -472,6 +472,14 @@
 			status = "disabled";
 		};
 
+		arm-pmu {
+			compatible = "arm,cortex-a57-pmu", "arm,armv8-pmuv3";
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		timer {
 			compatible = "arm,armv8-timer";
 			interrupts = <GIC_PPI 13
-- 
1.7.10.4
