From: will.deacon@arm.com (Will Deacon)
Date: Mon,  8 Aug 2011 18:16:08 +0100
Subject: [PATCH 07/10] ARM: perf: index Xscale and ARMv6 event counters
	starting from zero
In-Reply-To: <1312823771-9952-1-git-send-email-will.deacon@arm.com>
References: <1312823771-9952-1-git-send-email-will.deacon@arm.com>
Message-ID: <1312823771-9952-8-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the ARMv7 PMU backend indexes event counters from zero, follow
suit and do the same for ARMv6 and Xscale.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_v6.c     |    4 ++--
 arch/arm/kernel/perf_event_xscale.c |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index d1abe97..87f29b5 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -54,7 +54,7 @@ enum armv6_perf_types {
 };
 
 enum armv6_counters {
-	ARMV6_CYCLE_COUNTER = 1,
+	ARMV6_CYCLE_COUNTER = 0,
 	ARMV6_COUNTER0,
 	ARMV6_COUNTER1,
 };
@@ -487,7 +487,7 @@ armv6pmu_handle_irq(int irq_num,
 	perf_sample_data_init(&data, 0);
 
 	cpuc = &__get_cpu_var(cpu_hw_events);
-	for (idx = 0; idx <= armpmu->num_events; ++idx) {
+	for (idx = 0; idx < armpmu->num_events; ++idx) {
 		struct perf_event *event = cpuc->events[idx];
 		struct hw_perf_event *hwc;
 
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index 730b1c2..54312fc 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -40,7 +40,7 @@ enum xscale_perf_types {
 };
 
 enum xscale_counters {
-	XSCALE_CYCLE_COUNTER	= 1,
+	XSCALE_CYCLE_COUNTER	= 0,
 	XSCALE_COUNTER0,
 	XSCALE_COUNTER1,
 	XSCALE_COUNTER2,
@@ -249,7 +249,7 @@ xscale1pmu_handle_irq(int irq_num, void *dev)
 	perf_sample_data_init(&data, 0);
 
 	cpuc = &__get_cpu_var(cpu_hw_events);
-	for (idx = 0; idx <= armpmu->num_events; ++idx) {
+	for (idx = 0; idx < armpmu->num_events; ++idx) {
 		struct perf_event *event = cpuc->events[idx];
 		struct hw_perf_event *hwc;
 
@@ -581,7 +581,7 @@ xscale2pmu_handle_irq(int irq_num, void *dev)
 	perf_sample_data_init(&data, 0);
 
 	cpuc = &__get_cpu_var(cpu_hw_events);
-	for (idx = 0; idx <= armpmu->num_events; ++idx) {
+	for (idx = 0; idx < armpmu->num_events; ++idx) {
 		struct perf_event *event = cpuc->events[idx];
 		struct hw_perf_event *hwc;
 
-- 
1.7.0.4
