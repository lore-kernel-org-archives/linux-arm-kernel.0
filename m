From: ynvich@gmail.com (Sergei Ianovich)
Date: Mon,  9 Dec 2013 02:53:46 +0400
Subject: [PATCH 6/9] ARM: dts: pxa3xx: move declaration to header
In-Reply-To: <1386543229-1542-1-git-send-email-ynvich@gmail.com>
References: <1386348542-9584-1-git-send-email-ynvich@gmail.com>
 <1386543229-1542-1-git-send-email-ynvich@gmail.com>
Message-ID: <1386543229-1542-7-git-send-email-ynvich@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This way it will be more difficult to change the declaration in one
place, but not the other.

In addition, the change allows to use the binding for pxa-gpio on
other PXA CPUs.

Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
CC: Daniel Mack <zonque@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/include/mach/irqs.h | 4 ++++
 arch/arm/mach-pxa/pxa3xx.c            | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/irqs.h b/arch/arm/mach-pxa/include/mach/irqs.h
index 48c2fd8..0d71ae9 100644
--- a/arch/arm/mach-pxa/include/mach/irqs.h
+++ b/arch/arm/mach-pxa/include/mach/irqs.h
@@ -113,4 +113,8 @@ void ichp_handle_irq(struct pt_regs *);
 void pxa_init_irq(int irq_nr, int (*set_wake)(struct irq_data *, unsigned int));
 #endif
 
+#ifdef CONFIG_OF
+extern void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int));
+#endif /* CONFIG_OF */
+
 #endif /* __ASM_MACH_IRQS_H */
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 87011f3..2397dec 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -42,8 +42,6 @@
 #define PECR_IE(n)	((1 << ((n) * 2)) << 28)
 #define PECR_IS(n)	((1 << ((n) * 2)) << 29)
 
-extern void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int));
-
 static DEFINE_PXA3_CKEN(pxa3xx_ffuart, FFUART, 14857000, 1);
 static DEFINE_PXA3_CKEN(pxa3xx_btuart, BTUART, 14857000, 1);
 static DEFINE_PXA3_CKEN(pxa3xx_stuart, STUART, 14857000, 1);
-- 
1.8.4.3
