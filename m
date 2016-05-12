From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 12 May 2016 20:06:03 +0800
Subject: [PATCH v4 06/18] cris: Remove unnecessary of_platform_populate with
 default match table
In-Reply-To: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1463054775-18170-7-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After patch "of/platform: Add common method to populate default bus",
it is possible for arch code to remove unnecessary callers about the
of_platform_populate with default match table.

Cc: Mikael Starvik <starvik@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/cris/kernel/setup.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/cris/kernel/setup.c b/arch/cris/kernel/setup.c
index bb12aa9..4b4853d 100644
--- a/arch/cris/kernel/setup.c
+++ b/arch/cris/kernel/setup.c
@@ -21,7 +21,6 @@
 #include <linux/cpu.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
-#include <linux/of_platform.h>
 #include <asm/setup.h>
 #include <arch/system.h>
 
@@ -212,10 +211,3 @@ static int __init topology_init(void)
 }
 
 subsys_initcall(topology_init);
-
-static int __init cris_of_init(void)
-{
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-	return 0;
-}
-core_initcall(cris_of_init);
-- 
1.7.12.4
