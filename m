From: garlic.tseng@mediatek.com (Garlic Tseng)
Date: Thu, 16 Feb 2017 13:27:15 +0800
Subject: [alsa-devel] [PATCH 1/2] ASoC: mediatek: add power-domain get/put
 ctrl for mt2701
In-Reply-To: <1487222836-21174-1-git-send-email-garlic.tseng@mediatek.com>
References: <1487222836-21174-1-git-send-email-garlic.tseng@mediatek.com>
Message-ID: <1487222836-21174-2-git-send-email-garlic.tseng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add power-domain ctrl for audio driver

Signed-off-by: Garlic Tseng <garlic.tseng@mediatek.com>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index 34a6123..c7fa3e6 100644
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
1.9.1
