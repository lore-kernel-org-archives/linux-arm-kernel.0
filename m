From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 16 Mar 2012 04:21:28 +0000
Subject: [PATCH 8/9 v2] ARM: kirkwood: rtc-mv devicetree bindings
In-Reply-To: <cover.1331868507.git.jason@lakedaemon.net>
References: <cover.1331868507.git.jason@lakedaemon.net>
Message-ID: <45356e7e743479397bb661225beb68df5dd0947d.1331868507.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trivial conversion to devicetree.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---

Changes from v1:

    - added 'trivial conversion' patch description.

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
