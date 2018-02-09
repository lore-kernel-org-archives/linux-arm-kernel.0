From: marcus.folkesson@gmail.com (Marcus Folkesson)
Date: Fri,  9 Feb 2018 20:27:21 +0100
Subject: [PATCH 4/7] watchdog: pnx4008: make use of timeout-secs provided in
 devicetree
In-Reply-To: <20180209192724.1227-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180209192724.1227-1-marcus.folkesson@gmail.com>
Message-ID: <20180209192724.1227-5-marcus.folkesson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

watchdog_init_timeout() will allways pick timeout_param since it
defaults to a valid timeout.

Following best practice described in
Documentation/watchdog/watchdog-kernel-api.txt to make use of
the parameter logic.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/watchdog/pnx4008_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 0529aed158a4..8e261799c84e 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -78,7 +78,7 @@
 #define WDOG_COUNTER_RATE 13000000	/*the counter clock is 13 MHz fixed */
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
-static unsigned int heartbeat = DEFAULT_HEARTBEAT;
+static unsigned int heartbeat;
 
 static DEFINE_SPINLOCK(io_lock);
 static void __iomem	*wdt_base;
-- 
2.15.1
