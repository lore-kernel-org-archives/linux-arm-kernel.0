From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 2 Jul 2014 11:47:38 +0300
Subject: [PATCH 04/13] ARM: OMAP4+: dpll44xx: remove cm-regbits-44xx.h and
 clock44xx.h includes
In-Reply-To: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
References: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
Message-ID: <1404290867-6768-5-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead, copy the used bitfield definitions to the source file. Done in
preparation to migrate the clock implementation under clock driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/dpll44xx.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/dpll44xx.c b/arch/arm/mach-omap2/dpll44xx.c
index b071891..4613f1e 100644
--- a/arch/arm/mach-omap2/dpll44xx.c
+++ b/arch/arm/mach-omap2/dpll44xx.c
@@ -16,8 +16,6 @@
 #include <linux/bitops.h>
 
 #include "clock.h"
-#include "clock44xx.h"
-#include "cm-regbits-44xx.h"
 
 /*
  * Maximum DPLL input frequency (FINT) and output frequency (FOUT) that
@@ -28,6 +26,16 @@
 #define OMAP4_DPLL_LP_FINT_MAX	1000000
 #define OMAP4_DPLL_LP_FOUT_MAX	100000000
 
+/*
+ * Bitfield declarations
+ */
+#define OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK		(1 << 8)
+#define OMAP4430_DPLL_CLKOUTX2_GATE_CTRL_MASK		(1 << 10)
+#define OMAP4430_DPLL_REGM4XEN_MASK			(1 << 11)
+
+/* Static rate multiplier for OMAP4 REGM4XEN clocks */
+#define OMAP4430_REGM4XEN_MULT				4
+
 /* Supported only on OMAP4 */
 int omap4_dpllmx_gatectrl_read(struct clk_hw_omap *clk)
 {
-- 
1.7.9.5
