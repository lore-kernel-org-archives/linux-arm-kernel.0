From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 14 Feb 2011 17:22:59 +0900
Subject: [PATCH 03/11] ARM: EXYNOS4: Update IRQ part
In-Reply-To: <1297671787-10571-1-git-send-email-kgene.kim@samsung.com>
References: <1297671787-10571-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1297671787-10571-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates IRQ part of EXYNOS4 according to the change of
ARCH name, EXYNOS4.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 .../include/mach/irqs.h                            |    8 +-
 .../include/mach/regs-irq.h                        |    8 +-
 .../{mach-s5pv310 => mach-exynos4}/irq-combiner.c  |    4 +-
 arch/arm/{mach-s5pv310 => mach-exynos4}/irq-eint.c |   62 ++++++++++----------
 4 files changed, 41 insertions(+), 41 deletions(-)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/include/mach/irqs.h (96%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/include/mach/regs-irq.h (66%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/irq-combiner.c (96%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/irq-eint.c (72%)

diff --git a/arch/arm/mach-s5pv310/include/mach/irqs.h b/arch/arm/mach-exynos4/include/mach/irqs.h
similarity index 96%
rename from arch/arm/mach-s5pv310/include/mach/irqs.h
rename to arch/arm/mach-exynos4/include/mach/irqs.h
index 536b0b5..2dc5900 100644
--- a/arch/arm/mach-s5pv310/include/mach/irqs.h
+++ b/arch/arm/mach-exynos4/include/mach/irqs.h
@@ -1,9 +1,9 @@
-/* linux/arch/arm/mach-s5pv310/include/mach/irqs.h
+/* linux/arch/arm/mach-exynos4/include/mach/irqs.h
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
- * S5PV310 - IRQ definitions
+ * EXYNOS4 - IRQ definitions
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/mach-s5pv310/include/mach/regs-irq.h b/arch/arm/mach-exynos4/include/mach/regs-irq.h
similarity index 66%
rename from arch/arm/mach-s5pv310/include/mach/regs-irq.h
rename to arch/arm/mach-exynos4/include/mach/regs-irq.h
index c6e09c7..9c7b4bf 100644
--- a/arch/arm/mach-s5pv310/include/mach/regs-irq.h
+++ b/arch/arm/mach-exynos4/include/mach/regs-irq.h
@@ -1,9 +1,9 @@
-/* linux/arch/arm/mach-s5pv310/include/mach/regs-irq.h
+/* linux/arch/arm/mach-exynos4/include/mach/regs-irq.h
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
- * S5PV310 - IRQ register definitions
+ * EXYNOS4 - IRQ register definitions
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/mach-s5pv310/irq-combiner.c b/arch/arm/mach-exynos4/irq-combiner.c
similarity index 96%
rename from arch/arm/mach-s5pv310/irq-combiner.c
rename to arch/arm/mach-exynos4/irq-combiner.c
index 1ea4a9e..31618d9 100644
--- a/arch/arm/mach-s5pv310/irq-combiner.c
+++ b/arch/arm/mach-exynos4/irq-combiner.c
@@ -1,6 +1,6 @@
-/* linux/arch/arm/mach-s5pv310/irq-combiner.c
+/* linux/arch/arm/mach-exynos4/irq-combiner.c
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
  * Based on arch/arm/common/gic.c
diff --git a/arch/arm/mach-s5pv310/irq-eint.c b/arch/arm/mach-exynos4/irq-eint.c
similarity index 72%
rename from arch/arm/mach-s5pv310/irq-eint.c
rename to arch/arm/mach-exynos4/irq-eint.c
index 477bd9e..4f7ad4a 100644
--- a/arch/arm/mach-s5pv310/irq-eint.c
+++ b/arch/arm/mach-exynos4/irq-eint.c
@@ -1,9 +1,9 @@
-/* linux/arch/arm/mach-s5pv310/irq-eint.c
+/* linux/arch/arm/mach-exynos4/irq-eint.c
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
- * S5PV310 - IRQ EINT support
+ * EXYNOS4 - IRQ EINT support
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -27,7 +27,7 @@ static DEFINE_SPINLOCK(eint_lock);
 
 static unsigned int eint0_15_data[16];
 
-static unsigned int s5pv310_get_irq_nr(unsigned int number)
+static unsigned int exynos4_get_irq_nr(unsigned int number)
 {
 	u32 ret = 0;
 
@@ -48,7 +48,7 @@ static unsigned int s5pv310_get_irq_nr(unsigned int number)
 	return ret;
 }
 
-static inline void s5pv310_irq_eint_mask(struct irq_data *data)
+static inline void exynos4_irq_eint_mask(struct irq_data *data)
 {
 	u32 mask;
 
@@ -59,7 +59,7 @@ static inline void s5pv310_irq_eint_mask(struct irq_data *data)
 	spin_unlock(&eint_lock);
 }
 
-static void s5pv310_irq_eint_unmask(struct irq_data *data)
+static void exynos4_irq_eint_unmask(struct irq_data *data)
 {
 	u32 mask;
 
@@ -70,19 +70,19 @@ static void s5pv310_irq_eint_unmask(struct irq_data *data)
 	spin_unlock(&eint_lock);
 }
 
-static inline void s5pv310_irq_eint_ack(struct irq_data *data)
+static inline void exynos4_irq_eint_ack(struct irq_data *data)
 {
 	__raw_writel(eint_irq_to_bit(data->irq),
 		     S5P_EINT_PEND(EINT_REG_NR(data->irq)));
 }
 
-static void s5pv310_irq_eint_maskack(struct irq_data *data)
+static void exynos4_irq_eint_maskack(struct irq_data *data)
 {
-	s5pv310_irq_eint_mask(data);
-	s5pv310_irq_eint_ack(data);
+	exynos4_irq_eint_mask(data);
+	exynos4_irq_eint_ack(data);
 }
 
-static int s5pv310_irq_eint_set_type(struct irq_data *data, unsigned int type)
+static int exynos4_irq_eint_set_type(struct irq_data *data, unsigned int type)
 {
 	int offs = EINT_OFFSET(data->irq);
 	int shift;
@@ -145,19 +145,19 @@ static int s5pv310_irq_eint_set_type(struct irq_data *data, unsigned int type)
 	return 0;
 }
 
-static struct irq_chip s5pv310_irq_eint = {
-	.name		= "s5pv310-eint",
-	.irq_mask	= s5pv310_irq_eint_mask,
-	.irq_unmask	= s5pv310_irq_eint_unmask,
-	.irq_mask_ack	= s5pv310_irq_eint_maskack,
-	.irq_ack	= s5pv310_irq_eint_ack,
-	.irq_set_type	= s5pv310_irq_eint_set_type,
+static struct irq_chip exynos4_irq_eint = {
+	.name		= "exynos4-eint",
+	.irq_mask	= exynos4_irq_eint_mask,
+	.irq_unmask	= exynos4_irq_eint_unmask,
+	.irq_mask_ack	= exynos4_irq_eint_maskack,
+	.irq_ack	= exynos4_irq_eint_ack,
+	.irq_set_type	= exynos4_irq_eint_set_type,
 #ifdef CONFIG_PM
 	.irq_set_wake	= s3c_irqext_wake,
 #endif
 };
 
-/* s5pv310_irq_demux_eint
+/* exynos4_irq_demux_eint
  *
  * This function demuxes the IRQ from from EINTs 16 to 31.
  * It is designed to be inlined into the specific handler
@@ -165,7 +165,7 @@ static struct irq_chip s5pv310_irq_eint = {
  *
  * Each EINT pend/mask registers handle eight of them.
  */
-static inline void s5pv310_irq_demux_eint(unsigned int start)
+static inline void exynos4_irq_demux_eint(unsigned int start)
 {
 	unsigned int irq;
 
@@ -182,13 +182,13 @@ static inline void s5pv310_irq_demux_eint(unsigned int start)
 	}
 }
 
-static void s5pv310_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
+static void exynos4_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
 {
-	s5pv310_irq_demux_eint(IRQ_EINT(16));
-	s5pv310_irq_demux_eint(IRQ_EINT(24));
+	exynos4_irq_demux_eint(IRQ_EINT(16));
+	exynos4_irq_demux_eint(IRQ_EINT(24));
 }
 
-static void s5pv310_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
+static void exynos4_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
 {
 	u32 *irq_data = get_irq_data(irq);
 	struct irq_chip *chip = get_irq_chip(irq);
@@ -203,27 +203,27 @@ static void s5pv310_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
 	chip->irq_unmask(&desc->irq_data);
 }
 
-int __init s5pv310_init_irq_eint(void)
+int __init exynos4_init_irq_eint(void)
 {
 	int irq;
 
 	for (irq = 0 ; irq <= 31 ; irq++) {
-		set_irq_chip(IRQ_EINT(irq), &s5pv310_irq_eint);
+		set_irq_chip(IRQ_EINT(irq), &exynos4_irq_eint);
 		set_irq_handler(IRQ_EINT(irq), handle_level_irq);
 		set_irq_flags(IRQ_EINT(irq), IRQF_VALID);
 	}
 
-	set_irq_chained_handler(IRQ_EINT16_31, s5pv310_irq_demux_eint16_31);
+	set_irq_chained_handler(IRQ_EINT16_31, exynos4_irq_demux_eint16_31);
 
 	for (irq = 0 ; irq <= 15 ; irq++) {
 		eint0_15_data[irq] = IRQ_EINT(irq);
 
-		set_irq_data(s5pv310_get_irq_nr(irq), &eint0_15_data[irq]);
-		set_irq_chained_handler(s5pv310_get_irq_nr(irq),
-					s5pv310_irq_eint0_15);
+		set_irq_data(exynos4_get_irq_nr(irq), &eint0_15_data[irq]);
+		set_irq_chained_handler(exynos4_get_irq_nr(irq),
+					exynos4_irq_eint0_15);
 	}
 
 	return 0;
 }
 
-arch_initcall(s5pv310_init_irq_eint);
+arch_initcall(exynos4_init_irq_eint);
-- 
1.7.1
