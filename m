From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Mon, 24 Sep 2018 16:49:02 +0200
Subject: [PATCH 3/3] rtc: ab8500: remove useless check
In-Reply-To: <20180924144902.607-1-alexandre.belloni@bootlin.com>
References: <20180924144902.607-1-alexandre.belloni@bootlin.com>
Message-ID: <20180924144902.607-3-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rtc_time_to_tm always rturns a valid tm, there is no need to validate it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ab8500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ab8500.c b/drivers/rtc/rtc-ab8500.c
index 2e2671b84ab0..1f0cbd51ba06 100644
--- a/drivers/rtc/rtc-ab8500.c
+++ b/drivers/rtc/rtc-ab8500.c
@@ -170,7 +170,7 @@ static int ab8500_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 
 	rtc_time_to_tm(secs, &alarm->time);
 
-	return rtc_valid_tm(&alarm->time);
+	return 0;
 }
 
 static int ab8500_rtc_irq_enable(struct device *dev, unsigned int enabled)
-- 
2.19.0
