From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 21 Sep 2018 15:51:24 +0530
Subject: [RFC PATCH 09/40] PCI: keystone: Remove redundant platform_set_drvdata
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
Message-ID: <20180921102155.22839-10-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No functional change. Remove redundant platform_set_drvdata invocation
in ks_pcie_probe().

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 4554fdc6cce1..c54d18ea263a 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -829,8 +829,6 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, ks_pcie);
-
 	ret = ks_add_pcie_port(ks_pcie, pdev);
 	if (ret < 0)
 		goto fail_clk;
-- 
2.17.1
