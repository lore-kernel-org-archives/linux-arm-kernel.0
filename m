From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 12 May 2016 20:06:06 +0800
Subject: [PATCH v4 09/18] nios2: Remove unnecessary of_platform_populate with
 default match table
In-Reply-To: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1463054775-18170-10-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After patch "of/platform: Add common method to populate default bus",
it is possible for arch code to remove unnecessary callers about the
of_platform_populate with default match table.

Cc: Ley Foon Tan <lftan@altera.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/nios2/platform/platform.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/nios2/platform/platform.c b/arch/nios2/platform/platform.c
index d478773..2a35154 100644
--- a/arch/nios2/platform/platform.c
+++ b/arch/nios2/platform/platform.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/init.h>
-#include <linux/of_platform.h>
 #include <linux/of_address.h>
 #include <linux/of_fdt.h>
 #include <linux/err.h>
@@ -39,8 +38,7 @@ static int __init nios2_soc_device_init(void)
 		}
 	}
 
-	return of_platform_populate(NULL, of_default_bus_match_table,
-		NULL, NULL);
+	return 0;
 }
 
 device_initcall(nios2_soc_device_init);
-- 
1.7.12.4
