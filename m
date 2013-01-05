From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Sat,  5 Jan 2013 10:38:46 +0800
Subject: [v3 PATCH 6/9] watchdog/at91sam9_wdt: Remove the __initdata of
 at91wdt_wdd
In-Reply-To: <1357353529-20901-1-git-send-email-wenyou.yang@atmel.com>
References: <1357353529-20901-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1357353529-20901-7-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For this variable will be used in the timer handler.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Cc: wim at iguana.be
Cc: linux-watchdog at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/watchdog/at91sam9_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 53ede84..94be9d6 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -196,7 +196,7 @@ static struct watchdog_ops at91wdt_ops = {
 	.ping = at91wdt_ping,
 };
 
-static struct watchdog_device at91wdt_wdd __initdata = {
+static struct watchdog_device at91wdt_wdd = {
 	.timeout = WDT_HEARTBEAT,
 	.min_timeout = MIN_HEARTBEAT,
 	.max_timeout = MAX_HEARTBEAT,
-- 
1.7.9.5
