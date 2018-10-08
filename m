From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 08 Oct 2018 14:50:05 +0200
Subject: [PATCH 3/7] clocksource: Change CPU hotplug priority of exynos_mct
 driver
In-Reply-To: <20181008125009.3721-1-m.szyprowski@samsung.com>
References: <20181008125009.3721-1-m.szyprowski@samsung.com>
 <CGME20181008125047eucas1p1bbd0c4759612b6df8fbe25f759e03130@eucas1p1.samsung.com>
Message-ID: <20181008125009.3721-4-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos Multi-Core Timer driver (exynos_mct) must be started before
ARM Architected Timers (arch_timer), because both timers share common
hardware block and turning on MCT is needed to get ARM Architected
Timer working properly.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 include/linux/cpuhotplug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index caf40ad0bbc6..5d9e4a6ea299 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -115,10 +115,10 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_ACPI_STARTING,
 	CPUHP_AP_PERF_ARM_STARTING,
 	CPUHP_AP_ARM_L2X0_STARTING,
+	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
 	CPUHP_AP_ARM_ARCH_TIMER_STARTING,
 	CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
 	CPUHP_AP_JCORE_TIMER_STARTING,
-	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
 	CPUHP_AP_ARM_TWD_STARTING,
 	CPUHP_AP_QCOM_TIMER_STARTING,
 	CPUHP_AP_ARMADA_TIMER_STARTING,
-- 
2.17.1
