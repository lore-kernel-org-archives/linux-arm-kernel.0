From: guodong.xu@linaro.org (Guodong Xu)
Date: Tue,  9 Sep 2014 19:07:05 +0800
Subject: [PATCH] regulator: mc13xxx: add missing of_node_get()
Message-ID: <1410260825-21667-1-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mc13xxx_parse_regulators_dt() goes through dt tree to search for regulator
sub-nodes. For each matched node, later on it will be used and registered
into a regulator_dev.

of_node_get() should be called to increase its refcount.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 drivers/regulator/mc13xxx-regulator-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/mc13xxx-regulator-core.c b/drivers/regulator/mc13xxx-regulator-core.c
index afba024..ebc8ff1 100644
--- a/drivers/regulator/mc13xxx-regulator-core.c
+++ b/drivers/regulator/mc13xxx-regulator-core.c
@@ -195,7 +195,7 @@ struct mc13xxx_regulator_init_data *mc13xxx_parse_regulators_dt(
 				p->id = i;
 				p->init_data = of_get_regulator_init_data(
 							&pdev->dev, child);
-				p->node = child;
+				p->node = of_node_get(child);
 				p++;
 
 				parsed++;
-- 
1.9.1
