From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Fri, 28 Mar 2014 14:22:27 +0100
Subject: [RFC 2/4] ARM: topology: use new cpu_power interface
In-Reply-To: <1396012949-6227-1-git-send-email-vincent.guittot@linaro.org>
References: <1396012949-6227-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1396012949-6227-3-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new arch_scale_cpu_power in order to reflect the original capacity of
a CPU instead of arch_scale_freq_power which is more linked to a scaling of
the capacity regarding frequency.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 arch/arm/kernel/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 0bc94b1..55a7d90 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -42,7 +42,7 @@
  */
 static DEFINE_PER_CPU(unsigned long, cpu_scale);
 
-unsigned long arch_scale_freq_power(struct sched_domain *sd, int cpu)
+unsigned long arch_scale_cpu_power(struct sched_domain *sd, int cpu)
 {
 	return per_cpu(cpu_scale, cpu);
 }
@@ -166,7 +166,7 @@ static void update_cpu_power(unsigned int cpu)
 	set_power_scale(cpu, cpu_capacity(cpu) / middle_capacity);
 
 	printk(KERN_INFO "CPU%u: update cpu_power %lu\n",
-		cpu, arch_scale_freq_power(NULL, cpu));
+		cpu, arch_scale_cpu_power(NULL, cpu));
 }
 
 #else
-- 
1.9.0
