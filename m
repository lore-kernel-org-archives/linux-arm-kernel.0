From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 22 Aug 2013 11:41:52 -0300
Subject: [PATCH 1/7] watchdog: orion: Remove unneeded BRIDGE_CAUSE clear
In-Reply-To: <1377182518-12554-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377182518-12554-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1377182518-12554-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the introduction of the orion irqchip driver, now the BRIDGE_CAUSE
bit is cleared by it. There's no longer a need to do it in the watchdog
driver, so we can simply remove it.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 4ea5fcc..d43a3da 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -69,9 +69,6 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
 	/* Set watchdog duration */
 	writel(wdt_tclk * wdt_dev->timeout, wdt_reg + WDT_VAL);
 
-	/* Clear watchdog timer interrupt */
-	writel(~WDT_INT_REQ, BRIDGE_CAUSE);
-
 	/* Enable watchdog timer */
 	reg = readl(wdt_reg + TIMER_CTRL);
 	reg |= WDT_EN;
-- 
1.8.1.5
