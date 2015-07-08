From: drinkcat@chromium.org (Nicolas Boichat)
Date: Wed,  8 Jul 2015 14:30:16 +0800
Subject: [PATCHv2 1/3] mfd: vexpress: Add parentheses around
 bridge->ops->regmap_init call
In-Reply-To: <1436337018-32464-1-git-send-email-drinkcat@chromium.org>
References: <1436337018-32464-1-git-send-email-drinkcat@chromium.org>
Message-ID: <1436337018-32464-2-git-send-email-drinkcat@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

regmap_init(...) is a macro since commit
"regmap: Use different lockdep class for each regmap init call".
That same name is used as a function pointer: prevent its expansion
by adding parentheses around the function pointer.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/bus/vexpress-config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/vexpress-config.c b/drivers/bus/vexpress-config.c
index a64763b..6575c0f 100644
--- a/drivers/bus/vexpress-config.c
+++ b/drivers/bus/vexpress-config.c
@@ -107,7 +107,7 @@ struct regmap *devm_regmap_init_vexpress_config(struct device *dev)
 	if (!res)
 		return ERR_PTR(-ENOMEM);
 
-	regmap = bridge->ops->regmap_init(dev, bridge->context);
+	regmap = (bridge->ops->regmap_init)(dev, bridge->context);
 	if (IS_ERR(regmap)) {
 		devres_free(res);
 		return regmap;
-- 
2.4.3.573.g4eafbef
