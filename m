From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Fri,  1 Feb 2013 15:06:23 +0800
Subject: [PATCH v4 5/8] watchdog/at91sam9_wdt: Add nowayout helpers to
 Watchdog Timer Driver Kernel API
In-Reply-To: <1359702386-21284-1-git-send-email-wenyou.yang@atmel.com>
References: <1359702386-21284-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1359702386-21284-6-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Cc: wim at iguana.be
Cc: linux-watchdog at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/watchdog/at91sam9_wdt.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index c6d9f1f..e60a718 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -238,6 +238,8 @@ static int __init at91wdt_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	watchdog_set_nowayout(&at91wdt_wdd, nowayout);
+
 	watchdog_init_timeout(&at91wdt_wdd, heartbeat, pdev->dev.of_node);
 
 	ret = at91wdt_enable(&at91wdt_wdd, ms_to_ticks(WDT_HW_TIMEOUT * 1000));
-- 
1.7.9.5
