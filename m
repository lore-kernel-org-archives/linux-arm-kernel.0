From: axel.lin@gmail.com (Axel Lin)
Date: Tue, 28 Jun 2011 17:05:43 +0800
Subject: [PATCH] omap1: select GENERIC_IRQ_CHIP for TI OMAP1
Message-ID: <1309251943.3984.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpio-omap driver has been converted to use generic IRQ chip.
Thus select GENERIC_IRQ_CHIP for TI OMAP1 to fix below build error.

  LD      vmlinux
drivers/built-in.o: In function `omap_mpuio_alloc_gc':
drivers/gpio/gpio-omap.c:1087: undefined reference to `irq_alloc_generic_chip'
drivers/gpio/gpio-omap.c:1100: undefined reference to `irq_setup_generic_chip'
drivers/built-in.o: In function `omap_gpio_show_rev':
drivers/gpio/gpio-omap.c:998: undefined reference to `irq_gc_mask_clr_bit'
drivers/gpio/gpio-omap.c:998: undefined reference to `irq_gc_mask_set_bit'
make: *** [vmlinux] Error 1

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 arch/arm/plat-omap/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 49a4c75..9a4a6bf 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -13,6 +13,7 @@ config ARCH_OMAP1
 	bool "TI OMAP1"
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
+	select GENERIC_IRQ_CHIP
 	help
 	  "Systems based on omap7xx, omap15xx or omap16xx"
 
-- 
1.7.4.1
