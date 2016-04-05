From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 5 Apr 2016 12:17:29 -0500
Subject: [PATCH] PCI: xilinx-nwl: Fix spelling mistake "Initialization"
In-Reply-To: <1459680976-32222-1-git-send-email-colin.king@canonical.com>
References: <1459680976-32222-1-git-send-email-colin.king@canonical.com>
Message-ID: <20160405171729.GB12135@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 03, 2016 at 11:56:16AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Minor fix, spelling mistake "Initalization" should be
> "Initialization".
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to pci/misc for v4.7, thanks, Colin!

I noticed the same error in drivers/pci/pci.c and fixed that as well:

commit dcbb408ac5a2803ba44ca2fae8bf53eb5d4082f3
Author: Colin Ian King <colin.king@canonical.com>
Date:   Tue Apr 5 12:12:45 2016 -0500

    PCI: Fix spelling errors
    
    Fix spelling of "initalization".
    
    [bhelgaas: also fix pci/pci.c]
    Signed-off-by: Colin Ian King <colin.king@canonical.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 5139e64..3479d30 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -819,7 +819,7 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 
 	err = nwl_pcie_bridge_init(pcie);
 	if (err) {
-		dev_err(pcie->dev, "HW Initalization failed\n");
+		dev_err(pcie->dev, "HW Initialization failed\n");
 		return err;
 	}
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 25e0327..e3d6b33 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2389,7 +2389,7 @@ out:
 	return offset + ent_size;
 }
 
-/* Enhanced Allocation Initalization */
+/* Enhanced Allocation Initialization */
 void pci_ea_init(struct pci_dev *dev)
 {
 	int ea;
