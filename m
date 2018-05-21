From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Mon, 21 May 2018 22:49:05 +0200
Subject: [PATCH v2] rtc: st-lpc: add range
Message-ID: <20180521204905.7113-1-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RTC has a 64 bit counter.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-st-lpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
index 2f1ef2c28740..bee75ca7ff79 100644
--- a/drivers/rtc/rtc-st-lpc.c
+++ b/drivers/rtc/rtc-st-lpc.c
@@ -258,6 +258,8 @@ static int st_rtc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, rtc);
 
 	rtc->rtc_dev->ops = &st_rtc_ops;
+	rtc->rtc_dev->range_max = U64_MAX;
+	do_div(rtc->rtc_dev->range_max, rtc->clkrate);
 
 	ret = rtc_register_device(rtc->rtc_dev);
 	if (ret) {
-- 
2.17.0
