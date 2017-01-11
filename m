From: eric.auger@redhat.com (Eric Auger)
Date: Wed, 11 Jan 2017 09:41:51 +0000
Subject: [PATCH v8 15/18] irqchip/gicv3-its: Sets IRQ_DOMAIN_FLAG_MSI_REMAP
In-Reply-To: <1484127714-3263-1-git-send-email-eric.auger@redhat.com>
References: <1484127714-3263-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1484127714-3263-16-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GICv3 ITS is MSI remapping capable. Let's advertise
this property so that VFIO passthrough can assess IRQ safety.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

---

v7 -> v8:
- added Marc's R-b
---
 drivers/irqchip/irq-gic-v3-its.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 69b040f..9d4fefc 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1642,6 +1642,7 @@ static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
 
 	inner_domain->parent = its_parent;
 	inner_domain->bus_token = DOMAIN_BUS_NEXUS;
+	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_REMAP;
 	info->ops = &its_msi_domain_ops;
 	info->data = its;
 	inner_domain->host_data = info;
-- 
1.9.1
