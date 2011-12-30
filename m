From: richard.zhao@linaro.org (Richard Zhao)
Date: Fri, 30 Dec 2011 14:06:53 +0800
Subject: [PATCH 1/1] regulator/fixed: set constraints.apply_uV to 0
Message-ID: <1325225213-29655-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Zhao <richard.zhao@freescale.com>

Fix fixed regulator failed to call regulator_register.

Fixed regulator does not support set voltage operation, so we
don't need apply_uV.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 drivers/regulator/fixed.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index a44a017..fa0c426 100644
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
