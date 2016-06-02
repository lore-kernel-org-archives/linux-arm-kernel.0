From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 2 Jun 2016 10:28:10 +0800
Subject: [PATCH v3 4/5] of/numa: remove a duplicated warning
In-Reply-To: <1464834491-12024-1-git-send-email-thunder.leizhen@huawei.com>
References: <1464834491-12024-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1464834491-12024-5-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This warning has been printed in of_numa_parse_cpu_nodes before.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/of/of_numa.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
index 7b3fbdc..3157130 100644
--- a/drivers/of/of_numa.c
+++ b/drivers/of/of_numa.c
@@ -174,13 +174,8 @@ int of_node_to_nid(struct device_node *device)
 			np->name);
 	of_node_put(np);

-	if (!r) {
-		if (nid >= MAX_NUMNODES)
-			pr_warn("NUMA: Node id %u exceeds maximum value\n",
-				nid);
-		else
-			return nid;
-	}
+	if (!r)
+		return nid;

 	return NUMA_NO_NODE;
 }
--
2.5.0
