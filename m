From: eric.miao@canonical.com (Eric Miao)
Date: Tue, 13 Jul 2010 23:33:26 +0800
Subject: [PATCH 11/13] [ARM] Introduce ARCH_HAS_DISABLE_FIQ and remove most
	disable_fiq
In-Reply-To: <1279035208-7249-1-git-send-email-eric.miao@canonical.com>
References: <1279035208-7249-1-git-send-email-eric.miao@canonical.com>
Message-ID: <1279035208-7249-12-git-send-email-eric.miao@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/Kconfig                                   |    4 ++++
 arch/arm/include/asm/entry-macro-vic2.S            |    3 ---
 arch/arm/kernel/entry-armv.S                       |    2 ++
 arch/arm/mach-aaec2000/include/mach/entry-macro.S  |    3 ---
 arch/arm/mach-at91/include/mach/entry-macro.S      |    3 ---
 arch/arm/mach-bcmring/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-clps711x/include/mach/entry-macro.S  |    3 ---
 arch/arm/mach-cns3xxx/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-davinci/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-dove/include/mach/entry-macro.S      |    3 ---
 arch/arm/mach-ebsa110/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-ep93xx/include/mach/entry-macro.S    |    3 ---
 .../arm/mach-footbridge/include/mach/entry-macro.S |    3 ---
 arch/arm/mach-gemini/include/mach/entry-macro.S    |    3 ---
 arch/arm/mach-h720x/include/mach/entry-macro.S     |    3 ---
 .../arm/mach-integrator/include/mach/entry-macro.S |    3 ---
 arch/arm/mach-iop13xx/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-iop32x/include/mach/entry-macro.S    |    3 ---
 arch/arm/mach-iop33x/include/mach/entry-macro.S    |    3 ---
 arch/arm/mach-ixp2000/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-ixp23xx/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-ixp4xx/include/mach/entry-macro.S    |    3 ---
 arch/arm/mach-kirkwood/include/mach/entry-macro.S  |    3 ---
 arch/arm/mach-ks8695/include/mach/entry-macro.S    |    3 ---
 arch/arm/mach-l7200/include/mach/entry-macro.S     |    3 ---
 arch/arm/mach-lh7a40x/include/mach/entry-macro.S   |    9 ---------
 arch/arm/mach-loki/include/mach/entry-macro.S      |    3 ---
 arch/arm/mach-mmp/include/mach/entry-macro.S       |    3 ---
 arch/arm/mach-msm/include/mach/entry-macro.S       |    3 ---
 arch/arm/mach-mv78xx0/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-netx/include/mach/entry-macro.S      |    3 ---
 arch/arm/mach-nomadik/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-ns9xxx/include/mach/entry-macro.S    |    2 --
 arch/arm/mach-nuc93x/include/mach/entry-macro.S    |    5 -----
 arch/arm/mach-omap1/include/mach/entry-macro.S     |    3 ---
 arch/arm/mach-omap2/include/mach/entry-macro.S     |    3 ---
 arch/arm/mach-orion5x/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-pnx4008/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-pxa/include/mach/entry-macro.S       |    3 ---
 arch/arm/mach-realview/include/mach/entry-macro.S  |    3 ---
 arch/arm/mach-s3c2410/include/mach/entry-macro.S   |    5 -----
 arch/arm/mach-s5p6442/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-s5pc100/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-s5pv210/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-sa1100/include/mach/entry-macro.S    |    3 ---
 arch/arm/mach-shark/include/mach/entry-macro.S     |    3 ---
 arch/arm/mach-shmobile/include/mach/entry-macro.S  |    3 ---
 arch/arm/mach-spear3xx/include/mach/entry-macro.S  |    3 ---
 arch/arm/mach-spear6xx/include/mach/entry-macro.S  |    3 ---
 arch/arm/mach-stmp378x/include/mach/entry-macro.S  |    3 ---
 arch/arm/mach-stmp37xx/include/mach/entry-macro.S  |    3 ---
 arch/arm/mach-u300/include/mach/entry-macro.S      |    3 ---
 arch/arm/mach-ux500/include/mach/entry-macro.S     |    3 ---
 arch/arm/mach-versatile/include/mach/entry-macro.S |    3 ---
 arch/arm/mach-vexpress/include/mach/entry-macro.S  |    3 ---
 arch/arm/mach-w90x900/include/mach/entry-macro.S   |    5 -----
 arch/arm/plat-mxc/include/mach/entry-macro.S       |    3 ---
 57 files changed, 6 insertions(+), 176 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 57180ae..7da1979 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -157,6 +157,9 @@ config ARCH_HAS_CPUFREQ
 	  and that the relevant menu configurations are displayed for
 	  it.
 
+config ARCH_HAS_DISABLE_FIQ
+	def_bool n
+
 config GENERIC_HWEIGHT
 	bool
 	default y
@@ -619,6 +622,7 @@ config ARCH_RPC
 	select NO_IOPORT
 	select ARCH_SPARSEMEM_ENABLE
 	select ARCH_USES_GETTIMEOFFSET
+	select ARCH_HAS_DISABLE_FIQ
 	help
 	  On the Acorn Risc-PC, Linux can support the internal IDE disk and
 	  CD-ROM interface, serial and parallel port, and the floppy drive.
diff --git a/arch/arm/include/asm/entry-macro-vic2.S b/arch/arm/include/asm/entry-macro-vic2.S
index 3ceb85e..2077314 100644
--- a/arch/arm/include/asm/entry-macro-vic2.S
+++ b/arch/arm/include/asm/entry-macro-vic2.S
@@ -29,9 +29,6 @@
 
 #include <asm/hardware/vic.h>
 
-	.macro	disable_fiq
-	.endm
-
 	.macro	get_irqnr_preamble, base, tmp
 	ldr	\base, =VA_VIC0
 	.endm
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index ecb8492..5c45fb4 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -1209,7 +1209,9 @@ __stubs_start:
  * get out of that mode without clobbering one register.
  */
 vector_fiq:
+#ifdef CONFIG_ARCH_HAS_DISABLE_FIQ
 	disable_fiq
+#endif
 	subs	pc, lr, #4
 
 /*=============================================================================
diff --git a/arch/arm/mach-aaec2000/include/mach/entry-macro.S b/arch/arm/mach-aaec2000/include/mach/entry-macro.S
index c8fb344..1cdbab4 100644
--- a/arch/arm/mach-aaec2000/include/mach/entry-macro.S
+++ b/arch/arm/mach-aaec2000/include/mach/entry-macro.S
@@ -12,9 +12,6 @@
  */
 #include <mach/irqs.h>
 
-		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
diff --git a/arch/arm/mach-at91/include/mach/entry-macro.S b/arch/arm/mach-at91/include/mach/entry-macro.S
index 7ab68f9..c39f889 100644
--- a/arch/arm/mach-at91/include/mach/entry-macro.S
+++ b/arch/arm/mach-at91/include/mach/entry-macro.S
@@ -13,9 +13,6 @@
 #include <mach/hardware.h>
 #include <mach/at91_aic.h>
 
-	.macro	disable_fiq
-	.endm
-
 	.macro  get_irqnr_preamble, base, tmp
 	ldr	\base, =(AT91_VA_BASE_SYS + AT91_AIC)		@ base virtual address of AIC peripheral
 	.endm
diff --git a/arch/arm/mach-bcmring/include/mach/entry-macro.S b/arch/arm/mach-bcmring/include/mach/entry-macro.S
index 7d393ca..7dac106 100644
--- a/arch/arm/mach-bcmring/include/mach/entry-macro.S
+++ b/arch/arm/mach-bcmring/include/mach/entry-macro.S
@@ -21,9 +21,6 @@
 #include <mach/hardware.h>
 #include <mach/csp/mm_io.h>
 
-		.macro	disable_fiq
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		ldr	\base, =(MM_IO_BASE_INTC0)
 		ldr	\irqstat, [\base, #0]		@ get status
diff --git a/arch/arm/mach-clps711x/include/mach/entry-macro.S b/arch/arm/mach-clps711x/include/mach/entry-macro.S
index 90fa2f7..a04c12e 100644
--- a/arch/arm/mach-clps711x/include/mach/entry-macro.S
+++ b/arch/arm/mach-clps711x/include/mach/entry-macro.S
@@ -10,9 +10,6 @@
 #include <mach/hardware.h>
 #include <asm/hardware/clps7111.h>
 
-		.macro	disable_fiq
-		.endm
-
 		.macro	get_irqnr_preamble, base, tmp
 		.endm
 
diff --git a/arch/arm/mach-cns3xxx/include/mach/entry-macro.S b/arch/arm/mach-cns3xxx/include/mach/entry-macro.S
index 5e1c554..a7601d0 100644
--- a/arch/arm/mach-cns3xxx/include/mach/entry-macro.S
+++ b/arch/arm/mach-cns3xxx/include/mach/entry-macro.S
@@ -11,9 +11,6 @@
 #include <mach/hardware.h>
 #include <asm/hardware/gic.h>
 
-		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		ldr	\base, =gic_cpu_base_addr
 		ldr	\base, [\base]
diff --git a/arch/arm/mach-davinci/include/mach/entry-macro.S b/arch/arm/mach-davinci/include/mach/entry-macro.S
index fbdebc7..9119790 100644
--- a/arch/arm/mach-davinci/include/mach/entry-macro.S
+++ b/arch/arm/mach-davinci/include/mach/entry-macro.S
@@ -11,9 +11,6 @@
 #include <mach/io.h>
 #include <mach/irqs.h>
 
-		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		ldr \base, =davinci_intc_base
 		ldr \base, [\base]
diff --git a/arch/arm/mach-dove/include/mach/entry-macro.S b/arch/arm/mach-dove/include/mach/entry-macro.S
index e84c78c..ec55a83 100644
--- a/arch/arm/mach-dove/include/mach/entry-macro.S
+++ b/arch/arm/mach-dove/include/mach/entry-macro.S
@@ -10,9 +10,6 @@
 
 #include <mach/bridge-regs.h>
 
-	.macro  disable_fiq
-	.endm
-
 	.macro  arch_ret_to_user, tmp1, tmp2
 	.endm
 
diff --git a/arch/arm/mach-ebsa110/include/mach/entry-macro.S b/arch/arm/mach-ebsa110/include/mach/entry-macro.S
index cc3e599..6d32f8b 100644
--- a/arch/arm/mach-ebsa110/include/mach/entry-macro.S
+++ b/arch/arm/mach-ebsa110/include/mach/entry-macro.S
@@ -12,9 +12,6 @@
 
 #define IRQ_STAT		0xff000000	/* read */
 
-	.macro	disable_fiq
-	.endm
-
 	.macro  get_irqnr_preamble, base, tmp
 	mov	\base, #IRQ_STAT
 	.endm
diff --git a/arch/arm/mach-ep93xx/include/mach/entry-macro.S b/arch/arm/mach-ep93xx/include/mach/entry-macro.S
index 96b85e2..1b535d6 100644
--- a/arch/arm/mach-ep93xx/include/mach/entry-macro.S
+++ b/arch/arm/mach-ep93xx/include/mach/entry-macro.S
@@ -11,9 +11,6 @@
  */
 #include <mach/ep93xx-regs.h>
 
-		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
diff --git a/arch/arm/mach-footbridge/include/mach/entry-macro.S b/arch/arm/mach-footbridge/include/mach/entry-macro.S
index d3847be..77c709e 100644
--- a/arch/arm/mach-footbridge/include/mach/entry-macro.S
+++ b/arch/arm/mach-footbridge/include/mach/entry-macro.S
@@ -14,9 +14,6 @@
 		.equ	dc21285_high, ARMCSR_BASE & 0xff000000
 		.equ	dc21285_low, ARMCSR_BASE & 0x00ffffff
 
-		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		mov	\base, #dc21285_high
 		.if	dc21285_low
diff --git a/arch/arm/mach-gemini/include/mach/entry-macro.S b/arch/arm/mach-gemini/include/mach/entry-macro.S
index 1624f91..b24bde7 100644
--- a/arch/arm/mach-gemini/include/mach/entry-macro.S
+++ b/arch/arm/mach-gemini/include/mach/entry-macro.S
@@ -12,9 +12,6 @@
 
 #define IRQ_STATUS	0x14
 
-	.macro  disable_fiq
-	.endm
-
 	.macro  get_irqnr_preamble, base, tmp
 	.endm
 
diff --git a/arch/arm/mach-h720x/include/mach/entry-macro.S b/arch/arm/mach-h720x/include/mach/entry-macro.S
index 6d3b917..d928619 100644
--- a/arch/arm/mach-h720x/include/mach/entry-macro.S
+++ b/arch/arm/mach-h720x/include/mach/entry-macro.S
@@ -8,9 +8,6 @@
  * warranty of any kind, whether express or implied.
  */
 
-		.macro  disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
diff --git a/arch/arm/mach-integrator/include/mach/entry-macro.S b/arch/arm/mach-integrator/include/mach/entry-macro.S
index 3d029c9..f0c4de4 100644
--- a/arch/arm/mach-integrator/include/mach/entry-macro.S
+++ b/arch/arm/mach-integrator/include/mach/entry-macro.S
@@ -11,9 +11,6 @@
 #include <mach/platform.h>
 #include <mach/irqs.h>
 
- 		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
diff --git a/arch/arm/mach-iop13xx/include/mach/entry-macro.S b/arch/arm/mach-iop13xx/include/mach/entry-macro.S
index a624a78..1a2d603 100644
--- a/arch/arm/mach-iop13xx/include/mach/entry-macro.S
+++ b/arch/arm/mach-iop13xx/include/mach/entry-macro.S
@@ -16,9 +16,6 @@
  * Place - Suite 330, Boston, MA 02111-1307 USA.
  *
  */
-	.macro  disable_fiq
-	.endm
-
 	.macro get_irqnr_preamble, base, tmp
 	mrc	p15, 0, \tmp, c15, c1, 0
 	orr	\tmp, \tmp, #(1 << 6)
diff --git a/arch/arm/mach-iop32x/include/mach/entry-macro.S b/arch/arm/mach-iop32x/include/mach/entry-macro.S
index b02fb56..ea13ae0 100644
--- a/arch/arm/mach-iop32x/include/mach/entry-macro.S
+++ b/arch/arm/mach-iop32x/include/mach/entry-macro.S
@@ -9,9 +9,6 @@
  */
 #include <mach/iop32x.h>
 
-	.macro	disable_fiq
-	.endm
-
 	.macro get_irqnr_preamble, base, tmp
 	mrc	p15, 0, \tmp, c15, c1, 0
 	orr	\tmp, \tmp, #(1 << 6)
diff --git a/arch/arm/mach-iop33x/include/mach/entry-macro.S b/arch/arm/mach-iop33x/include/mach/entry-macro.S
index 4e1f728..0a398fe 100644
--- a/arch/arm/mach-iop33x/include/mach/entry-macro.S
+++ b/arch/arm/mach-iop33x/include/mach/entry-macro.S
@@ -9,9 +9,6 @@
  */
 #include <mach/iop33x.h>
 
-	.macro	disable_fiq
-	.endm
-
 	.macro get_irqnr_preamble, base, tmp
 	mrc	p15, 0, \tmp, c15, c1, 0
 	orr	\tmp, \tmp, #(1 << 6)
diff --git a/arch/arm/mach-ixp2000/include/mach/entry-macro.S b/arch/arm/mach-ixp2000/include/mach/entry-macro.S
index 5850ffc..6d27838 100644
--- a/arch/arm/mach-ixp2000/include/mach/entry-macro.S
+++ b/arch/arm/mach-ixp2000/include/mach/entry-macro.S
@@ -9,9 +9,6 @@
  */
 #include <mach/irqs.h>
 
-		.macro  disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
diff --git a/arch/arm/mach-ixp23xx/include/mach/entry-macro.S b/arch/arm/mach-ixp23xx/include/mach/entry-macro.S
index 3f5338a..c22f772 100644
--- a/arch/arm/mach-ixp23xx/include/mach/entry-macro.S
+++ b/arch/arm/mach-ixp23xx/include/mach/entry-macro.S
@@ -2,9 +2,6 @@
  * arch/arm/mach-ixp23xx/include/mach/entry-macro.S
  */
 
-		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
diff --git a/arch/arm/mach-ixp4xx/include/mach/entry-macro.S b/arch/arm/mach-ixp4xx/include/mach/entry-macro.S
index f2e14e9..c53de19 100644
--- a/arch/arm/mach-ixp4xx/include/mach/entry-macro.S
+++ b/arch/arm/mach-ixp4xx/include/mach/entry-macro.S
@@ -9,9 +9,6 @@
  */
 #include <mach/hardware.h>
 
-		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
diff --git a/arch/arm/mach-kirkwood/include/mach/entry-macro.S b/arch/arm/mach-kirkwood/include/mach/entry-macro.S
index 8939d36..5d072cb 100644
--- a/arch/arm/mach-kirkwood/include/mach/entry-macro.S
+++ b/arch/arm/mach-kirkwood/include/mach/entry-macro.S
@@ -10,9 +10,6 @@
 
 #include <mach/bridge-regs.h>
 
-	.macro  disable_fiq
-	.endm
-
 	.macro  arch_ret_to_user, tmp1, tmp2
 	.endm
 
diff --git a/arch/arm/mach-ks8695/include/mach/entry-macro.S b/arch/arm/mach-ks8695/include/mach/entry-macro.S
index b4fe0c1..1bc1c4c 100644
--- a/arch/arm/mach-ks8695/include/mach/entry-macro.S
+++ b/arch/arm/mach-ks8695/include/mach/entry-macro.S
@@ -14,9 +14,6 @@
 #include <mach/hardware.h>
 #include <mach/regs-irq.h>
 
-	.macro	disable_fiq
-	.endm
-
 	.macro  get_irqnr_preamble, base, tmp
 		ldr	\base, =KS8695_IRQ_VA			@ Base address of interrupt controller
 	.endm
diff --git a/arch/arm/mach-l7200/include/mach/entry-macro.S b/arch/arm/mach-l7200/include/mach/entry-macro.S
index 1726d91..570e71a 100644
--- a/arch/arm/mach-l7200/include/mach/entry-macro.S
+++ b/arch/arm/mach-l7200/include/mach/entry-macro.S
@@ -11,9 +11,6 @@
 
 		.equ	irq_base_addr,	IO_BASE_2
 
-		.macro  disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
diff --git a/arch/arm/mach-lh7a40x/include/mach/entry-macro.S b/arch/arm/mach-lh7a40x/include/mach/entry-macro.S
index 069bb4c..8e99a99 100644
--- a/arch/arm/mach-lh7a40x/include/mach/entry-macro.S
+++ b/arch/arm/mach-lh7a40x/include/mach/entry-macro.S
@@ -23,9 +23,6 @@
 
 #if defined (CONFIG_ARCH_LH7A400) && defined (CONFIG_ARCH_LH7A404)
 
-		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
@@ -83,9 +80,6 @@ branch_irq_lh7a400: b 1000f
 
 
 #elif defined (CONFIG_ARCH_LH7A400)
-		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
@@ -108,9 +102,6 @@ branch_irq_lh7a400: b 1000f
 
 #elif defined(CONFIG_ARCH_LH7A404)
 
-		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
diff --git a/arch/arm/mach-loki/include/mach/entry-macro.S b/arch/arm/mach-loki/include/mach/entry-macro.S
index bc917ed..a569fcb 100644
--- a/arch/arm/mach-loki/include/mach/entry-macro.S
+++ b/arch/arm/mach-loki/include/mach/entry-macro.S
@@ -10,9 +10,6 @@
 
 #include <mach/bridge-regs.h>
 
-	.macro  disable_fiq
-	.endm
-
 	.macro  arch_ret_to_user, tmp1, tmp2
 	.endm
 
diff --git a/arch/arm/mach-mmp/include/mach/entry-macro.S b/arch/arm/mach-mmp/include/mach/entry-macro.S
index c42d9d4..9e93544 100644
--- a/arch/arm/mach-mmp/include/mach/entry-macro.S
+++ b/arch/arm/mach-mmp/include/mach/entry-macro.S
@@ -8,9 +8,6 @@
 
 #include <mach/regs-icu.h>
 
-	.macro	disable_fiq
-	.endm
-
 	.macro	arch_ret_to_user, tmp1, tmp2
 	.endm
 
diff --git a/arch/arm/mach-msm/include/mach/entry-macro.S b/arch/arm/mach-msm/include/mach/entry-macro.S
index d225948..d4a5503 100644
--- a/arch/arm/mach-msm/include/mach/entry-macro.S
+++ b/arch/arm/mach-msm/include/mach/entry-macro.S
@@ -16,9 +16,6 @@
 
 #include <mach/msm_iomap.h>
 
- 	.macro	disable_fiq
-	.endm
-
 	.macro	get_irqnr_preamble, base, tmp
 	@ enable imprecise aborts
 	cpsie	a
diff --git a/arch/arm/mach-mv78xx0/include/mach/entry-macro.S b/arch/arm/mach-mv78xx0/include/mach/entry-macro.S
index 66ae2d2..ad7fd77 100644
--- a/arch/arm/mach-mv78xx0/include/mach/entry-macro.S
+++ b/arch/arm/mach-mv78xx0/include/mach/entry-macro.S
@@ -10,9 +10,6 @@
 
 #include <mach/bridge-regs.h>
 
-	.macro  disable_fiq
-	.endm
-
 	.macro  arch_ret_to_user, tmp1, tmp2
 	.endm
 
diff --git a/arch/arm/mach-netx/include/mach/entry-macro.S b/arch/arm/mach-netx/include/mach/entry-macro.S
index 844f1f9..3eea16a 100644
--- a/arch/arm/mach-netx/include/mach/entry-macro.S
+++ b/arch/arm/mach-netx/include/mach/entry-macro.S
@@ -20,9 +20,6 @@
  */
 #include <mach/hardware.h>
 
-		.macro  disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		ldr	\base, =io_p2v(0x001ff000)
 		.endm
diff --git a/arch/arm/mach-nomadik/include/mach/entry-macro.S b/arch/arm/mach-nomadik/include/mach/entry-macro.S
index 49f1aa3..6028da6 100644
--- a/arch/arm/mach-nomadik/include/mach/entry-macro.S
+++ b/arch/arm/mach-nomadik/include/mach/entry-macro.S
@@ -9,9 +9,6 @@
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 
-	.macro	disable_fiq
-	.endm
-
 	.macro	get_irqnr_preamble, base, tmp
 	ldr	\base, =IO_ADDRESS(NOMADIK_IC_BASE)
 	.endm
diff --git a/arch/arm/mach-ns9xxx/include/mach/entry-macro.S b/arch/arm/mach-ns9xxx/include/mach/entry-macro.S
index 71ca031..5e49cd4 100644
--- a/arch/arm/mach-ns9xxx/include/mach/entry-macro.S
+++ b/arch/arm/mach-ns9xxx/include/mach/entry-macro.S
@@ -24,5 +24,3 @@
 		ldrne	\irqnr, [\base]
 		.endm
 
-		.macro	disable_fiq
-		.endm
diff --git a/arch/arm/mach-nuc93x/include/mach/entry-macro.S b/arch/arm/mach-nuc93x/include/mach/entry-macro.S
index 1352cbd..e3cd5df 100644
--- a/arch/arm/mach-nuc93x/include/mach/entry-macro.S
+++ b/arch/arm/mach-nuc93x/include/mach/entry-macro.S
@@ -25,8 +25,3 @@
 		cmp	\irqnr, #0
 
 	.endm
-
-	/* currently don't need an disable_fiq macro */
-
-	.macro	disable_fiq
-	.endm
diff --git a/arch/arm/mach-omap1/include/mach/entry-macro.S b/arch/arm/mach-omap1/include/mach/entry-macro.S
index df9060e..1751955 100644
--- a/arch/arm/mach-omap1/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap1/include/mach/entry-macro.S
@@ -28,9 +28,6 @@
 #define INT_IH2_IRQ		INT_1510_IH2_IRQ
 #endif
 
- 		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
index 50fd749..e28b256 100644
--- a/arch/arm/mach-omap2/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
@@ -27,9 +27,6 @@
 #define INTCPS_SIR_IRQ_OFFSET	0x0040	/* omap2/3 active interrupt offset */
 #define	ACTIVEIRQ_MASK		0x7f	/* omap2/3 active interrupt bits */
 
-		.macro	disable_fiq
-		.endm
-
 		.macro  arch_ret_to_user, tmp1, tmp2
 		.endm
 
diff --git a/arch/arm/mach-orion5x/include/mach/entry-macro.S b/arch/arm/mach-orion5x/include/mach/entry-macro.S
index d658992..92409c3 100644
--- a/arch/arm/mach-orion5x/include/mach/entry-macro.S
+++ b/arch/arm/mach-orion5x/include/mach/entry-macro.S
@@ -10,9 +10,6 @@
 
 #include <mach/bridge-regs.h>
 
-	.macro  disable_fiq
-	.endm
-
 	.macro  arch_ret_to_user, tmp1, tmp2
 	.endm
 
diff --git a/arch/arm/mach-pnx4008/include/mach/entry-macro.S b/arch/arm/mach-pnx4008/include/mach/entry-macro.S
index 8003037..908c3d6 100644
--- a/arch/arm/mach-pnx4008/include/mach/entry-macro.S
+++ b/arch/arm/mach-pnx4008/include/mach/entry-macro.S
@@ -25,9 +25,6 @@
 #define SIC1_BASE_INT   32
 #define SIC2_BASE_INT   64
 
-		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
diff --git a/arch/arm/mach-pxa/include/mach/entry-macro.S b/arch/arm/mach-pxa/include/mach/entry-macro.S
index a73bc86..5f646d6 100644
--- a/arch/arm/mach-pxa/include/mach/entry-macro.S
+++ b/arch/arm/mach-pxa/include/mach/entry-macro.S
@@ -10,9 +10,6 @@
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 
-		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
diff --git a/arch/arm/mach-realview/include/mach/entry-macro.S b/arch/arm/mach-realview/include/mach/entry-macro.S
index 340a5c2..f3ec9d4 100644
--- a/arch/arm/mach-realview/include/mach/entry-macro.S
+++ b/arch/arm/mach-realview/include/mach/entry-macro.S
@@ -10,9 +10,6 @@
 #include <mach/hardware.h>
 #include <asm/hardware/gic.h>
 
-		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		ldr	\base, =gic_cpu_base_addr
 		ldr	\base, [\base]
diff --git a/arch/arm/mach-s3c2410/include/mach/entry-macro.S b/arch/arm/mach-s3c2410/include/mach/entry-macro.S
index 473b3cd..04791d2 100644
--- a/arch/arm/mach-s3c2410/include/mach/entry-macro.S
+++ b/arch/arm/mach-s3c2410/include/mach/entry-macro.S
@@ -71,8 +71,3 @@
 		@@ exit here, Z flag unset if IRQ
 
 	.endm
-
-		/* currently don't need an disable_fiq macro */
-
-		.macro	disable_fiq
-		.endm
diff --git a/arch/arm/mach-s5p6442/include/mach/entry-macro.S b/arch/arm/mach-s5p6442/include/mach/entry-macro.S
index 6d574ed..c56a1d6 100644
--- a/arch/arm/mach-s5p6442/include/mach/entry-macro.S
+++ b/arch/arm/mach-s5p6442/include/mach/entry-macro.S
@@ -14,9 +14,6 @@
 #include <mach/map.h>
 #include <plat/irqs.h>
 
-	.macro	disable_fiq
-	.endm
-
 	.macro	get_irqnr_preamble, base, tmp
 	ldr	\base, =VA_VIC0
 	.endm
diff --git a/arch/arm/mach-s5pc100/include/mach/entry-macro.S b/arch/arm/mach-s5pc100/include/mach/entry-macro.S
index 6713193..ffb41e9 100644
--- a/arch/arm/mach-s5pc100/include/mach/entry-macro.S
+++ b/arch/arm/mach-s5pc100/include/mach/entry-macro.S
@@ -16,9 +16,6 @@
 #include <mach/map.h>
 #include <plat/irqs.h>
 
-	.macro	disable_fiq
-	.endm
-
 	.macro	get_irqnr_preamble, base, tmp
 	ldr	\base, =S3C_VA_VIC0
 	.endm
diff --git a/arch/arm/mach-s5pv210/include/mach/entry-macro.S b/arch/arm/mach-s5pv210/include/mach/entry-macro.S
index 3aa41ac..35c7a7c 100644
--- a/arch/arm/mach-s5pv210/include/mach/entry-macro.S
+++ b/arch/arm/mach-s5pv210/include/mach/entry-macro.S
@@ -14,9 +14,6 @@
 #include <mach/map.h>
 #include <plat/irqs.h>
 
-	.macro	disable_fiq
-	.endm
-
 	.macro	get_irqnr_preamble, base, tmp
 	ldr	\base, =VA_VIC0
 	.endm
diff --git a/arch/arm/mach-sa1100/include/mach/entry-macro.S b/arch/arm/mach-sa1100/include/mach/entry-macro.S
index 6aa13c4..4151c7f 100644
--- a/arch/arm/mach-sa1100/include/mach/entry-macro.S
+++ b/arch/arm/mach-sa1100/include/mach/entry-macro.S
@@ -8,9 +8,6 @@
  * warranty of any kind, whether express or implied.
  */
 
- 		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		mov	\base, #0xfa000000		@ ICIP = 0xfa050000
 		add	\base, \base, #0x00050000
diff --git a/arch/arm/mach-shark/include/mach/entry-macro.S b/arch/arm/mach-shark/include/mach/entry-macro.S
index e2853c0..c7bfeaa 100644
--- a/arch/arm/mach-shark/include/mach/entry-macro.S
+++ b/arch/arm/mach-shark/include/mach/entry-macro.S
@@ -7,9 +7,6 @@
  * License version 2. This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
diff --git a/arch/arm/mach-shmobile/include/mach/entry-macro.S b/arch/arm/mach-shmobile/include/mach/entry-macro.S
index a285d13..dbc6545 100644
--- a/arch/arm/mach-shmobile/include/mach/entry-macro.S
+++ b/arch/arm/mach-shmobile/include/mach/entry-macro.S
@@ -17,9 +17,6 @@
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 
-	.macro  disable_fiq
-	.endm
-
 	.macro  get_irqnr_preamble, base, tmp
 	ldr     \base, =INTFLGA
 	.endm
diff --git a/arch/arm/mach-spear3xx/include/mach/entry-macro.S b/arch/arm/mach-spear3xx/include/mach/entry-macro.S
index 947625d..dfef683 100644
--- a/arch/arm/mach-spear3xx/include/mach/entry-macro.S
+++ b/arch/arm/mach-spear3xx/include/mach/entry-macro.S
@@ -15,9 +15,6 @@
 #include <mach/spear.h>
 #include <asm/hardware/vic.h>
 
-		.macro	disable_fiq
-		.endm
-
 		.macro	get_irqnr_preamble, base, tmp
 		.endm
 
diff --git a/arch/arm/mach-spear6xx/include/mach/entry-macro.S b/arch/arm/mach-spear6xx/include/mach/entry-macro.S
index 9eaecae..76a6ace 100644
--- a/arch/arm/mach-spear6xx/include/mach/entry-macro.S
+++ b/arch/arm/mach-spear6xx/include/mach/entry-macro.S
@@ -15,9 +15,6 @@
 #include <mach/spear.h>
 #include <asm/hardware/vic.h>
 
-		.macro	disable_fiq
-		.endm
-
 		.macro	get_irqnr_preamble, base, tmp
 		.endm
 
diff --git a/arch/arm/mach-stmp378x/include/mach/entry-macro.S b/arch/arm/mach-stmp378x/include/mach/entry-macro.S
index 731a922..9be8e1f 100644
--- a/arch/arm/mach-stmp378x/include/mach/entry-macro.S
+++ b/arch/arm/mach-stmp378x/include/mach/entry-macro.S
@@ -16,9 +16,6 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-		.macro	disable_fiq
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 
 	        mov	\base, #0xf0000000	@ vm address of IRQ controller
diff --git a/arch/arm/mach-stmp37xx/include/mach/entry-macro.S b/arch/arm/mach-stmp37xx/include/mach/entry-macro.S
index fed2787..04d9c76 100644
--- a/arch/arm/mach-stmp37xx/include/mach/entry-macro.S
+++ b/arch/arm/mach-stmp37xx/include/mach/entry-macro.S
@@ -16,9 +16,6 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-		.macro	disable_fiq
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 
 	        mov	\base, #0xf0000000	@ vm address of IRQ controller
diff --git a/arch/arm/mach-u300/include/mach/entry-macro.S b/arch/arm/mach-u300/include/mach/entry-macro.S
index 20731ae..171f2e1 100644
--- a/arch/arm/mach-u300/include/mach/entry-macro.S
+++ b/arch/arm/mach-u300/include/mach/entry-macro.S
@@ -11,9 +11,6 @@
 #include <mach/hardware.h>
 #include <asm/hardware/vic.h>
 
-	.macro	disable_fiq
-	.endm
-
 	.macro  get_irqnr_preamble, base, tmp
 	.endm
 
diff --git a/arch/arm/mach-ux500/include/mach/entry-macro.S b/arch/arm/mach-ux500/include/mach/entry-macro.S
index 60ea88d..1f5bb0b 100644
--- a/arch/arm/mach-ux500/include/mach/entry-macro.S
+++ b/arch/arm/mach-ux500/include/mach/entry-macro.S
@@ -13,9 +13,6 @@
 #include <mach/hardware.h>
 #include <asm/hardware/gic.h>
 
-		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		ldr     \base, =IO_ADDRESS(UX500_GIC_CPU_BASE)
 		.endm
diff --git a/arch/arm/mach-versatile/include/mach/entry-macro.S b/arch/arm/mach-versatile/include/mach/entry-macro.S
index e6f7c16..ea5e33d 100644
--- a/arch/arm/mach-versatile/include/mach/entry-macro.S
+++ b/arch/arm/mach-versatile/include/mach/entry-macro.S
@@ -11,9 +11,6 @@
 #include <mach/platform.h>
 #include <asm/hardware/vic.h>
 
-		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		ldr	\base, =IO_ADDRESS(VERSATILE_VIC_BASE)
 		.endm
diff --git a/arch/arm/mach-vexpress/include/mach/entry-macro.S b/arch/arm/mach-vexpress/include/mach/entry-macro.S
index 20e9fb5..15c70e8 100644
--- a/arch/arm/mach-vexpress/include/mach/entry-macro.S
+++ b/arch/arm/mach-vexpress/include/mach/entry-macro.S
@@ -1,8 +1,5 @@
 #include <asm/hardware/gic.h>
 
-	.macro	disable_fiq
-	.endm
-
 	.macro	get_irqnr_preamble, base, tmp
 	ldr	\base, =gic_cpu_base_addr
 	ldr	\base, [\base]
diff --git a/arch/arm/mach-w90x900/include/mach/entry-macro.S b/arch/arm/mach-w90x900/include/mach/entry-macro.S
index d39aca5..b747c2b 100644
--- a/arch/arm/mach-w90x900/include/mach/entry-macro.S
+++ b/arch/arm/mach-w90x900/include/mach/entry-macro.S
@@ -27,8 +27,3 @@
 		cmp	\irqnr, #0
 
 	.endm
-
-	/* currently don't need an disable_fiq macro */
-
-	.macro	disable_fiq
-	.endm
diff --git a/arch/arm/plat-mxc/include/mach/entry-macro.S b/arch/arm/plat-mxc/include/mach/entry-macro.S
index aeb0869..4afbf58 100644
--- a/arch/arm/plat-mxc/include/mach/entry-macro.S
+++ b/arch/arm/plat-mxc/include/mach/entry-macro.S
@@ -14,9 +14,6 @@
 #define AVIC_NIMASK	0x04
 
 	@ this macro disables fast irq (not implemented)
-	.macro	disable_fiq
-	.endm
-
 	.macro  get_irqnr_preamble, base, tmp
 #ifndef CONFIG_MXC_TZIC
 	ldr	\base, =avic_base
-- 
1.7.1
