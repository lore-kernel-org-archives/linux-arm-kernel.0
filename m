From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Sun, 20 May 2018 14:33:37 +0200
Subject: [PATCH 2/2] rtc: st-lpc: add range
In-Reply-To: <20180520123337.14856-1-alexandre.belloni@bootlin.com>
References: <20180520123337.14856-1-alexandre.belloni@bootlin.com>
Message-ID: <20180520123337.14856-2-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RTC has a 64 bit counter.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-st-lpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
index 2f1ef2c28740..df467ace397b 100644
--- a/drivers/rtc/rtc-st-lpc.c
+++ b/drivers/rtc/rtc-st-lpc.c
@@ -258,6 +258,7 @@ static int st_rtc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, rtc);
 
 	rtc->rtc_dev->ops = &st_rtc_ops;
+	rtc->range_max = do_div(U64_MAX, rtc->clkrate);
 
 	ret = rtc_register_device(rtc->rtc_dev);
 	if (ret) {
-- 
2.17.0
