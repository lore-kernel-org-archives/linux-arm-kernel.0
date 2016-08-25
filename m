From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 25 Aug 2016 15:19:50 +0800
Subject: [PATCH v8 02/11] power: act8945a_charger: Achieve properties from its
 node
In-Reply-To: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
References: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1472109599-21915-3-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the act8945a_charger is regarded as a sub-device, all properties will
be assigned to its own device node. All properties can be achieved from its
own node, instead of from its parent device.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/power/supply/act8945a_charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/act8945a_charger.c b/drivers/power/supply/act8945a_charger.c
index b5c00e4..3f486c9 100644
--- a/drivers/power/supply/act8945a_charger.c
+++ b/drivers/power/supply/act8945a_charger.c
@@ -328,11 +328,11 @@ static int act8945a_charger_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = act8945a_charger_config(pdev->dev.parent, charger);
+	ret = act8945a_charger_config(&pdev->dev, charger);
 	if (ret)
 		return ret;
 
-	psy_cfg.of_node	= pdev->dev.parent->of_node;
+	psy_cfg.of_node	= pdev->dev.of_node;
 	psy_cfg.drv_data = charger;
 
 	psy = devm_power_supply_register(&pdev->dev,
-- 
2.7.4
