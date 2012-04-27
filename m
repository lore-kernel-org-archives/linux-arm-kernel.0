From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 27 Apr 2012 17:53:25 +0530
Subject: [PATCH] ARM: OMAP3: Fix CM register bit masks
Message-ID: <1335529405-14230-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The register bits for MPU_CLK_SRC and IVA2_CLK_SRC
in CM_CLKSEL1_PLL register are 3 bits wide.
Fix the MASK definition accordingly.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/cm-regbits-34xx.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index b912759..8083a8c 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -79,7 +79,7 @@
 
 /* CM_CLKSEL1_PLL_IVA2 */
 #define OMAP3430_IVA2_CLK_SRC_SHIFT			19
-#define OMAP3430_IVA2_CLK_SRC_MASK			(0x3 << 19)
+#define OMAP3430_IVA2_CLK_SRC_MASK			(0x7 << 19)
 #define OMAP3430_IVA2_DPLL_MULT_SHIFT			8
 #define OMAP3430_IVA2_DPLL_MULT_MASK			(0x7ff << 8)
 #define OMAP3430_IVA2_DPLL_DIV_SHIFT			0
@@ -124,7 +124,7 @@
 
 /* CM_CLKSEL1_PLL_MPU */
 #define OMAP3430_MPU_CLK_SRC_SHIFT			19
-#define OMAP3430_MPU_CLK_SRC_MASK			(0x3 << 19)
+#define OMAP3430_MPU_CLK_SRC_MASK			(0x7 << 19)
 #define OMAP3430_MPU_DPLL_MULT_SHIFT			8
 #define OMAP3430_MPU_DPLL_MULT_MASK			(0x7ff << 8)
 #define OMAP3430_MPU_DPLL_DIV_SHIFT			0
-- 
1.7.1
