From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu,  8 Mar 2018 15:52:47 +0100
Subject: [PATCH v2 1/8] mmc: sunxi: Reorder the headers
In-Reply-To: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
References: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
Message-ID: <9530334c1fa45100e27c3d541d2a3b1e1d8113d2.1520520655.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our headers sort algorithm has had pretty chaotic results. Let's fix that.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/mmc/host/sunxi-mmc.c | 43 +++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index bad612d6f879..f9723797a9f8 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -13,36 +13,33 @@
  * the License, or (at your option) any later version.
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/io.h>
-#include <linux/device.h>
-#include <linux/interrupt.h>
-#include <linux/delay.h>
-#include <linux/err.h>
-
 #include <linux/clk.h>
 #include <linux/clk/sunxi-ng.h>
-#include <linux/gpio.h>
-#include <linux/platform_device.h>
-#include <linux/spinlock.h>
-#include <linux/scatterlist.h>
+#include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/dma-mapping.h>
-#include <linux/slab.h>
-#include <linux/reset.h>
-#include <linux/regulator/consumer.h>
-
-#include <linux/of_address.h>
-#include <linux/of_gpio.h>
-#include <linux/of_platform.h>
-
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/core.h>
+#include <linux/mmc/mmc.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sd.h>
 #include <linux/mmc/sdio.h>
-#include <linux/mmc/mmc.h>
-#include <linux/mmc/core.h>
-#include <linux/mmc/card.h>
 #include <linux/mmc/slot-gpio.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_gpio.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
 
 /* register offset definitions */
 #define SDXC_REG_GCTRL	(0x00) /* SMC Global Control Register */
-- 
git-series 0.9.1
