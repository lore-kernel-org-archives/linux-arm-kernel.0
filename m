From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  6 Mar 2012 19:42:12 -0300
Subject: [PATCH] ARM: kernel/bios32: Remove unused variable
Message-ID: <1331073732-25236-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/kernel/bios32.c: In function 'pcibios_fixup_bus':
arch/arm/kernel/bios32.c:302: warning: unused variable 'root'

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/kernel/bios32.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index be5d3b2..c0e71ea 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -299,7 +299,6 @@ static inline int pdev_bad_for_parity(struct pci_dev *dev)
  */
 void pcibios_fixup_bus(struct pci_bus *bus)
 {
-	struct pci_sys_data *root = bus->sysdata;
 	struct pci_dev *dev;
 	u16 features = PCI_COMMAND_SERR | PCI_COMMAND_PARITY | PCI_COMMAND_FAST_BACK;
 
-- 
1.7.1
