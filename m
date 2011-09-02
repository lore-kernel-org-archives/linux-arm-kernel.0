From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 01 Sep 2011 22:59:08 -0400
Subject: [PATCH 1/6] ARM: add an extra temp register to the addruart low level
	debugging macro
In-Reply-To: <1314932353-24813-1-git-send-email-nico@fluxnic.net>
References: <1314932353-24813-1-git-send-email-nico@fluxnic.net>
Message-ID: <1314932353-24813-2-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms (like OMAP not to name it) are doing rather complicated
hacks just to determine the base UART address to use.  Let's give the
addruart macro some slack by providing an extra work register which will
allow for further cleanups.

This is basically a no-op as this commit is only adding the extra argument
to the macro but no one is using it yet.

Signed-off-by: nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/kernel/debug.S                            |    2 +-
 arch/arm/kernel/head.S                             |    2 +-
 arch/arm/mach-at91/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-clps711x/include/mach/debug-macro.S  |    2 +-
 arch/arm/mach-cns3xxx/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-davinci/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-dove/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-ebsa110/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-ep93xx/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-exynos4/include/mach/debug-macro.S   |    2 +-
 .../arm/mach-footbridge/include/mach/debug-macro.S |    4 ++--
 arch/arm/mach-gemini/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-h720x/include/mach/debug-macro.S     |    2 +-
 .../arm/mach-integrator/include/mach/debug-macro.S |    2 +-
 arch/arm/mach-iop13xx/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-iop32x/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-iop33x/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-ixp2000/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-ixp23xx/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-ixp4xx/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-kirkwood/include/mach/debug-macro.S  |    2 +-
 arch/arm/mach-ks8695/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-l7200/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-lpc32xx/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-mmp/include/mach/debug-macro.S       |    2 +-
 arch/arm/mach-msm/include/mach/debug-macro.S       |    4 ++--
 arch/arm/mach-mv78xx0/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-mxs/include/mach/debug-macro.S       |    2 +-
 arch/arm/mach-netx/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-nomadik/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-omap1/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-omap2/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-orion5x/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-pnx4008/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-prima2/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-pxa/include/mach/debug-macro.S       |    2 +-
 arch/arm/mach-realview/include/mach/debug-macro.S  |    2 +-
 arch/arm/mach-rpc/include/mach/debug-macro.S       |    2 +-
 arch/arm/mach-s3c2410/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-s3c64xx/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-s5p64x0/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-s5pc100/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-s5pv210/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-sa1100/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-shark/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-tegra/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-u300/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-ux500/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-versatile/include/mach/debug-macro.S |    2 +-
 arch/arm/mach-vexpress/include/mach/debug-macro.S  |    2 +-
 arch/arm/mach-vt8500/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-zynq/include/mach/debug-macro.S      |    2 +-
 arch/arm/plat-mxc/include/mach/debug-macro.S       |    2 +-
 arch/arm/plat-spear/include/plat/debug-macro.S     |    2 +-
 arch/arm/plat-tcc/include/mach/debug-macro.S       |    2 +-
 55 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
index bcd66e0..dd962ed 100644
--- a/arch/arm/kernel/debug.S
+++ b/arch/arm/kernel/debug.S
@@ -106,7 +106,7 @@
 
 #ifdef CONFIG_MMU
 		.macro	addruart_current, rx, tmp1, tmp2
-		addruart	\tmp1, \tmp2
+		addruart	\tmp1, \tmp2, \rx
 		mrc		p15, 0, \rx, c1, c0
 		tst		\rx, #1
 		moveq		\rx, \tmp1
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 136abb6..7408fd5 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -234,7 +234,7 @@ __create_page_tables:
 	 * This allows debug messages to be output
 	 * via a serial console before paging_init.
 	 */
-	addruart r7, r3
+	addruart r7, r3, r0
 
 	mov	r3, r3, lsr #20
 	mov	r3, r3, lsl #2
diff --git a/arch/arm/mach-at91/include/mach/debug-macro.S b/arch/arm/mach-at91/include/mach/debug-macro.S
index bc1e0b2..0ed8648 100644
--- a/arch/arm/mach-at91/include/mach/debug-macro.S
+++ b/arch/arm/mach-at91/include/mach/debug-macro.S
@@ -14,7 +14,7 @@
 #include <mach/hardware.h>
 #include <mach/at91_dbgu.h>
 
-	.macro	addruart, rp, rv
+	.macro	addruart, rp, rv, tmp
 	ldr	\rp, =(AT91_BASE_SYS + AT91_DBGU)	@ System peripherals (phys address)
 	ldr	\rv, =(AT91_VA_BASE_SYS	+ AT91_DBGU)	@ System peripherals (virt address)
 	.endm
diff --git a/arch/arm/mach-clps711x/include/mach/debug-macro.S b/arch/arm/mach-clps711x/include/mach/debug-macro.S
index 507c687..b802e8a 100644
--- a/arch/arm/mach-clps711x/include/mach/debug-macro.S
+++ b/arch/arm/mach-clps711x/include/mach/debug-macro.S
@@ -14,7 +14,7 @@
 #include <mach/hardware.h>
 #include <asm/hardware/clps7111.h>
 
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 #ifndef CONFIG_DEBUG_CLPS711X_UART2
 		mov	\rp, #0x0000	@ UART1
 #else
diff --git a/arch/arm/mach-cns3xxx/include/mach/debug-macro.S b/arch/arm/mach-cns3xxx/include/mach/debug-macro.S
index 56d8286..d04c150 100644
--- a/arch/arm/mach-cns3xxx/include/mach/debug-macro.S
+++ b/arch/arm/mach-cns3xxx/include/mach/debug-macro.S
@@ -10,7 +10,7 @@
  * published by the Free Software Foundation.
  */
 
-		.macro	addruart,rp,rv
+		.macro	addruart,rp,rv,tmp
 		mov	\rp, #0x00009000
 		orr	\rv, \rp, #0xf0000000	@ virtual base
 		orr	\rp, \rp, #0x10000000
diff --git a/arch/arm/mach-davinci/include/mach/debug-macro.S b/arch/arm/mach-davinci/include/mach/debug-macro.S
index f8b7ea4..3cf4c1b 100644
--- a/arch/arm/mach-davinci/include/mach/debug-macro.S
+++ b/arch/arm/mach-davinci/include/mach/debug-macro.S
@@ -32,7 +32,7 @@ davinci_uart_phys:	.word	0
 davinci_uart_virt:	.word	0
 		.popsection
 
-		.macro addruart, rp, rv
+		.macro addruart, rp, rv, tmp
 
 		/* Use davinci_uart_phys/virt if already configured */
 10:		mrc	p15, 0, \rp, c1, c0
diff --git a/arch/arm/mach-dove/include/mach/debug-macro.S b/arch/arm/mach-dove/include/mach/debug-macro.S
index da8bf2b..5929cbc 100644
--- a/arch/arm/mach-dove/include/mach/debug-macro.S
+++ b/arch/arm/mach-dove/include/mach/debug-macro.S
@@ -8,7 +8,7 @@
 
 #include <mach/bridge-regs.h>
 
-	.macro	addruart, rp, rv
+	.macro	addruart, rp, rv, tmp
 	ldr	\rp, =DOVE_SB_REGS_PHYS_BASE
 	ldr	\rv, =DOVE_SB_REGS_VIRT_BASE
 	orr	\rp, \rp, #0x00012000
diff --git a/arch/arm/mach-ebsa110/include/mach/debug-macro.S b/arch/arm/mach-ebsa110/include/mach/debug-macro.S
index 7ef5690..bb02c05 100644
--- a/arch/arm/mach-ebsa110/include/mach/debug-macro.S
+++ b/arch/arm/mach-ebsa110/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
  *
 **/
 
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 		mov	\rp, #0xf0000000
 		orr	\rp, \rp, #0x00000be0
 		mov	\rp, \rv
diff --git a/arch/arm/mach-ep93xx/include/mach/debug-macro.S b/arch/arm/mach-ep93xx/include/mach/debug-macro.S
index b25bc907..af54e43 100644
--- a/arch/arm/mach-ep93xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-ep93xx/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
  */
 #include <mach/ep93xx-regs.h>
 
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 		ldr	\rp, =EP93XX_APB_PHYS_BASE	@ Physical base
 		ldr	\rv, =EP93XX_APB_VIRT_BASE	@ virtual base
 		orr	\rp, \rp, #0x000c0000
diff --git a/arch/arm/mach-exynos4/include/mach/debug-macro.S b/arch/arm/mach-exynos4/include/mach/debug-macro.S
index a442ef8..6cacf16 100644
--- a/arch/arm/mach-exynos4/include/mach/debug-macro.S
+++ b/arch/arm/mach-exynos4/include/mach/debug-macro.S
@@ -20,7 +20,7 @@
 	 * aligned and add in the offset when we load the value here.
 	 */
 
-	.macro addruart, rp, rv
+	.macro addruart, rp, rv, tmp
 		ldr	\rp, = S3C_PA_UART
 		ldr	\rv, = S3C_VA_UART
 #if CONFIG_DEBUG_S3C_UART != 0
diff --git a/arch/arm/mach-footbridge/include/mach/debug-macro.S b/arch/arm/mach-footbridge/include/mach/debug-macro.S
index 1be2eeb..e5acde2 100644
--- a/arch/arm/mach-footbridge/include/mach/debug-macro.S
+++ b/arch/arm/mach-footbridge/include/mach/debug-macro.S
@@ -15,7 +15,7 @@
 
 #ifndef CONFIG_DEBUG_DC21285_PORT
 	/* For NetWinder debugging */
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 		mov	\rp, #0x000003f8
 		orr	\rv, \rp, #0xff000000	@ virtual
 		orr	\rp, \rp, #0x7c000000	@ physical
@@ -31,7 +31,7 @@
 		.equ	dc21285_high, ARMCSR_BASE & 0xff000000
 		.equ	dc21285_low,  ARMCSR_BASE & 0x00ffffff
 
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 		.if	dc21285_low
 		mov	\rp, #dc21285_low
 		.else
diff --git a/arch/arm/mach-gemini/include/mach/debug-macro.S b/arch/arm/mach-gemini/include/mach/debug-macro.S
index f40e006..8376707 100644
--- a/arch/arm/mach-gemini/include/mach/debug-macro.S
+++ b/arch/arm/mach-gemini/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
  */
 #include <mach/hardware.h>
 
-	.macro	addruart, rp, rv
+	.macro	addruart, rp, rv, tmp
 	ldr	\rp, =GEMINI_UART_BASE			@ physical
 	ldr	\rv, =IO_ADDRESS(GEMINI_UART_BASE)	@ virtual
 	.endm
diff --git a/arch/arm/mach-h720x/include/mach/debug-macro.S b/arch/arm/mach-h720x/include/mach/debug-macro.S
index c2093e8..8a46157 100644
--- a/arch/arm/mach-h720x/include/mach/debug-macro.S
+++ b/arch/arm/mach-h720x/include/mach/debug-macro.S
@@ -16,7 +16,7 @@
 		.equ    io_virt, IO_VIRT
 		.equ    io_phys, IO_PHYS
 
-		.macro  addruart, rp, rv
+		.macro  addruart, rp, rv, tmp
 		mov     \rp, #0x00020000	@ UART1
 		add     \rv, \rp, #io_virt	@ virtual address
 		add     \rp, \rp, #io_phys	@ physical base address
diff --git a/arch/arm/mach-integrator/include/mach/debug-macro.S b/arch/arm/mach-integrator/include/mach/debug-macro.S
index a1f598f..411b116 100644
--- a/arch/arm/mach-integrator/include/mach/debug-macro.S
+++ b/arch/arm/mach-integrator/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
  *
 */
 
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 		mov	\rp, #0x16000000	@ physical base address
 		mov	\rv, #0xf0000000	@ virtual base
 		add	\rv, \rv, #0x16000000 >> 4
diff --git a/arch/arm/mach-iop13xx/include/mach/debug-macro.S b/arch/arm/mach-iop13xx/include/mach/debug-macro.S
index e664466..d869a6f 100644
--- a/arch/arm/mach-iop13xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-iop13xx/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
  * published by the Free Software Foundation.
  */
 
-	.macro	addruart, rp, rv
+	.macro	addruart, rp, rv, tmp
 	mov	\rp, #0x00002300
 	orr	\rp, \rp, #0x00000040
 	orr	\rv, \rp, #0xfe000000	@ virtual
diff --git a/arch/arm/mach-iop32x/include/mach/debug-macro.S b/arch/arm/mach-iop32x/include/mach/debug-macro.S
index ff9e76c..363bdf9 100644
--- a/arch/arm/mach-iop32x/include/mach/debug-macro.S
+++ b/arch/arm/mach-iop32x/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
  * published by the Free Software Foundation.
  */
 
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 		mov	\rp, #0xfe000000	@ physical as well as virtual
 		orr	\rp, \rp, #0x00800000	@ location of the UART
 		mov	\rv, \rp
diff --git a/arch/arm/mach-iop33x/include/mach/debug-macro.S b/arch/arm/mach-iop33x/include/mach/debug-macro.S
index 40c500d..361be1f 100644
--- a/arch/arm/mach-iop33x/include/mach/debug-macro.S
+++ b/arch/arm/mach-iop33x/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
  * published by the Free Software Foundation.
  */
 
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 		mov	\rp, #0x00ff0000
 		orr	\rp, \rp, #0x0000f700
 		orr	\rv, #0xfe000000	@ virtual
diff --git a/arch/arm/mach-ixp2000/include/mach/debug-macro.S b/arch/arm/mach-ixp2000/include/mach/debug-macro.S
index 0ef533b..bdd3ccd 100644
--- a/arch/arm/mach-ixp2000/include/mach/debug-macro.S
+++ b/arch/arm/mach-ixp2000/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
  *
 */
 
-		.macro  addruart, rp, rv
+		.macro  addruart, rp, rv, tmp
 		mov	\rp, #0x00030000
 #ifdef	__ARMEB__
 		orr	\rp, \rp, #0x00000003
diff --git a/arch/arm/mach-ixp23xx/include/mach/debug-macro.S b/arch/arm/mach-ixp23xx/include/mach/debug-macro.S
index f7c6eef..5ff524c 100644
--- a/arch/arm/mach-ixp23xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-ixp23xx/include/mach/debug-macro.S
@@ -12,7 +12,7 @@
  */
 #include <mach/ixp23xx.h>
 
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 		ldr	\rp, =IXP23XX_PERIPHERAL_PHYS 	@ physical
 		ldr	\rv, =IXP23XX_PERIPHERAL_VIRT	@ virtual
 #ifdef __ARMEB__
diff --git a/arch/arm/mach-ixp4xx/include/mach/debug-macro.S b/arch/arm/mach-ixp4xx/include/mach/debug-macro.S
index b974a49..8c9f8d5 100644
--- a/arch/arm/mach-ixp4xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-ixp4xx/include/mach/debug-macro.S
@@ -10,7 +10,7 @@
  * published by the Free Software Foundation.
 */
 
-                .macro  addruart, rp, rv
+                .macro  addruart, rp, rv, tmp
 #ifdef __ARMEB__
                 mov     \rp, #3         @ Uart regs are at off set of 3 if
 					@ byte writes used - Big Endian.
diff --git a/arch/arm/mach-kirkwood/include/mach/debug-macro.S b/arch/arm/mach-kirkwood/include/mach/debug-macro.S
index db06ae4..f785d40 100644
--- a/arch/arm/mach-kirkwood/include/mach/debug-macro.S
+++ b/arch/arm/mach-kirkwood/include/mach/debug-macro.S
@@ -8,7 +8,7 @@
 
 #include <mach/bridge-regs.h>
 
-	.macro	addruart, rp, rv
+	.macro	addruart, rp, rv, tmp
 	ldr	\rp, =KIRKWOOD_REGS_PHYS_BASE
 	ldr	\rv, =KIRKWOOD_REGS_VIRT_BASE
 	orr	\rp, \rp, #0x00012000
diff --git a/arch/arm/mach-ks8695/include/mach/debug-macro.S b/arch/arm/mach-ks8695/include/mach/debug-macro.S
index bf516ad..a79e489 100644
--- a/arch/arm/mach-ks8695/include/mach/debug-macro.S
+++ b/arch/arm/mach-ks8695/include/mach/debug-macro.S
@@ -14,7 +14,7 @@
 #include <mach/hardware.h>
 #include <mach/regs-uart.h>
 
-	.macro	addruart, rp, rv
+	.macro	addruart, rp, rv, tmp
 		ldr	\rp, =KS8695_UART_PA		@ physical base address
 		ldr	\rv, =KS8695_UART_VA		@ virtual base address
 	.endm
diff --git a/arch/arm/mach-l7200/include/mach/debug-macro.S b/arch/arm/mach-l7200/include/mach/debug-macro.S
index b0a2db7..0b4e760 100644
--- a/arch/arm/mach-l7200/include/mach/debug-macro.S
+++ b/arch/arm/mach-l7200/include/mach/debug-macro.S
@@ -14,7 +14,7 @@
 		.equ	io_virt, IO_BASE
 		.equ	io_phys, IO_START
 
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 		mov	\rp, #0x00044000	@ UART1
 @		mov	\rp, #0x00045000	@ UART2
 		add	\rv, \rp, #io_virt	@ virtual address
diff --git a/arch/arm/mach-lpc32xx/include/mach/debug-macro.S b/arch/arm/mach-lpc32xx/include/mach/debug-macro.S
index 629e744..351bd6c 100644
--- a/arch/arm/mach-lpc32xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-lpc32xx/include/mach/debug-macro.S
@@ -20,7 +20,7 @@
  * Debug output is hardcoded to standard UART 5
 */
 
-	.macro	addruart, rp, rv
+	.macro	addruart, rp, rv, tmp
 	ldreq	\rp, =0x40090000
 	ldrne	\rv, =0xF4090000
 	.endm
diff --git a/arch/arm/mach-mmp/include/mach/debug-macro.S b/arch/arm/mach-mmp/include/mach/debug-macro.S
index 7e2ebd3..b6f14d2 100644
--- a/arch/arm/mach-mmp/include/mach/debug-macro.S
+++ b/arch/arm/mach-mmp/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
 
 #include <mach/addr-map.h>
 
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 		ldr	\rp, =APB_PHYS_BASE		@ physical
 		ldr	\rv, =APB_VIRT_BASE		@ virtual
 		orr	\rp, \rp, #0x00017000
diff --git a/arch/arm/mach-msm/include/mach/debug-macro.S b/arch/arm/mach-msm/include/mach/debug-macro.S
index 646b99e..2dc73cc 100644
--- a/arch/arm/mach-msm/include/mach/debug-macro.S
+++ b/arch/arm/mach-msm/include/mach/debug-macro.S
@@ -20,7 +20,7 @@
 #include <mach/msm_iomap.h>
 
 #if defined(CONFIG_HAS_MSM_DEBUG_UART_PHYS) && !defined(CONFIG_MSM_DEBUG_UART_NONE)
-	.macro	addruart, rp, rv
+	.macro	addruart, rp, rv, tmp
 	ldr	\rp, =MSM_DEBUG_UART_PHYS
 	ldr	\rv, =MSM_DEBUG_UART_BASE
 	.endm
@@ -37,7 +37,7 @@
 	beq	1001b
 	.endm
 #else
-	.macro  addruart, rp, rv
+	.macro  addruart, rp, rv, tmp
 	mov	\rv, #0xff000000
 	orr	\rv, \rv, #0x00f00000
 	.endm
diff --git a/arch/arm/mach-mv78xx0/include/mach/debug-macro.S b/arch/arm/mach-mv78xx0/include/mach/debug-macro.S
index 0489142..a7df02b 100644
--- a/arch/arm/mach-mv78xx0/include/mach/debug-macro.S
+++ b/arch/arm/mach-mv78xx0/include/mach/debug-macro.S
@@ -8,7 +8,7 @@
 
 #include <mach/mv78xx0.h>
 
-	.macro	addruart, rp, rv
+	.macro	addruart, rp, rv, tmp
 	ldr	\rp, =MV78XX0_REGS_PHYS_BASE
 	ldr	\rv, =MV78XX0_REGS_VIRT_BASE
 	orr	\rp, \rp, #0x00012000
diff --git a/arch/arm/mach-mxs/include/mach/debug-macro.S b/arch/arm/mach-mxs/include/mach/debug-macro.S
index 79650a1..714570d 100644
--- a/arch/arm/mach-mxs/include/mach/debug-macro.S
+++ b/arch/arm/mach-mxs/include/mach/debug-macro.S
@@ -30,7 +30,7 @@
 
 #define UART_VADDR	MXS_IO_ADDRESS(UART_PADDR)
 
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 		ldr	\rp, =UART_PADDR	@ physical
 		ldr	\rv, =UART_VADDR	@ virtual
 		.endm
diff --git a/arch/arm/mach-netx/include/mach/debug-macro.S b/arch/arm/mach-netx/include/mach/debug-macro.S
index 56a9152..247781e 100644
--- a/arch/arm/mach-netx/include/mach/debug-macro.S
+++ b/arch/arm/mach-netx/include/mach/debug-macro.S
@@ -13,7 +13,7 @@
 
 #include "hardware.h"
 
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 		mov	\rp, #0x00000a00
 		orr	\rv, \rp, #io_p2v(0x00100000)	@ virtual
 		orr	\rp, \rp, #0x00100000		@ physical
diff --git a/arch/arm/mach-nomadik/include/mach/debug-macro.S b/arch/arm/mach-nomadik/include/mach/debug-macro.S
index e7151b4..73541792 100644
--- a/arch/arm/mach-nomadik/include/mach/debug-macro.S
+++ b/arch/arm/mach-nomadik/include/mach/debug-macro.S
@@ -10,7 +10,7 @@
  *
 */
 
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 		mov	\rp, #0x00100000
 		add	\rp, \rp, #0x000fb000
 		add	\rv, \rp, #0xf0000000	@ virtual base
diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
index 6285604..f944ae8 100644
--- a/arch/arm/mach-omap1/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
@@ -31,7 +31,7 @@ omap_uart_virt:	.word	0x0
 		 * the desired UART phys and virt addresses temporarily into
 		 * the omap_uart_phys and omap_uart_virt above.
 		 */
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 
 		/* Use omap_uart_phys/virt if already configured */
 9:		mrc	p15, 0, \rp, c1, c0
diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
index 48adfe9..fbd23ec 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -34,7 +34,7 @@ omap_uart_lsr:	.word	0
 		 * the desired UART phys and virt addresses temporarily into
 		 * the omap_uart_phys and omap_uart_virt above.
 		 */
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 
 		/* Use omap_uart_phys/virt if already configured */
 10:		mrc	p15, 0, \rp, c1, c0
diff --git a/arch/arm/mach-orion5x/include/mach/debug-macro.S b/arch/arm/mach-orion5x/include/mach/debug-macro.S
index 5e3bf5b..f340ed8 100644
--- a/arch/arm/mach-orion5x/include/mach/debug-macro.S
+++ b/arch/arm/mach-orion5x/include/mach/debug-macro.S
@@ -10,7 +10,7 @@
 
 #include <mach/orion5x.h>
 
-	.macro  addruart, rp, rv
+	.macro  addruart, rp, rv, tmp
 	ldr	\rp, =ORION5X_REGS_PHYS_BASE
 	ldr	\rv, =ORION5X_REGS_VIRT_BASE
 	orr	\rp, \rp, #0x00012000
diff --git a/arch/arm/mach-pnx4008/include/mach/debug-macro.S b/arch/arm/mach-pnx4008/include/mach/debug-macro.S
index 931afeb..469d60d 100644
--- a/arch/arm/mach-pnx4008/include/mach/debug-macro.S
+++ b/arch/arm/mach-pnx4008/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
  *
 */
 
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 		mov	\rp, #0x00090000
 		add	\rv, \rp, #0xf4000000	@ virtual
 		add	\rp, \rp, #0x40000000	@ physical
diff --git a/arch/arm/mach-prima2/include/mach/debug-macro.S b/arch/arm/mach-prima2/include/mach/debug-macro.S
index bf75106..cd97492 100644
--- a/arch/arm/mach-prima2/include/mach/debug-macro.S
+++ b/arch/arm/mach-prima2/include/mach/debug-macro.S
@@ -9,7 +9,7 @@
 #include <mach/hardware.h>
 #include <mach/uart.h>
 
-	.macro	addruart, rp, rv
+	.macro	addruart, rp, rv, tmp
 	ldr	\rp, =SIRFSOC_UART1_PA_BASE		@ physical
 	ldr	\rv, =SIRFSOC_UART1_VA_BASE		@ virtual
 	.endm
diff --git a/arch/arm/mach-pxa/include/mach/debug-macro.S b/arch/arm/mach-pxa/include/mach/debug-macro.S
index 7d5c751..70b112e 100644
--- a/arch/arm/mach-pxa/include/mach/debug-macro.S
+++ b/arch/arm/mach-pxa/include/mach/debug-macro.S
@@ -13,7 +13,7 @@
 
 #include "hardware.h"
 
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 		mov	\rp, #0x00100000
 		orr	\rv, \rp, #io_p2v(0x40000000)	@ virtual
 		orr	\rp, \rp, #0x40000000		@ physical
diff --git a/arch/arm/mach-realview/include/mach/debug-macro.S b/arch/arm/mach-realview/include/mach/debug-macro.S
index 90b687c..fb4901c 100644
--- a/arch/arm/mach-realview/include/mach/debug-macro.S
+++ b/arch/arm/mach-realview/include/mach/debug-macro.S
@@ -33,7 +33,7 @@
 #error "Unknown RealView platform"
 #endif
 
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 		mov	\rp, #DEBUG_LL_UART_OFFSET
 		orr	\rv, \rp, #0xfb000000	@ virtual base
 		orr	\rp, \rp, #0x10000000	@ physical base
diff --git a/arch/arm/mach-rpc/include/mach/debug-macro.S b/arch/arm/mach-rpc/include/mach/debug-macro.S
index 85effff..6d28cc9 100644
--- a/arch/arm/mach-rpc/include/mach/debug-macro.S
+++ b/arch/arm/mach-rpc/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
  *
 */
 
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 		mov	\rp, #0x00010000
 		orr	\rp, \rp, #0x00000fe0
 		orr	\rv, \rp, #0xe0000000	@ virtual
diff --git a/arch/arm/mach-s3c2410/include/mach/debug-macro.S b/arch/arm/mach-s3c2410/include/mach/debug-macro.S
index 5882dea..4135de8 100644
--- a/arch/arm/mach-s3c2410/include/mach/debug-macro.S
+++ b/arch/arm/mach-s3c2410/include/mach/debug-macro.S
@@ -19,7 +19,7 @@
 #define S3C2410_UART1_OFF (0x4000)
 #define SHIFT_2440TXF (14-9)
 
-	.macro addruart, rp, rv
+	.macro addruart, rp, rv, tmp
 		ldr	\rp, = S3C24XX_PA_UART
 		ldr	\rv, = S3C24XX_VA_UART
 #if CONFIG_DEBUG_S3C_UART != 0
diff --git a/arch/arm/mach-s3c64xx/include/mach/debug-macro.S b/arch/arm/mach-s3c64xx/include/mach/debug-macro.S
index a29e705..c0c076a 100644
--- a/arch/arm/mach-s3c64xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-s3c64xx/include/mach/debug-macro.S
@@ -21,7 +21,7 @@
 	 * aligned and add in the offset when we load the value here.
 	 */
 
-	.macro addruart, rp, rv
+	.macro addruart, rp, rv, tmp
 		ldr	\rp, = S3C_PA_UART
 		ldr	\rv, = (S3C_VA_UART + S3C_PA_UART & 0xfffff)
 #if CONFIG_DEBUG_S3C_UART != 0
diff --git a/arch/arm/mach-s5p64x0/include/mach/debug-macro.S b/arch/arm/mach-s5p64x0/include/mach/debug-macro.S
index 79b04e6..e80ba3c 100644
--- a/arch/arm/mach-s5p64x0/include/mach/debug-macro.S
+++ b/arch/arm/mach-s5p64x0/include/mach/debug-macro.S
@@ -15,7 +15,7 @@
 
 #include <plat/regs-serial.h>
 
-	.macro addruart, rp, rv
+	.macro addruart, rp, rv, tmp
 		mov	\rp, #0xE0000000
 		orr	\rp, \rp, #0x00100000
 		ldr	\rp, [\rp, #0x118 ]
diff --git a/arch/arm/mach-s5pc100/include/mach/debug-macro.S b/arch/arm/mach-s5pc100/include/mach/debug-macro.S
index b2ba95d..694f759 100644
--- a/arch/arm/mach-s5pc100/include/mach/debug-macro.S
+++ b/arch/arm/mach-s5pc100/include/mach/debug-macro.S
@@ -22,7 +22,7 @@
 	 * aligned and add in the offset when we load the value here.
 	 */
 
-	.macro addruart, rp, rv
+	.macro addruart, rp, rv, tmp
 		ldr	\rp, = S3C_PA_UART
 		ldr	\rv, = S3C_VA_UART
 #if CONFIG_DEBUG_S3C_UART != 0
diff --git a/arch/arm/mach-s5pv210/include/mach/debug-macro.S b/arch/arm/mach-s5pv210/include/mach/debug-macro.S
index 169fe65..79e5559 100644
--- a/arch/arm/mach-s5pv210/include/mach/debug-macro.S
+++ b/arch/arm/mach-s5pv210/include/mach/debug-macro.S
@@ -21,7 +21,7 @@
 	 * aligned and add in the offset when we load the value here.
 	 */
 
-	.macro addruart, rp, rv
+	.macro addruart, rp, rv, tmp
 		ldr	\rp, = S3C_PA_UART
 		ldr	\rv, = S3C_VA_UART
 #if CONFIG_DEBUG_S3C_UART != 0
diff --git a/arch/arm/mach-sa1100/include/mach/debug-macro.S b/arch/arm/mach-sa1100/include/mach/debug-macro.S
index 0cd0fc9..530772d 100644
--- a/arch/arm/mach-sa1100/include/mach/debug-macro.S
+++ b/arch/arm/mach-sa1100/include/mach/debug-macro.S
@@ -12,7 +12,7 @@
 */
 #include <mach/hardware.h>
 
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 		mrc	p15, 0, \rp, c1, c0
 		tst	\rp, #1			@ MMU enabled?
 		moveq	\rp, #0x80000000	@ physical base address
diff --git a/arch/arm/mach-shark/include/mach/debug-macro.S b/arch/arm/mach-shark/include/mach/debug-macro.S
index a473f55..20eb2bf 100644
--- a/arch/arm/mach-shark/include/mach/debug-macro.S
+++ b/arch/arm/mach-shark/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
  *
 */
 
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 		mov	\rp, #0xe0000000
 		orr	\rp, \rp, #0x000003f8
 		mov	\rv, \rp
diff --git a/arch/arm/mach-tegra/include/mach/debug-macro.S b/arch/arm/mach-tegra/include/mach/debug-macro.S
index e0ebe65..619abc6 100644
--- a/arch/arm/mach-tegra/include/mach/debug-macro.S
+++ b/arch/arm/mach-tegra/include/mach/debug-macro.S
@@ -21,7 +21,7 @@
 #include <mach/io.h>
 #include <mach/iomap.h>
 
-	.macro  addruart, rp, rv
+	.macro  addruart, rp, rv, tmp
         ldr     \rp, =IO_APB_PHYS       @ physical
         ldr     \rv, =IO_APB_VIRT        @ virtual
 	orr	\rp, \rp, #(TEGRA_DEBUG_UART_BASE & 0xFF)
diff --git a/arch/arm/mach-u300/include/mach/debug-macro.S b/arch/arm/mach-u300/include/mach/debug-macro.S
index df71570..8ae8e4a 100644
--- a/arch/arm/mach-u300/include/mach/debug-macro.S
+++ b/arch/arm/mach-u300/include/mach/debug-macro.S
@@ -10,7 +10,7 @@
  */
 #include <mach/hardware.h>
 
-	.macro	addruart, rp, rv
+	.macro	addruart, rp, rv, tmp
 	/* If we move the address using MMU, use this. */
 	ldr	\rp,	  = U300_SLOW_PER_PHYS_BASE @ MMU off, physical address
 	ldr	\rv,	  = U300_SLOW_PER_VIRT_BASE @ MMU on, virtual address
diff --git a/arch/arm/mach-ux500/include/mach/debug-macro.S b/arch/arm/mach-ux500/include/mach/debug-macro.S
index 700fb05..8d74d92 100644
--- a/arch/arm/mach-ux500/include/mach/debug-macro.S
+++ b/arch/arm/mach-ux500/include/mach/debug-macro.S
@@ -35,7 +35,7 @@
 #define UX500_UART(n)	__UX500_UART(n)
 #define UART_BASE	UX500_UART(CONFIG_UX500_DEBUG_UART)
 
-	.macro	addruart, rp, rv
+	.macro	addruart, rp, rv, tmp
 	ldr	\rp, =UART_BASE				@ no, physical address
 	ldr	\rv, =IO_ADDRESS(UART_BASE)		@ yes, virtual address
 	.endm
diff --git a/arch/arm/mach-versatile/include/mach/debug-macro.S b/arch/arm/mach-versatile/include/mach/debug-macro.S
index eb2cf7d..d0fbd7f 100644
--- a/arch/arm/mach-versatile/include/mach/debug-macro.S
+++ b/arch/arm/mach-versatile/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
  *
 */
 
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 		mov	\rp,      #0x001F0000
 		orr	\rp, \rp, #0x00001000
 		orr	\rv, \rp, #0xf1000000	@ virtual base
diff --git a/arch/arm/mach-vexpress/include/mach/debug-macro.S b/arch/arm/mach-vexpress/include/mach/debug-macro.S
index 050d65e..fd9e6c7 100644
--- a/arch/arm/mach-vexpress/include/mach/debug-macro.S
+++ b/arch/arm/mach-vexpress/include/mach/debug-macro.S
@@ -12,7 +12,7 @@
 
 #define DEBUG_LL_UART_OFFSET	0x00009000
 
-		.macro	addruart,rp,rv
+		.macro	addruart,rp,rv,tmp
 		mov	\rp, #DEBUG_LL_UART_OFFSET
 		orr	\rv, \rp, #0xf8000000	@ virtual base
 		orr	\rp, \rp, #0x10000000	@ physical base
diff --git a/arch/arm/mach-vt8500/include/mach/debug-macro.S b/arch/arm/mach-vt8500/include/mach/debug-macro.S
index f119162..ca292f2 100644
--- a/arch/arm/mach-vt8500/include/mach/debug-macro.S
+++ b/arch/arm/mach-vt8500/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
  *
 */
 
-	.macro	addruart, rp, rv
+	.macro	addruart, rp, rv, tmp
 	mov	\rp,      #0x00200000
 	orr	\rv, \rp, #0xf8000000
 	orr	\rp, \rp, #0xd8000000
diff --git a/arch/arm/mach-zynq/include/mach/debug-macro.S b/arch/arm/mach-zynq/include/mach/debug-macro.S
index 9f664d5..3ab0be1 100644
--- a/arch/arm/mach-zynq/include/mach/debug-macro.S
+++ b/arch/arm/mach-zynq/include/mach/debug-macro.S
@@ -17,7 +17,7 @@
 #include <mach/zynq_soc.h>
 #include <mach/uart.h>
 
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 		ldr	\rp, =LL_UART_PADDR	@ physical
 		ldr	\rv, =LL_UART_VADDR	@ virtual
 		.endm
diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
index e4dde91..a304593 100644
--- a/arch/arm/plat-mxc/include/mach/debug-macro.S
+++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
@@ -54,7 +54,7 @@
 
 #define UART_VADDR	IMX_IO_ADDRESS(UART_PADDR)
 
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 		ldr	\rp, =UART_PADDR	@ physical
 		ldr	\rv, =UART_VADDR	@ virtual
 		.endm
diff --git a/arch/arm/plat-spear/include/plat/debug-macro.S b/arch/arm/plat-spear/include/plat/debug-macro.S
index 8501bbf..02b160a 100644
--- a/arch/arm/plat-spear/include/plat/debug-macro.S
+++ b/arch/arm/plat-spear/include/plat/debug-macro.S
@@ -14,7 +14,7 @@
 #include <linux/amba/serial.h>
 #include <mach/hardware.h>
 
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 		mov	\rp, #SPEAR_DBG_UART_BASE		@ Physical base
 		mov	\rv, #VA_SPEAR_DBG_UART_BASE		@ Virtual base
 		.endm
diff --git a/arch/arm/plat-tcc/include/mach/debug-macro.S b/arch/arm/plat-tcc/include/mach/debug-macro.S
index 7662f73..cf17d04 100644
--- a/arch/arm/plat-tcc/include/mach/debug-macro.S
+++ b/arch/arm/plat-tcc/include/mach/debug-macro.S
@@ -9,7 +9,7 @@
  *
  */
 
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 		moveq	\rp, #0x90000000	@ physical base address
 		movne	\rv, #0xF1000000	@ virtual base
 		orr	\rp, \rp, #0x00007000	@ UART0
-- 
1.7.4
