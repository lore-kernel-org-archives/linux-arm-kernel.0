From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 16 Nov 2010 09:02:54 +0900
Subject: [PATCH 3/3] rtc: rtc-s3c: Change set alarm interrupt method in
	s3c_rtc_setaie
In-Reply-To: <1289865774-31073-1-git-send-email-kgene.kim@samsung.com>
References: <1289865774-31073-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1289865774-31073-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes method of setting alarm interrupt.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Wan ZongShun <mcuos.com@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/rtc/rtc-s3c.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index bb88027..1ccf81c 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -83,10 +83,12 @@ static int s3c_rtc_setaie(struct device *dev, unsigned int enabled)
 	pr_debug("%s: aie=%d\n", __func__, enabled);
 
 	spin_lock_irq(&s3c_rtc_pie_lock);
-	tmp = readb(s3c_rtc_base + S3C2410_RTCALM) & ~S3C2410_RTCALM_ALMEN;
+	tmp = readb(s3c_rtc_base + S3C2410_RTCALM);
 
 	if (enabled)
 		tmp |= S3C2410_RTCALM_ALMEN;
+	else
+		tmp &= ~S3C2410_RTCALM_ALMEN;
 
 	writeb(tmp, s3c_rtc_base + S3C2410_RTCALM);
 	spin_unlock_irq(&s3c_rtc_pie_lock);
-- 
1.6.2.5
