From: jglauber@cavium.com (Jan Glauber)
Date: Thu, 28 Jan 2016 15:54:59 +0100
Subject: [PATCH v2 1/5] arm64/perf: Rename Cortex A57 events
In-Reply-To: <cover.1453992560.git.jglauber@cavium.com>
References: <cover.1453992560.git.jglauber@cavium.com>
Message-ID: <2078b30bda5affe1c17555ce2888e98211dc4a9a.1453992560.git.jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The implemented Cortex A57 events are not A57 specific.
They are recommended by ARM and can be found on other
ARMv8 SOCs like Cavium ThunderX too. Therefore move
these events to the common PMUv3 table.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 arch/arm64/kernel/perf_event.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index f7ab14c..32fe656 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -87,17 +87,17 @@
 #define ARMV8_PMUV3_PERFCTR_L2D_TLB				0x2F
 #define ARMV8_PMUV3_PERFCTR_L21_TLB				0x30
 
+/* Recommended events. */
+#define ARMV8_PMUV3_PERFCTR_L1_DCACHE_ACCESS_LD			0x40
+#define ARMV8_PMUV3_PERFCTR_L1_DCACHE_ACCESS_ST			0x41
+#define ARMV8_PMUV3_PERFCTR_L1_DCACHE_REFILL_LD			0x42
+#define ARMV8_PMUV3_PERFCTR_L1_DCACHE_REFILL_ST			0x43
+#define ARMV8_PMUV3_PERFCTR_DTLB_REFILL_LD			0x4C
+#define ARMV8_PMUV3_PERFCTR_DTLB_REFILL_ST			0x4D
+
 /* ARMv8 Cortex-A53 specific event types. */
 #define ARMV8_A53_PERFCTR_PREFETCH_LINEFILL			0xC2
 
-/* ARMv8 Cortex-A57 and Cortex-A72 specific event types. */
-#define ARMV8_A57_PERFCTR_L1_DCACHE_ACCESS_LD			0x40
-#define ARMV8_A57_PERFCTR_L1_DCACHE_ACCESS_ST			0x41
-#define ARMV8_A57_PERFCTR_L1_DCACHE_REFILL_LD			0x42
-#define ARMV8_A57_PERFCTR_L1_DCACHE_REFILL_ST			0x43
-#define ARMV8_A57_PERFCTR_DTLB_REFILL_LD			0x4c
-#define ARMV8_A57_PERFCTR_DTLB_REFILL_ST			0x4d
-
 /* PMUv3 HW events mapping. */
 static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
 	PERF_MAP_ALL_UNSUPPORTED,
@@ -174,16 +174,16 @@ static const unsigned armv8_a57_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 					      [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
 	PERF_CACHE_MAP_ALL_UNSUPPORTED,
 
-	[C(L1D)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_A57_PERFCTR_L1_DCACHE_ACCESS_LD,
-	[C(L1D)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_A57_PERFCTR_L1_DCACHE_REFILL_LD,
-	[C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_A57_PERFCTR_L1_DCACHE_ACCESS_ST,
-	[C(L1D)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_A57_PERFCTR_L1_DCACHE_REFILL_ST,
+	[C(L1D)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1_DCACHE_ACCESS_LD,
+	[C(L1D)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1_DCACHE_REFILL_LD,
+	[C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1_DCACHE_ACCESS_ST,
+	[C(L1D)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1_DCACHE_REFILL_ST,
 
 	[C(L1I)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1_ICACHE_ACCESS,
 	[C(L1I)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1_ICACHE_REFILL,
 
-	[C(DTLB)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_A57_PERFCTR_DTLB_REFILL_LD,
-	[C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_A57_PERFCTR_DTLB_REFILL_ST,
+	[C(DTLB)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_DTLB_REFILL_LD,
+	[C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_DTLB_REFILL_ST,
 
 	[C(ITLB)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_ITLB_REFILL,
 
-- 
1.9.1
