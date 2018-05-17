From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 17 May 2018 14:04:23 +0200
Subject: [PATCH v3 1/4] rtc: stm32: fix misspelling and misalignment issues
In-Reply-To: <1526558666-24243-1-git-send-email-amelie.delaunay@st.com>
References: <1526558666-24243-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1526558666-24243-2-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch cleans the following checkpatch complaints:

CHECK: 'initalized' may be misspelled - perhaps 'initialized'?
#644: FILE: drivers/rtc/rtc-stm32.c:644:
+	 * the calendar has been initalized or not. INITS flag is reset by a

CHECK: Alignment should match open parenthesis
#669: FILE: drivers/rtc/rtc-stm32.c:669:
+	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, pdev->name,
+			&stm32_rtc_ops, THIS_MODULE);

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/rtc/rtc-stm32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index de49b5b..d41f804 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -641,7 +641,7 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 
 	/*
 	 * After a system reset, RTC_ISR.INITS flag can be read to check if
-	 * the calendar has been initalized or not. INITS flag is reset by a
+	 * the calendar has been initialized or not. INITS flag is reset by a
 	 * power-on reset (no vbat, no power-supply). It is not reset if
 	 * rtc_ck parent clock has changed (so RTC prescalers need to be
 	 * changed). That's why we cannot rely on this flag to know if RTC
@@ -666,7 +666,7 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 			 "alarm won't be able to wake up the system");
 
 	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, pdev->name,
-			&stm32_rtc_ops, THIS_MODULE);
+						&stm32_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc->rtc_dev)) {
 		ret = PTR_ERR(rtc->rtc_dev);
 		dev_err(&pdev->dev, "rtc device registration failed, err=%d\n",
-- 
2.7.4
