From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Sep 2011 02:46:11 -0700
Subject: [PATCH 2.5/6] ARM: omap: prepare debug-macro.S for offset based
	calculation of omap_uart_phys and virt
In-Reply-To: <1314932353-24813-3-git-send-email-nico@fluxnic.net>
References: <1314932353-24813-1-git-send-email-nico@fluxnic.net>
	<1314932353-24813-3-git-send-email-nico@fluxnic.net>
Message-ID: <20110905094611.GB1903@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just change 99 to 100 to allow using 99 for omap_uart_phys in the
following patches.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap1/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
@@ -43,7 +43,7 @@ omap_uart_virt:	.word	0x0
 		ldr	\rv, [\rv, #0]
 		cmp	\rp, #0			@ is port configured?
 		cmpne	\rv, #0
-		bne	99f			@ already configured
+		bne	100f			@ already configured
 
 		/* Check the debug UART configuration set in uncompress.h */
 		and	\rp, pc, #0xff000000
@@ -82,7 +82,7 @@ omap_uart_virt:	.word	0x0
 		add	\rv, \rv, #4		@ omap_uart_lsr
 		str	\rp, [\rv, #0]
 		b	9b
-99:
+100:
 		.endm
 
 		.macro	senduart,rd,rx
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -46,7 +46,7 @@ omap_uart_lsr:	.word	0
 		ldr	\rv, [\rv, #0]
 		cmp	\rp, #0			@ is port configured?
 		cmpne	\rv, #0
-		bne	99f			@ already configured
+		bne	100f			@ already configured
 
 		/* Check the debug UART configuration set in uncompress.h */
 		mov	\rp, pc
@@ -135,7 +135,7 @@ omap_uart_lsr:	.word	0
 		str	\rp, [\rv, #0]
 
 		b	10b
-99:
+100:
 		.endm
 
 		.macro	senduart,rd,rx
