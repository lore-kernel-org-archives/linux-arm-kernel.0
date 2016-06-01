From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 1 Jun 2016 14:52:55 +0800
Subject: [PATCH v5 02/18] arc: Remove unnecessary of_platform_populate with
 default match table
In-Reply-To: <1464763991-26634-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1464763991-26634-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1464763991-26634-3-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After patch "of/platform: Add common method to populate default bus",
it is possible for arch code to remove unnecessary callers of
of_platform_populate with default match table.

Acked-by: Vineet Gupta <vgupta@synopsys.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arc/kernel/setup.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index f63b8bf..59053c1 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/cpu.h>
 #include <linux/of_fdt.h>
-#include <linux/of_platform.h>
 #include <linux/cache.h>
 #include <asm/sections.h>
 #include <asm/arcregs.h>
@@ -435,12 +434,6 @@ void __init setup_arch(char **cmdline_p)
 
 static int __init customize_machine(void)
 {
-	/*
-	 * Traverses flattened DeviceTree - registering platform devices
-	 * (if any) complete with their resources
-	 */
-	of_platform_default_populate(NULL, NULL, NULL);
-
 	if (machine_desc->init_machine)
 		machine_desc->init_machine();
 
-- 
1.7.12.4
