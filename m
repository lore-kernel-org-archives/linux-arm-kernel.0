From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  2 Feb 2017 00:02:09 +0800
Subject: [PATCH] pinctrl: sunxi: Remove stray printk call in sun5i driver's
 probe function
Message-ID: <20170201160209.9261-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a stray printk call in the new sun5i pinctrl driver's probe
function.

Remove it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/pinctrl/sunxi/pinctrl-sun5i.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun5i.c b/drivers/pinctrl/sunxi/pinctrl-sun5i.c
index c8a94323ce8b..c7d44eeae704 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun5i.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun5i.c
@@ -719,8 +719,6 @@ static int sun5i_pinctrl_probe(struct platform_device *pdev)
 {
 	unsigned long variant = (unsigned long)of_device_get_match_data(&pdev->dev);
 
-	printk("prout\n");
-
 	return sunxi_pinctrl_init_with_variant(pdev, &sun5i_pinctrl_data,
 					       variant);
 }
-- 
2.11.0
