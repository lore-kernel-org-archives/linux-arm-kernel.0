From: sundar.iyer@stericsson.com (Sundar Iyer)
Date: Wed, 1 Sep 2010 14:10:11 +0530
Subject: [PATCH v3] ux500: add ab8500-regulators machine specific data
Message-ID: <1283330411-3784-1-git-send-email-sundar.iyer@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sundar R Iyer <sundar.iyer@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-By: Bengt JONSSON <bengt.g.jonsson@stericsson.com>
Signed-off-by: Sundar R Iyer <sundar.iyer@stericsson.com>

v3: 
  - Empty the consumer supply definitions themselves
  - Change regulator permissions REGULATOR_CHANGE_VOLTAGE for fixed 
    supplies

v2:
  - Empty the regulator_consumer_supply since there is no actual
    device to supply

v1:
  - Removed NULL device reference

---
 arch/arm/mach-ux500/Makefile                  |    1 +
 arch/arm/mach-ux500/board-mop500-regulators.c |  143 +++++++++++++++++++++++++
 2 files changed, 144 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-mop500-regulators.c

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 0097318..ed180b8 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_MACH_U8500_MOP)	+= board-mop500.o board-mop500-sdi.o
 obj-$(CONFIG_MACH_U5500)	+= board-u5500.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
+obj-$(CONFIG_REGULATOR_AB8500)	+= board-mop500-regulators.o
diff --git a/arch/arm/mach-ux500/board-mop500-regulators.c b/arch/arm/mach-ux500/board-mop500-regulators.c
new file mode 100644
index 0000000..8fcd9bb
--- /dev/null
+++ b/arch/arm/mach-ux500/board-mop500-regulators.c
@@ -0,0 +1,143 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * License Terms: GNU General Public License v2
+ *
+ * Author: Sundar Iyer <sundar.iyer@stericsson.com>
+ *
+ * MOP500 board specific initialization for regulators
+ */
+#include <linux/kernel.h>
+#include <linux/regulator/machine.h>
+
+#define AB8500_VAUXN_LDO_MIN_VOLTAGE    (1100000)
+#define AB8500_VAUXN_LDO_MAX_VOLTAGE    (3300000)
+
+struct regulator_init_data ab8500_vaux1_regulator = {
+	.supply_regulator_dev = NULL,
+	.constraints = {
+		.name = "ab8500-vaux1",
+		.min_uV = AB8500_VAUXN_LDO_MIN_VOLTAGE,
+		.max_uV = AB8500_VAUXN_LDO_MAX_VOLTAGE,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE|
+					REGULATOR_CHANGE_STATUS,
+	},
+};
+
+struct regulator_init_data ab8500_vaux2_regulator = {
+	.supply_regulator_dev = NULL,
+	.constraints = {
+		.name = "ab8500-vaux2",
+		.min_uV = AB8500_VAUXN_LDO_MIN_VOLTAGE,
+		.max_uV = AB8500_VAUXN_LDO_MAX_VOLTAGE,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE|
+					REGULATOR_CHANGE_STATUS,
+	},
+};
+
+struct regulator_init_data ab8500_vaux3_regulator = {
+	.supply_regulator_dev = NULL,
+	.constraints = {
+		.name = "ab8500-vaux3",
+		.min_uV = AB8500_VAUXN_LDO_MIN_VOLTAGE,
+		.max_uV = AB8500_VAUXN_LDO_MAX_VOLTAGE,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE|
+					REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* supply for tvout, gpadc, TVOUT LDO */
+#define AB8500_VTVOUT_LDO_MIN_VOLTAGE        (1900000)
+#define AB8500_VTVOUT_LDO_MAX_VOLTAGE        (2100000)
+
+struct regulator_init_data ab8500_vtvout_init = {
+	.supply_regulator_dev = NULL,
+	.constraints = {
+		.name = "ab8500-vtvout",
+		.min_uV = AB8500_VTVOUT_LDO_MIN_VOLTAGE,
+		.max_uV = AB8500_VTVOUT_LDO_MAX_VOLTAGE,
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* supply for ab8500-vaudio, VAUDIO LDO */
+#define AB8500_VAUDIO_REGULATOR_MIN_VOLTAGE        (1925000)
+#define AB8500_VAUDIO_REGULATOR_MAX_VOLTAGE        (2075000)
+
+struct regulator_init_data ab8500_vaudio_init = {
+	.supply_regulator_dev = NULL,
+	.constraints = {
+		.name = "ab8500-vaudio",
+		.min_uV = AB8500_VAUDIO_REGULATOR_MIN_VOLTAGE,
+		.max_uV = AB8500_VAUDIO_REGULATOR_MAX_VOLTAGE,
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* supply for v-anamic1 VAMic1-LDO */
+#define AB8500_VAMIC1_REGULATOR_MIN_VOLTAGE        (2000000)
+#define AB8500_VAMIC1_REGULATOR_MAX_VOLTAGE        (2100000)
+
+struct regulator_init_data ab8500_vamic1_init = {
+	.supply_regulator_dev = NULL,
+	.constraints = {
+		.name = "ab8500-vamic1",
+		.min_uV = AB8500_VAMIC1_REGULATOR_MIN_VOLTAGE,
+		.max_uV = AB8500_VAMIC1_REGULATOR_MAX_VOLTAGE,
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* supply for v-amic2, VAMIC2 LDO, reuse constants for AMIC1 */
+struct regulator_init_data ab8500_vamic2_init = {
+	.supply_regulator_dev = NULL,
+	.constraints = {
+		.name = "ab8500-vamic2",
+		.min_uV = AB8500_VAMIC1_REGULATOR_MIN_VOLTAGE,
+		.max_uV = AB8500_VAMIC1_REGULATOR_MAX_VOLTAGE,
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* supply for v-dmic, VDMIC LDO */
+#define AB8500_VDMIC_REGULATOR_MIN_VOLTAGE      (1700000)
+#define AB8500_VDMIC_REGULATOR_MAX_VOLTAGE      (1950000)
+
+struct regulator_init_data ab8500_vdmic_init = {
+	.supply_regulator_dev = NULL,
+	.constraints = {
+		.name = "ab8500-vdmic",
+		.min_uV = AB8500_VDMIC_REGULATOR_MIN_VOLTAGE,
+		.max_uV = AB8500_VDMIC_REGULATOR_MAX_VOLTAGE,
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* supply for v-intcore12, VINTCORE12 LDO */
+#define AB8500_VINTCORE_REGULATOR_MIN_VOLTAGE      (1200000)
+#define AB8500_VINTCORE_REGULATOR_MAX_VOLTAGE      (1350000)
+
+struct regulator_init_data ab8500_vintcore_init = {
+	.supply_regulator_dev = NULL,
+	.constraints = {
+		.name = "ab8500-vintcore",
+		.min_uV = AB8500_VINTCORE_REGULATOR_MIN_VOLTAGE,
+		.max_uV = AB8500_VINTCORE_REGULATOR_MAX_VOLTAGE,
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* supply for U8500 CSI/DSI, VANA LDO */
+#define AB8500_VANA_REGULATOR_MIN_VOLTAGE      (0)
+#define AB8500_VANA_REGULATOR_MAX_VOLTAGE      (1200000)
+
+struct regulator_init_data ab8500_vana_init = {
+	.supply_regulator_dev = NULL,
+	.constraints = {
+		.name = "ab8500-vana",
+		.min_uV = AB8500_VANA_REGULATOR_MIN_VOLTAGE,
+		.max_uV = AB8500_VANA_REGULATOR_MAX_VOLTAGE,
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
+
-- 
1.7.2.dirty
