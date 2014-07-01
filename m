From: mark.rutland@arm.com (Mark Rutland)
Date: Tue,  1 Jul 2014 16:11:11 +0100
Subject: [PATCH 1/8] arm: perf: move event map macros to pmu.h
In-Reply-To: <1404227478-9645-1-git-send-email-mark.rutland@arm.com>
References: <1404227478-9645-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1404227478-9645-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few PMU-related macros are now looking a little lonely in
asm/perf_event.h now that all other PMU-specific structs, function
prototypes and macros live in pmu.h.

So as to make their placement consistent and to make it easier to build
atop of the current PMU functionality, let's reunite the entire family in
pmu.h

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/perf_event.h | 9 ---------
 arch/arm/include/asm/pmu.h        | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/perf_event.h b/arch/arm/include/asm/perf_event.h
index 7558775..c3a8369 100644
--- a/arch/arm/include/asm/perf_event.h
+++ b/arch/arm/include/asm/perf_event.h
@@ -12,15 +12,6 @@
 #ifndef __ARM_PERF_EVENT_H__
 #define __ARM_PERF_EVENT_H__
 
-/*
- * The ARMv7 CPU PMU supports up to 32 event counters.
- */
-#define ARMPMU_MAX_HWEVENTS		32
-
-#define HW_OP_UNSUPPORTED		0xFFFF
-#define C(_x)				PERF_COUNT_HW_CACHE_##_x
-#define CACHE_OP_UNSUPPORTED		0xFFFF
-
 #ifdef CONFIG_HW_PERF_EVENTS
 struct pt_regs;
 extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index ae1919b..748d20d 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -42,6 +42,15 @@ struct arm_pmu_platdata {
 
 #ifdef CONFIG_HW_PERF_EVENTS
 
+/*
+ * The ARMv7 CPU PMU supports up to 32 event counters.
+ */
+#define ARMPMU_MAX_HWEVENTS		32
+
+#define HW_OP_UNSUPPORTED		0xFFFF
+#define C(_x)				PERF_COUNT_HW_CACHE_##_x
+#define CACHE_OP_UNSUPPORTED		0xFFFF
+
 /* The events for a given PMU register set. */
 struct pmu_hw_events {
 	/*
-- 
1.9.1
