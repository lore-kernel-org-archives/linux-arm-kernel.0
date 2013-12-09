From: balbi@ti.com (Felipe Balbi)
Date: Mon, 9 Dec 2013 10:21:12 -0600
Subject: [PATCH v3 02/15] mfd: menelaus: Switch over to module_i2c_driver
In-Reply-To: <1386606085-26838-1-git-send-email-balbi@ti.com>
References: <20131209161422.GC24047@saruman.home>
 <1386606085-26838-1-git-send-email-balbi@ti.com>
Message-ID: <1386606085-26838-2-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a macro to remove some boilerplate code, no functional changes.

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/mfd/menelaus.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
index 975ff9e..8bd97ca 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -1287,29 +1287,8 @@ static struct i2c_driver menelaus_i2c_driver = {
 	.id_table	= menelaus_id,
 };
 
-static int __init menelaus_init(void)
-{
-	int res;
-
-	res = i2c_add_driver(&menelaus_i2c_driver);
-	if (res < 0) {
-		pr_err(DRIVER_NAME ": driver registration failed\n");
-		return res;
-	}
-
-	return 0;
-}
-
-static void __exit menelaus_exit(void)
-{
-	i2c_del_driver(&menelaus_i2c_driver);
-
-	/* FIXME: Shutdown menelaus parts that can be shut down */
-}
+module_i2c_driver(menelaus_i2c_driver);
 
 MODULE_AUTHOR("Texas Instruments, Inc. (and others)");
 MODULE_DESCRIPTION("I2C interface for Menelaus.");
 MODULE_LICENSE("GPL");
-
-module_init(menelaus_init);
-module_exit(menelaus_exit);
-- 
1.8.4.GIT
