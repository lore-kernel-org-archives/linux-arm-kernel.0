From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Thu,  4 Sep 2014 09:34:39 +0200
Subject: [PATCH v5 09/11] sched: add usage_load_avg
In-Reply-To: <1409051215-16788-10-git-send-email-vincent.guittot@linaro.org>
References: <1409051215-16788-10-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1409816079-10131-1-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The update of update_rq_runnable_avg interface is missing for
CONFIG_FAIR_GROUP_SCHED in the original patch
"[PATCH v5 09/12] sched: add usage_load_avg"

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

Hi Peter,

Do you prefer that I sent a new version of 
"[PATCH v5 09/12] sched: add usage_load_avg" patch with the fix or this fix is
enough ?

Regards,
Vincent

 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1fd2131..cbe3eff 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2462,7 +2462,8 @@ static inline void __update_group_entity_contrib(struct sched_entity *se)
 
 static inline void update_rq_runnable_avg(struct rq *rq, int runnable)
 {
-	__update_entity_runnable_avg(rq_clock_task(rq), &rq->avg, runnable);
+	__update_entity_runnable_avg(rq_clock_task(rq), &rq->avg, runnable,
+			runnable);
 	__update_tg_runnable_avg(&rq->avg, &rq->cfs);
 }
 #else /* CONFIG_FAIR_GROUP_SCHED */
-- 
1.9.1
