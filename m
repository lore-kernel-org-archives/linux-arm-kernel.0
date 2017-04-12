From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 12 Apr 2017 09:58:46 +0800
Subject: [PATCH 5/6] regulator: anatop-regulator: make regulator-name using
 optionally
In-Reply-To: <1491962327-12477-1-git-send-email-aisheng.dong@nxp.com>
References: <1491962327-12477-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1491962327-12477-5-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rdesc->name/regulator-name is optional according to standard regulator
binding doc. Use it conditionally to avoid a kernel NULL point crash.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/regulator/anatop-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index 19eb1f4..6da0b20 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -298,7 +298,7 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 		 * a sane default until imx6-cpufreq was probed and changes the
 		 * voltage to the correct value. In this case we set 1.25V.
 		 */
-		if (!sreg->sel && !strcmp(rdesc->name, "vddpu"))
+		if (!sreg->sel && rdesc->name && !strcmp(rdesc->name, "vddpu"))
 			sreg->sel = 22;
 
 		if (!sreg->bypass && !sreg->sel) {
-- 
2.7.4
