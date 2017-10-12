From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Oct 2017 13:30:32 +0100
Subject: [PATCH v6 1/7] genirq: export irq_get_percpu_devid_partition to
 modules
In-Reply-To: <1507811438-2267-1-git-send-email-will.deacon@arm.com>
References: <1507811438-2267-1-git-send-email-will.deacon@arm.com>
Message-ID: <1507811438-2267-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Any modular driver using cluster-affine PPIs needs to be able to call
irq_get_percpu_devid_partition so that it can enable the IRQ on the
correct subset of CPUs.

This patch exports the symbol so that it can be called from within a
module.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/irq/irqdesc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 82afb7ed369f..694c1a9d6485 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -863,6 +863,7 @@ int irq_get_percpu_devid_partition(unsigned int irq, struct cpumask *affinity)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(irq_get_percpu_devid_partition);
 
 void kstat_incr_irq_this_cpu(unsigned int irq)
 {
-- 
2.1.4
