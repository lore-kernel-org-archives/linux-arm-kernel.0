From: julien.grall@citrix.com (Julien Grall)
Date: Sat, 25 Jul 2015 18:34:01 +0100
Subject: [PATCH] arm/xen: Drop the definition of xen_pci_platform_unplug
Message-ID: <1437845641-32052-1-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit 6f6c15ef912465b3aaafe709f39bd6026a8b3e72 "xen/pvhvm: Remove
the xen_platform_pci int." makes the x86 version of
xen_pci_platform_unplug static.

Therefore we don't need anymore to define a dummy xen_pci_platform_unplug
for ARM.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/xen/enlighten.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 6c09cc4..9055c92 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -49,9 +49,6 @@ struct xen_memory_region xen_extra_mem[XEN_EXTRA_MEM_MAX_REGIONS] __initdata;
 __read_mostly int xen_have_vector_callback;
 EXPORT_SYMBOL_GPL(xen_have_vector_callback);
 
-int xen_platform_pci_unplug = XEN_UNPLUG_ALL;
-EXPORT_SYMBOL_GPL(xen_platform_pci_unplug);
-
 static __read_mostly unsigned int xen_events_irq;
 
 static __initdata struct device_node *xen_node;
-- 
2.1.4
