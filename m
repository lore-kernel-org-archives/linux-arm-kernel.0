From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Mon, 5 Mar 2018 17:49:06 -0600
Subject: [PATCH] pinctrl: mediatek: mtk-common: use true and false for
 boolean values
Message-ID: <20180305234906.GA32058@embeddedgus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Assign true or false to boolean variables instead of an integer value.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 3cf384f..e161561 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -501,7 +501,7 @@ static int mtk_pctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	int num_pins, num_funcs, maps_per_pin;
 	unsigned long *configs;
 	unsigned int num_configs;
-	bool has_config = 0;
+	bool has_config = false;
 	int i, err;
 	unsigned reserve = 0;
 	struct mtk_pinctrl_group *grp;
@@ -520,7 +520,7 @@ static int mtk_pctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		return err;
 
 	if (num_configs)
-		has_config = 1;
+		has_config = true;
 
 	num_pins = pins->length / sizeof(u32);
 	num_funcs = num_pins;
-- 
2.7.4
