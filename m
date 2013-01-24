From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 24 Jan 2013 10:29:26 -0500
Subject: [PATCH] regulators/db8500: Fix compile failure for
 drivers/regulator/dbx500-prcmu.c
Message-ID: <1359041366.21576.146.camel@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building for the snowball board, I ran into this compile failure:

  CC      drivers/regulator/dbx500-prcmu.o
arm-test.git/drivers/regulator/dbx500-prcmu.c:119:11: error: 'THIS_MODULE' undeclared here (not in a function)
make[3]: *** [drivers/regulator/dbx500-prcmu.o] Error 1
make[2]: *** [drivers/regulator] Error 2

Commit 38e968380 "regulators/db8500: split off shared dbx500 code"
separated out the dbx500 code but did not copy over the required include
to linux/module.h.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/drivers/regulator/dbx500-prcmu.c b/drivers/regulator/dbx500-prcmu.c
index 261f3d2..89bd2fa 100644
--- a/drivers/regulator/dbx500-prcmu.c
+++ b/drivers/regulator/dbx500-prcmu.c
@@ -14,6 +14,7 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
+#include <linux/module.h>
 
 #include "dbx500-prcmu.h"
 
