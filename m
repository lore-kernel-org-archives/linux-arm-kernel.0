From: broonie@kernel.org (Mark Brown)
Date: Mon, 21 Aug 2017 18:16:45 +0100
Subject: Applied "regulator: fan53555: fix I2C device ids" to the regulator
 tree
In-Reply-To: <20170821124743.52924-1-guillaume.tucker@collabora.com>
Message-ID: <E1djqJh-00042c-Ok@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: fan53555: fix I2C device ids

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

>From fc1111b885437f374ed54aadda44d8b241ebd2a3 Mon Sep 17 00:00:00 2001
From: Guillaume Tucker <guillaume.tucker@collabora.com>
Date: Mon, 21 Aug 2017 13:47:43 +0100
Subject: [PATCH] regulator: fan53555: fix I2C device ids

The device tree nodes all correctly describe the regulators as
syr827 or syr828, but the I2C device id is currently set to the
wildcard value of syr82x in the driver.  This causes udev to fail
to match the driver module with the modalias data from sysfs.

Fix this by replacing the I2C device ids with ones that match the
device tree descriptions, with syr827 and syr828.  Tested on
Firefly rk3288 board.  The syr82x id was not used anywhere.

Fixes: e80c47bd738b (regulator: fan53555: Export I2C module alias information)
Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/fan53555.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index 6b1c0e4672a2..a3bc8037153e 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -470,7 +470,10 @@ static const struct i2c_device_id fan53555_id[] = {
 		.name = "fan53555",
 		.driver_data = FAN53555_VENDOR_FAIRCHILD
 	}, {
-		.name = "syr82x",
+		.name = "syr827",
+		.driver_data = FAN53555_VENDOR_SILERGY
+	}, {
+		.name = "syr828",
 		.driver_data = FAN53555_VENDOR_SILERGY
 	},
 	{ },
-- 
2.13.3
