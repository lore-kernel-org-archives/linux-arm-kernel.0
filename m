From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 12 Apr 2017 09:58:44 +0800
Subject: [PATCH 3/6] regulator: anatop: use of_property_read_string to read
 the name
In-Reply-To: <1491962327-12477-1-git-send-email-aisheng.dong@nxp.com>
References: <1491962327-12477-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1491962327-12477-3-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sreg->name is a string, so use a more proper api to read back the string
instead of of_get_property.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/regulator/anatop-regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index 2a97ada..9481730 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -193,7 +193,8 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 	sreg = devm_kzalloc(dev, sizeof(*sreg), GFP_KERNEL);
 	if (!sreg)
 		return -ENOMEM;
-	sreg->name = of_get_property(np, "regulator-name", NULL);
+
+	of_property_read_string(np, "regulator-name", &sreg->name);
 	rdesc = &sreg->rdesc;
 	rdesc->name = sreg->name;
 	rdesc->type = REGULATOR_VOLTAGE;
-- 
2.7.4
