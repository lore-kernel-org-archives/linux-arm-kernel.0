From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed,  5 Dec 2012 09:34:23 +0800
Subject: [v2 PATCH 4/8] watchdog/at91sam9_wdt: Add nowayout helpers to
 Watchdog Timer Driver Kernel API
In-Reply-To: <1354671267-19277-1-git-send-email-wenyou.yang@atmel.com>
References: <1354671267-19277-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1354671267-19277-5-git-send-email-wenyou.yang@atmel.com>
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
index 4dc6d61..f1e21dd 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -240,6 +240,8 @@ static int __init at91wdt_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	watchdog_set_nowayout(&at91wdt_wdd, nowayout);
+
 	watchdog_init_timeout(&at91wdt_wdd, heartbeat, pdev->dev.of_node);
 
 	ret = at91wdt_enable(&at91wdt_wdd, ms_to_ticks(WDT_HW_TIMEOUT * 1000));
-- 
1.7.9.5
