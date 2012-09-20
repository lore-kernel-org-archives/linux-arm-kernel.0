From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 20 Sep 2012 14:09:14 +0200
Subject: [PATCH 5/7] ASoC: Ux500: Minor coding layout changes
In-Reply-To: <1348142956-1872-1-git-send-email-lee.jones@linaro.org>
References: <1348142956-1872-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1348142956-1872-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Includes removal of duplicate debug print affirming entry into
the probe function, an unnecessary line break of a coding line
<80 chars and a white space change (unintentional tab).

Acked-by: Ola Lilja <ola.o.lilja@stericsson.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/ux500/mop500.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index 6840df7..356611d 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -88,8 +88,6 @@ static int __devinit mop500_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
-	pr_debug("%s: Enter.\n", __func__);
-
 	dev_dbg(&pdev->dev, "%s: Enter.\n", __func__);
 
 	mop500_card.dev = &pdev->dev;
@@ -117,8 +115,7 @@ static int __devinit mop500_probe(struct platform_device *pdev)
 	ret = snd_soc_register_card(&mop500_card);
 	if (ret)
 		dev_err(&pdev->dev,
-			"Error: snd_soc_register_card failed (%d)!\n",
-			ret);
+			"Error: snd_soc_register_card failed (%d)!\n", ret);
 
 	return ret;
 }
@@ -131,7 +128,7 @@ static int __devexit mop500_remove(struct platform_device *pdev)
 
 	snd_soc_unregister_card(mop500_card);
 	mop500_ab8500_remove(mop500_card);
-	
+
 	return 0;
 }
 
-- 
1.7.9.5
