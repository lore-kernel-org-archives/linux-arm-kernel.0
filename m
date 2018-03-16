From: weiyongjun1@huawei.com (Wei Yongjun)
Date: Fri, 16 Mar 2018 07:31:56 +0000
Subject: [PATCH -next] ASoC: mediatek: mt2701: drop unnessary
 snd_soc_unregister_component()
Message-ID: <1521185516-164333-1-git-send-email-weiyongjun1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's not necessary to unregister a component registered
with devm_snd_soc_register_component().

Fixes: f1b5bf07365d ("ASoC: mt2701/mt8173: replace platform to componen")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index f7e0702..43837a3 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -1561,8 +1561,6 @@ static int mt2701_afe_pcm_dev_remove(struct platform_device *pdev)
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		mt2701_afe_runtime_suspend(&pdev->dev);
 
-	snd_soc_unregister_component(&pdev->dev);
-
 	return 0;
 }
