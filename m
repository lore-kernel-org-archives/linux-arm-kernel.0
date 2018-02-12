From: jaedon.shin@gmail.com (Jaedon Shin)
Date: Mon, 12 Feb 2018 11:18:12 +0900
Subject: [PATCH] irqchip: Remove hashed address printing
Message-ID: <20180212021812.3882-1-jaedon.shin@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
pointers are being hashed when printed. Displaying the virtual memory at
bootup time is not helpful. so delete the prints.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/irqchip/irq-bcm7038-l1.c | 3 ---
 drivers/irqchip/irq-bcm7120-l2.c | 3 ---
 drivers/irqchip/irq-brcmstb-l2.c | 3 ---
 3 files changed, 9 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index 55cfb986225b..faf734ff4cf3 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -339,9 +339,6 @@ int __init bcm7038_l1_of_init(struct device_node *dn,
 		goto out_unmap;
 	}
 
-	pr_info("registered BCM7038 L1 intc (mem: 0x%p, IRQs: %d)\n",
-		intc->cpus[0]->map_base, IRQS_PER_WORD * intc->n_words);
-
 	return 0;
 
 out_unmap:
diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index 983640eba418..8968e5e93fcb 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -318,9 +318,6 @@ static int __init bcm7120_l2_intc_probe(struct device_node *dn,
 		}
 	}
 
-	pr_info("registered %s intc (mem: 0x%p, parent IRQ(s): %d)\n",
-			intc_name, data->map_base[0], data->num_parent_irqs);
-
 	return 0;
 
 out_free_domain:
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 691d20eb0bec..0e65f609352e 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -262,9 +262,6 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 		ct->chip.irq_set_wake = irq_gc_set_wake;
 	}
 
-	pr_info("registered L2 intc (mem: 0x%p, parent irq: %d)\n",
-			base, parent_irq);
-
 	return 0;
 
 out_free_domain:
-- 
2.16.1
