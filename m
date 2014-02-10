From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 10 Feb 2014 22:25:31 +0100
Subject: [PATCH] ASoC: smdk_wm8994: Fix typo "wm8894"
Message-ID: <1392067531.27939.19.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
0) This typo was introduced in commit 0d47acc4ffaa ("ASoC: smdk_wm8994:
Make driver name more unique").

1) So currently there's a difference between platform_drive.driver.name
and the (sub)string used in MODULE_ALIAS(). If I'd understand the
platform_driver interface I might have been able to say whether that
difference is only cosmetic or might actually break stuff. But I don't
understand it so I can't say. I can't even say whether this typo shows
up in some interface to user space.

2) Entirely untested.

 sound/soc/samsung/smdk_wm8994.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/smdk_wm8994.c b/sound/soc/samsung/smdk_wm8994.c
index d38ae98..682eb4f 100644
--- a/sound/soc/samsung/smdk_wm8994.c
+++ b/sound/soc/samsung/smdk_wm8994.c
@@ -202,7 +202,7 @@ static int smdk_audio_probe(struct platform_device *pdev)
 
 static struct platform_driver smdk_audio_driver = {
 	.driver		= {
-		.name	= "smdk-audio-wm8894",
+		.name	= "smdk-audio-wm8994",
 		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(samsung_wm8994_of_match),
 		.pm	= &snd_soc_pm_ops,
-- 
1.8.5.3
