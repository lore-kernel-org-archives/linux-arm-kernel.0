From: manishv.b@ti.com (Vishwanathrao Badarkhe, Manish)
Date: Tue, 29 Jan 2013 13:08:52 +0530
Subject: [PATCH V2 4/6] mfd: tps6507x: add device-tree support.
In-Reply-To: <1359445134-13323-1-git-send-email-manishv.b@ti.com>
References: <1359445134-13323-1-git-send-email-manishv.b@ti.com>
Message-ID: <1359445134-13323-5-git-send-email-manishv.b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree based initialization support for TI's
tps6507x mfd device.

Signed-off-by: Vishwanathrao Badarkhe, Manish <manishv.b@ti.com>
---
Changes since V1:
 - updated subject line for commit.

:100644 100644 409afa2... 5ad4b77... M	drivers/mfd/tps6507x.c
 drivers/mfd/tps6507x.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/tps6507x.c b/drivers/mfd/tps6507x.c
index 409afa2..5ad4b77 100644
--- a/drivers/mfd/tps6507x.c
+++ b/drivers/mfd/tps6507x.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
+#include <linux/of_device.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/tps6507x.h>
 
@@ -116,11 +117,19 @@ static const struct i2c_device_id tps6507x_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, tps6507x_i2c_id);
 
+#ifdef CONFIG_OF
+static struct of_device_id tps6507x_of_match[] = {
+	{.compatible = "ti,tps6507x", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, tps6507x_of_match);
+#endif
 
 static struct i2c_driver tps6507x_i2c_driver = {
 	.driver = {
 		   .name = "tps6507x",
 		   .owner = THIS_MODULE,
+		   .of_match_table = of_match_ptr(tps6507x_of_match),
 	},
 	.probe = tps6507x_i2c_probe,
 	.remove = tps6507x_i2c_remove,
-- 
1.7.4.1
