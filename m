From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 16 May 2012 17:05:19 +0200
Subject: [PATCH] ARM: mv78xx0: Fix compiler error in pcie.c
Message-ID: <1337180719-5655-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-mv78xx0/pcie.c:256:29: error: 'bus' undeclared (first use in this function)

caused by the patch:

ARM: PCI: dove/kirkwood/mv78xx0: use sys->private_data

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-mv78xx0/pcie.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
index 67357d1..2e56e86 100644
--- a/arch/arm/mach-mv78xx0/pcie.c
+++ b/arch/arm/mach-mv78xx0/pcie.c
@@ -253,7 +253,7 @@ mv78xx0_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 static int __init mv78xx0_pcie_map_irq(const struct pci_dev *dev, u8 slot,
 	u8 pin)
 {
-	struct pci_sys_data *sys = bus->sysdata;
+	struct pci_sys_data *sys = dev->bus->sysdata;
 	struct pcie_port *pp = sys->private_data;
 
 	return IRQ_MV78XX0_PCIE_00 + (pp->maj << 2) + pp->min;
-- 
1.7.10
