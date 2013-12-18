From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 18 Dec 2013 14:55:41 +0800
Subject: [RESEND PATCH v2 2/2] ASoC: atmel: sam9x5_wm8731: remove
 platform_set_drvdata
In-Reply-To: <1385546710-11308-2-git-send-email-voice.shen@atmel.com>
References: <1385546710-11308-2-git-send-email-voice.shen@atmel.com>
Message-ID: <1387349741-13121-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When call snd_soc_register_card, it will set driver data to this
device through dev_set_drvdata, then in driver, no need to call
platform_set_drvdata again, so remove it.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
Tested-by: Richard Genoud <richard.genoud@gmail.com>
---
Hi Mark,
   This patch is not in your tree, so I resend it.

 sound/soc/atmel/sam9x5_wm8731.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/atmel/sam9x5_wm8731.c b/sound/soc/atmel/sam9x5_wm8731.c
index 7d6a905..3188036 100644
--- a/sound/soc/atmel/sam9x5_wm8731.c
+++ b/sound/soc/atmel/sam9x5_wm8731.c
@@ -155,8 +155,6 @@ static int sam9x5_wm8731_driver_probe(struct platform_device *pdev)
 	of_node_put(codec_np);
 	of_node_put(cpu_np);
 
-	platform_set_drvdata(pdev, card);
-
 	ret = snd_soc_register_card(card);
 	if (ret) {
 		dev_err(&pdev->dev,
-- 
1.7.9.5
