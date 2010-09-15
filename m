From: sundar.iyer@stericsson.com (Sundar Iyer)
Date: Wed, 15 Sep 2010 14:24:30 +0530
Subject: [PATCH v5] ux500: add ab8500-regulators machine specific data
Message-ID: <1284540870-8238-1-git-send-email-sundar.iyer@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sundar R Iyer <sundar.iyer@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Bengt JONSSON <bengt.g.jonsson@stericsson.com>
Signed-off-by: Sundar R Iyer <sundar.iyer@stericsson.com>
---
Thanx a bunch to Mark for being so persistent and helpful :)

v5:
 - corrected the voltage regulator names as suggested by Mark
 - corrcted the voltage ranges for the approproate regulators

v4:
 - make all structs as static
 - remove NULL initialization

v3:
 - Empty the consumer supply definitions themselves
 - Change regulator permissions REGULATOR_CHANGE_VOLTAGE for fixed
  supplies

v2:
 - Empty the regulator_consumer_supply since there is no actual
  device to supply

v1:
 - Removed NULL device reference

 arch/arm/mach-ux500/Makefile                  |    1 +
 arch/arm/mach-ux500/board-mop500-regulators.c |  101 +++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-mop500-regulators.c

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index bb3e74e..46dbaf6 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_MACH_U5500)	+= board-u5500.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
+obj-$(CONFIG_REGULATOR_AB8500)	+= board-mop500-regulators.o
diff --git a/arch/arm/mach-ux500/board-mop500-regulators.c b/arch/arm/mach-ux500/board-mop500-regulators.c
new file mode 100644
index 0000000..1187f1f
--- /dev/null
+++ b/arch/arm/mach-ux500/board-mop500-regulators.c
@@ -0,0 +1,101 @@
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
+/* supplies to the display/camera */
+static struct regulator_init_data ab8500_vaux1_regulator = {
+	.constraints = {
+		.name = "V-DISPLAY",
+		.min_uV = 2500000,
+		.max_uV = 2900000,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE|
+					REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* supplies to the on-board eMMC */
+static struct regulator_init_data ab8500_vaux2_regulator = {
+	.constraints = {
+		.name = "V-eMMC1",
+		.min_uV = 1100000,
+		.max_uV = 3300000,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE|
+					REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* supply for VAUX3, supplies to SDcard slots */
+static struct regulator_init_data ab8500_vaux3_regulator = {
+	.constraints = {
+		.name = "V-MMC-SD",
+		.min_uV = 1100000,
+		.max_uV = 3300000,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE|
+					REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* supply for tvout, gpadc, TVOUT LDO */
+static struct regulator_init_data ab8500_vtvout_init = {
+	.constraints = {
+		.name = "V-TVOUT",
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* supply for ab8500-vaudio, VAUDIO LDO */
+static struct regulator_init_data ab8500_vaudio_init = {
+	.constraints = {
+		.name = "V-AUD",
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* supply for v-anamic1 VAMic1-LDO */
+static struct regulator_init_data ab8500_vamic1_init = {
+	.constraints = {
+		.name = "V-AMIC1",
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* supply for v-amic2, VAMIC2 LDO, reuse constants for AMIC1 */
+static struct regulator_init_data ab8500_vamic2_init = {
+	.constraints = {
+		.name = "V-AMIC2",
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* supply for v-dmic, VDMIC LDO */
+static struct regulator_init_data ab8500_vdmic_init = {
+	.constraints = {
+		.name = "V-DMIC",
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* supply for v-intcore12, VINTCORE12 LDO */
+static struct regulator_init_data ab8500_vintcore_init = {
+	.constraints = {
+		.name = "V-INTCORE",
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* supply for U8500 CSI/DSI, VANA LDO */
+static struct regulator_init_data ab8500_vana_init = {
+	.constraints = {
+		.name = "V-CSI/DSI",
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
+
-- 
1.7.2.dirty
