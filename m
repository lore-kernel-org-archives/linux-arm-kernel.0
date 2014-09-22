From: j.uzycki@elproma.com.pl (Janusz Uzycki)
Date: Mon, 22 Sep 2014 22:55:48 +0200
Subject: [PATCH 4/6] stmp3xxx_rtc_wdt: WATCHDOG_KEEP_ON enabled
In-Reply-To: <1411419350-1297-1-git-send-email-j.uzycki@elproma.com.pl>
References: <1411419350-1297-1-git-send-email-j.uzycki@elproma.com.pl>
Message-ID: <1411419350-1297-4-git-send-email-j.uzycki@elproma.com.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
 drivers/watchdog/stmp3xxx_rtc_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
index 77936b6..7e753b9 100644
--- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -67,7 +67,7 @@ static struct watchdog_device stmp3xxx_wdd = {
 	.ops = &stmp3xxx_wdt_ops,
 	.min_timeout = 1,
 	.max_timeout = STMP3XXX_MAX_TIMEOUT,
-	.status = WATCHDOG_NOWAYOUT_INIT_STATUS,
+	.status = WATCHDOG_NOWAYOUT_INIT_STATUS | WATCHDOG_KEEP_ON,
 };
 
 static int stmp3xxx_wdt_probe(struct platform_device *pdev)
-- 
1.7.11.3
