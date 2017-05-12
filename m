From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 13 May 2017 01:18:45 +0900
Subject: [PATCH] gpio: zynq: remove unneeded (void *) casts in of_match_table
Message-ID: <1494605925-6487-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_device_id::data is an opaque pointer.  No explicit cast is needed.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/gpio/gpio-zynq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 6b4d10d..ed87c9a 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -651,9 +651,8 @@ static const struct zynq_platform_data zynq_gpio_def = {
 };
 
 static const struct of_device_id zynq_gpio_of_match[] = {
-	{ .compatible = "xlnx,zynq-gpio-1.0", .data = (void *)&zynq_gpio_def },
-	{ .compatible = "xlnx,zynqmp-gpio-1.0",
-					.data = (void *)&zynqmp_gpio_def },
+	{ .compatible = "xlnx,zynq-gpio-1.0", .data = &zynq_gpio_def },
+	{ .compatible = "xlnx,zynqmp-gpio-1.0", .data = &zynqmp_gpio_def },
 	{ /* end of table */ }
 };
 MODULE_DEVICE_TABLE(of, zynq_gpio_of_match);
-- 
2.7.4
