From: festevam@gmail.com (Fabio Estevam)
Date: Sun,  1 Sep 2013 23:11:08 -0300
Subject: [PATCH] ARM: mxs: pm: Include "pm.h"
Message-ID: <1378087868-29744-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Include "pm.h" in order to fix the following sparse warning:

arch/arm/mach-mxs/pm.c:37:13: warning: symbol 'mxs_pm_init' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mxs/pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mxs/pm.c b/arch/arm/mach-mxs/pm.c
index b2494d2..0170e99 100644
--- a/arch/arm/mach-mxs/pm.c
+++ b/arch/arm/mach-mxs/pm.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/suspend.h>
 #include <linux/io.h>
+#include "pm.h"
 
 static int mxs_suspend_enter(suspend_state_t state)
 {
-- 
1.8.1.2
