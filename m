From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sun, 23 May 2010 21:55:47 +0200
Subject: [PATCH 138/199] arch/arm/mach-shark/pci.c: Checkpatch cleanup
In-Reply-To: <1274644549-24952-1-git-send-email-andrea.gelmini@gelma.net>
References: <1274644549-24952-1-git-send-email-andrea.gelmini@gelma.net>
Message-ID: <1274644549-24952-11-git-send-email-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-shark/pci.c:19: ERROR: trailing statements should be on next line
arch/arm/mach-shark/pci.c:20: ERROR: trailing statements should be on next line
arch/arm/mach-shark/pci.c:21: ERROR: trailing statements should be on next line
arch/arm/mach-shark/pci.c:24: WARNING: externs should be avoided in .c files
arch/arm/mach-shark/pci.c:28: WARNING: please, no space before tabs

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-shark/pci.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shark/pci.c b/arch/arm/mach-shark/pci.c
index 37a7112..89d175c 100644
--- a/arch/arm/mach-shark/pci.c
+++ b/arch/arm/mach-shark/pci.c
@@ -16,16 +16,19 @@
 static int __init shark_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	if (dev->bus->number == 0)
-		if (dev->devfn == 0) return 255;
-		else return 11;
-	else return 255;
+		if (dev->devfn == 0)
+			return 255;
+		else
+			return 11;
+	else
+		return 255;
 }
 
 extern void __init via82c505_preinit(void);
 
 static struct hw_pci shark_pci __initdata = {
 	.setup		= via82c505_setup,
-	.swizzle     	= pci_std_swizzle,
+	.swizzle	= pci_std_swizzle,
 	.map_irq	= shark_map_irq,
 	.nr_controllers = 1,
 	.scan		= via82c505_scan_bus,
-- 
1.7.1.251.gf80a2
