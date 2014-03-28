From: robherring2@gmail.com (Rob Herring)
Date: Fri, 28 Mar 2014 16:20:29 -0500
Subject: [PATCH 2/2] misc: arm-charlcd: add DT probe support
In-Reply-To: <1396041629-28820-1-git-send-email-robherring2@gmail.com>
References: <1396041629-28820-1-git-send-email-robherring2@gmail.com>
Message-ID: <1396041629-28820-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Add the DT match table to enable DT based probe matching.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/arm-charlcd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/misc/arm-charlcd.c b/drivers/misc/arm-charlcd.c
index b7ebf80..c72e96b 100644
--- a/drivers/misc/arm-charlcd.c
+++ b/drivers/misc/arm-charlcd.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/io.h>
@@ -366,11 +367,17 @@ static const struct dev_pm_ops charlcd_pm_ops = {
 	.resume = charlcd_resume,
 };
 
+static const struct of_device_id charlcd_match[] = {
+	{ .compatible = "arm,versatile-lcd", },
+	{}
+};
+
 static struct platform_driver charlcd_driver = {
 	.driver = {
 		.name = DRIVERNAME,
 		.owner = THIS_MODULE,
 		.pm = &charlcd_pm_ops,
+		.of_match_table = of_match_ptr(charlcd_match),
 	},
 	.remove = __exit_p(charlcd_remove),
 };
-- 
1.8.3.2
