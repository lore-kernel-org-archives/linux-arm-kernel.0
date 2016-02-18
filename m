From: jglauber@cavium.com (Jan Glauber)
Date: Thu, 18 Feb 2016 17:50:10 +0100
Subject: [PATCH v4 1/5] arm64/perf: Rename Cortex A57 events
In-Reply-To: <cover.1455810755.git.jglauber@cavium.com>
References: <cover.1455810755.git.jglauber@cavium.com>
Message-ID: <f974b2901758c907119aaf453f8730be8c9aca59.1455810755.git.jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The implemented Cortex A57 events are strictly-speaking not
A57 specific. They are ARM recommended implementation defined events
and can be found on other ARMv8 SOCs like Cavium ThunderX too.

Therefore rename these events to allow using them in other
implementations too.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 arch/arm64/kernel/perf_event.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index f7ab14c..2adbcb5 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -90,13 +90,13 @@
 /* ARMv8 Cortex-A53 specific event types. */
 #define ARMV8_A53_PERFCTR_PREFETCH_LINEFILL			0xC2
 
-/* ARMv8 Cortex-A57 and Cortex-A72 specific event types. */
-#define ARMV8_A57_PERFCTR_L1_DCACHE_ACCESS_LD			0x40
-#define ARMV8_A57_PERFCTR_L1_DCACHE_ACCESS_ST			0x41
-#define ARMV8_A57_PERFCTR_L1_DCACHE_REFILL_LD			0x42
-#define ARMV8_A57_PERFCTR_L1_DCACHE_REFILL_ST			0x43
-#define ARMV8_A57_PERFCTR_DTLB_REFILL_LD			0x4c
-#define ARMV8_A57_PERFCTR_DTLB_REFILL_ST			0x4d
+/* ARMv8 implementation defined event types. */
+#define ARMV8_IMPDEF_PERFCTR_L1_DCACHE_ACCESS_LD		0x40
+#define ARMV8_IMPDEF_PERFCTR_L1_DCACHE_ACCESS_ST		0x41
+#define ARMV8_IMPDEF_PERFCTR_L1_DCACHE_REFILL_LD		0x42
+#define ARMV8_IMPDEF_PERFCTR_L1_DCACHE_REFILL_ST		0x43
+#define ARMV8_IMPDEF_PERFCTR_DTLB_REFILL_LD			0x4c
+#define ARMV8_IMPDEF_PERFCTR_DTLB_REFILL_ST			0x4d
 
 /* PMUv3 HW events mapping. */
 static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
@@ -174,16 +174,16 @@ static const unsigned armv8_a57_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 					      [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
 	PERF_CACHE_MAP_ALL_UNSUPPORTED,
 
-	[C(L1D)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_A57_PERFCTR_L1_DCACHE_ACCESS_LD,
-	[C(L1D)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_A57_PERFCTR_L1_DCACHE_REFILL_LD,
-	[C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_A57_PERFCTR_L1_DCACHE_ACCESS_ST,
-	[C(L1D)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_A57_PERFCTR_L1_DCACHE_REFILL_ST,
+	[C(L1D)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_IMPDEF_PERFCTR_L1_DCACHE_ACCESS_LD,
+	[C(L1D)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_IMPDEF_PERFCTR_L1_DCACHE_REFILL_LD,
+	[C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_IMPDEF_PERFCTR_L1_DCACHE_ACCESS_ST,
+	[C(L1D)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_IMPDEF_PERFCTR_L1_DCACHE_REFILL_ST,
 
 	[C(L1I)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1_ICACHE_ACCESS,
 	[C(L1I)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1_ICACHE_REFILL,
 
-	[C(DTLB)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_A57_PERFCTR_DTLB_REFILL_LD,
-	[C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_A57_PERFCTR_DTLB_REFILL_ST,
+	[C(DTLB)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_IMPDEF_PERFCTR_DTLB_REFILL_LD,
+	[C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_IMPDEF_PERFCTR_DTLB_REFILL_ST,
 
 	[C(ITLB)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_ITLB_REFILL,
 
-- 
1.9.1
