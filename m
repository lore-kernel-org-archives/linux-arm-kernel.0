From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 12 May 2016 20:06:12 +0800
Subject: [PATCH v4 15/18] bus: uniphier-system-bus: use
 of_platform_default_populate() to populate default bus
In-Reply-To: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1463054775-18170-16-git-send-email-wangkefeng.wang@huawei.com>
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
index 350b730..1e6e0269 100644
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
1.7.12.4
