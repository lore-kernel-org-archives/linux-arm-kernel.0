From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Thu, 1 Sep 2016 15:44:45 +0530
Subject: [PATCH 5/6] PCI: Xilinx: Read more than one function per device.
In-Reply-To: <1472724886-28301-1-git-send-email-bharatku@xilinx.com>
References: <1472724886-28301-1-git-send-email-bharatku@xilinx.com>
Message-ID: <1472724886-28301-5-git-send-email-bharatku@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AXI PCIe supports multifunciton device.
Removing unneccessary condition.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
---
 drivers/pci/host/pcie-xilinx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index a276fa6..58b7a13 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -170,13 +170,6 @@ static bool xilinx_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 	if (bus->number == port->root_busno && devfn > 0)
 		return false;
 
-	/*
-	 * Do not read more than one device on the bus directly attached
-	 * to RC.
-	 */
-	if (bus->primary == port->root_busno && devfn > 0)
-		return false;
-
 	return true;
 }
 
-- 
2.1.1
