From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Wed, 24 Aug 2016 15:44:43 +0800
Subject: [PATCH v7 04/14] of/numa: remove a duplicated warning
In-Reply-To: <1472024693-12912-1-git-send-email-thunder.leizhen@huawei.com>
References: <1472024693-12912-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1472024693-12912-5-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This warning has been printed in of_numa_parse_cpu_nodes before.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 drivers/of/of_numa.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
index afaeb9c..8723f64 100644
--- a/drivers/of/of_numa.c
+++ b/drivers/of/of_numa.c
@@ -179,13 +179,8 @@ int of_node_to_nid(struct device_node *device)
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
