From: marcus.folkesson@gmail.com (Marcus Folkesson)
Date: Fri,  9 Feb 2018 20:27:24 +0100
Subject: [PATCH 7/7] watchdog: coh901327: make use of timeout-secs provided in
 devicetree
In-Reply-To: <20180209192724.1227-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180209192724.1227-1-marcus.folkesson@gmail.com>
Message-ID: <20180209192724.1227-8-marcus.folkesson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

watchdog_init_timeout() will allways pick timeout_param since it
defaults to a valid timeout.

Following best practice described in
Documentation/watchdog/watchdog-kernel-api.txt to make use of
the parameter logic.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/watchdog/coh901327_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
index 4410337f4f7f..437f865e5c6b 100644
--- a/drivers/watchdog/coh901327_wdt.c
+++ b/drivers/watchdog/coh901327_wdt.c
@@ -67,7 +67,7 @@
 #define U300_WDOG_IFR_WILL_BARK_IRQ_FORCE_ENABLE			0x0001U
 
 /* Default timeout in seconds = 1 minute */
-static unsigned int margin = 60;
+static unsigned int margin;
 static int irq;
 static void __iomem *virtbase;
 static struct device *parent;
-- 
2.15.1
