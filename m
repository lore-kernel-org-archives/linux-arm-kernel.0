From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 20 Apr 2017 12:05:45 -0700
Subject: [PATCH 1/2] arm64: pmu: Wire-up Cortex A53 L2 cache events and DTLB
 refills
In-Reply-To: <20170420190546.7453-1-f.fainelli@gmail.com>
References: <20170420190546.7453-1-f.fainelli@gmail.com>
Message-ID: <20170420190546.7453-3-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing L2 cache events: read/write accesses and misses, as well as
the DTLB refills.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/kernel/perf_event.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 57ae9d9ed9bb..4f011cdd756d 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -290,6 +290,12 @@ static const unsigned armv8_a53_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 	[C(L1I)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1I_CACHE,
 	[C(L1I)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1I_CACHE_REFILL,
 
+	[C(LL)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L2D_CACHE,
+	[C(LL)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L2D_CACHE_REFILL,
+	[C(LL)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L2D_CACHE,
+	[C(LL)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L2D_CACHE_REFILL,
+
+	[C(DTLB)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1D_TLB_REFILL,
 	[C(ITLB)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1I_TLB_REFILL,
 
 	[C(BPU)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_BR_PRED,
-- 
2.9.3
