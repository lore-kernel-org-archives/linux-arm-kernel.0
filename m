From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Apr 2012 17:28:08 +0200
Subject: [PATCH 18/33] ARM i.MX3: Make ccm base address a variable
In-Reply-To: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
References: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1335367703-19929-19-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of having a cpu_is_* in each ccm register access it
is more efficient to make it a variable.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/crmregs-imx3.h |   79 +++++++++++++++++++-------------------
 arch/arm/mach-imx/mm-imx3.c      |    6 +++
 arch/arm/mach-imx/pm-imx3.c      |    4 +-
 3 files changed, 47 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-imx/crmregs-imx3.h b/arch/arm/mach-imx/crmregs-imx3.h
index 5314127..a1dfde5 100644
--- a/arch/arm/mach-imx/crmregs-imx3.h
+++ b/arch/arm/mach-imx/crmregs-imx3.h
@@ -24,48 +24,47 @@
 #define CKIH_CLK_FREQ_27MHZ     27000000
 #define CKIL_CLK_FREQ           32768
 
-#define MXC_CCM_BASE		(cpu_is_mx31() ? \
-MX31_IO_ADDRESS(MX31_CCM_BASE_ADDR) : MX35_IO_ADDRESS(MX35_CCM_BASE_ADDR))
+extern void __iomem *mx3_ccm_base;
 
 /* Register addresses */
-#define MXC_CCM_CCMR		(MXC_CCM_BASE + 0x00)
-#define MXC_CCM_PDR0		(MXC_CCM_BASE + 0x04)
-#define MXC_CCM_PDR1		(MXC_CCM_BASE + 0x08)
-#define MX35_CCM_PDR2		(MXC_CCM_BASE + 0x0C)
-#define MXC_CCM_RCSR		(MXC_CCM_BASE + 0x0C)
-#define MX35_CCM_PDR3		(MXC_CCM_BASE + 0x10)
-#define MXC_CCM_MPCTL		(MXC_CCM_BASE + 0x10)
-#define MX35_CCM_PDR4		(MXC_CCM_BASE + 0x14)
-#define MXC_CCM_UPCTL		(MXC_CCM_BASE + 0x14)
-#define MX35_CCM_RCSR		(MXC_CCM_BASE + 0x18)
-#define MXC_CCM_SRPCTL		(MXC_CCM_BASE + 0x18)
-#define MX35_CCM_MPCTL		(MXC_CCM_BASE + 0x1C)
-#define MXC_CCM_COSR		(MXC_CCM_BASE + 0x1C)
-#define MX35_CCM_PPCTL		(MXC_CCM_BASE + 0x20)
-#define MXC_CCM_CGR0		(MXC_CCM_BASE + 0x20)
-#define MX35_CCM_ACMR		(MXC_CCM_BASE + 0x24)
-#define MXC_CCM_CGR1		(MXC_CCM_BASE + 0x24)
-#define MX35_CCM_COSR		(MXC_CCM_BASE + 0x28)
-#define MXC_CCM_CGR2		(MXC_CCM_BASE + 0x28)
-#define MX35_CCM_CGR0		(MXC_CCM_BASE + 0x2C)
-#define MXC_CCM_WIMR		(MXC_CCM_BASE + 0x2C)
-#define MX35_CCM_CGR1		(MXC_CCM_BASE + 0x30)
-#define MXC_CCM_LDC		(MXC_CCM_BASE + 0x30)
-#define MX35_CCM_CGR2		(MXC_CCM_BASE + 0x34)
-#define MXC_CCM_DCVR0		(MXC_CCM_BASE + 0x34)
-#define MX35_CCM_CGR3		(MXC_CCM_BASE + 0x38)
-#define MXC_CCM_DCVR1		(MXC_CCM_BASE + 0x38)
-#define MXC_CCM_DCVR2		(MXC_CCM_BASE + 0x3C)
-#define MXC_CCM_DCVR3		(MXC_CCM_BASE + 0x40)
-#define MXC_CCM_LTR0		(MXC_CCM_BASE + 0x44)
-#define MXC_CCM_LTR1		(MXC_CCM_BASE + 0x48)
-#define MXC_CCM_LTR2		(MXC_CCM_BASE + 0x4C)
-#define MXC_CCM_LTR3		(MXC_CCM_BASE + 0x50)
-#define MXC_CCM_LTBR0		(MXC_CCM_BASE + 0x54)
-#define MXC_CCM_LTBR1		(MXC_CCM_BASE + 0x58)
-#define MXC_CCM_PMCR0		(MXC_CCM_BASE + 0x5C)
-#define MXC_CCM_PMCR1		(MXC_CCM_BASE + 0x60)
-#define MXC_CCM_PDR2		(MXC_CCM_BASE + 0x64)
+#define MXC_CCM_CCMR		0x00
+#define MXC_CCM_PDR0		0x04
+#define MXC_CCM_PDR1		0x08
+#define MX35_CCM_PDR2		0x0C
+#define MXC_CCM_RCSR		0x0C
+#define MX35_CCM_PDR3		0x10
+#define MXC_CCM_MPCTL		0x10
+#define MX35_CCM_PDR4		0x14
+#define MXC_CCM_UPCTL		0x14
+#define MX35_CCM_RCSR		0x18
+#define MXC_CCM_SRPCTL		0x18
+#define MX35_CCM_MPCTL		0x1C
+#define MXC_CCM_COSR		0x1C
+#define MX35_CCM_PPCTL		0x20
+#define MXC_CCM_CGR0		0x20
+#define MX35_CCM_ACMR		0x24
+#define MXC_CCM_CGR1		0x24
+#define MX35_CCM_COSR		0x28
+#define MXC_CCM_CGR2		0x28
+#define MX35_CCM_CGR0		0x2C
+#define MXC_CCM_WIMR		0x2C
+#define MX35_CCM_CGR1		0x30
+#define MXC_CCM_LDC		0x30
+#define MX35_CCM_CGR2		0x34
+#define MXC_CCM_DCVR0		0x34
+#define MX35_CCM_CGR3		0x38
+#define MXC_CCM_DCVR1		0x38
+#define MXC_CCM_DCVR2		0x3C
+#define MXC_CCM_DCVR3		0x40
+#define MXC_CCM_LTR0		0x44
+#define MXC_CCM_LTR1		0x48
+#define MXC_CCM_LTR2		0x4C
+#define MXC_CCM_LTR3		0x50
+#define MXC_CCM_LTBR0		0x54
+#define MXC_CCM_LTBR1		0x58
+#define MXC_CCM_PMCR0		0x5C
+#define MXC_CCM_PMCR1		0x60
+#define MXC_CCM_PDR2		0x64
 
 /* Register bit definitions */
 #define MXC_CCM_CCMR_WBEN                       (1 << 27)
diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 7412738..57b39f8 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -31,6 +31,10 @@
 #include <mach/iomux-v3.h>
 #include <mach/irqs.h>
 
+#include "crmregs-imx3.h"
+
+void __iomem *mx3_ccm_base;
+
 static void imx3_idle(void)
 {
 	unsigned long reg = 0;
@@ -137,6 +141,7 @@ void __init imx31_init_early(void)
 	mxc_arch_reset_init(MX31_IO_ADDRESS(MX31_WDOG_BASE_ADDR));
 	arch_ioremap_caller = imx3_ioremap_caller;
 	arm_pm_idle = imx3_idle;
+	mx3_ccm_base = MX31_IO_ADDRESS(MX31_CCM_BASE_ADDR);
 }
 
 void __init mx31_init_irq(void)
@@ -210,6 +215,7 @@ void __init imx35_init_early(void)
 	mxc_arch_reset_init(MX35_IO_ADDRESS(MX35_WDOG_BASE_ADDR));
 	arm_pm_idle = imx3_idle;
 	arch_ioremap_caller = imx3_ioremap_caller;
+	mx3_ccm_base = MX35_IO_ADDRESS(MX35_CCM_BASE_ADDR);
 }
 
 void __init mx35_init_irq(void)
diff --git a/arch/arm/mach-imx/pm-imx3.c b/arch/arm/mach-imx/pm-imx3.c
index b375243..822103b 100644
--- a/arch/arm/mach-imx/pm-imx3.c
+++ b/arch/arm/mach-imx/pm-imx3.c
@@ -21,14 +21,14 @@
  */
 void mx3_cpu_lp_set(enum mx3_cpu_pwr_mode mode)
 {
-	int reg = __raw_readl(MXC_CCM_CCMR);
+	int reg = __raw_readl(mx3_ccm_base + MXC_CCM_CCMR);
 	reg &= ~MXC_CCM_CCMR_LPM_MASK;
 
 	switch (mode) {
 	case MX3_WAIT:
 		if (cpu_is_mx35())
 			reg |= MXC_CCM_CCMR_LPM_WAIT_MX35;
-		__raw_writel(reg, MXC_CCM_CCMR);
+		__raw_writel(reg, mx3_ccm_base + MXC_CCM_CCMR);
 		break;
 	default:
 		pr_err("Unknown cpu power mode: %d\n", mode);
-- 
1.7.10
