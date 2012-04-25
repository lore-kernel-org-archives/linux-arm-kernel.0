From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Apr 2012 17:28:02 +0200
Subject: [PATCH 12/33] watchdog imx2: prepare clk before enabling it
In-Reply-To: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
References: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1335367703-19929-13-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/watchdog/imx2_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 7a2b734..bcfab2b 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -121,7 +121,7 @@ static void imx2_wdt_start(void)
 {
 	if (!test_and_set_bit(IMX2_WDT_STATUS_STARTED, &imx2_wdt.status)) {
 		/* at our first start we enable clock and do initialisations */
-		clk_enable(imx2_wdt.clk);
+		clk_prepare_enable(imx2_wdt.clk);
 
 		imx2_wdt_setup();
 	} else	/* delete the timer that pings the watchdog after close */
-- 
1.7.10
