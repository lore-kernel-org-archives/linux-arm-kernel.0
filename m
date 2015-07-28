From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 28 Jul 2015 14:46:17 +0100
Subject: [PATCH v6 10/19] genirq: Add DOMAIN_BUS_NEXUS irqdomain property
In-Reply-To: <1438091186-10244-1-git-send-email-marc.zyngier@arm.com>
References: <1438091186-10244-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1438091186-10244-11-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some IRQ domains are not designed to directly provide interrupts
to devices, but strictly to be used by other domains. An example
of this is the GICv3 ITS, which is completely bus agnostic, and
on which it is possible to implement a PCI/MSI domain.

Just introduce the irq_domain_bus_token property for now.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/irqdomain.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index b4a74f7..d3ca792 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -56,6 +56,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_ANY		= 0,
 	DOMAIN_BUS_PCI_MSI,
 	DOMAIN_BUS_PLATFORM_MSI,
+	DOMAIN_BUS_NEXUS,
 };
 
 /**
-- 
2.1.4
