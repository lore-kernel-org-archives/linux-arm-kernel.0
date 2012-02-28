From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 28 Feb 2012 15:09:13 +0530
Subject: [PATCH 4/4] MFD: twl-core: regulator configuration for twl6030 V1V8,
 V2V1 SMPS
In-Reply-To: <1330421953-29517-1-git-send-email-rnayak@ti.com>
References: <1330421953-29517-1-git-send-email-rnayak@ti.com>
Message-ID: <1330421953-29517-5-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

To be able to attach consumers to these supplies from board
files we need to have regulator_init_data for them.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/mfd/twl-core.c  |   10 ++++++++++
 include/linux/i2c/twl.h |    2 ++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index e1d3a64..6cb1061 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -966,6 +966,16 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 		if (IS_ERR(child))
 			return PTR_ERR(child);
 
+		child = add_regulator(TWL6030_REG_V1V8, pdata->v1v8,
+					features);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator(TWL6030_REG_V2V1, pdata->v2v1,
+					features);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
 		child = add_regulator(TWL6030_REG_VMMC, pdata->vmmc,
 					features);
 		if (IS_ERR(child))
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index f66c031..7fcab23 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -734,6 +734,8 @@ struct twl4030_platform_data {
 	struct regulator_init_data              *vcxio;
 	struct regulator_init_data              *vusb;
 	struct regulator_init_data		*clk32kg;
+	struct regulator_init_data              *v1v8;
+	struct regulator_init_data              *v2v1;
 	/* TWL6025 LDO regulators */
 	struct regulator_init_data		*ldo1;
 	struct regulator_init_data		*ldo2;
-- 
1.7.1
