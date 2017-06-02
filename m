From: guodong.xu@linaro.org (Guodong Xu)
Date: Fri,  2 Jun 2017 18:51:54 +0800
Subject: [PATCH v3 4/6] regulator: hi6421: Describe consumed platform device
In-Reply-To: <20170602105156.11351-1-guodong.xu@linaro.org>
References: <20170602105156.11351-1-guodong.xu@linaro.org>
Message-ID: <20170602105156.11351-5-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hi6421-regulator driver consumes a similarly named platform device.
Adding that to the module device table, allows modprobe to locate this
driver once the device is created.

Cc: Jeremy Linton <lintonrjeremy@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 drivers/regulator/hi6421-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/hi6421-regulator.c b/drivers/regulator/hi6421-regulator.c
index 62c5f54..259c3a8 100644
--- a/drivers/regulator/hi6421-regulator.c
+++ b/drivers/regulator/hi6421-regulator.c
@@ -621,7 +621,14 @@ static int hi6421_regulator_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct platform_device_id hi6421_regulator_table[] = {
+	{ .name = "hi6421-regulator" },
+	{},
+};
+MODULE_DEVICE_TABLE(platform, hi6421_regulator_table);
+
 static struct platform_driver hi6421_regulator_driver = {
+	.id_table = hi6421_regulator_table,
 	.driver = {
 		.name	= "hi6421-regulator",
 	},
-- 
2.10.2
