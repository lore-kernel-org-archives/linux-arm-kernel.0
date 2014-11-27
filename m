From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 27 Nov 2014 17:06:39 +0100
Subject: [PATCH 11/11] ARM: at91: remove unused IRQ function declarations
In-Reply-To: <cover.1417103399.git.nicolas.ferre@atmel.com>
References: <cover.1417103399.git.nicolas.ferre@atmel.com>
Message-ID: <e3abb8ec58303988f78739f2d837b7d62ce556b5.1417103399.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 3b26f39b0ab1 (ARM: at91: make use of the new AIC driver for dt enabled
boards) the old IRQ initialisation functions aren't used anymore: remove their
declaration in generic.h.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/generic.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 713d1d9e50a1..eb81940f9848 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -29,10 +29,6 @@ extern void __init at91_dt_initialize(void);
  /* Interrupts */
 extern void __init at91_init_irq_default(void);
 extern void __init at91_init_interrupts(unsigned int priority[]);
-extern int  __init at91_aic_of_init(struct device_node *node,
-				    struct device_node *parent);
-extern int  __init at91_aic5_of_init(struct device_node *node,
-				    struct device_node *parent);
 extern void __init at91_sysirq_mask_rtc(u32 rtc_base);
 extern void __init at91_sysirq_mask_rtt(u32 rtt_base);
 
-- 
2.1.3
