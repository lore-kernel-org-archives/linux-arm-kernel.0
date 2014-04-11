From: fabf@skynet.be (Fabian Frederick)
Date: Sat, 12 Apr 2014 00:32:57 +0200
Subject: [PATCH 1/1] arch/arm/mach-ks8695/board-og.c: __initdata fix
Message-ID: <20140412003257.d66b1b91c74b44ca8f2e5c6d@skynet.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Place __initdata before equal signs.

Cc: linux-arm-kernel at lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 arch/arm/mach-ks8695/board-og.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ks8695/board-og.c b/arch/arm/mach-ks8695/board-og.c
index f265816..2627d82 100644
--- a/arch/arm/mach-ks8695/board-og.c
+++ b/arch/arm/mach-ks8695/board-og.c
@@ -30,7 +30,7 @@ static int og_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return KS8695_IRQ_EXTERN0;
 }
 
-static struct ks8695_pci_cfg __initdata og_pci = {
+static struct ks8695_pci_cfg og_pci __initdata = {
 	.mode		= KS8695_MODE_PCI,
 	.map_irq	= og_pci_map_irq,
 };
@@ -80,7 +80,7 @@ static void __init og_pci_bus_reset(void)
 #define	S8250_VIRT	0xf4000000
 #define	S8250_SIZE	0x00100000
 
-static struct __initdata map_desc og_io_desc[] = {
+static struct map_desc og_io_desc[] __initdata = {
 	{
 		.virtual	= S8250_VIRT,
 		.pfn		= __phys_to_pfn(S8250_PHYS),
-- 
1.8.4.5
