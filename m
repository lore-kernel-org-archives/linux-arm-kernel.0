From: ynorov@caviumnetworks.com (Yury Norov)
Date: Sun, 25 Mar 2018 20:50:03 +0300
Subject: [PATCH 1/2] rcu: declare rcu_eqs_special_set() in public header
In-Reply-To: <20180325175004.28162-1-ynorov@caviumnetworks.com>
References: <20180325175004.28162-1-ynorov@caviumnetworks.com>
Message-ID: <20180325175004.28162-2-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rcu_eqs_special_set() is declared only in internal header
kernel/rcu/tree.h and stubbed in include/linux/rcutiny.h.

This patch declares rcu_eqs_special_set() in include/linux/rcutree.h, so
it can be used in non-rcu kernel code.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 include/linux/rcutree.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index fd996cdf1833..448f20f27396 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -74,6 +74,7 @@ static inline void synchronize_rcu_bh_expedited(void)
 void rcu_barrier(void);
 void rcu_barrier_bh(void);
 void rcu_barrier_sched(void);
+bool rcu_eqs_special_set(int cpu);
 unsigned long get_state_synchronize_rcu(void);
 void cond_synchronize_rcu(unsigned long oldstate);
 unsigned long get_state_synchronize_sched(void);
-- 
2.14.1
