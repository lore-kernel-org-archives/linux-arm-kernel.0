From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Thu, 29 Jan 2015 16:22:57 -0800
Subject: [PATCH] regulator: qcom-rpm: Make it possible to specify supply
Message-ID: <1422577377-31986-1-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make it possible to specify the supply of a regulator, through the
vin-supply property in dt.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 drivers/regulator/qcom_rpm-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/qcom_rpm-regulator.c b/drivers/regulator/qcom_rpm-regulator.c
index e3120bf..00c5cc3 100644
--- a/drivers/regulator/qcom_rpm-regulator.c
+++ b/drivers/regulator/qcom_rpm-regulator.c
@@ -679,6 +679,7 @@ static int rpm_reg_probe(struct platform_device *pdev)
 	vreg->desc.owner = THIS_MODULE;
 	vreg->desc.type = REGULATOR_VOLTAGE;
 	vreg->desc.name = pdev->dev.of_node->name;
+	vreg->desc.supply_name = "vin";
 
 	vreg->rpm = dev_get_drvdata(pdev->dev.parent);
 	if (!vreg->rpm) {
-- 
1.9.1
