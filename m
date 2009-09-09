From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed,  9 Sep 2009 23:22:48 +0200
Subject: [PATCH 1/4] gpio/pcf857x: copy i2c_device_id from old pcf8574-driver
In-Reply-To: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1252531371-14866-2-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The deprecated pcf8574 driver is going to be removed. Make sure this
replacement-driver inherits all i2c_device_ids for a smooth transition.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Jean Delvare <khali@linux-fr.org>
---
 drivers/gpio/pcf857x.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/pcf857x.c b/drivers/gpio/pcf857x.c
index 9525724..3f1ec1e 100644
--- a/drivers/gpio/pcf857x.c
+++ b/drivers/gpio/pcf857x.c
@@ -28,6 +28,7 @@
 
 static const struct i2c_device_id pcf857x_id[] = {
 	{ "pcf8574", 8 },
+	{ "pcf8574a", 8 },
 	{ "pca8574", 8 },
 	{ "pca9670", 8 },
 	{ "pca9672", 8 },
-- 
1.6.3.3
