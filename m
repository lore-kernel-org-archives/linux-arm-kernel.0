From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Sat, 25 Jun 2016 22:52:11 -0700
Subject: [PATCH 1/3] regulator: qcom_spmi: Add support for S4 supply on pm8941
In-Reply-To: <20160626055213.18071-1-stephen.boyd@linaro.org>
References: <20160626055213.18071-1-stephen.boyd@linaro.org>
Message-ID: <20160626055213.18071-2-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The S4 supply is sometimes called the boost regulator because it
outputs 5V. Typically it's connected to the 5vs1 and 5vs2
switches for use in USB OTG and HDMI applications. Add support
for this regulator which was mistakenly left out from the initial
submission of this driver.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Fixes: e92a4047419c ("regulator: Add QCOM SPMI regulator driver")
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt | 4 ++--
 drivers/regulator/qcom_spmi-regulator.c                             | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
index 46c6f3ed1a1c..3e827bb9a56d 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
@@ -113,8 +113,8 @@ pm8916:
 	l14, l15, l16, l17, l18
 
 pm8941:
-	s1, s2, s3, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13, l14,
-	l15, l16, l17, l18, l19, l20, l21, l22, l23, l24, lvs1, lvs2, lvs3,
+	s1, s2, s3, s4, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13,
+	l14, l15, l16, l17, l18, l19, l20, l21, l22, l23, l24, lvs1, lvs2, lvs3,
 	mvs1, mvs2
 
 pm8994:
diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 84cce21e98cd..fe09407b150b 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -1496,6 +1496,7 @@ static const struct spmi_regulator_data pm8941_regulators[] = {
 	{ "s1", 0x1400, "vdd_s1", },
 	{ "s2", 0x1700, "vdd_s2", },
 	{ "s3", 0x1a00, "vdd_s3", },
+	{ "s4", 0xa000, },
 	{ "l1", 0x4000, "vdd_l1_l3", },
 	{ "l2", 0x4100, "vdd_l2_lvs_1_2_3", },
 	{ "l3", 0x4200, "vdd_l1_l3", },
-- 
2.9.0.rc2.8.ga28705d
