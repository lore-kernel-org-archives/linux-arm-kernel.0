From: emilgoode@gmail.com (Emil Goode)
Date: Fri, 14 Jun 2013 11:48:56 +0200
Subject: [PATCH] ASoC: Fix double assignment of .owner in struct snd_soc_card
Message-ID: <1371203336-16972-1-git-send-email-emilgoode@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In struct snd_soc_card zylonite .owner is assigned THIS_MODULE
twice, remove one of them.

Signed-off-by: Emil Goode <emilgoode@gmail.com>
---
 sound/soc/pxa/zylonite.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/pxa/zylonite.c b/sound/soc/pxa/zylonite.c
index ceb6566..db8aadf 100644
--- a/sound/soc/pxa/zylonite.c
+++ b/sound/soc/pxa/zylonite.c
@@ -256,7 +256,6 @@ static struct snd_soc_card zylonite = {
 	.resume_pre = &zylonite_resume_pre,
 	.dai_link = zylonite_dai,
 	.num_links = ARRAY_SIZE(zylonite_dai),
-	.owner = THIS_MODULE,
 };
 
 static struct platform_device *zylonite_snd_ac97_device;
-- 
1.7.10.4
