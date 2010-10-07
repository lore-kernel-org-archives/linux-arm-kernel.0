From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu,  7 Oct 2010 17:20:08 +0900
Subject: [PATCH 3/3] rtc: rtc-s3c: Add rtc_valid_tm in s3c_rtc_gettime()
In-Reply-To: <1286439608-22722-1-git-send-email-kgene.kim@samsung.com>
References: <1286439608-22722-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1286439608-22722-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds "rtc_valid_tm" in s3c_rtc_gettime()
as per Wan ZongShun's suggestion.

Suggested-by: Wan ZongShun <mcuos.com@gmail.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 drivers/rtc/rtc-s3c.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 125c50a..7d55a2c 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -185,7 +185,7 @@ static int s3c_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
 	rtc_tm->tm_year += 100;
 	rtc_tm->tm_mon -= 1;
 
-	return 0;
+	return rtc_valid_tm(rtc_tm);
 }
 
 static int s3c_rtc_settime(struct device *dev, struct rtc_time *tm)
-- 
1.6.2.5
