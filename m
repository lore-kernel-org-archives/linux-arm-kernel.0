From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 16 Mar 2016 15:35:40 +0800
Subject: [PATCH v2 all 11/14] bus: uniphier-system-bus: use
 of_platform_default_populate() to populate default bus
In-Reply-To: <1458113743-15131-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1458113743-15131-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1458113743-15131-12-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use helper of_platform_default_populate() in linux/of_platform
when possible, instead of calling of_platform_populate() with
the default match table.

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/bus/uniphier-system-bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bus/uniphier-system-bus.c b/drivers/bus/uniphier-system-bus.c
index 834a2ae..f50bd6d 100644
--- a/drivers/bus/uniphier-system-bus.c
+++ b/drivers/bus/uniphier-system-bus.c
@@ -257,8 +257,7 @@ static int uniphier_system_bus_probe(struct platform_device *pdev)
 	uniphier_system_bus_set_reg(priv);
 
 	/* Now, the bus is configured.  Populate platform_devices below it */
-	return of_platform_populate(dev->of_node, of_default_bus_match_table,
-				    NULL, dev);
+	return of_platform_default_populate(dev->of_node, NULL, dev);
 }
 
 static const struct of_device_id uniphier_system_bus_match[] = {
-- 
2.6.0.GIT
