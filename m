From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Fri, 01 Apr 2016 19:32:43 +0900
Subject: [PATCH] bus: uniphier-system-bus: fix condition of overlap check
Message-ID: <20160401193242.F963.4A936039@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes condition whether the specified address ranges
overlap each other.

Fixes: 4b7f48d395a7 ("bus: uniphier-system-bus: add UniPhier System Bus driver")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/bus/uniphier-system-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/uniphier-system-bus.c b/drivers/bus/uniphier-system-bus.c
index 834a2ae..350b730 100644
--- a/drivers/bus/uniphier-system-bus.c
+++ b/drivers/bus/uniphier-system-bus.c
@@ -108,7 +108,7 @@ static int uniphier_system_bus_check_overlap(
 
 	for (i = 0; i < ARRAY_SIZE(priv->bank); i++) {
 		for (j = i + 1; j < ARRAY_SIZE(priv->bank); j++) {
-			if (priv->bank[i].end > priv->bank[j].base ||
+			if (priv->bank[i].end > priv->bank[j].base &&
 			    priv->bank[i].base < priv->bank[j].end) {
 				dev_err(priv->dev,
 					"region overlap between bank%d and bank%d\n",
-- 
2.1.4
