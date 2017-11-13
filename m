From: helgaas@kernel.org (Bjorn Helgaas)
Date: Mon, 13 Nov 2017 16:40:58 -0600
Subject: [PATCH v1 3/3] PCI: xilinx: Rename xilinx_pcie_link_is_up() to
 xilinx_pcie_link_up()
In-Reply-To: <20171113224001.29024.87126.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20171113224001.29024.87126.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20171113224058.29024.51914.stgit@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Helgaas <bhelgaas@google.com>

Rename xilinx_pcie_link_is_up() to xilinx_pcie_link_up() to follow the
convention of other drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-xilinx.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 94e13cb8608f..7b5325990f5e 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -129,7 +129,7 @@ static inline void pcie_write(struct xilinx_pcie_port *port, u32 val, u32 reg)
 	writel(val, port->reg_base + reg);
 }
 
-static inline bool xilinx_pcie_link_is_up(struct xilinx_pcie_port *port)
+static inline bool xilinx_pcie_link_up(struct xilinx_pcie_port *port)
 {
 	return (pcie_read(port, XILINX_PCIE_REG_PSCR) &
 		XILINX_PCIE_REG_PSCR_LNKUP) ? 1 : 0;
@@ -165,7 +165,7 @@ static bool xilinx_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 
 	/* Check if link is up when trying to access downstream ports */
 	if (bus->number != port->root_busno)
-		if (!xilinx_pcie_link_is_up(port))
+		if (!xilinx_pcie_link_up(port))
 			return false;
 
 	/* Only one device down on each root port */
@@ -541,7 +541,7 @@ static void xilinx_pcie_init_port(struct xilinx_pcie_port *port)
 {
 	struct device *dev = port->dev;
 
-	if (xilinx_pcie_link_is_up(port))
+	if (xilinx_pcie_link_up(port))
 		dev_info(dev, "PCIe Link is UP\n");
 	else
 		dev_info(dev, "PCIe Link is DOWN\n");
