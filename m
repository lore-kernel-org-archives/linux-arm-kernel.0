From: baruch@tkos.co.il (Baruch Siach)
Date: Mon,  2 Mar 2015 19:28:45 +0200
Subject: [PATCH] pinctrl: at91: simplify probe error handling
Message-ID: <2adab2d9a86d0e44051541052ace08527bdcc045.1425317325.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no code ender the 'err' label. Just return the error code directly.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/pinctrl/pinctrl-at91.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index f4cd0b9b2438..6cfe534ab27e 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1240,8 +1240,7 @@ static int at91_pinctrl_probe(struct platform_device *pdev)
 
 	if (!info->pctl) {
 		dev_err(&pdev->dev, "could not register AT91 pinctrl driver\n");
-		ret = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
 	/* We will handle a range of GPIO pins */
@@ -1252,9 +1251,6 @@ static int at91_pinctrl_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "initialized AT91 pinctrl driver\n");
 
 	return 0;
-
-err:
-	return ret;
 }
 
 static int at91_pinctrl_remove(struct platform_device *pdev)
-- 
2.1.4
