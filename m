From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon,  8 Sep 2014 11:19:20 +0200
Subject: [PATCH v2 5/5] rtc: rtc-isl12057: Change vendor prefix for Intersil
 Corporation to isil
In-Reply-To: <1410167960-554-1-git-send-email-p.zabel@pengutronix.de>
References: <1410167960-554-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1410167960-554-6-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently there is a wild mixture of isl, isil, and intersil compatibles
in the kernel. At this point, changing the vendor symbol to the most often
used variant, which is equal to the NASDAQ symbol, isil, should not hurt.

Patch 70e123373c05 (rtc: Add support for Intersil ISL12057 I2C RTC chip)
added this driver with device tree support using the then documented isl
vendor prefix, so we keep that around for backwards compatibility.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/rtc/rtc-isl12057.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-isl12057.c b/drivers/rtc/rtc-isl12057.c
index 455b601..8276bd6 100644
--- a/drivers/rtc/rtc-isl12057.c
+++ b/drivers/rtc/rtc-isl12057.c
@@ -279,7 +279,8 @@ static int isl12057_probe(struct i2c_client *client,
 
 #ifdef CONFIG_OF
 static const struct of_device_id isl12057_dt_match[] = {
-	{ .compatible = "isl,isl12057" },
+	{ .compatible = "isil,isl12057" },
+	{ .compatible = "isl,isl12057" }, /* for backwards compatibility */
 	{ },
 };
 #endif
-- 
2.1.0.rc1
