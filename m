From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 20 Aug 2014 10:43:03 +0200
Subject: [RFC PATCH 5/6] rtc: rtc-isl12022: Change vendor prefix for Intersil
 Corporation to isil
In-Reply-To: <1408524184-31928-1-git-send-email-p.zabel@pengutronix.de>
References: <1408524184-31928-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1408524184-31928-6-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently there is a wild mixture of isl, isil, and intersil
compatibles in the kernel. At this point, changing the vendor
symbol to the most often used variant, which is equal to the
NASDAQ symbol, isil, should not hurt, since the isl1208 driver
doesn't care either way.
Patch db04d6284e2a added device tree support using the then
documented isl vendor prefix, so we keep that around for
backwards compatibility.

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
