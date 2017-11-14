From: xuyiping@hisilicon.com (Xu YiPing)
Date: Tue, 14 Nov 2017 20:27:59 +0800
Subject: [PATCH] arm64: perf: remove duplicated and unsupported events for
 Cortex-A73
Message-ID: <1510662479-9550-1-git-send-email-xuyiping@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bus access read/write events are not supported in A73, and the definition
is duplicated, so delete it.

Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
---
 arch/arm64/kernel/perf_event.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 9eaef51..3affca3 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -262,12 +262,6 @@ static const unsigned armv8_a73_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 
 	[C(L1D)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_IMPDEF_PERFCTR_L1D_CACHE_RD,
 	[C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WR,
-
-	[C(NODE)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD,
-	[C(NODE)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR,
-
-	[C(NODE)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD,
-	[C(NODE)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR,
 };
 
 static const unsigned armv8_thunder_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
-- 
2.7.4
