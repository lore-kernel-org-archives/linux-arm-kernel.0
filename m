From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 10 Feb 2015 16:43:12 +0100
Subject: [PATCH] genirq: fix virtual irq demuxer related comments
In-Reply-To: <20150210150013.GD7119@twins.programming.kicks-ass.net>
References: <20150210150013.GD7119@twins.programming.kicks-ass.net>
Message-ID: <1423582992-8154-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace remaining 'Dumb' occurrences by 'Virtual'.
Remove inappropriate notes in kerneldoc headers.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/linux/irq.h          | 8 +-------
 kernel/irq/Kconfig           | 2 +-
 kernel/irq/chip.c            | 7 ++-----
 kernel/irq/virt-demux-chip.c | 2 +-
 4 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index b703093..192dd85 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -886,18 +886,12 @@ static inline u32 irq_reg_readl(struct irq_chip_generic *gc,
 
 #ifdef CONFIG_VIRT_IRQ_DEMUX_CHIP
 /**
- * struct irq_chip_virt_demux - Dumb demultiplexer irq chip data structure
+ * struct irq_chip_virt_demux - Virtual demultiplexer irq chip data structure
  * @domain:		irq domain pointer
  * @available:		Bitfield of valid irqs
  * @unmasked:		Bitfield containing irqs status
  * @flags:		irq_virt_demux_flags flags
  * @src_irq:		irq feeding the virt demux chip
- *
- * Note, that irq_chip_generic can have multiple irq_chip_type
- * implementations which can be associated to a particular irq line of
- * an irq_chip_generic instance. That allows to share and protect
- * state in an irq_chip_generic instance when we need to implement
- * different flow mechanisms (level/edge) for it.
  */
 struct irq_chip_virt_demux {
 	struct irq_domain *domain;
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 506644f..f608fbe 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -51,7 +51,7 @@ config GENERIC_IRQ_CHIP
        bool
        select IRQ_DOMAIN
 
-# Dumb interrupt demuxer chip implementation
+# Virtual interrupt demuxer chip implementation
 config VIRT_IRQ_DEMUX_CHIP
 	bool
 	select IRQ_DOMAIN
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 38abf8d..235595f 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -407,16 +407,13 @@ EXPORT_SYMBOL_GPL(handle_simple_irq);
 
 #ifdef CONFIG_VIRT_IRQ_DEMUX_CHIP
 /**
- *	handle_virt_demux_irq - Dumb demuxer irq handle function.
+ *	handle_virt_demux_irq - Virtual demuxer irq handle function.
  *	@irq:	the interrupt number
  *	@desc:	the interrupt description structure for this irq
  *
- *	Dumb demux interrupts are sent from a demultiplexing interrupt handler
+ *	Virtual demux interrupts are sent from a demultiplexing interrupt handler
  *	which is not able to decide which child interrupt handler should be
  *	called.
- *
- *	Note: The caller is expected to handle the ack, clear, mask and
- *	unmask issues if necessary.
  */
 irqreturn_t
 handle_virt_demux_irq(unsigned int irq, struct irq_desc *desc)
diff --git a/kernel/irq/virt-demux-chip.c b/kernel/irq/virt-demux-chip.c
index 31f35f0..b705d54 100644
--- a/kernel/irq/virt-demux-chip.c
+++ b/kernel/irq/virt-demux-chip.c
@@ -83,7 +83,7 @@ struct irq_domain_ops irq_virt_demux_domain_ops = {
 EXPORT_SYMBOL_GPL(irq_virt_demux_domain_ops);
 
 /**
- * irq_virt_demux_handler - Dumb demux flow handler
+ * irq_virt_demux_handler - Virtual demux flow handler
  * @irq:		Virtual irq number
  * @irq_desc:		irq descriptor
  */
-- 
1.9.1
