From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 21 Dec 2014 22:14:48 +0100
Subject: [PATCH 27/28] ASoC: samsung: drop owner assignment from
 platform_drivers
In-Reply-To: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
References: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1419196495-9626-28-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform_driver does not need to set an owner, it will be populated by the
driver core.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
Generated with coccinelle. SmPL file is in the introductory msg. The big
cleanup was pulled in this merge window. This series catches the bits fallen
through. The patches shall go in via the subsystem trees.

 sound/soc/samsung/arndale_rt5631.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/samsung/arndale_rt5631.c b/sound/soc/samsung/arndale_rt5631.c
index 1e2b61ca8db2..8bf2e2c4bafb 100644
--- a/sound/soc/samsung/arndale_rt5631.c
+++ b/sound/soc/samsung/arndale_rt5631.c
@@ -135,7 +135,6 @@ MODULE_DEVICE_TABLE(of, samsung_arndale_rt5631_of_match);
 static struct platform_driver arndale_audio_driver = {
 	.driver = {
 		.name   = "arndale-audio",
-		.owner  = THIS_MODULE,
 		.pm = &snd_soc_pm_ops,
 		.of_match_table = of_match_ptr(samsung_arndale_rt5631_of_match),
 	},
-- 
2.1.3
