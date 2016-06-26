From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Sat, 25 Jun 2016 22:52:13 -0700
Subject: [PATCH 3/3] regulator: qcom_spmi: Add support for get_mode/set_mode
 on switches
In-Reply-To: <20160626055213.18071-1-stephen.boyd@linaro.org>
References: <20160626055213.18071-1-stephen.boyd@linaro.org>
Message-ID: <20160626055213.18071-4-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The voltage switches support mode switching, so add support for
these ops to those types of regulators.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Fixes: e92a4047419c ("regulator: Add QCOM SPMI regulator driver")
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/regulator/qcom_spmi-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 43f8f20b82e9..16c5f84e06a7 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -1085,6 +1085,8 @@ static struct regulator_ops spmi_vs_ops = {
 	.set_pull_down		= spmi_regulator_common_set_pull_down,
 	.set_soft_start		= spmi_regulator_common_set_soft_start,
 	.set_over_current_protection = spmi_regulator_vs_ocp,
+	.set_mode		= spmi_regulator_common_set_mode,
+	.get_mode		= spmi_regulator_common_get_mode,
 };
 
 static struct regulator_ops spmi_boost_ops = {
-- 
2.9.0.rc2.8.ga28705d
