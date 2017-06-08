From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  8 Jun 2017 15:13:01 +0100
Subject: [RFT PATCH v2 01/42] PCI: xilinx-nwl: Remove nwl_pcie_enable_msi()
 unused bus parameter
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170608141342.2018-2-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

nwl_pcie_enable_msi() second parameter (ie bus) is unused and creates
a fake dependency on the struct pci_bus that just does not exist.

Remove it.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 4b16b26..26e66e8 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -530,7 +530,7 @@ static int nwl_pcie_init_irq_domain(struct nwl_pcie *pcie)
 	return 0;
 }
 
-static int nwl_pcie_enable_msi(struct nwl_pcie *pcie, struct pci_bus *bus)
+static int nwl_pcie_enable_msi(struct nwl_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
@@ -838,7 +838,7 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	}
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		err = nwl_pcie_enable_msi(pcie, bus);
+		err = nwl_pcie_enable_msi(pcie);
 		if (err < 0) {
 			dev_err(dev, "failed to enable MSI support: %d\n", err);
 			goto error;
-- 
2.10.0
