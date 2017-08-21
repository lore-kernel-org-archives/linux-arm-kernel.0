From: broonie@kernel.org (Mark Brown)
Date: Mon, 21 Aug 2017 18:16:33 +0100
Subject: Applied "ASoC: mediatek: Remove unnecessary function call" to the
 asoc tree
In-Reply-To: <1503206520-15031-1-git-send-email-dolinux.peng@gmail.com>
Message-ID: <E1djqJV-0003xv-Ez@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: mediatek: Remove unnecessary function call

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

>From b286401752c61de9c2335a1c9748243bb53649de Mon Sep 17 00:00:00 2001
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Sun, 20 Aug 2017 13:22:00 +0800
Subject: [PATCH] ASoC: mediatek: Remove unnecessary function call

First of all,the address of pdev->dev is assigned to card->dev,then
the function platform_set_drvdata copies the value the variable card
to pdev->dev.driver_data, but when calling snd_soc_register_card,the
function dev_set_drvdata(card->dev, card) will also do the same copy
operation,so i think that the former copy operation can be removed.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c | 1 -
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c | 1 -
 sound/soc/mediatek/mt8173/mt8173-rt5650.c        | 1 -
 3 files changed, 3 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
index 5e383eb456a4..99c15219dbc8 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
@@ -222,7 +222,6 @@ static int mt8173_rt5650_rt5514_dev_probe(struct platform_device *pdev)
 		mt8173_rt5650_rt5514_codecs[1].of_node;
 
 	card->dev = &pdev->dev;
-	platform_set_drvdata(pdev, card);
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret)
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
index fed1f15a39c2..42de84ca8c84 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
@@ -279,7 +279,6 @@ static int mt8173_rt5650_rt5676_dev_probe(struct platform_device *pdev)
 	}
 
 	card->dev = &pdev->dev;
-	platform_set_drvdata(pdev, card);
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret)
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650.c b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
index a78470839b65..e69c141d8ed4 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
@@ -311,7 +311,6 @@ static int mt8173_rt5650_dev_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 	card->dev = &pdev->dev;
-	platform_set_drvdata(pdev, card);
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret)
-- 
2.13.3
