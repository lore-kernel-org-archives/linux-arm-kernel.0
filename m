From: will.deacon@arm.com (Will Deacon)
Date: Mon,  6 Jun 2011 17:55:52 +0100
Subject: [PATCH 08/11] ARM: perf: remove confusing comment from v7 perf events
	backend
In-Reply-To: <1307379355-13802-1-git-send-email-will.deacon@arm.com>
References: <1307379355-13802-1-git-send-email-will.deacon@arm.com>
Message-ID: <1307379355-13802-9-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The comment about measuring TLB misses and refills in the ARMv7 perf
backend makes little sense and refers loosely to raw counters that
should be used instead.

This patch removes the comments to avoid any confusion.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_v7.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 4960686..554eba3 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -207,11 +207,6 @@ static const unsigned armv7_a8_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 		},
 	},
 	[C(DTLB)] = {
-		/*
-		 * Only ITLB misses and DTLB refills are supported.
-		 * If users want the DTLB refills misses a raw counter
-		 * must be used.
-		 */
 		[C(OP_READ)] = {
 			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
 			[C(RESULT_MISS)]	= ARMV7_PERFCTR_DTLB_REFILL,
@@ -323,11 +318,6 @@ static const unsigned armv7_a9_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 		},
 	},
 	[C(DTLB)] = {
-		/*
-		 * Only ITLB misses and DTLB refills are supported.
-		 * If users want the DTLB refills misses a raw counter
-		 * must be used.
-		 */
 		[C(OP_READ)] = {
 			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
 			[C(RESULT_MISS)]	= ARMV7_PERFCTR_DTLB_REFILL,
-- 
1.7.0.4
