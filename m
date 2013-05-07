From: padma.v@samsung.com (Padmavathi Venna)
Date: Tue, 07 May 2013 09:09:01 +0530
Subject: [PATCH] ASoC: Samsung: i2s: Fix crash in i2s driver
Message-ID: <1367897941-18439-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a null pointer deference in i2s driver in DT
case

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---

This patch is dependent on below patch posted by Thomas Abraham.
https://patchwork.kernel.org/patch/2224801/

 sound/soc/samsung/i2s.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 7ce7c50..eaf6439 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1182,7 +1182,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		pri_dai->sec_dai = sec_dai;
 	}
 
-	if (i2s_pdata->cfg_gpio && i2s_pdata->cfg_gpio(pdev)) {
+	if (i2s_pdata && i2s_pdata->cfg_gpio && i2s_pdata->cfg_gpio(pdev)) {
 		dev_err(&pdev->dev, "Unable to configure gpio\n");
 		ret = -EINVAL;
 		goto err;
-- 
1.7.4.4
