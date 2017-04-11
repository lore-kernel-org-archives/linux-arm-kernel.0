From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Apr 2017 21:42:22 +0100
Subject: Applied "regulator: anatop: check return value of
 of_get_regulator_init_data" to the regulator tree
In-Reply-To: <1491962327-12477-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <E1cy2cI-00087i-1y@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: anatop: check return value of of_get_regulator_init_data

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

>From 7f51cf2ea7186e3f217e616a5522f1156678356f Mon Sep 17 00:00:00 2001
From: Dong Aisheng <aisheng.dong@nxp.com>
Date: Wed, 12 Apr 2017 09:58:42 +0800
Subject: [PATCH] regulator: anatop: check return value of
 of_get_regulator_init_data

Should check the return value of of_get_regulator_init_data before
using it.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/anatop-regulator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index 3a6d0290c54c..aa93f462ac6e 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -200,6 +200,9 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 	rdesc->owner = THIS_MODULE;
 
 	initdata = of_get_regulator_init_data(dev, np, rdesc);
+	if (!initdata)
+		return -ENOMEM;
+
 	initdata->supply_regulator = "vin";
 	sreg->initdata = initdata;
 
-- 
2.11.0
