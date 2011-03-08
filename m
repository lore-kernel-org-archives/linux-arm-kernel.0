From: andy@warmcat.com (Andy Green)
Date: Tue, 8 Mar 2011 11:09:12 +0000
Subject: [PATCH] OMAP2+: hwmod data: add correct functionality flags to all omap2plus i2c dev_attr
Message-ID: <mailman.166.1299685429.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the new functionality flags for OMAP i2c unit to all OMAP2+
hwmod definitions.

Cc: patches at linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
[b-cousson at ti.com: Move dev_attr to stick to
hwmod template, update the subject]
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    7 ++++++-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    3 +++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    9 +++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   10 ++++++++++
 4 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index de92d75..fe70365 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -1450,7 +1450,12 @@ static struct omap_hwmod_class i2c_class = {
 	.rev		= OMAP_I2C_IP_VERSION_1,
 };
 
-static struct omap_i2c_dev_attr i2c_dev_attr;
+static struct omap_i2c_dev_attr i2c_dev_attr = {
+	.flags		= OMAP_I2C_FLAG_NO_FIFO |
+			  OMAP_I2C_FLAG_SIMPLE_CLOCK |
+			  OMAP_I2C_FLAG_16BIT_DATA_REG |
+			  OMAP_I2C_FLAG_BUS_SHIFT_2,
+};
 
 /* I2C1 */
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index d737b99..a30b100 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -1527,6 +1527,9 @@ static struct omap_hwmod_class i2c_class = {
 
 static struct omap_i2c_dev_attr i2c_dev_attr = {
 	.fifo_depth	= 8, /* bytes */
+	.flags		= OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
+			  OMAP_I2C_FLAG_BUS_SHIFT_2 |
+			  OMAP_I2C_FLAG_FORCE_19200_INT_CLK,
 };
 
 /* I2C1 */
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 324162d..f804e78 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1876,6 +1876,9 @@ static struct omap_hwmod omap3xxx_dss_venc_hwmod = {
 
 static struct omap_i2c_dev_attr i2c1_dev_attr = {
 	.fifo_depth	= 8, /* bytes */
+	.flags = OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
+		 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
+		 OMAP_I2C_FLAG_BUS_SHIFT_2,
 };
 
 static struct omap_hwmod_irq_info i2c1_mpu_irqs[] = {
@@ -1919,6 +1922,9 @@ static struct omap_hwmod omap3xxx_i2c1_hwmod = {
 
 static struct omap_i2c_dev_attr i2c2_dev_attr = {
 	.fifo_depth	= 8, /* bytes */
+	.flags = OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
+		 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
+		 OMAP_I2C_FLAG_BUS_SHIFT_2,
 };
 
 static struct omap_hwmod_irq_info i2c2_mpu_irqs[] = {
@@ -1962,6 +1968,9 @@ static struct omap_hwmod omap3xxx_i2c2_hwmod = {
 
 static struct omap_i2c_dev_attr i2c3_dev_attr = {
 	.fifo_depth	= 64, /* bytes */
+	.flags = OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
+		 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
+		 OMAP_I2C_FLAG_BUS_SHIFT_2,
 };
 
 static struct omap_hwmod_irq_info i2c3_mpu_irqs[] = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 5d3f684..c2edb21 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -27,6 +27,7 @@
 #include <plat/mcspi.h>
 #include <plat/mcbsp.h>
 #include <plat/mmc.h>
+#include <plat/i2c.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -2090,6 +2091,11 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
 	.rev	= OMAP_I2C_IP_VERSION_2,
 };
 
+/* i2c dev_attr */
+static struct omap_i2c_dev_attr i2c_dev_attr = {
+	.flags	= OMAP_I2C_FLAG_BUS_SHIFT_NONE,
+};
+
 /* i2c1 */
 static struct omap_hwmod omap44xx_i2c1_hwmod;
 static struct omap_hwmod_irq_info omap44xx_i2c1_irqs[] = {
@@ -2138,6 +2144,7 @@ static struct omap_hwmod omap44xx_i2c1_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_I2C1_CLKCTRL,
 		},
 	},
+	.dev_attr	= &i2c_dev_attr,
 	.slaves		= omap44xx_i2c1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c1_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -2191,6 +2198,7 @@ static struct omap_hwmod omap44xx_i2c2_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_I2C2_CLKCTRL,
 		},
 	},
+	.dev_attr	= &i2c_dev_attr,
 	.slaves		= omap44xx_i2c2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c2_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -2244,6 +2252,7 @@ static struct omap_hwmod omap44xx_i2c3_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_I2C3_CLKCTRL,
 		},
 	},
+	.dev_attr	= &i2c_dev_attr,
 	.slaves		= omap44xx_i2c3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c3_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -2297,6 +2306,7 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_I2C4_CLKCTRL,
 		},
 	},
+	.dev_attr	= &i2c_dev_attr,
 	.slaves		= omap44xx_i2c4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c4_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-- 
1.7.0.4
