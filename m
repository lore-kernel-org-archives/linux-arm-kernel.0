From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Oct 2018 17:31:55 +0100
Subject: [PATCH 6/6] arm64: perf: Hook up new events
In-Reply-To: <1539189115-16221-1-git-send-email-will.deacon@arm.com>
References: <1539189115-16221-1-git-send-email-will.deacon@arm.com>
Message-ID: <1539189115-16221-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There have been some additional events added to the PMU architecture
since Armv8.0, so expose them via our sysfs infrastructure.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/perf_event.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index a6e17622bad3..95d40cde3621 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -221,6 +221,18 @@ ARMV8_EVENT_ATTR(l2d_tlb_refill, ARMV8_PMUV3_PERFCTR_L2D_TLB_REFILL);
 ARMV8_EVENT_ATTR(l2i_tlb_refill, ARMV8_PMUV3_PERFCTR_L2I_TLB_REFILL);
 ARMV8_EVENT_ATTR(l2d_tlb, ARMV8_PMUV3_PERFCTR_L2D_TLB);
 ARMV8_EVENT_ATTR(l2i_tlb, ARMV8_PMUV3_PERFCTR_L2I_TLB);
+ARMV8_EVENT_ATTR(remote_access, ARMV8_PMUV3_PERFCTR_REMOTE_ACCESS);
+ARMV8_EVENT_ATTR(ll_cache, ARMV8_PMUV3_PERFCTR_LL_CACHE);
+ARMV8_EVENT_ATTR(ll_cache_miss, ARMV8_PMUV3_PERFCTR_LL_CACHE_MISS);
+ARMV8_EVENT_ATTR(dtlb_walk, ARMV8_PMUV3_PERFCTR_DTLB_WALK);
+ARMV8_EVENT_ATTR(itlb_walk, ARMV8_PMUV3_PERFCTR_ITLB_WALK);
+ARMV8_EVENT_ATTR(ll_cache_rd, ARMV8_PMUV3_PERFCTR_LL_CACHE_RD);
+ARMV8_EVENT_ATTR(ll_cache_miss_rd, ARMV8_PMUV3_PERFCTR_LL_CACHE_MISS_RD);
+ARMV8_EVENT_ATTR(remote_access_rd, ARMV8_PMUV3_PERFCTR_REMOTE_ACCESS_RD);
+ARMV8_EVENT_ATTR(sample_pop, ARMV8_SPE_PERFCTR_SAMPLE_POP);
+ARMV8_EVENT_ATTR(sample_feed, ARMV8_SPE_PERFCTR_SAMPLE_FEED);
+ARMV8_EVENT_ATTR(sample_filtrate, ARMV8_SPE_PERFCTR_SAMPLE_FILTRATE);
+ARMV8_EVENT_ATTR(sample_collision, ARMV8_SPE_PERFCTR_SAMPLE_COLLISION);
 
 static struct attribute *armv8_pmuv3_event_attrs[] = {
 	&armv8_event_attr_sw_incr.attr.attr,
@@ -271,6 +283,18 @@ static struct attribute *armv8_pmuv3_event_attrs[] = {
 	&armv8_event_attr_l2i_tlb_refill.attr.attr,
 	&armv8_event_attr_l2d_tlb.attr.attr,
 	&armv8_event_attr_l2i_tlb.attr.attr,
+	&armv8_event_attr_remote_access.attr.attr,
+	&armv8_event_attr_ll_cache.attr.attr,
+	&armv8_event_attr_ll_cache_miss.attr.attr,
+	&armv8_event_attr_dtlb_walk.attr.attr,
+	&armv8_event_attr_itlb_walk.attr.attr,
+	&armv8_event_attr_ll_cache_rd.attr.attr,
+	&armv8_event_attr_ll_cache_miss_rd.attr.attr,
+	&armv8_event_attr_remote_access_rd.attr.attr,
+	&armv8_event_attr_sample_pop.attr.attr,
+	&armv8_event_attr_sample_feed.attr.attr,
+	&armv8_event_attr_sample_filtrate.attr.attr,
+	&armv8_event_attr_sample_collision.attr.attr,
 	NULL,
 };
 
-- 
2.1.4
