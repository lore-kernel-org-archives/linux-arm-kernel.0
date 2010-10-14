From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 14 Oct 2010 19:25:03 +0200
Subject: [PATCH 2/5] AT91: trivial: align comment of at91sam9g20_reset with
	one more tab
In-Reply-To: <20100528153725.GA5102@axolotl.localnet>
References: <20100528153725.GA5102@axolotl.localnet>
Message-ID: <6c647bd39375c3185b7e446e296f3e8b248a17d5.1287076894.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Preparing next patch with longer names

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91sam9g20_reset.S |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9g20_reset.S b/arch/arm/mach-at91/at91sam9g20_reset.S
index f6e9b03..1631c38 100644
--- a/arch/arm/mach-at91/at91sam9g20_reset.S
+++ b/arch/arm/mach-at91/at91sam9g20_reset.S
@@ -33,23 +33,23 @@
 			.globl	at91sam9g20_reset
 
 at91sam9g20_reset:	mov	r0, #0
-			mcr	p15, 0, r0, c7, c5, 0	@ flush I-cache
+			mcr	p15, 0, r0, c7, c5, 0		@ flush I-cache
 
 			mrc	p15, 0, r0, c1, c0, 0
 			orr	r0, r0, #CP15_CR_I
-			mcr	p15, 0, r0, c1, c0, 0	@ enable I-cache
+			mcr	p15, 0, r0, c1, c0, 0		@ enable I-cache
 
-			ldr	r0, =SDRAMC_BASE	@ preload constants
+			ldr	r0, =SDRAMC_BASE		@ preload constants
 			ldr	r1, =RSTC_BASE
 
 			mov	r2, #1
 			mov	r3, #SDRAMC_LPCB_POWER_DOWN
 			ldr	r4, =RSTC_KEY | RSTC_PERRST | RSTC_PROCRST
 
-			.balign	32			@ align to cache line
+			.balign	32				@ align to cache line
 
-			str	r2, [r0, #SDRAMC_TR]	@ disable SDRAM access
-			str	r3, [r0, #SDRAMC_LPR]	@ power down SDRAM
-			str	r4, [r1, #RSTC_CR]	@ reset processor
+			str	r2, [r0, #SDRAMC_TR]		@ disable SDRAM access
+			str	r3, [r0, #SDRAMC_LPR]		@ power down SDRAM
+			str	r4, [r1, #RSTC_CR]		@ reset processor
 
 			b	.
-- 
1.7.3
