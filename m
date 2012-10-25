From: preeti@linux.vnet.ibm.com (Preeti U Murthy)
Date: Thu, 25 Oct 2012 15:55:49 +0530
Subject: [RFC PATCH 08/13] sched: Some miscallaneous changes in load_balance
In-Reply-To: <20121025102045.21022.92489.stgit@preeti.in.ibm.com>
References: <20121025102045.21022.92489.stgit@preeti.in.ibm.com>
Message-ID: <20121025102549.21022.81965.stgit@preeti.in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modify certain decisions in load_balance to use the imbalance
amount as calculated by the PJT's metric.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
 kernel/sched/fair.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bd7b69d..68a6b1d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5284,7 +5284,10 @@ more_balance:
 		 * moreover subsequent load balance cycles should correct the
 		 * excess load moved.
 		 */
-		if ((env.flags & LBF_SOME_PINNED) && env.imbalance > 0 &&
+		/*
+		 * The following decision based on PJT's metric
+ 		 */
+		if ((env.flags & LBF_SOME_PINNED) && env.load_imbalance > 0 &&
 				lb_iterations++ < max_lb_iterations) {
 
 			env.dst_rq	 = cpu_rq(env.new_dst_cpu);
