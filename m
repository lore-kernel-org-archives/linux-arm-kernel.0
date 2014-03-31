From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 31 Mar 2014 18:15:53 +0300
Subject: [PATCH 14/55] ARM: OMAP2: CM: remove references to cm-regbits-24xx.h
 from CM core code
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Message-ID: <1396278994-12624-15-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Done in preparation to make CM a standalone driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm2xxx.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
index 4c29f63..e74484a 100644
--- a/arch/arm/mach-omap2/cm2xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx.c
@@ -22,7 +22,6 @@
 #include "cm.h"
 #include "cm2xxx_3xxx_private.h"
 #include "cm2xxx.h"
-#include "cm-regbits-24xx.h"
 #include "clockdomain.h"
 
 /* CM_AUTOIDLE_PLL.AUTO_* bit values for DPLLs */
@@ -36,6 +35,24 @@
 /* CM_IDLEST_PLL bit value offset for APLLs (OMAP2xxx only) */
 #define EN_APLL_LOCKED					3
 
+#define OMAP24XX_CLKSTCTRL_DISABLE_AUTO			0x0
+#define OMAP24XX_CLKSTCTRL_ENABLE_AUTO			0x1
+
+#define OMAP24XX_CORE_CLK_SRC_MASK			(0x3 << 0)
+
+#define OMAP24XX_EN_54M_PLL_SHIFT			6
+#define OMAP24XX_EN_96M_PLL_SHIFT			2
+#define OMAP24XX_ST_54M_APLL_SHIFT			9
+#define OMAP24XX_ST_96M_APLL_SHIFT			8
+#define OMAP24XX_AUTO_54M_MASK				(0x3 << 6)
+#define OMAP24XX_AUTO_96M_MASK				(0x3 << 2)
+#define OMAP24XX_AUTO_DPLL_SHIFT			0
+#define OMAP24XX_AUTO_DPLL_MASK				(0x3 << 0)
+
+#define OMAP24XX_EN_DSS1_MASK				(1 << 0)
+
+#define OMAP24XX_CLKSEL_DSS2_MASK			(0x1 << 13)
+
 static const u8 omap2xxx_cm_idlest_offs[] = {
 	CM_IDLEST1, CM_IDLEST2, OMAP2430_CM_IDLEST3, OMAP24XX_CM_IDLEST4
 };
-- 
1.7.9.5
