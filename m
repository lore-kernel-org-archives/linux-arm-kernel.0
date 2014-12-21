From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 21 Dec 2014 22:14:47 +0100
Subject: [PATCH 26/28] ASoC: pxa: drop owner assignment from platform_drivers
In-Reply-To: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
References: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1419196495-9626-27-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform_driver does not need to set an owner, it will be populated by the
driver core.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
Generated with coccinelle. SmPL file is in the introductory msg. The big
cleanup was pulled in this merge window. This series catches the bits fallen
through. The patches shall go in via the subsystem trees.

 sound/soc/pxa/spitz.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index d7d5fb20ea6f..a6d680acd907 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -352,7 +352,6 @@ static int spitz_remove(struct platform_device *pdev)
 static struct platform_driver spitz_driver = {
 	.driver		= {
 		.name	= "spitz-audio",
-		.owner	= THIS_MODULE,
 		.pm     = &snd_soc_pm_ops,
 	},
 	.probe		= spitz_probe,
-- 
2.1.3
