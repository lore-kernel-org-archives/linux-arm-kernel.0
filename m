From: rklein@nvidia.com (Rhyland Klein)
Date: Mon, 10 Jun 2013 17:26:41 -0400
Subject: [PATCH 3/4] power: tps65090-charger: Add dt node to power_supply
In-Reply-To: <1370899602-22123-1-git-send-email-rklein@nvidia.com>
References: <1370899602-22123-1-git-send-email-rklein@nvidia.com>
Message-ID: <1370899602-22123-4-git-send-email-rklein@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Passing in the dt node for this charger enables the logic in the core
to lookup this device, to see if it is supplying another power_supply,
through dt.

Signed-off-by: Rhyland Klein <rklein@nvidia.com>
---
 drivers/power/tps65090-charger.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/tps65090-charger.c b/drivers/power/tps65090-charger.c
index 77ab856..3f4b9cc 100644
--- a/drivers/power/tps65090-charger.c
+++ b/drivers/power/tps65090-charger.c
@@ -230,6 +230,7 @@ static int tps65090_charger_probe(struct platform_device *pdev)
 	cdata->ac.num_properties	= ARRAY_SIZE(tps65090_ac_props);
 	cdata->ac.supplied_to		= pdata->supplied_to;
 	cdata->ac.num_supplicants	= pdata->num_supplicants;
+	cdata->ac.of_node		= pdev->dev.of_node;
 
 	ret = power_supply_register(&pdev->dev, &cdata->ac);
 	if (ret) {
-- 
1.7.9.5
