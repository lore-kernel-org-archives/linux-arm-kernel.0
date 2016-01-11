From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Jan 2016 13:11:24 +0100
Subject: [PATCH] PCI: designware: remove unused variable
Message-ID: <4643317.WUGgxPjcvu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A cleanup patch removed the only use of the 'ret' variable
in wr_conf but forgot to remove the variable:

pci/host/pcie-designware.c: In function 'dw_pcie_wr_conf':
pci/host/pcie-designware.c:683:6: warning: unused variable 'ret' [-Wunused-variable]

This cleans that part up as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 50a1a3b06ddd ("PCI: designware: Simplify control flow")
---
This came up this morning on linux-next with ARM randconfig builds

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 9a666dbff127..21716827847a 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -680,7 +680,6 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 			int where, int size, u32 val)
 {
 	struct pcie_port *pp = bus->sysdata;
-	int ret;
 
 	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
