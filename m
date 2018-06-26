From: broonie@kernel.org (Mark Brown)
Date: Tue, 26 Jun 2018 16:10:57 +0100 (BST)
Subject: Applied "ASoC: qcom: apq8096: remove redundant owner assignment" to
 the asoc tree
In-Reply-To: <20180625143115.8346-11-srinivas.kandagatla@linaro.org>
Message-ID: <20180626151057.A5751440070@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: qcom: apq8096: remove redundant owner assignment

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 2d12c20b98ad610892151da37367f2d018181455 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Tue, 26 Jun 2018 10:20:14 +0100
Subject: [PATCH] ASoC: qcom: apq8096: remove redundant owner assignment

module owner is already set in platform_driver_register(), so remove this
redundant assignment.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/apq8096.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index 239b8cb77bdb..cab8c4ff7c00 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -246,7 +246,6 @@ static struct platform_driver msm_snd_apq8096_driver = {
 	.remove = apq8096_platform_remove,
 	.driver = {
 		.name = "msm-snd-apq8096",
-		.owner = THIS_MODULE,
 		.of_match_table = msm_snd_apq8096_dt_match,
 	},
 };
-- 
2.17.1
