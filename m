From: robherring2@gmail.com (Rob Herring)
Date: Wed, 14 Sep 2011 11:31:36 -0500
Subject: [PATCH 1/5] irq: add declaration of irq_domain_simple_ops to
	irqdomain.h
In-Reply-To: <1316017900-19918-1-git-send-email-robherring2@gmail.com>
References: <1316017900-19918-1-git-send-email-robherring2@gmail.com>
Message-ID: <1316017900-19918-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

irq_domain_simple_ops is exported, but is not declared in irqdomain.h, so
add it.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irqdomain.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index e807ad6..3ad553e 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -80,6 +80,7 @@ extern void irq_domain_del(struct irq_domain *domain);
 #endif /* CONFIG_IRQ_DOMAIN */
 
 #if defined(CONFIG_IRQ_DOMAIN) && defined(CONFIG_OF_IRQ)
+extern struct irq_domain_ops irq_domain_simple_ops;
 extern void irq_domain_add_simple(struct device_node *controller, int irq_base);
 extern void irq_domain_generate_simple(const struct of_device_id *match,
 					u64 phys_base, unsigned int irq_start);
-- 
1.7.5.4
