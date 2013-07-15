From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 15 Jul 2013 20:32:42 -0300
Subject: [PATCH 09/10] watchdog: orion: Use BIT()
In-Reply-To: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1373931163-12670-10-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a purely cosmetic commit: we replace hardcoded values that
representing bits by BIT(), which is slightly more readable.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 4ed7a74..ae64cec 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -30,8 +30,8 @@
 /*
  * Watchdog timer block registers.
  */
-#define WDT_EN			0x0010
-#define WDT_RESET_OUT_EN	0x0002
+#define WDT_EN			BIT(4)
+#define WDT_RESET_OUT_EN	BIT(1)
 
 #define WDT_MAX_CYCLE_COUNT	0xffffffff
 #define WDT_IN_USE		0
-- 
1.8.1.5
