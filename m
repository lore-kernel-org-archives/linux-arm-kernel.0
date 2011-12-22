From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 22 Dec 2011 16:54:09 +0800
Subject: [PATCH 1/3] rtc: rtc-max8925: fix max8925_rtc_read_alarm return value
 error
Message-ID: <1324544051-1494-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Liu <kliu5@marvell.com>

max8925_rtc_read_alarm should always return 0 with success

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/rtc/rtc-max8925.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/rtc/rtc-max8925.c b/drivers/rtc/rtc-max8925.c
index 3bc046f..d93bd40 100644
--- a/drivers/rtc/rtc-max8925.c
+++ b/drivers/rtc/rtc-max8925.c
@@ -204,6 +204,7 @@ static int max8925_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		alrm->pending = 1;
 	else
 		alrm->pending = 0;
+	return 0;
 out:
 	return ret;
 }
-- 
1.7.0.4
