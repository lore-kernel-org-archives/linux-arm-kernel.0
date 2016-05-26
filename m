From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 26 May 2016 10:43:57 +0800
Subject: [PATCH 1/3] of/numa: remove a duplicated pr_debug information
Message-ID: <1464230639-9852-1-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This information will be printed in the subfunction numa_add_memblk.
They are not the same, but very similar.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/of/of_numa.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
index 0f2784b..21d831f 100644
--- a/drivers/of/of_numa.c
+++ b/drivers/of/of_numa.c
@@ -88,9 +88,6 @@ static int __init of_numa_parse_memory_nodes(void)
 			break;
 		}

-		pr_debug("NUMA:  base = %llx len = %llx, node = %u\n",
-			 rsrc.start, rsrc.end - rsrc.start + 1, nid);
-
 		r = numa_add_memblk(nid, rsrc.start,
 				    rsrc.end - rsrc.start + 1);
 		if (r)
--
2.5.0
