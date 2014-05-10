From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 10 May 2014 12:18:13 +0400
Subject: [PATCH 1/2] pinctrl: i.MX27: Remove unused structure definition
Message-ID: <1399709894-7652-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct imx27_pinctrl_private is not used in the driver.
Remove this definition.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/pinctrl/pinctrl-imx27.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-imx27.c b/drivers/pinctrl/pinctrl-imx27.c
index 417c992..27ae7ce 100644
--- a/drivers/pinctrl/pinctrl-imx27.c
+++ b/drivers/pinctrl/pinctrl-imx27.c
@@ -440,12 +440,6 @@ static struct of_device_id imx27_pinctrl_of_match[] = {
 	{ /* sentinel */ }
 };
 
-struct imx27_pinctrl_private {
-	int num_gpio_childs;
-	struct platform_device **gpio_dev;
-	struct mxc_gpio_platform_data *gpio_pdata;
-};
-
 static int imx27_pinctrl_probe(struct platform_device *pdev)
 {
 	return imx1_pinctrl_core_probe(pdev, &imx27_pinctrl_info);
-- 
1.8.3.2
