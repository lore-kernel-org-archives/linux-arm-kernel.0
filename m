From: sassmann@kpanic.de (Stefan Assmann)
Date: Wed, 30 Jul 2014 16:02:28 +0200
Subject: [PATCH 1/2] mfd: twl-core: move TWL6030 defines to twl.h
In-Reply-To: <1406728949-7560-1-git-send-email-sassmann@kpanic.de>
References: <1406728949-7560-1-git-send-email-sassmann@kpanic.de>
Message-ID: <1406728949-7560-2-git-send-email-sassmann@kpanic.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These defines should be available to all drivers. Also added register
offset for CLK32KG_CFG_STATE and GRP defines.

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 drivers/regulator/twl-regulator.c | 11 -----------
 include/linux/i2c/twl.h           | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index fed28ab..ad0dd22 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -94,17 +94,6 @@ struct twlreg_info {
 #define VREG_BC_PROC		3
 #define VREG_BC_CLK_RST		4
 
-/* TWL6030 LDO register values for CFG_STATE */
-#define TWL6030_CFG_STATE_OFF	0x00
-#define TWL6030_CFG_STATE_ON	0x01
-#define TWL6030_CFG_STATE_OFF2	0x02
-#define TWL6030_CFG_STATE_SLEEP	0x03
-#define TWL6030_CFG_STATE_GRP_SHIFT	5
-#define TWL6030_CFG_STATE_APP_SHIFT	2
-#define TWL6030_CFG_STATE_APP_MASK	(0x03 << TWL6030_CFG_STATE_APP_SHIFT)
-#define TWL6030_CFG_STATE_APP(v)	(((v) & TWL6030_CFG_STATE_APP_MASK) >>\
-						TWL6030_CFG_STATE_APP_SHIFT)
-
 /* Flags for SMPS Voltage reading */
 #define SMPS_OFFSET_EN		BIT(0)
 #define SMPS_EXTENDED_EN	BIT(1)
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 8cfb50f..8ad63a2 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -127,6 +127,20 @@ enum twl6030_module_ids {
 #define REG_INT_MSK_STS_B		0x07
 #define REG_INT_MSK_STS_C		0x08
 
+/* TWL6030 register values for CFG_STATE */
+#define TWL6030_GRP_APP			(1 << 0)
+#define TWL6030_GRP_CON			(1 << 1)
+#define TWL6030_GRP_MOD			(1 << 2)
+#define TWL6030_CFG_STATE_OFF		0x00
+#define TWL6030_CFG_STATE_ON		0x01
+#define TWL6030_CFG_STATE_OFF2		0x02
+#define TWL6030_CFG_STATE_SLEEP		0x03
+#define TWL6030_CFG_STATE_GRP_SHIFT	5
+#define TWL6030_CFG_STATE_APP_SHIFT	2
+#define TWL6030_CFG_STATE_APP_MASK	(0x03 << TWL6030_CFG_STATE_APP_SHIFT)
+#define TWL6030_CFG_STATE_APP(v)	(((v) & TWL6030_CFG_STATE_APP_MASK) >>\
+						TWL6030_CFG_STATE_APP_SHIFT)
+
 /* MASK INT REG GROUP A */
 #define TWL6030_PWR_INT_MASK 		0x07
 #define TWL6030_RTC_INT_MASK 		0x18
@@ -470,6 +484,12 @@ static inline int twl6030_mmc_card_detect(struct device *dev, int slot)
 
 #define TWL4030_PM_MASTER_GLOBAL_TST		0xb6
 
+/*
+ * PM Receiver module register offsets (use TWL_MODULE_PM_RECEIVER)
+ */
+
+#define TWL6030_PM_RECEIVER_CLK32KG_CFG_STATE	0x8e
+
 /*----------------------------------------------------------------------*/
 
 /* Power bus message definitions */
-- 
1.9.3
