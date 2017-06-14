From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 14 Jun 2017 23:11:06 +0800
Subject: [PATCH] regulator: hi6421v530: Describe consumed platform device
Message-ID: <20170614151106.11423-1-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hi6421v530-regulator driver consumes a similarly named platform device.
Adding that to the module device table, allows modprobe to locate this
driver once the device is created.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 drivers/regulator/hi6421v530-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/hi6421v530-regulator.c b/drivers/regulator/hi6421v530-regulator.c
index 46bbba9..c09bc71 100644
--- a/drivers/regulator/hi6421v530-regulator.c
+++ b/drivers/regulator/hi6421v530-regulator.c
@@ -194,7 +194,14 @@ static int hi6421v530_regulator_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct platform_device_id hi6421v530_regulator_table[] = {
+	{ .name = "hi6421v530-regulator" },
+	{},
+};
+MODULE_DEVICE_TABLE(platform, hi6421v530_regulator_table);
+
 static struct platform_driver hi6421v530_regulator_driver = {
+	.id_table = hi6421v530_regulator_table,
 	.driver = {
 		.name	= "hi6421v530-regulator",
 	},
-- 
2.10.2
