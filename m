From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon, 22 Dec 2014 13:05:38 +0300
Subject: [PATCH 3/5] ARM: sa1100: switch to irq_domain_add_simple()
In-Reply-To: <1419242740-20219-1-git-send-email-dbaryshkov@gmail.com>
References: <1419242740-20219-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1419242740-20219-3-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As now both SC and GPIO irq domains start from 0 hwirq and do not
contain holes, switch to using irq_domain_add_simple() instead of
irq_domain_add_legacy().

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/irq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index 5589b23..a9dfe8e 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -318,12 +318,12 @@ void __init sa1100_init_irq(void)
 	 */
 	ICCR = 1;
 
-	sa1100_normal_irqdomain = irq_domain_add_legacy(NULL,
-			32, IRQ_GPIO0_SC, 0,
+	sa1100_normal_irqdomain = irq_domain_add_simple(NULL,
+			32, IRQ_GPIO0_SC,
 			&sa1100_normal_irqdomain_ops, NULL);
 
-	sa1100_gpio_irqdomain = irq_domain_add_legacy(NULL,
-			28, IRQ_GPIO0, 0,
+	sa1100_gpio_irqdomain = irq_domain_add_simple(NULL,
+			28, IRQ_GPIO0,
 			&sa1100_gpio_irqdomain_ops, NULL);
 
 	/*
-- 
2.1.3
