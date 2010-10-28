From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 28 Oct 2010 14:10:09 +0900
Subject: [PATCH] arm: s5pc210: Use the nr_irqs instead of NR_IRQS
Message-ID: <20101028051009.GA23311@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

When enable the SPARSE_IRQ. It's not handled the proper number of irqs

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/mach-s5pv310/irq-combiner.c b/arch/arm/mach-s5pv310/irq-combiner.c
index 0f70521..1bb38bf 100644
--- a/arch/arm/mach-s5pv310/irq-combiner.c
+++ b/arch/arm/mach-s5pv310/irq-combiner.c
@@ -73,7 +73,7 @@ static void combiner_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
 	}
 
 	cascade_irq = combiner_irq + (chip_data->irq_offset & ~31);
-	if (unlikely(cascade_irq >= NR_IRQS))
+	if (unlikely(cascade_irq >= nr_irqs))
 		do_bad_IRQ(cascade_irq, desc);
 	else
 		generic_handle_irq(cascade_irq);
