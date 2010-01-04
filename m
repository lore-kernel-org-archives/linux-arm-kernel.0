From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon,  4 Jan 2010 13:24:39 +0000
Subject: [PATCH] kgdb: Fix ARM build with KGDB disabled
Message-ID: <1262611479-25833-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch "kgdb: core changes to support kdb" in -next makes the
inclusion of asm/kgdb.h depend on the selection of KGDB in Kconfig,
breaking the build on ARM when this is not selected since it protypes
a function kgdb_die_hook() there. Since this seems like a reasonable
thing for an architecture to want to do fix this by moving the
inclusion outside the ifdef check.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/kgdb.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index bd84f73..ada1f26 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -16,9 +16,11 @@
 #include <linux/serial_8250.h>
 #include <linux/linkage.h>
 #include <linux/init.h>
+
+#include <asm/kgdb.h>
+
 #ifdef CONFIG_KGDB
 #include <asm/atomic.h>
-#include <asm/kgdb.h>
 
 struct pt_regs;
 
-- 
1.6.5.7
