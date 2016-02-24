From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:45:49 +0530
Subject: [PATCH 24/50] pinctrl: samsung: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-25-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 5cc97f8..ed0b708 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -884,7 +884,8 @@ static int samsung_pinctrl_register(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	drvdata->pctl_dev = pinctrl_register(ctrldesc, &pdev->dev, drvdata);
+	drvdata->pctl_dev = devm_pinctrl_register(&pdev->dev, ctrldesc,
+						  drvdata);
 	if (IS_ERR(drvdata->pctl_dev)) {
 		dev_err(&pdev->dev, "could not register pinctrl driver\n");
 		return PTR_ERR(drvdata->pctl_dev);
-- 
2.1.4
