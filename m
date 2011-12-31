From: richard.zhao@linaro.org (Richard Zhao)
Date: Sat, 31 Dec 2011 20:51:16 +0800
Subject: [PATCH 1/1] regulator/fixed: pass regulator_register of_node
In-Reply-To: <1325225213-29655-1-git-send-email-richard.zhao@linaro.org>
References: <1325225213-29655-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1325335876-15296-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

regulator_get needs of_node to find right regulator.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 drivers/regulator/fixed.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index fa0c426..e24e3a1 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -247,7 +247,8 @@ static int __devinit reg_fixed_voltage_probe(struct platform_device *pdev)
 	}
 
 	drvdata->dev = regulator_register(&drvdata->desc, &pdev->dev,
-					  config->init_data, drvdata, NULL);
+					  config->init_data, drvdata,
+					  pdev->dev.of_node);
 	if (IS_ERR(drvdata->dev)) {
 		ret = PTR_ERR(drvdata->dev);
 		dev_err(&pdev->dev, "Failed to register regulator: %d\n", ret);
-- 
1.7.5.4
