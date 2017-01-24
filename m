From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Jan 2017 18:39:38 +0000
Subject: Applied "regulator: axp20x: AXP806: Fix dcdcb being set instead of
 dcdce" to the regulator tree
In-Reply-To: <20170121161142.g4zslhohb6vvcvwd@localhost>
Message-ID: <E1cW60I-0006ge-Bf@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: axp20x: AXP806: Fix dcdcb being set instead of dcdce

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

>From d0e287a401d9acf67b75180b26e2d62b7d482652 Mon Sep 17 00:00:00 2001
From: Rask Ingemann Lambertsen <rask@formelder.dk>
Date: Sat, 21 Jan 2017 17:11:43 +0100
Subject: [PATCH] regulator: axp20x: AXP806: Fix dcdcb being set instead of
 dcdce

A typo or copy-paste bug means that the register access intended for
regulator dcdce goes to dcdcb instead. This patch corrects it.

Fixes: 2ca342d391e3 (regulator: axp20x: Support AXP806 variant)
Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable at vger.kernel.org
---
 drivers/regulator/axp20x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index e6a512ebeae2..a3ade9e4ef47 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -272,7 +272,7 @@ static const struct regulator_desc axp806_regulators[] = {
 			64, AXP806_DCDCD_V_CTRL, 0x3f, AXP806_PWR_OUT_CTRL1,
 			BIT(3)),
 	AXP_DESC(AXP806, DCDCE, "dcdce", "vine", 1100, 3400, 100,
-		 AXP806_DCDCB_V_CTRL, 0x1f, AXP806_PWR_OUT_CTRL1, BIT(4)),
+		 AXP806_DCDCE_V_CTRL, 0x1f, AXP806_PWR_OUT_CTRL1, BIT(4)),
 	AXP_DESC(AXP806, ALDO1, "aldo1", "aldoin", 700, 3300, 100,
 		 AXP806_ALDO1_V_CTRL, 0x1f, AXP806_PWR_OUT_CTRL1, BIT(5)),
 	AXP_DESC(AXP806, ALDO2, "aldo2", "aldoin", 700, 3400, 100,
-- 
2.11.0
