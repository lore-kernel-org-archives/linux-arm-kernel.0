From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 23 Dec 2017 22:38:50 +0100
Subject: [PATCH 1/3] pinctrl: rockchip: Delete error messages for a failed
 memory allocation in two functions
In-Reply-To: <323697d0-e1e8-8d3b-1070-f481cfa30b9a@users.sourceforge.net>
References: <323697d0-e1e8-8d3b-1070-f481cfa30b9a@users.sourceforge.net>
Message-ID: <7a067193-e0c3-c2b9-b85a-e05c8ff8860e@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 23 Dec 2017 22:02:47 +0100

Omit extra messages for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/pinctrl/pinctrl-rockchip.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 2ba17548ad5b..285169170eb2 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -2400,18 +2400,14 @@ static int rockchip_pinctrl_parse_dt(struct platform_device *pdev,
 	info->functions = devm_kzalloc(dev, info->nfunctions *
 					      sizeof(struct rockchip_pmx_func),
 					      GFP_KERNEL);
-	if (!info->functions) {
-		dev_err(dev, "failed to allocate memory for function list\n");
+	if (!info->functions)
 		return -EINVAL;
-	}
 
 	info->groups = devm_kzalloc(dev, info->ngroups *
 					    sizeof(struct rockchip_pin_group),
 					    GFP_KERNEL);
-	if (!info->groups) {
-		dev_err(dev, "failed allocate memory for ping group list\n");
+	if (!info->groups)
 		return -EINVAL;
-	}
 
 	i = 0;
 
@@ -2447,10 +2443,9 @@ static int rockchip_pinctrl_register(struct platform_device *pdev,
 
 	pindesc = devm_kzalloc(&pdev->dev, sizeof(*pindesc) *
 			info->ctrl->nr_pins, GFP_KERNEL);
-	if (!pindesc) {
-		dev_err(&pdev->dev, "mem alloc for pin descriptors failed\n");
+	if (!pindesc)
 		return -ENOMEM;
-	}
+
 	ctrldesc->pins = pindesc;
 	ctrldesc->npins = info->ctrl->nr_pins;
 
-- 
2.15.1
