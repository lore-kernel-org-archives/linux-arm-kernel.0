From: manjunath.hadli@ti.com (Manjunath Hadli)
Date: Tue, 13 Dec 2011 16:53:28 +0530
Subject: [PATCH v5 04/11] ARM: davinci: dm646x: remove the macros from the
 header to move to c file
In-Reply-To: <1323775415-24504-1-git-send-email-manjunath.hadli@ti.com>
References: <1323775415-24504-1-git-send-email-manjunath.hadli@ti.com>
Message-ID: <1323775415-24504-5-git-send-email-manjunath.hadli@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

move the register base addresses and offsets used only by dm646x
platform file from platform header dm646x.h to dm646x.c as they
are used only in the c file.

Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
---
 arch/arm/mach-davinci/dm646x.c              |    7 +++++++
 arch/arm/mach-davinci/include/mach/dm646x.h |    7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 0b68ed5..0560e82 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -46,6 +46,13 @@
 #define DM646X_REF_FREQ		27000000
 #define DM646X_AUX_FREQ		24000000
 
+#define DM646X_EMAC_BASE		0x01c80000
+#define DM646X_EMAC_MDIO_BASE		(DM646X_EMAC_BASE + 0x4000)
+#define DM646X_EMAC_CNTRL_OFFSET	0x0000
+#define DM646X_EMAC_CNTRL_MOD_OFFSET	0x1000
+#define DM646X_EMAC_CNTRL_RAM_OFFSET	0x2000
+#define DM646X_EMAC_CNTRL_RAM_SIZE	0x2000
+
 static struct pll_data pll1_data = {
 	.num       = 1,
 	.phys_base = DAVINCI_PLL1_BASE,
diff --git a/arch/arm/mach-davinci/include/mach/dm646x.h b/arch/arm/mach-davinci/include/mach/dm646x.h
index a8ee6c9..eb95864 100644
--- a/arch/arm/mach-davinci/include/mach/dm646x.h
+++ b/arch/arm/mach-davinci/include/mach/dm646x.h
@@ -18,13 +18,6 @@
 #include <linux/davinci_emac.h>
 #include <media/davinci/vpif_types.h>
 
-#define DM646X_EMAC_BASE		(0x01C80000)
-#define DM646X_EMAC_MDIO_BASE		(DM646X_EMAC_BASE + 0x4000)
-#define DM646X_EMAC_CNTRL_OFFSET	(0x0000)
-#define DM646X_EMAC_CNTRL_MOD_OFFSET	(0x1000)
-#define DM646X_EMAC_CNTRL_RAM_OFFSET	(0x2000)
-#define DM646X_EMAC_CNTRL_RAM_SIZE	(0x2000)
-
 #define DM646X_ASYNC_EMIF_CONTROL_BASE	0x20008000
 #define DM646X_ASYNC_EMIF_CS2_SPACE_BASE 0x42000000
 
-- 
1.6.2.4
