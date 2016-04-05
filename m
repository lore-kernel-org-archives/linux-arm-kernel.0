From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Tue, 5 Apr 2016 13:59:42 +0800
Subject: [PATCH v3 14/14] Revert "of/platform: export
 of_default_bus_match_table"
In-Reply-To: <1459835982-26473-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1459835982-26473-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1459835982-26473-15-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit b80443c2211c7daaabd20fbbe9e7beb3fa3408e0.

After covering to use helper of_platform_default_populate() to populate
the default bus, no need to export of_default_bus_match_table anymore.

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/of/platform.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 8d103e4..af98343 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -31,7 +31,6 @@ const struct of_device_id of_default_bus_match_table[] = {
 #endif /* CONFIG_ARM_AMBA */
 	{} /* Empty terminated list */
 };
-EXPORT_SYMBOL(of_default_bus_match_table);
 
 static int of_dev_node_match(struct device *dev, void *data)
 {
-- 
2.6.0.GIT
