From: vthakkar1994@gmail.com (Vaishali Thakkar)
Date: Thu, 20 Aug 2015 22:11:15 +0530
Subject: [PATCH] ASoC: Samsung: Remove redundant arndale_audio_remove
Message-ID: <20150820164115.GA19191@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no use of snd_soc_unregister_card in remove function
as devm_snd_soc_register_card in probe function automatically
handles it. So, remove use of snd_soc_unregister_card and with
this change remove arndale_audio_remove as it is now redundant.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
 sound/soc/samsung/arndale_rt5631.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/samsung/arndale_rt5631.c b/sound/soc/samsung/arndale_rt5631.c
index 8bf2e2c..9e371eb 100644
--- a/sound/soc/samsung/arndale_rt5631.c
+++ b/sound/soc/samsung/arndale_rt5631.c
@@ -116,15 +116,6 @@ static int arndale_audio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int arndale_audio_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
-
-	return 0;
-}
-
 static const struct of_device_id samsung_arndale_rt5631_of_match[] __maybe_unused = {
 	{ .compatible = "samsung,arndale-rt5631", },
 	{ .compatible = "samsung,arndale-alc5631", },
@@ -139,7 +130,6 @@ static struct platform_driver arndale_audio_driver = {
 		.of_match_table = of_match_ptr(samsung_arndale_rt5631_of_match),
 	},
 	.probe = arndale_audio_probe,
-	.remove = arndale_audio_remove,
 };
 
 module_platform_driver(arndale_audio_driver);
-- 
1.9.1
