From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 16 Mar 2016 15:35:42 +0800
Subject: [PATCH v2 all 13/14] of: unittest: use of_platform_default_populate()
 to populate default bus
In-Reply-To: <1458113743-15131-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1458113743-15131-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1458113743-15131-14-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use helper of_platform_default_populate() in linux/of_platform
when possible, instead of calling of_platform_populate() with
the default match table.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/of/unittest.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 979b6e4..31837c8 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -772,7 +772,7 @@ static void __init of_unittest_platform_populate(void)
 	};
 
 	np = of_find_node_by_path("/testcase-data");
-	of_platform_populate(np, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(np, NULL, NULL);
 
 	/* Test that a missing irq domain returns -EPROBE_DEFER */
 	np = of_find_node_by_path("/testcase-data/testcase-device1");
@@ -1880,8 +1880,7 @@ static void __init of_unittest_overlay(void)
 		goto out;
 	}
 
-	ret = of_platform_populate(bus_np, of_default_bus_match_table,
-			NULL, NULL);
+	ret = of_platform_default_populate(bus_np, NULL, NULL);
 	if (ret != 0) {
 		unittest(0, "could not populate bus @ \"%s\"\n", bus_path);
 		goto out;
-- 
2.6.0.GIT
