From: sachin.kamat@samsung.com (Sachin Kamat)
Date: Wed,  2 Jul 2014 14:36:16 +0530
Subject: [PATCH 1/1] arm: perf: Fix build error
Message-ID: <1404291976-24662-1-git-send-email-sachin.kamat@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing semicolon to fix the following build errors introduced by
commit 6f73e8ababdd ("arm: perf: clean up PMU names"):
arch/arm/kernel/perf_event_v6.c:498:2: error: expected ?;? before ?return?
arch/arm/kernel/perf_event_v6.c:505:2: error: expected ?;? before ?return?
arch/arm/kernel/perf_event_v6.c:512:2: error: expected ?;? before ?return?

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_v6.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index 62227d11e874..abfeb04f3213 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -494,21 +494,21 @@ static void armv6pmu_init(struct arm_pmu *cpu_pmu)
 static int armv6_1136_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv6pmu_init(cpu_pmu);
-	cpu_pmu->name		= "armv6_1136"
+	cpu_pmu->name		= "armv6_1136";
 	return 0;
 }
 
 static int armv6_1156_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv6pmu_init(cpu_pmu);
-	cpu_pmu->name		= "armv6_1156"
+	cpu_pmu->name		= "armv6_1156";
 	return 0;
 }
 
 static int armv6_1176_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv6pmu_init(cpu_pmu);
-	cpu_pmu->name		= "armv6_1176"
+	cpu_pmu->name		= "armv6_1176";
 	return 0;
 }
 
-- 
1.7.9.5
