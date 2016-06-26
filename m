From: broonie@kernel.org (Mark Brown)
Date: Sun, 26 Jun 2016 13:03:05 +0100
Subject: Applied "regulator: qcom_spmi: Add support for get_mode/set_mode on
 switches" to the regulator tree
In-Reply-To: <20160626055213.18071-4-stephen.boyd@linaro.org>
Message-ID: <E1bH8mH-0002aN-Au@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: qcom_spmi: Add support for get_mode/set_mode on switches

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

>From 919163f6362ac23138d31fc8befdd52e5d7e488d Mon Sep 17 00:00:00 2001
From: Stephen Boyd <stephen.boyd@linaro.org>
Date: Sat, 25 Jun 2016 22:52:13 -0700
Subject: [PATCH] regulator: qcom_spmi: Add support for get_mode/set_mode on
 switches

The voltage switches support mode switching, so add support for
these ops to those types of regulators.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Fixes: e92a4047419c ("regulator: Add QCOM SPMI regulator driver")
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/qcom_spmi-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 43f8f20b82e9..16c5f84e06a7 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -1085,6 +1085,8 @@ static struct regulator_ops spmi_vs_ops = {
 	.set_pull_down		= spmi_regulator_common_set_pull_down,
 	.set_soft_start		= spmi_regulator_common_set_soft_start,
 	.set_over_current_protection = spmi_regulator_vs_ocp,
+	.set_mode		= spmi_regulator_common_set_mode,
+	.get_mode		= spmi_regulator_common_get_mode,
 };
 
 static struct regulator_ops spmi_boost_ops = {
-- 
2.8.1
