From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 18 Mar 2015 17:28:57 +0530
Subject: [RESEND 6/7] ARM: davinci: irqs: Correct McASP1 TX interrupt
 definition for DM646x
In-Reply-To: <1426147591-31764-7-git-send-email-peter.ujfalusi@ti.com>
References: <1426147591-31764-1-git-send-email-peter.ujfalusi@ti.com>
 <1426147591-31764-7-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <55096881.9040506@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 March 2015 01:36 PM, Peter Ujfalusi wrote:
> McASP1 TX interrupt is 30, not 32 on DM646x DMSoC
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Okay, sparse spotted an error uncovered by this patch. I think it 
will be good to fix that as well here. Updated patch attached.

Thanks,
Sekhar

---8<---
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 12 Mar 2015 10:06:30 +0200
Subject: [PATCH] ARM: davinci: irqs: Correct McASP1 TX interrupt definition
 for DM646x

McASP1 TX interrupt is 30, not 32 on DM646x DMSoC.

While at it remove the bogus AEMIF interrupt entry from
dm646x_default_priorities[]. AEMIF interrupt on DM6467 is
60 not 30 and the entry for the correct interrupt number
is already present in the same table.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
[nsekhar at ti.com: remove bogus entry from dm646x_default_priorities[]]
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/dm646x.c            |    1 -
 arch/arm/mach-davinci/include/mach/irqs.h |    2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index d2a2619aee81..58769eddd3c3 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -493,7 +493,6 @@ static u8 dm646x_default_priorities[DAVINCI_N_AINTC_IRQ] = {
 	[IRQ_DM646X_EMACMISCINT]        = 7,
 	[IRQ_DM646X_MCASP0TXINT]        = 7,
 	[IRQ_DM646X_MCASP0RXINT]        = 7,
-	[IRQ_AEMIFINT]                  = 7,
 	[IRQ_DM646X_RESERVED_3]         = 7,
 	[IRQ_DM646X_MCASP1TXINT]        = 7,    /* clockevent */
 	[IRQ_TINT0_TINT34]              = 7,    /* clocksource */
diff --git a/arch/arm/mach-davinci/include/mach/irqs.h b/arch/arm/mach-davinci/include/mach/irqs.h
index 354af71798dc..edb2ca62321a 100644
--- a/arch/arm/mach-davinci/include/mach/irqs.h
+++ b/arch/arm/mach-davinci/include/mach/irqs.h
@@ -129,8 +129,8 @@
 #define IRQ_DM646X_EMACMISCINT  27
 #define IRQ_DM646X_MCASP0TXINT  28
 #define IRQ_DM646X_MCASP0RXINT  29
+#define IRQ_DM646X_MCASP1TXINT  30
 #define IRQ_DM646X_RESERVED_3   31
-#define IRQ_DM646X_MCASP1TXINT  32
 #define IRQ_DM646X_VLQINT       38
 #define IRQ_DM646X_UARTINT2     42
 #define IRQ_DM646X_SPINT0       43
-- 
1.7.10.1
