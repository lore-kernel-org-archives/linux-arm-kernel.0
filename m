From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  8 Feb 2010 10:09:39 +0100
Subject: [PATCH 2/3] gpiolib: a gpio is unsigned, so use %u to print it
In-Reply-To: <20100203155558.GH11354@pengutronix.de>
References: <20100203155558.GH11354@pengutronix.de>
Message-ID: <1265620180-14150-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/gpio/gpiolib.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 8543685..20988c8 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -747,7 +747,7 @@ int gpio_export(unsigned gpio, bool direction_may_change)
 		struct device	*dev;
 
 		dev = device_create(&gpio_class, desc->chip->dev, MKDEV(0, 0),
-				desc, ioname ? ioname : "gpio%d", gpio);
+				desc, ioname ? ioname : "gpio%u", gpio);
 		if (!IS_ERR(dev)) {
 			status = sysfs_create_group(&dev->kobj,
 						&gpio_attr_group);
-- 
1.6.6
