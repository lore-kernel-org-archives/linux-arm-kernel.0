From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Apr 2017 21:42:19 +0100
Subject: Applied "regulator: anatop: use of_property_read_string to read the
 name" to the regulator tree
In-Reply-To: <1491962327-12477-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <E1cy2cF-00086i-10@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: anatop: use of_property_read_string to read the name

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

>From 5062e04711dbc4f67b24ffd926cc67060267792d Mon Sep 17 00:00:00 2001
From: Dong Aisheng <aisheng.dong@nxp.com>
Date: Wed, 12 Apr 2017 09:58:44 +0800
Subject: [PATCH] regulator: anatop: use of_property_read_string to read the
 name

sreg->name is a string, so use a more proper api to read back the string
instead of of_get_property.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/anatop-regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index aa93f462ac6e..58141cbdf257 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -193,7 +193,8 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 	sreg = devm_kzalloc(dev, sizeof(*sreg), GFP_KERNEL);
 	if (!sreg)
 		return -ENOMEM;
-	sreg->name = of_get_property(np, "regulator-name", NULL);
+
+	of_property_read_string(np, "regulator-name", &sreg->name);
 	rdesc = &sreg->rdesc;
 	rdesc->name = sreg->name;
 	rdesc->type = REGULATOR_VOLTAGE;
-- 
2.11.0
