From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon,  8 Sep 2014 11:19:19 +0200
Subject: [PATCH v2 4/5] rtc: rtc-isl12022: Change vendor prefix for Intersil
 Corporation to isil
In-Reply-To: <1410167960-554-1-git-send-email-p.zabel@pengutronix.de>
References: <1410167960-554-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1410167960-554-5-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently there is a wild mixture of isl, isil, and intersil compatibles
in the kernel. At this point, changing the vendor symbol to the most often
used variant, which is equal to the NASDAQ symbol, isil, should not hurt.

Patch db04d6284e2a (drivers/rtc/rtc-isl12022.c: device tree support)
added device tree support using the then documented isl vendor prefix,
so we keep that around for backwards compatibility.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/rtc/rtc-isl12022.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index aa55f08..df20f18 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -275,7 +275,8 @@ static int isl12022_probe(struct i2c_client *client,
 
 #ifdef CONFIG_OF
 static struct of_device_id isl12022_dt_match[] = {
-	{ .compatible = "isl,isl12022" },
+	{ .compatible = "isil,isl12022" },
+	{ .compatible = "isl,isl12022" }, /* for backwards compatibility */
 	{ },
 };
 #endif
-- 
2.1.0.rc1
