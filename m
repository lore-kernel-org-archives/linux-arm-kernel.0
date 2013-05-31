From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Jun 2013 00:22:38 +0200
Subject: [PATCH 01/15] irqdomain: export irq_domain_add_simple
In-Reply-To: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
References: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
Message-ID: <1370038972-2318779-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All other irq_domain_add_* functions are exported already, and apparently
this one got left out by mistake, which causes build errors for ARM
allmodconfig kernels:

ERROR: "irq_domain_add_simple" [drivers/gpio/gpio-rcar.ko] undefined!
ERROR: "irq_domain_add_simple" [drivers/gpio/gpio-em.ko] undefined!

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Magnus Damm <damm@opensource.se>
---
 kernel/irq/irqdomain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index af804b5..47d0564 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -194,6 +194,7 @@ struct irq_domain *irq_domain_add_simple(struct device_node *of_node,
 	/* A linear domain is the default */
 	return irq_domain_add_linear(of_node, size, ops, host_data);
 }
+EXPORT_SYMBOL_GPL(irq_domain_add_simple);
 
 /**
  * irq_domain_add_legacy() - Allocate and register a legacy revmap irq_domain.
-- 
1.8.1.2
