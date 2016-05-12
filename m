From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 12 May 2016 20:06:04 +0800
Subject: [PATCH v4 07/18] metag: Remove unnecessary of_platform_populate with
 default match table
In-Reply-To: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1463054775-18170-8-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After patch "of/platform: Add common method to populate default bus",
it is possible for arch code to remove unnecessary callers about the
of_platform_populate with default match table.

Cc: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/metag/kernel/setup.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/metag/kernel/setup.c b/arch/metag/kernel/setup.c
index 31cf53d..1166f1f 100644
--- a/arch/metag/kernel/setup.c
+++ b/arch/metag/kernel/setup.c
@@ -20,7 +20,6 @@
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/of_fdt.h>
-#include <linux/of_platform.h>
 #include <linux/pfn.h>
 #include <linux/root_dev.h>
 #include <linux/sched.h>
@@ -414,9 +413,7 @@ static int __init customize_machine(void)
 	/* customizes platform devices, or adds new ones */
 	if (machine_desc->init_machine)
 		machine_desc->init_machine();
-	else
-		of_platform_populate(NULL, of_default_bus_match_table, NULL,
-				     NULL);
+
 	return 0;
 }
 arch_initcall(customize_machine);
-- 
1.7.12.4
