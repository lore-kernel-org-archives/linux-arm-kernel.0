From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 12 Apr 2017 09:58:42 +0800
Subject: [PATCH 1/6] regulator: anatop: check return value of
 of_get_regulator_init_data
Message-ID: <1491962327-12477-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Should check the return value of of_get_regulator_init_data before
using it.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/regulator/anatop-regulator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index b041f27..46b9c2c 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -200,6 +200,9 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 	rdesc->owner = THIS_MODULE;
 
 	initdata = of_get_regulator_init_data(dev, np, rdesc);
+	if (!initdata)
+		return -ENOMEM;
+
 	initdata->supply_regulator = "vin";
 	sreg->initdata = initdata;
 
-- 
2.7.4
