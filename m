From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 15 Oct 2018 14:31:10 +0200
Subject: [PATCH v2 4/6] clocksource: Change CPU hotplug priority of
 exynos_mct driver
In-Reply-To: <20181015123112.9379-1-m.szyprowski@samsung.com>
References: <20181015123112.9379-1-m.szyprowski@samsung.com>
 <CGME20181015123136eucas1p2f7d4ae86ba3547b891749b01514cd335@eucas1p2.samsung.com>
Message-ID: <20181015123112.9379-5-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos Multi-Core Timer driver (exynos_mct) must be started before
ARM Architected Timers (arch_timer), because both timers share common
hardware block and turning on MCT is needed to get ARM Architected
Timer working properly.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
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
