From: zlim@broadcom.com (Zi Shen Lim)
Date: Thu, 24 Apr 2014 20:18:41 -0700
Subject: [PATCHv2 1/2] arm64,
 sched: Remove unused mc_capable() and smt_capable()
In-Reply-To: <1398395922-7482-1-git-send-email-zlim@broadcom.com>
References: <1398395922-7482-1-git-send-email-zlim@broadcom.com>
Message-ID: <1398395922-7482-2-git-send-email-zlim@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unused and deprecated mc_capable() and smt_capable().

Both were added recently by f6e763b93a6c ("arm64: topology:
Implement basic CPU topology support"). Uses of both were removed
by 8e7fbcbc22c1 ("sched: Remove stale power aware scheduling
remnants and dysfunctional knobs").

Reviewed-by: Mark Brown <broonie@linaro.org>
Signed-off-by: Zi Shen Lim <zlim@broadcom.com>
---
v1->v2: No changes.
 - Added Mark's review-by.

 arch/arm64/include/asm/topology.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index 0172e6d..7ebcd31 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -20,9 +20,6 @@ extern struct cpu_topology cpu_topology[NR_CPUS];
 #define topology_core_cpumask(cpu)	(&cpu_topology[cpu].core_sibling)
 #define topology_thread_cpumask(cpu)	(&cpu_topology[cpu].thread_sibling)
 
-#define mc_capable()	(cpu_topology[0].cluster_id != -1)
-#define smt_capable()	(cpu_topology[0].thread_id != -1)
-
 void init_cpu_topology(void);
 void store_cpu_topology(unsigned int cpuid);
 const struct cpumask *cpu_coregroup_mask(int cpu);
-- 
1.8.4.3
