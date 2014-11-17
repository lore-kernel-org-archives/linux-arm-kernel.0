From: wangyijing@huawei.com (Yijing Wang)
Date: Mon, 17 Nov 2014 18:21:46 +0800
Subject: [RFC PATCH 12/16] ia64/PCI: Remove the redundant bus variable
In-Reply-To: <1416219710-26088-1-git-send-email-wangyijing@huawei.com>
References: <1416219710-26088-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1416219710-26088-13-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/ia64/pci/pci.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 291a582..aac3220 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -424,7 +424,6 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 {
 	struct acpi_device *device = root->device;
 	int domain = root->segment;
-	int bus = root->secondary.start;
 	struct pci_controller *controller;
 	struct pci_root_info *info = NULL;
 	int busnum = root->secondary.start;
@@ -465,7 +464,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	 * should handle the case here, but it appears that IA64 hasn't
 	 * such quirk. So we just ignore the case now.
 	 */
-	pbus = pci_create_root_bus(NULL, bus, &pci_root_ops, controller,
+	pbus = pci_create_root_bus(NULL, busnum, &pci_root_ops, controller,
 				   &info->resources);
 	if (!pbus) {
 		pci_free_resource_list(&info->resources);
-- 
1.7.1
