From: wangyijing@huawei.com (Yijing Wang)
Date: Fri, 3 Apr 2015 17:26:00 +0800
Subject: [PATCH v9 26/30] PCI/xgene: Use pci_scan_root_bus() instead of
 pci_create_root_bus()
In-Reply-To: <1428053164-28277-1-git-send-email-wangyijing@huawei.com>
References: <1428053164-28277-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1428053164-28277-28-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use pci_scan_root_bus() instead of pci_create_root_bus() +
pci_scan_child_bus() for simplicity.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
CC: Tanmay Inamdar <tinamdar@apm.com>
---
 drivers/pci/host/pci-xgene.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 078e853..380c259 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -499,12 +499,11 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	bus = pci_create_root_bus(&pdev->dev, -1, 0,
+	bus = pci_scan_root_bus(&pdev->dev, -1, 0,
 					&xgene_pcie_ops, port, &res);
 	if (!bus)
 		return -ENOMEM;
 
-	pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
 	pci_bus_add_devices(bus);
 
-- 
1.7.1
