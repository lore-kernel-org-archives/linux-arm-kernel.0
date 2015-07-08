From: drinkcat@chromium.org (Nicolas Boichat)
Date: Wed,  8 Jul 2015 14:30:17 +0800
Subject: [PATCHv2 2/3] thermal: sti: Add parentheses around
 bridge->ops->regmap_init call
In-Reply-To: <1436337018-32464-1-git-send-email-drinkcat@chromium.org>
References: <1436337018-32464-1-git-send-email-drinkcat@chromium.org>
Message-ID: <1436337018-32464-3-git-send-email-drinkcat@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

regmap_init(...) is a macro since commit
"regmap: Use different lockdep class for each regmap init call".
That same name is used as a function pointer: prevent its expansion
by adding parentheses around the function pointer.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/thermal/st/st_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
index 76c515d..88c759d 100644
--- a/drivers/thermal/st/st_thermal.c
+++ b/drivers/thermal/st/st_thermal.c
@@ -214,7 +214,7 @@ int st_thermal_register(struct platform_device *pdev,
 
 	sensor->ops = sensor->cdata->ops;
 
-	ret = sensor->ops->regmap_init(sensor);
+	ret = (sensor->ops->regmap_init)(sensor);
 	if (ret)
 		return ret;
 
-- 
2.4.3.573.g4eafbef
