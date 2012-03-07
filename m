From: jason@lakedaemon.net (Jason Cooper)
Date: Wed,  7 Mar 2012 03:44:48 +0000
Subject: [PATCH 07/14] ARM: kirkwood: rtc-mv devicetree bindings
In-Reply-To: <cover.1331090356.git.jason@lakedaemon.net>
References: <cover.1331090356.git.jason@lakedaemon.net>
Message-ID: <bb4ab565bd8506f6ac126571f46fc3b26178821f.1331090356.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---

Changes from previous version:

* s/marvell,/mrvl,/g for compatible properties
* split into binding patch and a use patch.

 drivers/rtc/rtc-mv.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/rtc/rtc-mv.c b/drivers/rtc/rtc-mv.c
index 768e2ed..0dd8421 100644
--- a/drivers/rtc/rtc-mv.c
+++ b/drivers/rtc/rtc-mv.c
@@ -12,6 +12,7 @@
 #include <linux/bcd.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 #include <linux/delay.h>
 #include <linux/gfp.h>
 #include <linux/module.h>
@@ -294,11 +295,19 @@ static int __exit mv_rtc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static struct of_device_id rtc_mv_of_match_table[] = {
+	{ .compatible = "mrvl,orion-rtc", },
+	{}
+};
+#endif
+
 static struct platform_driver mv_rtc_driver = {
 	.remove		= __exit_p(mv_rtc_remove),
 	.driver		= {
 		.name	= "rtc-mv",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(rtc_mv_of_match_table),
 	},
 };
 
-- 
1.7.3.4
