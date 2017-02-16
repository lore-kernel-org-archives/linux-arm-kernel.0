From: broonie@kernel.org (Mark Brown)
Date: Thu, 16 Feb 2017 19:04:54 +0000
Subject: Applied "ASoC: mediatek: add power-domain get/put ctrl for mt2701" to
 the asoc tree
In-Reply-To: <1487222836-21174-2-git-send-email-garlic.tseng@mediatek.com>
Message-ID: <E1ceRMM-0007iZ-43@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: mediatek: add power-domain get/put ctrl for mt2701

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From cc3e1ce2c73c0e44373eb364f94e4fefebf7719e Mon Sep 17 00:00:00 2001
From: Garlic Tseng <garlic.tseng@mediatek.com>
Date: Thu, 16 Feb 2017 13:27:15 +0800
Subject: [PATCH] ASoC: mediatek: add power-domain get/put ctrl for mt2701

add power-domain ctrl for audio driver

Signed-off-by: Garlic Tseng <garlic.tseng@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index 34a6123480d3..c7fa3e663463 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -1578,6 +1578,7 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev))
 		goto err_pm_disable;
+	pm_runtime_get_sync(&pdev->dev);
 
 	ret = snd_soc_register_platform(&pdev->dev, &mtk_afe_pcm_platform);
 	if (ret) {
@@ -1617,6 +1618,7 @@ static int mt2701_afe_pcm_dev_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		mt2701_afe_runtime_suspend(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
 
 	snd_soc_unregister_component(&pdev->dev);
 	snd_soc_unregister_platform(&pdev->dev);
-- 
2.11.0
