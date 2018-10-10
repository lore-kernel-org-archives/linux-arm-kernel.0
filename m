From: lkundrak@v3.sk (Lubomir Rintel)
Date: Wed, 10 Oct 2018 19:22:47 +0200
Subject: [PATCH 02/15] Revert "platform/olpc: Make ec explicitly non-modular"
In-Reply-To: <20181010172300.317643-1-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
Message-ID: <20181010172300.317643-3-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It doesn't make sense to always have this built-in, e.g. on ARM
multiplatform kernels. A better way to address the problem the original
commit aimed to solve is to fix Kconfig.

This reverts commit f48d1496b8537d75776478c6942dd87f34d7f270.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/platform/olpc/olpc-ec.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc-ec.c
index 374a8028fec7..f99b183d5296 100644
--- a/drivers/platform/olpc/olpc-ec.c
+++ b/drivers/platform/olpc/olpc-ec.c
@@ -1,8 +1,6 @@
 /*
  * Generic driver for the OLPC Embedded Controller.
  *
- * Author: Andres Salomon <dilinger@queued.net>
- *
  * Copyright (C) 2011-2012 One Laptop per Child Foundation.
  *
  * Licensed under the GPL v2 or later.
@@ -14,7 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
-#include <linux/init.h>
+#include <linux/module.h>
 #include <linux/list.h>
 #include <linux/olpc-ec.h>
 #include <asm/olpc.h>
@@ -328,4 +326,8 @@ static int __init olpc_ec_init_module(void)
 {
 	return platform_driver_register(&olpc_ec_plat_driver);
 }
+
 arch_initcall(olpc_ec_init_module);
+
+MODULE_AUTHOR("Andres Salomon <dilinger@queued.net>");
+MODULE_LICENSE("GPL");
-- 
2.19.0
