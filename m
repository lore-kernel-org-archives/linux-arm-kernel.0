From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 29 Jun 2013 12:40:41 +0400
Subject: [PATCH v3 2/5] rtc: mxc_rtc: Cleanup code
In-Reply-To: <1372495244-21215-1-git-send-email-shc_work@mail.ru>
References: <1372495244-21215-1-git-send-email-shc_work@mail.ru>
Message-ID: <1372495244-21215-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provide cleanup mxc_rtc driver code (spaces to tabs).
No functional changes.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/rtc/rtc-mxc.c | 52 ++++++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
index 8ec47c8..f333581 100644
--- a/drivers/rtc/rtc-mxc.c
+++ b/drivers/rtc/rtc-mxc.c
@@ -20,23 +20,23 @@
 #define RTC_INPUT_CLK_32000HZ	(0x01 << 5)
 #define RTC_INPUT_CLK_38400HZ	(0x02 << 5)
 
-#define RTC_SW_BIT      (1 << 0)
-#define RTC_ALM_BIT     (1 << 2)
-#define RTC_1HZ_BIT     (1 << 4)
-#define RTC_2HZ_BIT     (1 << 7)
-#define RTC_SAM0_BIT    (1 << 8)
-#define RTC_SAM1_BIT    (1 << 9)
-#define RTC_SAM2_BIT    (1 << 10)
-#define RTC_SAM3_BIT    (1 << 11)
-#define RTC_SAM4_BIT    (1 << 12)
-#define RTC_SAM5_BIT    (1 << 13)
-#define RTC_SAM6_BIT    (1 << 14)
-#define RTC_SAM7_BIT    (1 << 15)
-#define PIT_ALL_ON      (RTC_2HZ_BIT | RTC_SAM0_BIT | RTC_SAM1_BIT | \
+#define RTC_SW_BIT	(1 << 0)
+#define RTC_ALM_BIT	(1 << 2)
+#define RTC_1HZ_BIT	(1 << 4)
+#define RTC_2HZ_BIT	(1 << 7)
+#define RTC_SAM0_BIT	(1 << 8)
+#define RTC_SAM1_BIT	(1 << 9)
+#define RTC_SAM2_BIT	(1 << 10)
+#define RTC_SAM3_BIT	(1 << 11)
+#define RTC_SAM4_BIT	(1 << 12)
+#define RTC_SAM5_BIT	(1 << 13)
+#define RTC_SAM6_BIT	(1 << 14)
+#define RTC_SAM7_BIT	(1 << 15)
+#define PIT_ALL_ON	(RTC_2HZ_BIT | RTC_SAM0_BIT | RTC_SAM1_BIT | \
 			 RTC_SAM2_BIT | RTC_SAM3_BIT | RTC_SAM4_BIT | \
 			 RTC_SAM5_BIT | RTC_SAM6_BIT | RTC_SAM7_BIT)
 
-#define RTC_ENABLE_BIT  (1 << 7)
+#define RTC_ENABLE_BIT	(1 << 7)
 
 #define MXC_RTC_TIME	0
 #define MXC_RTC_ALARM	1
@@ -58,13 +58,13 @@ enum imx_rtc_type {
 };
 
 struct rtc_plat_data {
-	struct rtc_device *rtc;
-	void __iomem *ioaddr;
-	int irq;
+	struct rtc_device	*rtc;
+	void __iomem		*ioaddr;
+	int			irq;
 	struct rtc_class_ops	rtc_ops;
 	struct clk		*clk_rtc;
 	struct clk		*clk_ipg;
-	enum imx_rtc_type devtype;
+	enum imx_rtc_type	devtype;
 };
 
 /*
@@ -156,7 +156,7 @@ static int rtc_update_alarm(struct device *dev, struct rtc_time *alrm)
 }
 
 static void mxc_rtc_irq_enable(struct device *dev, unsigned int bit,
-				unsigned int enabled)
+			       unsigned int enabled)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
@@ -187,6 +187,7 @@ static irqreturn_t mxc_rtc_interrupt(int irq, void *dev_id)
 	u32 events = 0;
 
 	spin_lock_irqsave(&pdata->rtc->irq_lock, flags);
+
 	status = readw(ioaddr + RTC_RTCISR) & readw(ioaddr + RTC_RTCIENR);
 	/* clear interrupt sources */
 	writew(status, ioaddr + RTC_RTCISR);
@@ -205,6 +206,7 @@ static irqreturn_t mxc_rtc_interrupt(int irq, void *dev_id)
 		events |= (RTC_PF | RTC_IRQF);
 
 	rtc_update_irq(pdata->rtc, 1, events);
+
 	spin_unlock_irqrestore(&pdata->rtc->irq_lock, flags);
 
 	return IRQ_HANDLED;
@@ -454,14 +456,14 @@ static const struct platform_device_id mxc_rtc_id_table[] = {
 MODULE_DEVICE_TABLE(platform, mxc_rtc_id_table);
 
 static struct platform_driver mxc_rtc_driver = {
-	.driver = {
-		   .name	= "mxc_rtc",
-		   .pm		= &mxc_rtc_pm_ops,
-		   .owner	= THIS_MODULE,
+	.driver	= {
+		.name	= "mxc_rtc",
+		.owner	= THIS_MODULE,
+		.pm	= &mxc_rtc_pm_ops,
 	},
 	.id_table = mxc_rtc_id_table,
-	.probe = mxc_rtc_probe,
-	.remove = mxc_rtc_remove,
+	.probe	= mxc_rtc_probe,
+	.remove	= mxc_rtc_remove,
 };
 module_platform_driver(mxc_rtc_driver)
 
-- 
1.8.1.5
