From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 12 May 2016 20:06:02 +0800
Subject: [PATCH v4 05/18] c6x: Remove unnecessary of_platform_populate with
 default match table
In-Reply-To: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1463054775-18170-6-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After patch "of/platform: Add common method to populate default bus",
it is possible for arch code to remove unnecessary callers about the
of_platform_populate with default match table.

Cc: Mikael Starvik <starvik@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/c6x/platforms/Makefile   |  2 +-
 arch/c6x/platforms/platform.c | 17 -----------------
 2 files changed, 1 insertion(+), 18 deletions(-)
 delete mode 100644 arch/c6x/platforms/platform.c

diff --git a/arch/c6x/platforms/Makefile b/arch/c6x/platforms/Makefile
index 9a95b9b..5f7d934 100644
--- a/arch/c6x/platforms/Makefile
+++ b/arch/c6x/platforms/Makefile
@@ -4,7 +4,7 @@
 # Copyright 2010, 2011 Texas Instruments Incorporated
 #
 
-obj-y = platform.o cache.o megamod-pic.o pll.o plldata.o timer64.o
+obj-y = cache.o megamod-pic.o pll.o plldata.o timer64.o
 obj-y += dscr.o
 
 # SoC objects
diff --git a/arch/c6x/platforms/platform.c b/arch/c6x/platforms/platform.c
deleted file mode 100644
index 26c1a35..0000000
--- a/arch/c6x/platforms/platform.c
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * Copyright 2011 Texas Instruments Incorporated
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-#include <linux/init.h>
-#include <linux/of_platform.h>
-
-static int __init c6x_device_probe(void)
-{
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-	return 0;
-}
-core_initcall(c6x_device_probe);
-- 
1.7.12.4
