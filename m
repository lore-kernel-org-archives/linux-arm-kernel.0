From: broonie@kernel.org (Mark Brown)
Date: Tue,  7 Jan 2014 14:06:33 +0000
Subject: [PATCH] ARM: topology: Coding style fixes
Message-ID: <1389103593-29284-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

Use kcalloc() and ULONG_MAX rather than open coding them.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 arch/arm/kernel/topology.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 0bc94b1fd1ae..0fa8825cea04 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -91,13 +91,13 @@ static void __init parse_dt_topology(void)
 {
 	const struct cpu_efficiency *cpu_eff;
 	struct device_node *cn = NULL;
-	unsigned long min_capacity = (unsigned long)(-1);
+	unsigned long min_capacity = ULONG_MAX;
 	unsigned long max_capacity = 0;
 	unsigned long capacity = 0;
-	int alloc_size, cpu = 0;
+	int cpu = 0;
 
-	alloc_size = nr_cpu_ids * sizeof(*__cpu_capacity);
-	__cpu_capacity = kzalloc(alloc_size, GFP_NOWAIT);
+	__cpu_capacity = kcalloc(nr_cpu_ids, sizeof(*__cpu_capacity),
+				 GFP_NOWAIT);
 
 	for_each_possible_cpu(cpu) {
 		const u32 *rate;
-- 
1.8.5.2
