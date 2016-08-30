From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 30 Aug 2016 12:00:51 +0100
Subject: [PATCH 6/8] ARM: sa1100/nanoengine: move nanoengine header file
In-Reply-To: <20160830105950.GA15580@n2100.armlinux.org.uk>
References: <20160830105950.GA15580@n2100.armlinux.org.uk>
Message-ID: <E1begmh-0007IX-Al@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nothing outside arch/arm/mach-sa1100 needs the nanoengine header file,
so move it into that directory.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/nanoengine.c                    | 2 +-
 arch/arm/mach-sa1100/{include/mach => }/nanoengine.h | 0
 arch/arm/mach-sa1100/pci-nanoengine.c                | 3 ++-
 3 files changed, 3 insertions(+), 2 deletions(-)
 rename arch/arm/mach-sa1100/{include/mach => }/nanoengine.h (100%)

diff --git a/arch/arm/mach-sa1100/nanoengine.c b/arch/arm/mach-sa1100/nanoengine.c
index 4d35258a7b32..51e8ab94cd6d 100644
--- a/arch/arm/mach-sa1100/nanoengine.c
+++ b/arch/arm/mach-sa1100/nanoengine.c
@@ -28,10 +28,10 @@
 #include <asm/mach/map.h>
 
 #include <mach/hardware.h>
-#include <mach/nanoengine.h>
 #include <mach/irqs.h>
 
 #include "generic.h"
+#include "nanoengine.h"
 
 /* Flash bank 0 */
 static struct mtd_partition nanoengine_partitions[] = {
diff --git a/arch/arm/mach-sa1100/include/mach/nanoengine.h b/arch/arm/mach-sa1100/nanoengine.h
similarity index 100%
rename from arch/arm/mach-sa1100/include/mach/nanoengine.h
rename to arch/arm/mach-sa1100/nanoengine.h
diff --git a/arch/arm/mach-sa1100/pci-nanoengine.c b/arch/arm/mach-sa1100/pci-nanoengine.c
index d7ae8d50f6d8..81c5e7f68135 100644
--- a/arch/arm/mach-sa1100/pci-nanoengine.c
+++ b/arch/arm/mach-sa1100/pci-nanoengine.c
@@ -26,9 +26,10 @@
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
 
-#include <mach/nanoengine.h>
 #include <mach/hardware.h>
 
+#include "nanoengine.h"
+
 static void __iomem *nanoengine_pci_map_bus(struct pci_bus *bus,
 					    unsigned int devfn, int where)
 {
-- 
2.1.0
