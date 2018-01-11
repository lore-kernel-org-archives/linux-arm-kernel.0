From: weiyongjun1@huawei.com (Wei Yongjun)
Date: Thu, 11 Jan 2018 11:11:51 +0000
Subject: [PATCH -next] ASoC: stm32: fix a typo in stm32_adfsdm_probe()
Message-ID: <1515669111-125208-1-git-send-email-weiyongjun1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix a typo, we should return PTR_ERR(priv->iio_cb) instead of
PTR_ERR(priv->iio_ch).

Fixes: 55da094824c4 ("ASoC: stm32: add DFSDM DAI support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/stm/stm32_adfsdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index af50891..7306e3e 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -320,7 +320,7 @@ static int stm32_adfsdm_probe(struct platform_device *pdev)
 
 	priv->iio_cb = iio_channel_get_all_cb(&pdev->dev, NULL, NULL);
 	if (IS_ERR(priv->iio_cb))
-		return PTR_ERR(priv->iio_ch);
+		return PTR_ERR(priv->iio_cb);
 
 	ret = devm_snd_soc_register_platform(&pdev->dev,
 					     &stm32_adfsdm_soc_platform);
