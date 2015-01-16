From: wangyijing@huawei.com (Yijing Wang)
Date: Fri, 16 Jan 2015 09:44:22 +0800
Subject: [PATCH 24/28] PCI/xgene: Use pci_scan_root_bus() instead of
 pci_create_root_bus()
In-Reply-To: <1421372666-12288-1-git-send-email-wangyijing@huawei.com>
References: <1421372666-12288-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1421372666-12288-25-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use pci_scan_root_bus() instead of pci_create_root_bus() +
pci_scan_child_bus() for simplicity.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/host/pci-xgene.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index b1d0596..7e46a39 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -631,12 +631,11 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	bus = pci_create_root_bus(&pdev->dev, 0,
+	bus = pci_scan_root_bus(&pdev->dev, 0,
 					&xgene_pcie_ops, port, &res);
 	if (!bus)
 		return -ENOMEM;
 
-	pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
 	pci_bus_add_devices(bus);
 
-- 
1.7.1
