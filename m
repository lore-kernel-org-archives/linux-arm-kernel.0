From: preeti@linux.vnet.ibm.com (Preeti U Murthy)
Date: Thu, 25 Oct 2012 15:55:54 +0530
Subject: [RFC PATCH 09/13] sched: Modify check_asym_packing to use PJT's metric
In-Reply-To: <20121025102045.21022.92489.stgit@preeti.in.ibm.com>
References: <20121025102045.21022.92489.stgit@preeti.in.ibm.com>
Message-ID: <20121025102554.21022.45715.stgit@preeti.in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make appropriate modifications in check_asym_packing to reflect PJT's
metric.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
 kernel/sched/fair.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 68a6b1d..3b18f5f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4814,6 +4814,8 @@ static int check_asym_packing(struct lb_env *env, struct sd_lb_stats *sds)
 
 	env->imbalance = DIV_ROUND_CLOSEST(
 		sds->max_load * sds->busiest->sgp->power, SCHED_POWER_SCALE);
+	env->load_imbalance = DIV_ROUND_CLOSEST(
+		sds->max_sg_load * sds->busiest->sgp->power, SCHED_POWER_SCALE);
 
 	return 1;
 }
