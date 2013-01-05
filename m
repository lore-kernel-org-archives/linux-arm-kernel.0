From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Sat,  5 Jan 2013 10:38:45 +0800
Subject: [v3 PATCH 5/9] watchdog/at91sam9_wdt: Add nowayout helpers to
 Watchdog Timer Driver Kernel API
In-Reply-To: <1357353529-20901-1-git-send-email-wenyou.yang@atmel.com>
References: <1357353529-20901-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1357353529-20901-6-git-send-email-wenyou.yang@atmel.com>
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
index a3d1a09..53ede84 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -235,6 +235,8 @@ static int __init at91wdt_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	watchdog_set_nowayout(&at91wdt_wdd, nowayout);
+
 	watchdog_init_timeout(&at91wdt_wdd, heartbeat, pdev->dev.of_node);
 
 	ret = at91wdt_enable(&at91wdt_wdd, ms_to_ticks(WDT_HW_TIMEOUT * 1000));
-- 
1.7.9.5
