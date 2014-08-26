From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Tue, 26 Aug 2014 13:06:55 +0200
Subject: [PATCH v5 12/12] sched: add SD_PREFER_SIBLING for SMT level
In-Reply-To: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
References: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1409051215-16788-13-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add the SD_PREFER_SIBLING flag for SMT level in order to ensure that
the scheduler will put at least 1 task per core.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7c3b237..ab5ab60 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6093,6 +6093,7 @@ sd_init(struct sched_domain_topology_level *tl, int cpu)
 	 */
 
 	if (sd->flags & SD_SHARE_CPUCAPACITY) {
+		sd->flags |= SD_PREFER_SIBLING;
 		sd->imbalance_pct = 110;
 		sd->smt_gain = 1178; /* ~15% */
 
-- 
1.9.1
