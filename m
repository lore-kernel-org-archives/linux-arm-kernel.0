From: tony@atomide.com (Tony Lindgren)
Date: Fri, 29 Jan 2010 18:01:30 -0800
Subject: [PATCH 3/9] omap4: Use get_irqnr_preamble
In-Reply-To: <20100130020036.10590.78028.stgit@baageli.muru.com>
References: <20100130020036.10590.78028.stgit@baageli.muru.com>
Message-ID: <20100130020130.10590.82312.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use get_irqnr_preamble

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/include/mach/entry-macro.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
index 3e63aaa..101ed79 100644
--- a/arch/arm/mach-omap2/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
@@ -92,6 +92,7 @@ omap_irq_base:	.word	0
 #ifdef CONFIG_ARCH_OMAP4
 
 		.macro  get_irqnr_preamble, base, tmp
+		ldr     \base, =OMAP4_IRQ_BASE
 		.endm
 
 		/*
@@ -114,7 +115,6 @@ omap_irq_base:	.word	0
 		 * valid range for an IRQ (30-1020 inclusive).
 		 */
 		.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
-		ldr     \base, =OMAP4_IRQ_BASE
 		ldr     \irqstat, [\base, #GIC_CPU_INTACK]
 
 		ldr     \tmp, =1021
