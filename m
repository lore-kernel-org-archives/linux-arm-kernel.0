From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 26 Nov 2013 12:17:52 +0800
Subject: [PATCH 2/2] ASoC: atmel: sam9x5_wm8731: remove platform_set_drvdata
In-Reply-To: <1385439472-23352-1-git-send-email-voice.shen@atmel.com>
References: <1385439472-23352-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1385439472-23352-2-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When call snd_soc_register_card, it will set driver data to this
device through dev_set_drvdata, then in driver, no need to call
platform_set_drvdata again, so remove it.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 sound/soc/atmel/sam9x5_wm8731.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/atmel/sam9x5_wm8731.c b/sound/soc/atmel/sam9x5_wm8731.c
index 6dc33ac..4af6836 100644
--- a/sound/soc/atmel/sam9x5_wm8731.c
+++ b/sound/soc/atmel/sam9x5_wm8731.c
@@ -154,8 +154,6 @@ static int sam9x5_wm8731_driver_probe(struct platform_device *pdev)
 	of_node_put(codec_np);
 	of_node_put(cpu_np);
 
-	platform_set_drvdata(pdev, card);
-
 	ret = snd_soc_register_card(card);
 	if (ret) {
 		dev_err(&pdev->dev,
-- 
1.7.9.5
