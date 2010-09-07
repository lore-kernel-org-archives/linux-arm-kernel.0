From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue,  7 Sep 2010 14:29:39 +0900
Subject: [PATCH 3/5] rtc: rtc-s3c: Fix on support RTC Alarm
In-Reply-To: <1283837381-9575-1-git-send-email-kgene.kim@samsung.com>
References: <1283837381-9575-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1283837381-9575-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

The alarm_irq_enable function should be implemented to support RTC alarm.
And fixes tab instead of white space abound proc field.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 drivers/rtc/rtc-s3c.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index e9eb0a0..c078548 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -384,7 +384,8 @@ static const struct rtc_class_ops s3c_rtcops = {
 	.set_alarm	= s3c_rtc_setalarm,
 	.irq_set_freq	= s3c_rtc_setfreq,
 	.irq_set_state	= s3c_rtc_setpie,
-	.proc	        = s3c_rtc_proc,
+	.proc		= s3c_rtc_proc,
+	.alarm_irq_enable = s3c_rtc_setaie,
 };
 
 static void s3c_rtc_enable(struct platform_device *pdev, int en)
-- 
1.6.2.5
