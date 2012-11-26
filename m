From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Mon, 26 Nov 2012 14:43:55 +0530
Subject: [PATCH] i2c: omap: Remove the OMAP_I2C_FLAG_RESET_REGS_POSTIDLE flag
Message-ID: <1353921235-22408-1-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OMAP_I2C_FLAG_RESET_REGS_POSTIDLE is not used anymore
in the i2c driver. Remove the flag.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
Has dependency on the below patch
http://git.pengutronix.de/?p=wsa/linux.git;a=commitdiff;h=554c96744afd169886bd6fc2736fb0d9aaf634e8

 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    3 +--
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 +--
 drivers/i2c/busses/i2c-omap.c              |    3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 943222c4..3dd9e69 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -791,8 +791,7 @@ static struct omap_hwmod omap3xxx_dss_venc_hwmod = {
 /* I2C1 */
 static struct omap_i2c_dev_attr i2c1_dev_attr = {
 	.fifo_depth	= 8, /* bytes */
-	.flags		= OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
-			  OMAP_I2C_FLAG_BUS_SHIFT_2,
+	.flags		= OMAP_I2C_FLAG_BUS_SHIFT_2,
 };
 
 static struct omap_hwmod omap3xxx_i2c1_hwmod = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 0b1249e..1afab5f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1527,8 +1527,7 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
 };
 
 static struct omap_i2c_dev_attr i2c_dev_attr = {
-	.flags	= OMAP_I2C_FLAG_BUS_SHIFT_NONE |
-			OMAP_I2C_FLAG_RESET_REGS_POSTIDLE,
+	.flags	= OMAP_I2C_FLAG_BUS_SHIFT_NONE,
 };
 
 /* i2c1 */
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 872444a..d3b853b 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1034,8 +1034,7 @@ static const struct i2c_algorithm omap_i2c_algo = {
 #ifdef CONFIG_OF
 static struct omap_i2c_bus_platform_data omap3_pdata = {
 	.rev = OMAP_I2C_IP_VERSION_1,
-	.flags = OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
-		 OMAP_I2C_FLAG_BUS_SHIFT_2,
+	.flags = OMAP_I2C_FLAG_BUS_SHIFT_2,
 };
 
 static struct omap_i2c_bus_platform_data omap4_pdata = {
-- 
1.7.5.4
