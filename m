From: broonie@kernel.org (Mark Brown)
Date: Thu, 22 Mar 2018 02:13:57 +0000 (GMT)
Subject: Applied "regulator: qcom_smd: Drop regulator/{machine,
 of_regulator} includes" to the regulator tree
In-Reply-To: <20180321184811.120996-1-swboyd@chromium.org>
Message-ID: <20180322021357.B202E44007A@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: qcom_smd: Drop regulator/{machine,of_regulator} includes

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

>From 6a2e3c3ea31bba91191c4c1a8a6afd7f08f9399e Mon Sep 17 00:00:00 2001
From: Stephen Boyd <swboyd@chromium.org>
Date: Wed, 21 Mar 2018 11:48:11 -0700
Subject: [PATCH] regulator: qcom_smd: Drop regulator/{machine,of_regulator}
 includes

These seem to be leftovers from previous developments of the driver but
they never got removed. Dropping them still allows the code to compile
so everything must be fine.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/qcom_smd-regulator.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 940fe1b78411..0c6e681c7d89 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -17,8 +17,6 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
-#include <linux/regulator/machine.h>
-#include <linux/regulator/of_regulator.h>
 #include <linux/soc/qcom/smd-rpm.h>
 
 struct qcom_rpm_reg {
-- 
2.16.2
