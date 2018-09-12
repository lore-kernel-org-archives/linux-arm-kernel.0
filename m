From: t.jag587@gmail.com (Jagdish Tirumala)
Date: Wed, 12 Sep 2018 08:33:54 -0700
Subject: [PATCH] WATCHDOG: uniphier_wdt.c: Fixed error do not initialise
 statics to 0
Message-ID: <20180912153354.4658-1-t.jag587@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed error do not initialise statics to 0
in file drivers/watchdog/uniphier_wdt.c

Signed-off-by: Jagdish Tirumala <t.jag587@gmail.com>
---
 drivers/watchdog/uniphier_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/uniphier_wdt.c b/drivers/watchdog/uniphier_wdt.c
index e20a7a459d69..2c62ad7250fb 100644
--- a/drivers/watchdog/uniphier_wdt.c
+++ b/drivers/watchdog/uniphier_wdt.c
@@ -41,7 +41,7 @@
 #define WDT_PERIOD_MIN			1
 #define WDT_PERIOD_MAX			128
 
-static unsigned int timeout = 0;
+static unsigned int timeout;
 static bool nowayout = WATCHDOG_NOWAYOUT;
 
 struct uniphier_wdt_dev {
-- 
2.17.1
