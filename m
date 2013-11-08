From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Fri, 8 Nov 2013 02:01:38 -0800 (PST)
Subject: [patch] pinctrl: rockchip: testing the wrong variable
Message-ID: <20131108100138.GO27977@elgon.mountain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a copy and paste bug so we test "info->reg_base" instead of
"info->reg_pull".

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I can't compile this.

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index e939c28..fe2ec1b 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -1453,8 +1453,8 @@ static int rockchip_pinctrl_probe(struct platform_device *pdev)
 	if (ctrl->type == RK3188) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 		info->reg_pull = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(info->reg_base))
-			return PTR_ERR(info->reg_base);
+		if (IS_ERR(info->reg_pull))
+			return PTR_ERR(info->reg_pull);
 	}
 
 	ret = rockchip_gpiolib_register(pdev, info);
