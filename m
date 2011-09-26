From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 26 Sep 2011 08:26:19 +0200
Subject: [PATCH] dma/imx-sdma+imx-dma: explicitly #include <linux/module.h>
Message-ID: <1317018379-8897-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed after commit

	include: replace linux/module.h with "struct module" wherever possible

(currently 25215aa in next).

Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

maybe it's sensible for Paul to take that before his commit?

Best regards
Uwe

 drivers/dma/imx-dma.c  |    1 +
 drivers/dma/imx-sdma.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index d99f71c..3732de8 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/dmaengine.h>
+#include <linux/module.h>
 
 #include <asm/irq.h>
 #include <mach/dma-v1.h>
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index b5cc27d..86fb6e5 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -34,6 +34,7 @@
 #include <linux/dmaengine.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/module.h>
 
 #include <asm/irq.h>
 #include <mach/sdma.h>
-- 
1.7.6.3
