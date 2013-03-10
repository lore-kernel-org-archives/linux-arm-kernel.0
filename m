From: mihai.stirbat@gmail.com (Mihai Stirbat)
Date: Sun, 10 Mar 2013 15:35:35 +0200
Subject: [PATCH] topology: removed kzalloc return value cast
Message-ID: <1362922535-25172-1-git-send-email-mihai.stirbat@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mihai Stirbat <mihai.stirbat@gmail.com>
---
 arch/arm/kernel/topology.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 79282eb..f10316b 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -100,7 +100,7 @@ static void __init parse_dt_topology(void)
 	int alloc_size, cpu = 0;
 
 	alloc_size = nr_cpu_ids * sizeof(struct cpu_capacity);
-	cpu_capacity = (struct cpu_capacity *)kzalloc(alloc_size, GFP_NOWAIT);
+	cpu_capacity = kzalloc(alloc_size, GFP_NOWAIT);
 
 	while ((cn = of_find_node_by_type(cn, "cpu"))) {
 		const u32 *rate, *reg;
-- 
1.7.10.4
