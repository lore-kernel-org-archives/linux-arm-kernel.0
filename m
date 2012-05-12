From: linux-arm@overkiz.com (Boris BREZILLON)
Date: Sat, 12 May 2012 10:53:54 +0200
Subject: [PATCH 1/5] ARM: at91: Add PMC registers definitions.
In-Reply-To: <1336812838-3649-1-git-send-email-linux-arm@overkiz.com>
References: <1336812838-3649-1-git-send-email-linux-arm@overkiz.com>
Message-ID: <1336812838-3649-2-git-send-email-linux-arm@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds definition of SOSCSEL bit used by pmc-osc.c to know 
which kind of oscilator is used (internal RC => drift).

This patch adds ICPLLR definition used in pll config. 
---
 arch/arm/mach-at91/include/mach/at91_pmc.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-at91/include/mach/at91_pmc.h b/arch/arm/mach-at91/include/mach/at91_pmc.h
index 3660478..845af9e 100644
--- a/arch/arm/mach-at91/include/mach/at91_pmc.h
+++ b/arch/arm/mach-at91/include/mach/at91_pmc.h
@@ -149,6 +149,7 @@ extern void __iomem *at91_pmc_base;
 #define		AT91_PMC_LOCKB		(1 <<  2)		/* PLLB Lock */
 #define		AT91_PMC_MCKRDY		(1 <<  3)		/* Master Clock */
 #define		AT91_PMC_LOCKU		(1 <<  6)		/* UPLL Lock [some SAM9] */
+#define		AT91_PMC_SOSCSEL	(1 <<  7)		/* Slow osc external selction */
 #define		AT91_PMC_PCK0RDY	(1 <<  8)		/* Programmable Clock 0 */
 #define		AT91_PMC_PCK1RDY	(1 <<  9)		/* Programmable Clock 1 */
 #define		AT91_PMC_PCK2RDY	(1 << 10)		/* Programmable Clock 2 */
@@ -158,6 +159,10 @@ extern void __iomem *at91_pmc_base;
 #define		AT91_PMC_CFDEV		(1 << 18)		/* Clock Failure Detector Event [some SAM9] */
 #define	AT91_PMC_IMR		0x6c			/* Interrupt Mask Register */
 
+#define	AT91_PMC_PLLICPR	0x80			/* PLL Charge Pump Current Register */
+#define		AT91_PMC_ICPLLA		(1 <<  0)		/* ICPLLA Flag */
+#define		AT91_PMC_ICPLLB		(1 <<  16)		/* ICPLLA Flag */
+
 #define AT91_PMC_PROT		0xe4			/* Write Protect Mode Register [some SAM9] */
 #define		AT91_PMC_WPEN		(0x1  <<  0)		/* Write Protect Enable */
 #define		AT91_PMC_WPKEY		(0xffffff << 8)		/* Write Protect Key */
-- 
1.7.9.5
