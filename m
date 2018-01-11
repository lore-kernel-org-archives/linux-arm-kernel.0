From: broonie@kernel.org (Mark Brown)
Date: Thu, 11 Jan 2018 12:31:03 +0000
Subject: Applied "ASoC: stm32: fix a typo in stm32_adfsdm_probe()" to the asoc
 tree
In-Reply-To: <1515669111-125208-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <E1eZc0d-0007Qk-1v@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: stm32: fix a typo in stm32_adfsdm_probe()

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

>From 6dee6722c6065f4850eab98c2b7b9f4a08a35813 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Thu, 11 Jan 2018 11:11:51 +0000
Subject: [PATCH] ASoC: stm32: fix a typo in stm32_adfsdm_probe()

Fix a typo, we should return PTR_ERR(priv->iio_cb) instead of
PTR_ERR(priv->iio_ch).

Fixes: 55da094824c4 ("ASoC: stm32: add DFSDM DAI support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_adfsdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index af50891983c6..7306e3eca9e1 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -320,7 +320,7 @@ static int stm32_adfsdm_probe(struct platform_device *pdev)
 
 	priv->iio_cb = iio_channel_get_all_cb(&pdev->dev, NULL, NULL);
 	if (IS_ERR(priv->iio_cb))
-		return PTR_ERR(priv->iio_ch);
+		return PTR_ERR(priv->iio_cb);
 
 	ret = devm_snd_soc_register_platform(&pdev->dev,
 					     &stm32_adfsdm_soc_platform);
-- 
2.15.1
