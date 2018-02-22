From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 22 Feb 2018 17:14:27 +0800
Subject: [PATCH] soc: imx: gpc: fix double semicolons
Message-ID: <1519290867-4974-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix double semicolons in function imx_gpc_old_dt_init().

Reported-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
 drivers/soc/imx/gpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 4bd241047634..b16880df0517 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -350,7 +350,7 @@ static int imx_gpc_old_dt_init(struct device *dev, struct regmap *regmap,
 		if (i == 1) {
 			domain->supply = devm_regulator_get(dev, "pu");
 			if (IS_ERR(domain->supply))
-				return PTR_ERR(domain->supply);;
+				return PTR_ERR(domain->supply);
 
 			ret = imx_pgc_get_clocks(dev, domain);
 			if (ret)
-- 
1.9.1
