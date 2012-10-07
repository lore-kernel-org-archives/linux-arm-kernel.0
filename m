From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Sun,  7 Oct 2012 09:43:58 +0200
Subject: [RFC 6/6] ARM: sched: clear SD_SHARE_POWERLINE
In-Reply-To: <1349595838-31274-1-git-send-email-vincent.guittot@linaro.org>
References: <1349595838-31274-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1349595838-31274-7-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM platforms take advantage of packing small tasks on few cores.
This is true even when the cores of a cluster can't be powergated
independantly.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 arch/arm/kernel/topology.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 26c12c6..00511d0 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -226,6 +226,11 @@ static inline void update_cpu_power(unsigned int cpuid, unsigned int mpidr) {}
  */
 struct cputopo_arm cpu_topology[NR_CPUS];
 
+int arch_sd_share_power_line(void)
+{
+	return 0*SD_SHARE_POWERLINE;
+}
+
 const struct cpumask *cpu_coregroup_mask(int cpu)
 {
 	return &cpu_topology[cpu].core_sibling;
-- 
1.7.9.5
