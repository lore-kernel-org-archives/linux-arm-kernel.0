From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri,  1 Apr 2016 14:54:21 +0200
Subject: [PATCH 01/12] mtd: nand: remove unneeded of_mtd.h inclusions
In-Reply-To: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459515272-31011-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some drivers are including linux/of_mtd.h even if they don't use any of
the of_get_nand_xxx() helpers.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/jz4780_nand.c | 1 -
 drivers/mtd/nand/lpc32xx_mlc.c | 1 -
 drivers/mtd/nand/qcom_nandc.c  | 1 -
 drivers/mtd/nand/sunxi_nand.c  | 1 -
 drivers/mtd/nand/vf610_nfc.c   | 1 -
 5 files changed, 5 deletions(-)

diff --git a/drivers/mtd/nand/jz4780_nand.c b/drivers/mtd/nand/jz4780_nand.c
index e1c016c..23a1999 100644
--- a/drivers/mtd/nand/jz4780_nand.c
+++ b/drivers/mtd/nand/jz4780_nand.c
@@ -17,7 +17,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/gpio/consumer.h>
-#include <linux/of_mtd.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/mtd/mtd.h>
diff --git a/drivers/mtd/nand/lpc32xx_mlc.c b/drivers/mtd/nand/lpc32xx_mlc.c
index d8c3e7a..8e43978 100644
--- a/drivers/mtd/nand/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/lpc32xx_mlc.c
@@ -35,7 +35,6 @@
 #include <linux/completion.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
-#include <linux/of_mtd.h>
 #include <linux/of_gpio.h>
 #include <linux/mtd/lpc32xx_mlc.h>
 #include <linux/io.h>
diff --git a/drivers/mtd/nand/qcom_nandc.c b/drivers/mtd/nand/qcom_nandc.c
index f550a57..f3de983 100644
--- a/drivers/mtd/nand/qcom_nandc.c
+++ b/drivers/mtd/nand/qcom_nandc.c
@@ -21,7 +21,6 @@
 #include <linux/mtd/partitions.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_mtd.h>
 #include <linux/delay.h>
 
 /* NANDc reg offsets */
diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 1c03eee..3a97093 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -30,7 +30,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
-#include <linux/of_mtd.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
index 293feb1..a7f2756 100644
--- a/drivers/mtd/nand/vf610_nfc.c
+++ b/drivers/mtd/nand/vf610_nfc.c
@@ -33,7 +33,6 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
-#include <linux/of_mtd.h>
 #include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
-- 
2.5.0
