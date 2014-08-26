From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Tue, 26 Aug 2014 13:06:48 +0200
Subject: [PATCH v5 05/12] ARM: topology: use new cpu_capacity interface
In-Reply-To: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
References: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1409051215-16788-6-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new arch_scale_cpu_capacity in order to reflect the original capacity
of a CPU instead of arch_scale_freq_capacity which is more linked to a scaling
of the capacity linked to the frequency.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 arch/arm/kernel/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index e35d880..89cfdd6 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -42,7 +42,7 @@
  */
 static DEFINE_PER_CPU(unsigned long, cpu_scale);
 
-unsigned long arch_scale_freq_capacity(struct sched_domain *sd, int cpu)
+unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
 {
 	return per_cpu(cpu_scale, cpu);
 }
@@ -166,7 +166,7 @@ static void update_cpu_capacity(unsigned int cpu)
 	set_capacity_scale(cpu, cpu_capacity(cpu) / middle_capacity);
 
 	printk(KERN_INFO "CPU%u: update cpu_capacity %lu\n",
-		cpu, arch_scale_freq_capacity(NULL, cpu));
+		cpu, arch_scale_cpu_capacity(NULL, cpu));
 }
 
 #else
-- 
1.9.1
