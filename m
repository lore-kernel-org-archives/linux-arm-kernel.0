From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Tue, 5 Apr 2016 13:59:40 +0800
Subject: [PATCH v3 12/14] memory: omap-gpmc: use
 of_platform_default_populate() to populate default bus
In-Reply-To: <1459835982-26473-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1459835982-26473-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1459835982-26473-13-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use helper of_platform_default_populate() in linux/of_platform
when possible, instead of calling of_platform_populate() with
the default match table.

Acked-by: Roger Quadros <rogerq@ti.com>
Cc: Roger Quadros <rogerq@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/memory/omap-gpmc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 21825dd..b9f6cc8 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2046,8 +2046,7 @@ no_timings:
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
