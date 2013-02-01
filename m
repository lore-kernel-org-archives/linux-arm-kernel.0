From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Fri,  1 Feb 2013 15:06:22 +0800
Subject: [PATCH v4 4/8] watchdog/at91sam9_wdt: Adjust the options of
 watchdog_info
In-Reply-To: <1359702386-21284-1-git-send-email-wenyou.yang@atmel.com>
References: <1359702386-21284-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1359702386-21284-5-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the Watchdog Timer Mode Register can be only written only once,
so the watchdog_info shall not support WDIOF_SETTIMEOUT
and WDIOF_MAGICCLOSE options, remove them.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Cc: wim at iguana.be
Cc: linux-watchdog at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/watchdog/at91sam9_wdt.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index ce7930b..c6d9f1f 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -152,8 +152,7 @@ static int at91wdt_enable(struct watchdog_device *wddev, unsigned int timeout)
 
 static const struct watchdog_info at91_wdt_info = {
 	.identity	= DRV_NAME,
-	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
-						WDIOF_MAGICCLOSE,
+	.options	= WDIOF_KEEPALIVEPING,
 };
 
 static int at91wdt_start(struct watchdog_device *wddev)
-- 
1.7.9.5
