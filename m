From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 12 May 2016 20:05:59 +0800
Subject: [PATCH v4 02/18] arc: Remove unnecessary of_platform_populate with
 default match table
In-Reply-To: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1463054775-18170-3-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After patch "of/platform: Add common method to populate default bus",
it is possible for arch code to remove unnecessary callers about the
of_platform_populate with default match table.

Cc: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arc/kernel/setup.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index 151acf0..27d25baa 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -15,7 +15,6 @@
 #include <linux/cpu.h>
 #include <linux/clk-provider.h>
 #include <linux/of_fdt.h>
-#include <linux/of_platform.h>
 #include <linux/cache.h>
 #include <asm/sections.h>
 #include <asm/arcregs.h>
@@ -445,11 +444,6 @@ void __init setup_arch(char **cmdline_p)
 static int __init customize_machine(void)
 {
 	of_clk_init(NULL);
-	/*
-	 * Traverses flattened DeviceTree - registering platform devices
-	 * (if any) complete with their resources
-	 */
-	of_platform_default_populate(NULL, NULL, NULL);
 
 	if (machine_desc->init_machine)
 		machine_desc->init_machine();
-- 
1.7.12.4
