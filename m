From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Wed, 10 Aug 2016 13:42:34 +0000
Subject: [PATCH -next] ASoC: sun4i-codec: Fix error return code in
 sun4i_codec_probe()
Message-ID: <1470836554-11569-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix to return error code -ENOMEM instead of 0 when create card
failed, as done elsewhere in this function.

Fixes: 45fb6b6f2aa3 ("ASoC: sunxi: add support for the on-chip
codec on early Allwinner SoCs")
Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 sound/soc/sunxi/sun4i-codec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 0e19c50..e741659 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -846,6 +846,7 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 	card = sun4i_codec_create_card(&pdev->dev);
 	if (!card) {
 		dev_err(&pdev->dev, "Failed to create our card\n");
+		ret = -ENOMEM;
 		goto err_unregister_codec;
 	}
