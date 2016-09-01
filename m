From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 1 Sep 2016 14:54:52 +0800
Subject: [PATCH v8 01/16] of/numa: remove a duplicated pr_debug information
In-Reply-To: <1472712907-12700-1-git-send-email-thunder.leizhen@huawei.com>
References: <1472712907-12700-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1472712907-12700-2-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This information will be printed in the subfunction numa_add_memblk.
They are not the same, but very similar.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 drivers/of/of_numa.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
index ed5a097..fb71b4e 100644
--- a/drivers/of/of_numa.c
+++ b/drivers/of/of_numa.c
@@ -88,10 +88,6 @@ static int __init of_numa_parse_memory_nodes(void)
 			break;
 		}

-		pr_debug("NUMA:  base = %llx len = %llx, node = %u\n",
-			 rsrc.start, rsrc.end - rsrc.start + 1, nid);
-
-
 		r = numa_add_memblk(nid, rsrc.start, rsrc.end + 1);
 		if (r)
 			break;
--
2.5.0
