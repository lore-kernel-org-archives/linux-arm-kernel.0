From: tony@atomide.com (Tony Lindgren)
Date: Tue, 7 Dec 2010 17:48:29 -0800
Subject: [PATCH 2/3] omap1: Use get_irqnr_preamble
In-Reply-To: <20101208014548.GJ17435@atomide.com>
References: <20101204001435.28853.29616.stgit@baageli.muru.com>
	<alpine.LFD.2.00.1012040040590.10437@xanadu.home>
	<20101204180541.GH17222@atomide.com>
	<alpine.LFD.2.00.1012042126350.10437@xanadu.home>
	<20101205031002.GP17222@atomide.com>
	<20101208014548.GJ17435@atomide.com>
Message-ID: <20101208014829.GL17435@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This saves some cycles for multiple interrupts case.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/include/mach/entry-macro.S b/arch/arm/mach-omap1/include/mach/entry-macro.S
index c9be6d4..584bf7b 100644
--- a/arch/arm/mach-omap1/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap1/include/mach/entry-macro.S
@@ -31,13 +31,13 @@ omap_irq_flags:
 		.endm
 
 		.macro  get_irqnr_preamble, base, tmp
+		ldr	\base, =OMAP1_IO_ADDRESS(OMAP_IH1_BASE)
 		.endm
 
 		.macro  arch_ret_to_user, tmp1, tmp2
 		.endm
 
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-		ldr	\base, =OMAP1_IO_ADDRESS(OMAP_IH1_BASE)
 		ldr	\irqnr, [\base, #IRQ_ITR_REG_OFFSET]
 		ldr	\tmp, [\base, #IRQ_MIR_REG_OFFSET]
 		mov	\irqstat, #0xffffffff
