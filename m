From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  4 Nov 2011 16:57:36 +0000
Subject: [PATCH v3 02/17] ARM: mxc: rename gic_handle_irq to avoid name clash
In-Reply-To: <1320425871-30564-1-git-send-email-marc.zyngier@arm.com>
References: <1320425871-30564-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1320425871-30564-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before introducing a global gic_handle_irq(), rename
MXC's version to mcx_gic_handle_irq(). This function will be
removed altogether in a later patch.

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/plat-mxc/gic.c                 |    2 +-
 arch/arm/plat-mxc/include/mach/common.h |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-mxc/gic.c b/arch/arm/plat-mxc/gic.c
index 12f8f81..ea51ea4 100644
--- a/arch/arm/plat-mxc/gic.c
+++ b/arch/arm/plat-mxc/gic.c
@@ -18,7 +18,7 @@
 #include <asm/smp.h>
 #endif
 
-asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
+asmlinkage void __exception_irq_entry mxc_gic_handle_irq(struct pt_regs *regs)
 {
 	u32 irqstat, irqnr;
 
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 83b745a..f6c13ab 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -90,7 +90,7 @@ extern void imx_print_silicon_rev(const char *cpu, int srev);
 
 void avic_handle_irq(struct pt_regs *);
 void tzic_handle_irq(struct pt_regs *);
-void gic_handle_irq(struct pt_regs *);
+void mxc_gic_handle_irq(struct pt_regs *);
 
 #define imx1_handle_irq avic_handle_irq
 #define imx21_handle_irq avic_handle_irq
@@ -101,7 +101,7 @@ void gic_handle_irq(struct pt_regs *);
 #define imx50_handle_irq tzic_handle_irq
 #define imx51_handle_irq tzic_handle_irq
 #define imx53_handle_irq tzic_handle_irq
-#define imx6q_handle_irq gic_handle_irq
+#define imx6q_handle_irq mcx_gic_handle_irq
 
 extern void imx_enable_cpu(int cpu, bool enable);
 extern void imx_set_cpu_jump(int cpu, void *jump_addr);
-- 
1.7.0.4
