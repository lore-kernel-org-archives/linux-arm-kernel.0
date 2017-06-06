From: guodong.xu@linaro.org (Guodong Xu)
Date: Tue,  6 Jun 2017 16:51:37 +0800
Subject: [PATCH v4 2/8] mfd: hi6421-pmic: cleanup: update dev_err messages
In-Reply-To: <20170606085143.13154-1-guodong.xu@linaro.org>
References: <20170606085143.13154-1-guodong.xu@linaro.org>
Message-ID: <20170606085143.13154-3-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update dev_err messages to make them more readable.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 drivers/mfd/hi6421-pmic-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/hi6421-pmic-core.c b/drivers/mfd/hi6421-pmic-core.c
index ad9e3d8..b1139d4 100644
--- a/drivers/mfd/hi6421-pmic-core.c
+++ b/drivers/mfd/hi6421-pmic-core.c
@@ -52,8 +52,8 @@ static int hi6421_pmic_probe(struct platform_device *pdev)
 	pmic->regmap = devm_regmap_init_mmio_clk(&pdev->dev, NULL, base,
 						 &hi6421_regmap_config);
 	if (IS_ERR(pmic->regmap)) {
-		dev_err(&pdev->dev,
-			"regmap init failed: %ld\n", PTR_ERR(pmic->regmap));
+		dev_err(&pdev->dev, "Failed to initialise Regmap: %ld\n",
+						PTR_ERR(pmic->regmap));
 		return PTR_ERR(pmic->regmap);
 	}
 
@@ -70,7 +70,7 @@ static int hi6421_pmic_probe(struct platform_device *pdev)
 	ret = devm_mfd_add_devices(&pdev->dev, 0, hi6421_devs,
 				   ARRAY_SIZE(hi6421_devs), NULL, 0, NULL);
 	if (ret) {
-		dev_err(&pdev->dev, "add mfd devices failed: %d\n", ret);
+		dev_err(&pdev->dev, "Failed to add child devices: %d\n", ret);
 		return ret;
 	}
 
-- 
2.10.2
