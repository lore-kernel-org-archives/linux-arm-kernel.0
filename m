From: wangyijing@huawei.com (Yijing Wang)
Date: Mon, 23 Mar 2015 20:40:54 +0800
Subject: [PATCH v7 28/31] PCI: rename to pci_find_host_bridge()
In-Reply-To: <1427114457-16687-1-git-send-email-wangyijing@huawei.com>
References: <1427114457-16687-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1427114457-16687-29-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/host-bridge.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index 919ba4d..8efb3a7 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -144,7 +144,7 @@ static struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
 	return bus;
 }
 
-static struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
+struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus)
 {
 	struct pci_bus *root_bus = find_pci_root_bus(bus);
 
@@ -162,7 +162,7 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 void pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
 			     struct resource *res)
 {
-	struct pci_host_bridge *bridge = find_pci_host_bridge(bus);
+	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
 	struct resource_entry *window;
 	resource_size_t offset = 0;
 
@@ -187,7 +187,7 @@ static bool region_contains(struct pci_bus_region *region1,
 void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
 			     struct pci_bus_region *region)
 {
-	struct pci_host_bridge *bridge = find_pci_host_bridge(bus);
+	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
 	struct resource_entry *window;
 	resource_size_t offset = 0;
 
-- 
1.7.1
