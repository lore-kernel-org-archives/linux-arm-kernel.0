From: rklein@nvidia.com (Rhyland Klein)
Date: Mon, 10 Jun 2013 17:26:40 -0400
Subject: [PATCH 2/4] power: sbs-battery: Add dt to power_supply struct
In-Reply-To: <1370899602-22123-1-git-send-email-rklein@nvidia.com>
References: <1370899602-22123-1-git-send-email-rklein@nvidia.com>
Message-ID: <1370899602-22123-3-git-send-email-rklein@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By passing in the dt node of this device, we enable the logic for
linking power_supplies together from dt. This is specified by adding
a "power-supplies" property with a phandle to the charger for a
given supply.

Enable this logic now for the sbs-battery driver.

Signed-off-by: Rhyland Klein <rklein@nvidia.com>
---
 drivers/power/sbs-battery.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/sbs-battery.c b/drivers/power/sbs-battery.c
index c8c78a7..b5f2a76 100644
--- a/drivers/power/sbs-battery.c
+++ b/drivers/power/sbs-battery.c
@@ -704,6 +704,7 @@ static int sbs_probe(struct i2c_client *client,
 	chip->power_supply.properties = sbs_properties;
 	chip->power_supply.num_properties = ARRAY_SIZE(sbs_properties);
 	chip->power_supply.get_property = sbs_get_property;
+	chip->power_supply.of_node = client->dev.of_node;
 	/* ignore first notification of external change, it is generated
 	 * from the power_supply_register call back
 	 */
-- 
1.7.9.5
