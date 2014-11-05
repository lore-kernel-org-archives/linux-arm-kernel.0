From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed,  5 Nov 2014 17:44:52 +0100
Subject: [PATCH] ASoC: samsung: Add MODULE_DEVICE_TABLE for Snow
Message-ID: <1415205892-5553-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the snd_soc_snow module to be auto-loaded.

Fixes: da5993df2374 ("ASoC: samsung: Add sound card driver for Snow board")
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Tested using patches for Spring, but should apply to Snow/Peach-pi equally.
 Rebased onto sound.git for-next branch.

 sound/soc/samsung/snow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/samsung/snow.c b/sound/soc/samsung/snow.c
index 0acf5d0eed53..72118a77dd5b 100644
--- a/sound/soc/samsung/snow.c
+++ b/sound/soc/samsung/snow.c
@@ -110,6 +110,7 @@ static const struct of_device_id snow_of_match[] = {
 	{ .compatible = "google,snow-audio-max98095", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, snow_of_match);
 
 static struct platform_driver snow_driver = {
 	.driver = {
-- 
2.1.2
