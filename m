From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 13 Jun 2017 13:45:51 +0100
Subject: [PATCH] drivers/perf: commonise PERF_EVENTS dependency
Message-ID: <1497357951-17292-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All PMU drivers are going to depend on PERF_EVENTS, so let's make this
dependency common and simplify the individual Kconfig entries.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/Kconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index aa587ed..e5197ff 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -3,9 +3,10 @@
 #
 
 menu "Performance monitor support"
+	depends on PERF_EVENTS
 
 config ARM_PMU
-	depends on PERF_EVENTS && (ARM || ARM64)
+	depends on ARM || ARM64
 	bool "ARM PMU framework"
 	default y
 	help
@@ -18,7 +19,7 @@ config ARM_PMU_ACPI
 
 config QCOM_L2_PMU
 	bool "Qualcomm Technologies L2-cache PMU"
-	depends on ARCH_QCOM && ARM64 && PERF_EVENTS && ACPI
+	depends on ARCH_QCOM && ARM64 && ACPI
 	  help
 	  Provides support for the L2 cache performance monitor unit (PMU)
 	  in Qualcomm Technologies processors.
@@ -27,7 +28,7 @@ config QCOM_L2_PMU
 
 config QCOM_L3_PMU
 	bool "Qualcomm Technologies L3-cache PMU"
-	depends on ARCH_QCOM && ARM64 && PERF_EVENTS && ACPI
+	depends on ARCH_QCOM && ARM64 && ACPI
 	select QCOM_IRQ_COMBINER
 	help
 	   Provides support for the L3 cache performance monitor unit (PMU)
@@ -36,7 +37,7 @@ config QCOM_L3_PMU
 	   monitoring L3 cache events.
 
 config XGENE_PMU
-        depends on PERF_EVENTS && ARCH_XGENE
+        depends on ARCH_XGENE
         bool "APM X-Gene SoC PMU"
         default n
         help
-- 
1.9.1
