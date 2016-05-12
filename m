From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 12 May 2016 20:06:07 +0800
Subject: [PATCH v4 10/18] sh: Remove unnecessary of_platform_populate with
 default match table
In-Reply-To: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1463054775-18170-11-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After patch "of/platform: Add common method to populate default bus",
it is possible for arch code to remove unnecessary callers about the
of_platform_populate with default match table.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/sh/boards/of-generic.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index b4d4313..911ffb9 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/of_fdt.h>
 #include <linux/clocksource.h>
 #include <linux/irqchip.h>
@@ -179,16 +178,3 @@ void __init arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
 void __init plat_irq_setup(void)
 {
 }
-
-static int __init sh_of_device_init(void)
-{
-	pr_info("SH generic board support: populating platform devices\n");
-	if (of_have_populated_dt()) {
-		of_platform_populate(NULL, of_default_bus_match_table,
-				     NULL, NULL);
-	} else {
-		pr_crit("Device tree not populated\n");
-	}
-	return 0;
-}
-arch_initcall_sync(sh_of_device_init);
-- 
1.7.12.4
