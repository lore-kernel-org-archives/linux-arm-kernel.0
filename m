From: eric.auger@redhat.com (Eric Auger)
Date: Thu, 19 Jan 2017 20:57:58 +0000
Subject: [PATCH v9 13/18] genirq/msi: Set IRQ_DOMAIN_FLAG_MSI on MSI domain
 creation
In-Reply-To: <1484859483-2866-1-git-send-email-eric.auger@redhat.com>
References: <1484859483-2866-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1484859483-2866-14-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now we have a flag value indicating an IRQ domain implements MSI,
let's set it on msi_create_irq_domain().

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Tested-by: Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>
Tested-by: Bharat Bhushan <bharat.bhushan@nxp.com>

---

v7 -> v8
- Added Marc's R-b

v6: new
---
 kernel/irq/msi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index ee23006..ddc2f54 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -270,8 +270,8 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		msi_domain_update_chip_ops(info);
 
-	return irq_domain_create_hierarchy(parent, 0, 0, fwnode,
-					   &msi_domain_ops, info);
+	return irq_domain_create_hierarchy(parent, IRQ_DOMAIN_FLAG_MSI, 0,
+					   fwnode, &msi_domain_ops, info);
 }
 
 int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
-- 
1.9.1
