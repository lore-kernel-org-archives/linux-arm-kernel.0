From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Fri, 18 Apr 2014 13:54:25 +0200
Subject: [PATCH] fix: sched: rework of sched_domain topology definition
In-Reply-To: <20140418105801.GV11182@twins.programming.kicks-ass.net>
References: <20140418105801.GV11182@twins.programming.kicks-ass.net>
Message-ID: <1397822065-26210-1-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

set_sched_topology doesn't need to be defined for non SMP because
there is no sched_domain

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/sched.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d2b981c..674b1fa 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1047,8 +1047,6 @@ static inline bool cpus_share_cache(int this_cpu, int that_cpu)
 	return true;
 }
 
-static inline void set_sched_topology(struct sched_domain_topology_level *tl) { }
-
 #endif	/* !CONFIG_SMP */
 
 
-- 
1.9.1
