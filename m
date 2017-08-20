From: dolinux.peng@gmail.com (Peng Donglin)
Date: Sun, 20 Aug 2017 13:55:13 +0800
Subject: [PATCH 10/12] ASoC: sun4i-codec: Remove unnecessary function call
Message-ID: <1503208513-4015-1-git-send-email-dolinux.peng@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First of all,the address of pdev->dev is assigned to card->dev in
create_card,then the function platform_set_drvdata copies the value
the variable card to pdev->dev.driver_data, but when calling
snd_soc_register_card,the function dev_set_drvdata(card->dev, card)
will also do the same copy operation,so i think that the former copy
operation can be removed.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---
 sound/soc/sunxi/sun4i-codec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 1500699..82beeae 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -1655,7 +1655,6 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 		goto err_unregister_codec;
 	}
 
-	platform_set_drvdata(pdev, card);
 	snd_soc_card_set_drvdata(card, scodec);
 
 	ret = snd_soc_register_card(card);
-- 
1.9.1
