From: colin.king@canonical.com (Colin King)
Date: Sat, 12 Nov 2016 16:30:25 +0000
Subject: [PATCH] ASoC: mioa701_wm9713: add missing white space in dev_err
 message
Message-ID: <20161112163025.4801-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

There is a missing whitespace in the dev_err message between
"will" and "lead".  Add the whitespace.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/pxa/mioa701_wm9713.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index d1661fa..0fe0abe 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -187,7 +187,7 @@ static int mioa701_wm9713_probe(struct platform_device *pdev)
 	mioa701.dev = &pdev->dev;
 	rc = devm_snd_soc_register_card(&pdev->dev, &mioa701);
 	if (!rc)
-		dev_warn(&pdev->dev, "Be warned that incorrect mixers/muxes setup will"
+		dev_warn(&pdev->dev, "Be warned that incorrect mixers/muxes setup will "
 			 "lead to overheating and possible destruction of your device."
 			 " Do not use without a good knowledge of mio's board design!\n");
 	return rc;
-- 
2.10.2
