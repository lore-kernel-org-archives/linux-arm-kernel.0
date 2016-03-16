From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 16 Mar 2016 15:35:41 +0800
Subject: [PATCH v2 all 12/14] memory: omap-gpmc: use
 of_platform_default_populate() to populate default bus
In-Reply-To: <1458113743-15131-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1458113743-15131-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1458113743-15131-13-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use helper of_platform_default_populate() in linux/of_platform
when possible, instead of calling of_platform_populate() with
the default match table.

Cc: Roger Quadros <rogerq@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/memory/omap-gpmc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 6515dfc..455fc73 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2016,8 +2016,7 @@ no_timings:
 	/* is child a common bus? */
 	if (of_match_node(of_default_bus_match_table, child))
 		/* create children and other common bus children */
-		if (of_platform_populate(child, of_default_bus_match_table,
-					 NULL, &pdev->dev))
+		if (of_platform_default_populate(child, NULL, &pdev->dev))
 			goto err_child_fail;
 
 	return 0;
-- 
2.6.0.GIT
