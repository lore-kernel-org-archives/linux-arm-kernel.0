From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Tue,  4 Mar 2014 15:50:03 +0000
Subject: [PATCH v5 6/7] pci: Export find_pci_host_bridge() function.
In-Reply-To: <1393948204-11555-1-git-send-email-Liviu.Dudau@arm.com>
References: <1393948204-11555-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1393948204-11555-7-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a useful function and we should make it visible outside the
generic PCI code. Export it as a GPL symbol.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index 06ace62..8708b652 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -17,12 +17,13 @@ static struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
 	return bus;
 }
 
-static struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
+struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
 {
 	struct pci_bus *root_bus = find_pci_root_bus(bus);
 
 	return to_pci_host_bridge(root_bus->bridge);
 }
+EXPORT_SYMBOL_GPL(find_pci_host_bridge);
 
 void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 				 void (*release_fn)(struct pci_host_bridge *),
-- 
1.9.0
