From: axel.lin@gmail.com (Axel Lin)
Date: Wed, 03 Aug 2011 15:18:17 +0800
Subject: [PATCH RESEND] omap1: select GENERIC_IRQ_CHIP for TI OMAP1
Message-ID: <1312355897.14329.5.camel@phoenix>
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
Kevin already sent a similar patch.  http://marc.info/?l=linux-omap&m=130749135312468&w=2
But I still have the build error with make omap1_defconfig in today's linux-next tree.
So here is a resend.

Regards,
Axel
 arch/arm/plat-omap/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 6e6735f..bb8f4a6 100644
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
