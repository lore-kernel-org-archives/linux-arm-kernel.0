From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Feb 2014 10:59:24 -0800
Subject: [PATCH v4 6/8] mfd: pm8921: Add DT match table
In-Reply-To: <1393441166-32692-1-git-send-email-sboyd@codeaurora.org>
References: <1393441166-32692-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1393441166-32692-7-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow this driver to probe based on devicetree.

Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/mfd/pm8921-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mfd/pm8921-core.c b/drivers/mfd/pm8921-core.c
index e9340bd6d1ab..3aab6ace5eb5 100644
--- a/drivers/mfd/pm8921-core.c
+++ b/drivers/mfd/pm8921-core.c
@@ -392,6 +392,13 @@ static const struct regmap_config ssbi_regmap_config = {
 	.reg_write = ssbi_reg_write
 };
 
+static const struct of_device_id pm8921_id_table[] = {
+	{ .compatible = "qcom,pm8058", },
+	{ .compatible = "qcom,pm8921", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pm8921_id_table);
+
 static int pm8921_probe(struct platform_device *pdev)
 {
 	struct pm8921 *pmic;
@@ -501,6 +508,7 @@ static struct platform_driver pm8921_driver = {
 	.driver		= {
 		.name	= "pm8921-core",
 		.owner	= THIS_MODULE,
+		.of_match_table = pm8921_id_table,
 	},
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
