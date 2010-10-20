From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 20 Oct 2010 06:51:31 +0200
Subject: [PATCH 2/5] ks8695_wdt: explicitly define the SoC timer tick base rate
Message-ID: <20101020045131.GY12979@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

..instead of including mach/timex.h, as the latter is going away.

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 drivers/watchdog/ks8695_wdt.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/ks8695_wdt.c b/drivers/watchdog/ks8695_wdt.c
index 2852bb2..0060519 100644
--- a/drivers/watchdog/ks8695_wdt.c
+++ b/drivers/watchdog/ks8695_wdt.c
@@ -21,9 +21,10 @@
 #include <linux/watchdog.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
-#include <mach/timex.h>
 #include <mach/regs-timer.h>
 
+#define KS8695_CLOCK_RATE	25000000
+
 #define WDT_DEFAULT_TIME	5	/* seconds */
 #define WDT_MAX_TIME		171	/* seconds */
 
-- 
1.7.2.3
