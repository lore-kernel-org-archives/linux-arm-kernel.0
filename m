From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri, 14 Jun 2013 18:40:49 +0200
Subject: [PATCH 7/7] irqdomain: use irq_get_trigger_type() to get IRQ flags
In-Reply-To: <1371228049-27080-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1371228049-27080-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1371228049-27080-8-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use irq_get_trigger_type() to get the IRQ trigger type flags
instead calling irqd_get_trigger_type(irq_desc_get_irq_data(virq))

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 kernel/irq/irqdomain.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 54a4d522..ff3eebb 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -698,7 +698,7 @@ unsigned int irq_create_of_mapping(struct device_node *controller,
 
 	/* Set type if specified and different than the current one */
 	if (type != IRQ_TYPE_NONE &&
-	    type != (irqd_get_trigger_type(irq_get_irq_data(virq))))
+	    type != irq_get_trigger_type(virq))
 		irq_set_irq_type(virq, type);
 	return virq;
 }
-- 
1.7.7.6
