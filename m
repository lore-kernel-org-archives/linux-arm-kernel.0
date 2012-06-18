From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 18 Jun 2012 10:06:34 +0200
Subject: [PATCH] ARM:Orion5x: Fix panic at boot for PCI IO reservation
Message-ID: <1340006794-18097-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Orion5x, and all other orion based systems have a PCI(E) IO window
size of 1Mbyte. Recent changes to mach/io.h mean that by default the
kernel does not allow such large windows, it refuses to reserve that
much resource space, triggering a panic.

Reduce the PCI(E) IO window size to the normal 64K.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-orion5x/include/mach/orion5x.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-orion5x/include/mach/orion5x.h b/arch/arm/mach-orion5x/include/mach/orion5x.h
index 2745f5d..2cdb12c 100644
--- a/arch/arm/mach-orion5x/include/mach/orion5x.h
+++ b/arch/arm/mach-orion5x/include/mach/orion5x.h
@@ -43,12 +43,12 @@
 #define ORION5X_PCIE_IO_PHYS_BASE	0xf2000000
 #define ORION5X_PCIE_IO_VIRT_BASE	0xfde00000
 #define ORION5X_PCIE_IO_BUS_BASE	0x00000000
-#define ORION5X_PCIE_IO_SIZE		SZ_1M
+#define ORION5X_PCIE_IO_SIZE		SZ_64K
 
 #define ORION5X_PCI_IO_PHYS_BASE	0xf2100000
 #define ORION5X_PCI_IO_VIRT_BASE	0xfdf00000
-#define ORION5X_PCI_IO_BUS_BASE		0x00100000
-#define ORION5X_PCI_IO_SIZE		SZ_1M
+#define ORION5X_PCI_IO_BUS_BASE		0x00010000
+#define ORION5X_PCI_IO_SIZE		SZ_64K
 
 #define ORION5X_SRAM_PHYS_BASE		(0xf2200000)
 #define ORION5X_SRAM_SIZE		SZ_8K
-- 
1.7.10
