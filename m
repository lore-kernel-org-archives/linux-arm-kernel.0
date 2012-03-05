From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Mon,  5 Mar 2012 20:21:46 +0800
Subject: [PATCH v2 2/7] rtc: sa1100: add OF support
In-Reply-To: <1330950111-30797-1-git-send-email-haojian.zhuang@marvell.com>
References: <1330950111-30797-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1330950111-30797-3-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add OF support on rtc-sa1100.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/rtc/rtc-sa1100.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
index 962510c..e443b78 100644
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@ -30,6 +30,7 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/bitops.h>
 
@@ -349,6 +350,13 @@ static const struct dev_pm_ops sa1100_rtc_pm_ops = {
 };
 #endif
 
+static struct of_device_id sa1100_rtc_dt_ids[] = {
+	{ .compatible = "mrvl,sa1100-rtc", },
+	{ .compatible = "mrvl,mmp-rtc", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sa1100_rtc_dt_ids);
+
 static struct platform_driver sa1100_rtc_driver = {
 	.probe		= sa1100_rtc_probe,
 	.remove		= sa1100_rtc_remove,
@@ -357,6 +365,7 @@ static struct platform_driver sa1100_rtc_driver = {
 #ifdef CONFIG_PM
 		.pm	= &sa1100_rtc_pm_ops,
 #endif
+		.of_match_table = sa1100_rtc_dt_ids,
 	},
 };
 
-- 
1.7.0.4
