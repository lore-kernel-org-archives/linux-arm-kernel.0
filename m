From: manjunath.hadli@ti.com (Manjunath Hadli)
Date: Fri, 20 May 2011 19:38:17 +0530
Subject: [PATCH 1/4] davinci: dm644x: move EMAC definitions from dm644x.h to
	dm644x.c
Message-ID: <1305900497-3668-1-git-send-email-manjunath.hadli@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

move the register base addresses and offsets used only by dm644x
platform file from platform header dm644x.h to dm644x.c as they
are used only in the c file.

Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
---
 arch/arm/mach-davinci/dm644x.c              |   16 +++++++++++-----
 arch/arm/mach-davinci/include/mach/dm644x.h |    7 -------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 9a2376b..4fbb250 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -30,11 +30,6 @@
 #include "clock.h"
 #include "mux.h"
 
-/*
- * Device specific clocks
- */
-#define DM644X_REF_FREQ		27000000
-
 static struct pll_data pll1_data = {
 	.num       = 1,
 	.phys_base = DAVINCI_PLL1_BASE,
@@ -45,6 +40,8 @@ static struct pll_data pll2_data = {
 	.phys_base = DAVINCI_PLL2_BASE,
 };
 
+#define DM644X_REF_FREQ		27000000
+
 static struct clk ref_clk = {
 	.name = "ref_clk",
 	.rate = DM644X_REF_FREQ,
@@ -318,6 +315,11 @@ static struct clk_lookup dm644x_clks[] = {
 	CLK(NULL, NULL, NULL),
 };
 
+#define DM644X_EMAC_CNTRL_OFFSET	0x0000
+#define DM644X_EMAC_CNTRL_MOD_OFFSET	0x1000
+#define DM644X_EMAC_CNTRL_RAM_OFFSET	0x2000
+#define DM644X_EMAC_CNTRL_RAM_SIZE	0x2000
+
 static struct emac_platform_data dm644x_emac_pdata = {
 	.ctrl_reg_offset	= DM644X_EMAC_CNTRL_OFFSET,
 	.ctrl_mod_reg_offset	= DM644X_EMAC_CNTRL_MOD_OFFSET,
@@ -326,6 +328,8 @@ static struct emac_platform_data dm644x_emac_pdata = {
 	.version		= EMAC_VERSION_1,
 };
 
+#define DM644X_EMAC_BASE	0x01C80000
+
 static struct resource dm644x_emac_resources[] = {
 	{
 		.start	= DM644X_EMAC_BASE,
@@ -349,6 +353,8 @@ static struct platform_device dm644x_emac_device = {
        .resource	= dm644x_emac_resources,
 };
 
+#define DM644X_EMAC_MDIO_BASE	(DM644X_EMAC_BASE + 0x4000)
+
 static struct resource dm644x_mdio_resources[] = {
 	{
 		.start	= DM644X_EMAC_MDIO_BASE,
diff --git a/arch/arm/mach-davinci/include/mach/dm644x.h b/arch/arm/mach-davinci/include/mach/dm644x.h
index 5a1b26d..724377f 100644
--- a/arch/arm/mach-davinci/include/mach/dm644x.h
+++ b/arch/arm/mach-davinci/include/mach/dm644x.h
@@ -27,13 +27,6 @@
 #include <mach/asp.h>
 #include <media/davinci/vpfe_capture.h>
 
-#define DM644X_EMAC_BASE		(0x01C80000)
-#define DM644X_EMAC_MDIO_BASE		(DM644X_EMAC_BASE + 0x4000)
-#define DM644X_EMAC_CNTRL_OFFSET	(0x0000)
-#define DM644X_EMAC_CNTRL_MOD_OFFSET	(0x1000)
-#define DM644X_EMAC_CNTRL_RAM_OFFSET	(0x2000)
-#define DM644X_EMAC_CNTRL_RAM_SIZE	(0x2000)
-
 #define DM644X_ASYNC_EMIF_CONTROL_BASE	0x01E00000
 #define DM644X_ASYNC_EMIF_DATA_CE0_BASE 0x02000000
 #define DM644X_ASYNC_EMIF_DATA_CE1_BASE 0x04000000
-- 
1.6.2.4
