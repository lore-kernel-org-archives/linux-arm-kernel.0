From: guodong.xu@linaro.org (Guodong Xu)
Date: Fri, 26 May 2017 14:35:14 +0800
Subject: [PATCH 2/6] mfd: hi6421-pmic: move hi6421_regmap_config definition to
 header file
In-Reply-To: <20170526063518.21246-1-guodong.xu@linaro.org>
References: <20170526063518.21246-1-guodong.xu@linaro.org>
Message-ID: <20170526063518.21246-3-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move hi6421_regmap_config definition from c code to common header:
 - include/linux/mfd/hi6421-pmic.h

This is to improve code re-use for upcoming hi6421 series of MFD driver.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 drivers/mfd/hi6421-pmic-core.c  | 7 -------
 include/linux/mfd/hi6421-pmic.h | 6 ++++++
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/hi6421-pmic-core.c b/drivers/mfd/hi6421-pmic-core.c
index 3fd703f..dc1b5cf 100644
--- a/drivers/mfd/hi6421-pmic-core.c
+++ b/drivers/mfd/hi6421-pmic-core.c
@@ -35,13 +35,6 @@ static const struct mfd_cell hi6421_devs[] = {
 	{ .name = "hi6421-regulator", },
 };
 
-static const struct regmap_config hi6421_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 8,
-	.max_register = HI6421_REG_TO_BUS_ADDR(HI6421_REG_MAX),
-};
-
 static int hi6421_pmic_probe(struct platform_device *pdev)
 {
 	struct hi6421_pmic *pmic;
diff --git a/include/linux/mfd/hi6421-pmic.h b/include/linux/mfd/hi6421-pmic.h
index 587273e..f4674ff 100644
--- a/include/linux/mfd/hi6421-pmic.h
+++ b/include/linux/mfd/hi6421-pmic.h
@@ -38,4 +38,10 @@ struct hi6421_pmic {
 	struct regmap		*regmap;
 };
 
+static const struct regmap_config hi6421_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 8,
+	.max_register = HI6421_REG_TO_BUS_ADDR(HI6421_REG_MAX),
+};
 #endif		/* __HI6421_PMIC_H */
-- 
2.10.2
