From: weiyongjun1@huawei.com (Wei Yongjun)
Date: Thu, 31 May 2018 11:39:42 +0000
Subject: [PATCH -next] pinctrl: mediatek: remove redundant return value check
 of platform_get_resource()
Message-ID: <1527766782-72315-1-git-send-email-weiyongjun1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unneeded error handling on the result of a call
to platform_get_resource() when the value is passed to
devm_ioremap_resource().

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index b379969..16ff56f9 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -1000,11 +1000,6 @@ static int mtk_eint_init(struct mtk_pinctrl *pctl, struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Unable to get eint resource\n");
-		return -ENODEV;
-	}
-
 	pctl->eint->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(pctl->eint->base))
 		return PTR_ERR(pctl->eint->base);
