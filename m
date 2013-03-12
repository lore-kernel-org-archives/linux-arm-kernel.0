From: zhangyanfei@cn.fujitsu.com (Zhang Yanfei)
Date: Tue, 12 Mar 2013 12:42:37 +0800
Subject: [PATCH 01/18] arm: remove cast for kzalloc return value
Message-ID: <513EB23D.7020303@cn.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

remove cast for kzalloc return value.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/kernel/topology.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

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
1.7.1
