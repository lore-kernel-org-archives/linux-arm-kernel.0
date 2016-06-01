From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 1 Jun 2016 14:53:09 +0800
Subject: [PATCH v5 16/18] memory: omap-gpmc: use
 of_platform_default_populate() to populate default bus
In-Reply-To: <1464763991-26634-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1464763991-26634-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1464763991-26634-17-git-send-email-wangkefeng.wang@huawei.com>
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
index af4884b..4b1913a 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2134,8 +2134,7 @@ no_timings:
 	/* is child a common bus? */
 	if (of_match_node(of_default_bus_match_table, child))
 		/* create children and other common bus children */
-		if (of_platform_populate(child, of_default_bus_match_table,
-					 NULL, &pdev->dev))
+		if (of_platform_default_populate(child, NULL, &pdev->dev))
 			goto err_child_fail;
 
 	return 0;
-- 
1.7.12.4
