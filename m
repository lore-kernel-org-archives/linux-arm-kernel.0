From: dolinux.peng@gmail.com (Peng Donglin)
Date: Sun, 20 Aug 2017 13:22:00 +0800
Subject: [PATCH 02/12] ASoC: mediatek: Remove unnecessary function call
Message-ID: <1503206520-15031-1-git-send-email-dolinux.peng@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First of all,the address of pdev->dev is assigned to card->dev,then
the function platform_set_drvdata copies the value the variable card
to pdev->dev.driver_data, but when calling snd_soc_register_card,the
function dev_set_drvdata(card->dev, card) will also do the same copy
operation,so i think that the former copy operation can be removed.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c | 1 -
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c | 1 -
 sound/soc/mediatek/mt8173/mt8173-rt5650.c        | 1 -
 3 files changed, 3 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
index 5e383eb..99c1521 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
@@ -222,7 +222,6 @@ static int mt8173_rt5650_rt5514_dev_probe(struct platform_device *pdev)
 		mt8173_rt5650_rt5514_codecs[1].of_node;
 
 	card->dev = &pdev->dev;
-	platform_set_drvdata(pdev, card);
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret)
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
index fed1f15..42de84c 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
@@ -279,7 +279,6 @@ static int mt8173_rt5650_rt5676_dev_probe(struct platform_device *pdev)
 	}
 
 	card->dev = &pdev->dev;
-	platform_set_drvdata(pdev, card);
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret)
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650.c b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
index a784708..e69c141 100644
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
1.9.1
