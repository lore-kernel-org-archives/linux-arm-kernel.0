From: richard.zhao@linaro.org (Richard Zhao)
Date: Wed, 4 Jan 2012 11:07:29 +0800
Subject: [PATCH v2 1/1] regulator: set constraints.apply_uV to 0 in
 of_get_fixed_voltage_config
In-Reply-To: <1325225213-29655-1-git-send-email-richard.zhao@linaro.org>
References: <1325225213-29655-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1325646449-21916-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix fixed regulator using DT failed to call regulator_register.

of_get_regulator_init_data set apply_uV to 1, but fixed regulator
doesn't need it. Set it back to 0.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 drivers/regulator/fixed.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 393f039..e24e3a1 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -69,6 +69,7 @@ of_get_fixed_voltage_config(struct device *dev)
 		return NULL;
 
 	init_data = config->init_data;
+	init_data->constraints.apply_uV = 0;
 
 	config->supply_name = init_data->constraints.name;
 	if (init_data->constraints.min_uV == init_data->constraints.max_uV) {
-- 
1.7.5.4
