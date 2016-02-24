From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:45:28 +0530
Subject: [PATCH 03/50] pinctrl: bcm281xx: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-4-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Ray Jui <rjui@broadcom.com>
---
 drivers/pinctrl/bcm/pinctrl-bcm281xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm281xx.c b/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
index c3c692e..0c0c0f0 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
@@ -1422,9 +1422,7 @@ static int __init bcm281xx_pinctrl_probe(struct platform_device *pdev)
 	bcm281xx_pinctrl_desc.pins = bcm281xx_pinctrl.pins;
 	bcm281xx_pinctrl_desc.npins = bcm281xx_pinctrl.npins;
 
-	pctl = pinctrl_register(&bcm281xx_pinctrl_desc,
-				&pdev->dev,
-				pdata);
+	pctl = devm_pinctrl_register(&pdev->dev, &bcm281xx_pinctrl_desc, pdata);
 	if (IS_ERR(pctl)) {
 		dev_err(&pdev->dev, "Failed to register pinctrl\n");
 		return PTR_ERR(pctl);
-- 
2.1.4
