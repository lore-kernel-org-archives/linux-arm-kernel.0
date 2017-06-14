From: broonie@kernel.org (Mark Brown)
Date: Wed, 14 Jun 2017 19:22:10 +0100
Subject: Applied "regulator: hi6421v530: Describe consumed platform device" to
 the regulator tree
In-Reply-To: <20170614151106.11423-1-guodong.xu@linaro.org>
Message-ID: <E1dLCvi-0002Ic-DC@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: hi6421v530: Describe consumed platform device

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From ded7b2aeefaff4e9d52a935e13ff1f1970b7cfda Mon Sep 17 00:00:00 2001
From: Guodong Xu <guodong.xu@linaro.org>
Date: Wed, 14 Jun 2017 23:11:06 +0800
Subject: [PATCH] regulator: hi6421v530: Describe consumed platform device

The hi6421v530-regulator driver consumes a similarly named platform device.
Adding that to the module device table, allows modprobe to locate this
driver once the device is created.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/hi6421v530-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/hi6421v530-regulator.c b/drivers/regulator/hi6421v530-regulator.c
index 46bbba96307f..c09bc71538a5 100644
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
2.11.0
