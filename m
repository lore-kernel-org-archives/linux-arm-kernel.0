From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  8 Dec 2017 14:35:35 +0100
Subject: [PATCH] i2c: imx: Include the right GPIO header
Message-ID: <20171208133535.17562-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<linux/of_gpio.h> is not used in this file, by
<linux/gpio/consumer.h> is.

Someone is just lucky with their implicit includes.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/i2c/busses/i2c-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index c4cf26571b66..e54a2516c036 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -37,6 +37,7 @@
 #include <linux/dmapool.h>
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -46,7 +47,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
-#include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_data/i2c-imx.h>
 #include <linux/platform_device.h>
-- 
2.14.3
