From: vw@iommu.org (Wan Zongshun)
Date: Sat, 25 Jun 2016 18:37:20 +0800
Subject: [PATCH 4/6] irqchip: add irqchip driver for nuc900
In-Reply-To: <1466851042-22239-1-git-send-email-vw@iommu.org>
References: <1466851042-22239-1-git-send-email-vw@iommu.org>
Message-ID: <1466851042-22239-5-git-send-email-vw@iommu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to add irqchip driver support for nuc900 plat,
current this driver only supports nuc970 SoC.

Signed-off-by: Wan Zongshun <mcuos.com@gmail.com>
---
 arch/arm/mach-w90x900/include/mach/irqs.h          |  69 ++++++++++++++
 .../mach-w90x900/include/mach/nuc970-regs-aic.h    |  53 +++++++++++
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-nuc900.c                       | 104 +++++++++++++++++++++
 4 files changed, 227 insertions(+)
 create mode 100644 arch/arm/mach-w90x900/include/mach/nuc970-regs-aic.h
 create mode 100644 drivers/irqchip/irq-nuc900.c

diff --git a/arch/arm/mach-w90x900/include/mach/irqs.h b/arch/arm/mach-w90x900/include/mach/irqs.h
index 9d5cba3..c56d4bb 100644
--- a/arch/arm/mach-w90x900/include/mach/irqs.h
+++ b/arch/arm/mach-w90x900/include/mach/irqs.h
@@ -28,6 +28,8 @@
 
 /* Main cpu interrupts */
 
+#if !defined(CONFIG_SOC_NUC970)
+
 #define IRQ_WDT		W90X900_IRQ(1)
 #define IRQ_GROUP0	W90X900_IRQ(2)
 #define IRQ_GROUP1	W90X900_IRQ(3)
@@ -83,4 +85,71 @@
 #define	IRQ_GROUP1_IRQ6	0x00000040
 #define	IRQ_GROUP1_IRQ7	0x00000080
 
+#else
+
+/*For nuc970*/
+#define IRQ_WDT		W90X900_IRQ(1)
+#define IRQ_WWDT	W90X900_IRQ(2)
+#define IRQ_LVD		W90X900_IRQ(3)
+#define IRQ_EXT0	W90X900_IRQ(4)
+#define IRQ_EXT1	W90X900_IRQ(5)
+#define IRQ_EXT2	W90X900_IRQ(6)
+#define IRQ_EXT3	W90X900_IRQ(7)
+#define IRQ_EXT4	W90X900_IRQ(8)
+#define IRQ_EXT5	W90X900_IRQ(9)
+#define IRQ_EXT6	W90X900_IRQ(10)
+#define IRQ_EXT7	W90X900_IRQ(11)
+#define IRQ_ACTL	W90X900_IRQ(12)
+#define IRQ_LCD		W90X900_IRQ(13)
+#define IRQ_CAP		W90X900_IRQ(14)
+#define IRQ_RTC		W90X900_IRQ(15)
+#define IRQ_TMR0	W90X900_IRQ(16)
+#define IRQ_TMR1	W90X900_IRQ(17)
+#define IRQ_ADC		W90X900_IRQ(18)
+#define IRQ_EMC0RX	W90X900_IRQ(19)
+#define IRQ_EMC1RX	W90X900_IRQ(20)
+#define IRQ_EMC0TX	W90X900_IRQ(21)
+#define IRQ_EMC1TX	W90X900_IRQ(22)
+#define IRQ_EHCI	W90X900_IRQ(23)
+#define IRQ_OHCI	W90X900_IRQ(24)
+#define IRQ_GDMA0	W90X900_IRQ(25)
+#define IRQ_GDMA1	W90X900_IRQ(26)
+#define IRQ_SDH		W90X900_IRQ(27)
+#define IRQ_FMI		W90X900_IRQ(28)
+#define IRQ_UDC		W90X900_IRQ(29)
+#define IRQ_TMR2	W90X900_IRQ(30)
+#define IRQ_TMR3	W90X900_IRQ(31)
+#define IRQ_TMR4	W90X900_IRQ(32)
+#define IRQ_JPEG	W90X900_IRQ(33)
+#define IRQ_GE2D	W90X900_IRQ(34)
+#define IRQ_CRYPTO	W90X900_IRQ(35)
+#define IRQ_UART0	W90X900_IRQ(36)
+#define IRQ_UART1	W90X900_IRQ(37)
+#define IRQ_UART2	W90X900_IRQ(38)
+#define IRQ_UART4	W90X900_IRQ(39)
+#define IRQ_UART6	W90X900_IRQ(40)
+#define IRQ_UART8	W90X900_IRQ(41)
+#define IRQ_UART10	W90X900_IRQ(42)
+#define IRQ_UART3	W90X900_IRQ(43)
+#define IRQ_UART5	W90X900_IRQ(44)
+#define IRQ_UART7	W90X900_IRQ(45)
+#define IRQ_UART9	W90X900_IRQ(46)
+#define IRQ_ETIMER0	W90X900_IRQ(47)
+#define IRQ_ETIMER1	W90X900_IRQ(48)
+#define IRQ_ETIMER2	W90X900_IRQ(49)
+#define IRQ_ETIMER3	W90X900_IRQ(50)
+#define IRQ_SPI0	W90X900_IRQ(51)
+#define IRQ_SPI1	W90X900_IRQ(52)
+#define IRQ_I2C0	W90X900_IRQ(53)
+#define IRQ_I2C1	W90X900_IRQ(54)
+#define IRQ_SMC0	W90X900_IRQ(55)
+#define IRQ_SMC1	W90X900_IRQ(56)
+#define IRQ_GPIO	W90X900_IRQ(57)
+#define IRQ_CAN0	W90X900_IRQ(58)
+#define IRQ_CAN1	W90X900_IRQ(59)
+#define IRQ_PWM		W90X900_IRQ(60)
+#define IRQ_KPI		W90X900_IRQ(61)
+#define NR_IRQS		(IRQ_KPI+1)
+#endif
+
 #endif /* __ASM_ARCH_IRQ_H */
diff --git a/arch/arm/mach-w90x900/include/mach/nuc970-regs-aic.h b/arch/arm/mach-w90x900/include/mach/nuc970-regs-aic.h
new file mode 100644
index 0000000..7a77016
--- /dev/null
+++ b/arch/arm/mach-w90x900/include/mach/nuc970-regs-aic.h
@@ -0,0 +1,53 @@
+/*
+ * Copyright 2016 Wan Zongshun <mcuos.com@gmail.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifndef __ASM_ARCH_REGS_AIC_H
+#define __ASM_ARCH_REGS_AIC_H
+
+/*NUC970 AIC regs*/
+
+#define	REG_AIC_SCR1	0x00
+#define	REG_AIC_SCR2	0x04
+#define	REG_AIC_SCR3	0x08
+#define	REG_AIC_SCR4	0x0C
+#define	REG_AIC_SCR5	0x10
+#define	REG_AIC_SCR6	0x14
+#define	REG_AIC_SCR7	0x18
+#define	REG_AIC_SCR8	0x1C
+#define	REG_AIC_SCR9	0x20
+#define	REG_AIC_SCR10	0x24
+#define	REG_AIC_SCR11	0x28
+#define	REG_AIC_SCR12	0x2C
+#define	REG_AIC_SCR13	0x30
+#define	REG_AIC_SCR14	0x34
+#define	REG_AIC_SCR15	0x38
+#define	REG_AIC_IRSR	0x100
+#define	REG_AIC_IRSRH	0x104
+#define	REG_AIC_IASR	0x108
+#define	REG_AIC_IASRH	0x10C
+#define	REG_AIC_ISR	0x110
+#define	REG_AIC_ISRH	0x114
+#define	REG_AIC_IPER	0x118
+#define	REG_AIC_ISNR	0x120
+#define	REG_AIC_OISR	0x124
+#define	REG_AIC_IMR	0x128
+#define	REG_AIC_IMRH	0x12C
+#define	REG_AIC_MECR	0x130
+#define	REG_AIC_MECRH	0x134
+#define	REG_AIC_MDCR	0x138
+#define	REG_AIC_MDCRH	0x13C
+#define	REG_AIC_SSCR	0x140
+#define	REG_AIC_SSCRH	0x144
+#define	REG_AIC_SCCR	0x148
+#define	REG_AIC_SCCRH	0x14C
+#define	REG_AIC_EOSCR	0x150
+
+#endif /*  __ASM_ARCH_REGS_AIC_H */
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 38853a1..9ccd5af8a 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -69,3 +69,4 @@ obj-$(CONFIG_PIC32_EVIC)		+= irq-pic32-evic.o
 obj-$(CONFIG_MVEBU_ODMI)		+= irq-mvebu-odmi.o
 obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
 obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
+obj-$(CONFIG_SOC_NUC970)		+= irq-nuc900.o
diff --git a/drivers/irqchip/irq-nuc900.c b/drivers/irqchip/irq-nuc900.c
new file mode 100644
index 0000000..50308b9b
--- /dev/null
+++ b/drivers/irqchip/irq-nuc900.c
@@ -0,0 +1,104 @@
+/*
+ * Copyright 2016 Wan Zongshun <mcuos.com@gmail.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#include <asm/exception.h>
+#include <asm/hardirq.h>
+
+#include <mach/nuc970-regs-aic.h>
+
+static void __iomem *aic_base;
+static struct irq_domain *aic_domain;
+#define MAKE_HWIRQ(irqnum)	(irqnum)
+
+static void nuc970_irq_mask(struct irq_data *d)
+{
+	if (d->irq < 32)
+		__raw_writel(1 << (d->irq), aic_base + REG_AIC_MDCR);
+	else
+		__raw_writel(1 << (d->irq - 32), aic_base + REG_AIC_MDCRH);
+}
+
+static void nuc970_irq_ack(struct irq_data *d)
+{
+	__raw_writel(0x01, aic_base + REG_AIC_EOSCR);
+}
+
+static void nuc970_irq_unmask(struct irq_data *d)
+{
+	if (d->irq < 32)
+		__raw_writel(1 << (d->irq), aic_base + REG_AIC_MECR);
+	else
+		__raw_writel(1 << (d->irq - 32), aic_base + REG_AIC_MECRH);
+}
+
+static struct irq_chip nuc970_irq_chip = {
+	.irq_ack	= nuc970_irq_ack,
+	.irq_mask	= nuc970_irq_mask,
+	.irq_unmask	= nuc970_irq_unmask,
+};
+
+void __exception_irq_entry aic_handle_irq(struct pt_regs *regs)
+{
+	u32 hwirq;
+
+	hwirq = __raw_readl(aic_base + REG_AIC_IPER);
+	hwirq = __raw_readl(aic_base + REG_AIC_ISNR);
+	if (!hwirq)
+		__raw_writel(0x01, aic_base + REG_AIC_EOSCR);
+
+	handle_IRQ((irq_find_mapping(aic_domain, hwirq)), regs);
+}
+
+static int aic_irq_domain_map(struct irq_domain *d, unsigned int virq,
+			      irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(virq, &nuc970_irq_chip, handle_level_irq);
+	irq_clear_status_flags(virq, IRQ_NOREQUEST);
+
+	return 0;
+}
+
+static struct irq_domain_ops aic_irq_domain_ops = {
+	.map = aic_irq_domain_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static int __init aic_of_init(struct device_node *node,
+			      struct device_node *parent)
+{
+	aic_base = of_iomap(node, 0);
+	if (!aic_base)
+		panic("%s: unable to map IC registers\n", node->full_name);
+
+	__raw_writel(0xFFFFFFFC, aic_base + REG_AIC_MDCR);
+	__raw_writel(0xFFFFFFFF, aic_base + REG_AIC_MDCRH);
+
+	aic_domain = irq_domain_add_linear(node, NR_IRQS,
+					   &aic_irq_domain_ops, NULL);
+
+	if (!aic_domain)
+		panic("%s: unable to create IRQ domain\n", node->full_name);
+
+	set_handle_irq(aic_handle_irq);
+	return 0;
+}
+
+IRQCHIP_DECLARE(nuc970, "nuvoton,aic", aic_of_init);
-- 
2.7.4
