From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 15 Jul 2013 20:32:41 -0300
Subject: [PATCH 08/10] watchdog: orion: Remove mach-specific unneeded header
In-Reply-To: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1373931163-12670-9-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mach/bridge-regs.h header is not needed anymore, so we can remove it.
This commit allows to use this driver on multiplatforms builds.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 4a0ab47..4ed7a74 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -26,12 +26,12 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/time-orion.h>
-#include <mach/bridge-regs.h>
 
 /*
  * Watchdog timer block registers.
  */
 #define WDT_EN			0x0010
+#define WDT_RESET_OUT_EN	0x0002
 
 #define WDT_MAX_CYCLE_COUNT	0xffffffff
 #define WDT_IN_USE		0
-- 
1.8.1.5
