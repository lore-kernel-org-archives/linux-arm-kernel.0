From: will.deacon@arm.com (Will Deacon)
Date: Mon,  8 Aug 2011 18:16:06 +0100
Subject: [PATCH 05/10] ARM: perf: use integers for ARMv7 event indices
In-Reply-To: <1312823771-9952-1-git-send-email-will.deacon@arm.com>
References: <1312823771-9952-1-git-send-email-will.deacon@arm.com>
Message-ID: <1312823771-9952-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch ensures that integers are used to represent event indices in
the ARMv7 PMU backend. This ensures consistency between functions and
also with the arm_pmu structure.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_v7.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index f4f260d..e39bc89 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -793,7 +793,7 @@ static inline int armv7_pmnc_counter_has_overflowed(u32 pmnc,
 	return ret;
 }
 
-static inline int armv7_pmnc_select_counter(unsigned int idx)
+static inline int armv7_pmnc_select_counter(int idx)
 {
 	u32 val;
 
@@ -840,7 +840,7 @@ static inline void armv7pmu_write_counter(int idx, u32 value)
 			smp_processor_id(), idx);
 }
 
-static inline void armv7_pmnc_write_evtsel(unsigned int idx, u32 val)
+static inline void armv7_pmnc_write_evtsel(int idx, u32 val)
 {
 	if (armv7_pmnc_select_counter(idx) == idx) {
 		val &= ARMV7_EVTSEL_MASK;
@@ -848,7 +848,7 @@ static inline void armv7_pmnc_write_evtsel(unsigned int idx, u32 val)
 	}
 }
 
-static inline u32 armv7_pmnc_enable_counter(unsigned int idx)
+static inline int armv7_pmnc_enable_counter(int idx)
 {
 	u32 val;
 
@@ -869,7 +869,7 @@ static inline u32 armv7_pmnc_enable_counter(unsigned int idx)
 	return idx;
 }
 
-static inline u32 armv7_pmnc_disable_counter(unsigned int idx)
+static inline int armv7_pmnc_disable_counter(int idx)
 {
 	u32 val;
 
@@ -891,7 +891,7 @@ static inline u32 armv7_pmnc_disable_counter(unsigned int idx)
 	return idx;
 }
 
-static inline u32 armv7_pmnc_enable_intens(unsigned int idx)
+static inline int armv7_pmnc_enable_intens(int idx)
 {
 	u32 val;
 
@@ -912,7 +912,7 @@ static inline u32 armv7_pmnc_enable_intens(unsigned int idx)
 	return idx;
 }
 
-static inline u32 armv7_pmnc_disable_intens(unsigned int idx)
+static inline int armv7_pmnc_disable_intens(int idx)
 {
 	u32 val;
 
-- 
1.7.0.4
