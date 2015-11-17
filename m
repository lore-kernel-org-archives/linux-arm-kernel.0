From: Zhiqiang.Hou@freescale.com (Zhiqiang Hou)
Date: Tue, 17 Nov 2015 17:53:18 +0800
Subject: [PATCHv8 1/5] i2c: imx: fix a compiling error
Message-ID: <1447754002-40555-1-git-send-email-Zhiqiang.Hou@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@freescale.com>

drivers/i2c/busses/i2c-imx.c:978:2: error: implicit declaration of
function ?pinctrl_select_state? [-Werror=implicit-function-declaration]
  pinctrl_select_state(i2c_imx->pinctrl, i2c_imx->pinctrl_pins_gpio);
  ^

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@freescale.com>
---
V8:
 - New patch.

 drivers/i2c/busses/i2c-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 1e4d99d..9bb0b05 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -50,6 +50,7 @@
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
 #include <linux/of_gpio.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_data/i2c-imx.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
-- 
2.1.0.27.g96db324
