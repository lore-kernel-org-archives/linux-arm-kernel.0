From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 23 May 2013 18:18:48 +0800
Subject: [PATCH] at91: sama5: fix incorrect PMC pcr div definition
Message-ID: <1369304328-11442-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 arch/arm/mach-at91/include/mach/at91_pmc.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91_pmc.h b/arch/arm/mach-at91/include/mach/at91_pmc.h
index 31df120..2bd7f51 100644
--- a/arch/arm/mach-at91/include/mach/at91_pmc.h
+++ b/arch/arm/mach-at91/include/mach/at91_pmc.h
@@ -179,9 +179,9 @@ extern void __iomem *at91_pmc_base;
 #define		AT91_PMC_PCR_CMD	(0x1  <<  12)		/* Command (read=0, write=1) */
 #define		AT91_PMC_PCR_DIV(n)	((n)  <<  16)		/* Divisor Value */
 #define			AT91_PMC_PCR_DIV0	0x0			/* Peripheral clock is MCK */
-#define			AT91_PMC_PCR_DIV2	0x2			/* Peripheral clock is MCK/2 */
-#define			AT91_PMC_PCR_DIV4	0x4			/* Peripheral clock is MCK/4 */
-#define			AT91_PMC_PCR_DIV8	0x8			/* Peripheral clock is MCK/8 */
+#define			AT91_PMC_PCR_DIV2	0x1			/* Peripheral clock is MCK/2 */
+#define			AT91_PMC_PCR_DIV4	0x2			/* Peripheral clock is MCK/4 */
+#define			AT91_PMC_PCR_DIV8	0x3			/* Peripheral clock is MCK/8 */
 #define		AT91_PMC_PCR_EN		(0x1  <<  28)		/* Enable */
 
 #endif
-- 
1.7.10
