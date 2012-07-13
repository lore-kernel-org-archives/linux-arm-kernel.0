From: y@pengutronix.de (y at pengutronix.de)
Date: Fri, 13 Jul 2012 14:32:09 +0200
Subject: [PATCH 06/11] i2c/i2c-omap: add a const qualifier
In-Reply-To: <1342182734-321-1-git-send-email-y>
References: <1342182734-321-1-git-send-email-y>
Message-ID: <1342182734-321-8-git-send-email-y>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

This prepares of_device_id.data becoming const. Without this change
the following warning would occur:

	drivers/i2c/busses/i2c-omap.c: In function 'omap_i2c_probe':
	drivers/i2c/busses/i2c-omap.c:1025: warning: assignment discards qualifiers from pointer target type

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-omap at vger.kernel.org
Cc: linux-i2c at vger.kernel.org
---
 drivers/i2c/busses/i2c-omap.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 801df60..4fc585d 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -987,7 +987,8 @@ omap_i2c_probe(struct platform_device *pdev)
 	struct omap_i2c_dev	*dev;
 	struct i2c_adapter	*adap;
 	struct resource		*mem, *irq, *ioarea;
-	struct omap_i2c_bus_platform_data *pdata = pdev->dev.platform_data;
+	const struct omap_i2c_bus_platform_data *pdata =
+		pdev->dev.platform_data;
 	struct device_node	*node = pdev->dev.of_node;
 	const struct of_device_id *match;
 	irq_handler_t isr;
-- 
1.7.10.4
