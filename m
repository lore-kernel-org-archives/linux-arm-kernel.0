From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 23 Jun 2017 14:55:30 +0530
Subject: [PATCH V3 1/5] arch_topology: Don't break lines unnecessarily
In-Reply-To: <cover.1498209817.git.viresh.kumar@linaro.org>
References: <cover.1498209817.git.viresh.kumar@linaro.org>
Message-ID: <b930d45f593c8550a78477c0d56bd5ee27d4af89.1498209817.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need of line break at few places, avoid them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/arch_topology.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index d1c33a85059e..0ad79b5cd56d 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -41,8 +41,7 @@ static ssize_t cpu_capacity_show(struct device *dev,
 {
 	struct cpu *cpu = container_of(dev, struct cpu, dev);
 
-	return sprintf(buf, "%lu\n",
-			topology_get_cpu_scale(NULL, cpu->dev.id));
+	return sprintf(buf, "%lu\n", topology_get_cpu_scale(NULL, cpu->dev.id));
 }
 
 static ssize_t cpu_capacity_store(struct device *dev,
@@ -128,8 +127,7 @@ int __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 	if (cap_parsing_failed)
 		return !ret;
 
-	ret = of_property_read_u32(cpu_node,
-				   "capacity-dmips-mhz",
+	ret = of_property_read_u32(cpu_node, "capacity-dmips-mhz",
 				   &cpu_capacity);
 	if (!ret) {
 		if (!raw_capacity) {
@@ -181,8 +179,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 		pr_debug("cpu_capacity: init cpu capacity for CPUs [%*pbl] (to_visit=%*pbl)\n",
 				cpumask_pr_args(policy->related_cpus),
 				cpumask_pr_args(cpus_to_visit));
-		cpumask_andnot(cpus_to_visit,
-			       cpus_to_visit,
+		cpumask_andnot(cpus_to_visit, cpus_to_visit,
 			       policy->related_cpus);
 		for_each_cpu(cpu, policy->related_cpus) {
 			raw_capacity[cpu] = topology_get_cpu_scale(NULL, cpu) *
-- 
2.13.0.71.gd7076ec9c9cb
