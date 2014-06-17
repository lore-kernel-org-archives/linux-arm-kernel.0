From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 17 Jun 2014 16:47:29 +0900
Subject: [PATCH v2 04/08] ARM: shmobile: Move most of irqs.h,
 keep some for pinctl
In-Reply-To: <20140617074658.30008.53021.sendpatchset@w520>
References: <20140617074658.30008.53021.sendpatchset@w520>
Message-ID: <20140617074729.30008.55742.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Move most of irqs.h so it can be used as #include "irqs.h"
instead of the old style #include <mach/irqs.h>.

Legacy code in drivers/pinctrl needs more work to get rid
of the "mach" portion of the include path, so some part
is left in the original location.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---

 Changes since V1:
 - rebased to v3.16-rc1

 arch/arm/mach-shmobile/board-ape6evm.c           |    2 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c   |    3 +--
 arch/arm/mach-shmobile/board-bockw.c             |    2 +-
 arch/arm/mach-shmobile/board-genmai.c            |    2 +-
 arch/arm/mach-shmobile/board-koelsch-reference.c |    2 +-
 arch/arm/mach-shmobile/board-koelsch.c           |    2 +-
 arch/arm/mach-shmobile/board-kzm9g.c             |    2 +-
 arch/arm/mach-shmobile/board-lager-reference.c   |    2 +-
 arch/arm/mach-shmobile/board-lager.c             |    2 +-
 arch/arm/mach-shmobile/board-mackerel.c          |    5 +----
 arch/arm/mach-shmobile/board-marzen-reference.c  |    2 +-
 arch/arm/mach-shmobile/board-marzen.c            |    2 +-
 arch/arm/mach-shmobile/include/mach/irqs.h       |   17 ++---------------
 arch/arm/mach-shmobile/intc-sh7372.c             |    2 +-
 arch/arm/mach-shmobile/intc-sh73a0.c             |    2 +-
 arch/arm/mach-shmobile/irqs.h                    |   21 +++++++++++++++++++++
 arch/arm/mach-shmobile/setup-r7s72100.c          |    2 +-
 arch/arm/mach-shmobile/setup-r8a73a4.c           |    2 +-
 arch/arm/mach-shmobile/setup-r8a7740.c           |    2 +-
 arch/arm/mach-shmobile/setup-r8a7778.c           |    2 +-
 arch/arm/mach-shmobile/setup-r8a7779.c           |    2 +-
 arch/arm/mach-shmobile/setup-r8a7790.c           |    2 +-
 arch/arm/mach-shmobile/setup-r8a7791.c           |    2 +-
 arch/arm/mach-shmobile/setup-sh7372.c            |    2 +-
 arch/arm/mach-shmobile/setup-sh73a0.c            |    2 +-
 25 files changed, 46 insertions(+), 42 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-ape6evm.c
+++ work/arch/arm/mach-shmobile/board-ape6evm.c	2014-06-17 16:03:57.000000000 +0900
@@ -34,10 +34,10 @@
 #include <linux/sh_clk.h>
 #include <linux/smsc911x.h>
 #include <mach/common.h>
-#include <mach/irqs.h>
 #include <mach/r8a73a4.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include "irqs.h"
 
 /* LEDS */
 static struct gpio_led ape6evm_leds[] = {
--- 0001/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ work/arch/arm/mach-shmobile/board-armadillo800eva.c	2014-06-17 16:03:57.000000000 +0900
@@ -46,7 +46,6 @@
 #include <linux/i2c-gpio.h>
 #include <linux/reboot.h>
 #include <mach/common.h>
-#include <mach/irqs.h>
 #include <mach/r8a7740.h>
 #include <media/mt9t112.h>
 #include <media/sh_mobile_ceu.h>
@@ -61,7 +60,7 @@
 #include <video/sh_mobile_hdmi.h>
 #include <sound/sh_fsi.h>
 #include <sound/simple_card.h>
-
+#include "irqs.h"
 #include "sh-gpio.h"
 
 /*
--- 0001/arch/arm/mach-shmobile/board-bockw.c
+++ work/arch/arm/mach-shmobile/board-bockw.c	2014-06-17 16:03:57.000000000 +0900
@@ -36,11 +36,11 @@
 #include <linux/usb/renesas_usbhs.h>
 #include <media/soc_camera.h>
 #include <mach/common.h>
-#include <mach/irqs.h>
 #include <mach/r8a7778.h>
 #include <asm/mach/arch.h>
 #include <sound/rcar_snd.h>
 #include <sound/simple_card.h>
+#include "irqs.h"
 
 #define FPGA	0x18200000
 #define IRQ0MR	0x30
--- 0001/arch/arm/mach-shmobile/board-genmai.c
+++ work/arch/arm/mach-shmobile/board-genmai.c	2014-06-17 16:03:57.000000000 +0900
@@ -26,10 +26,10 @@
 #include <linux/spi/rspi.h>
 #include <linux/spi/spi.h>
 #include <mach/common.h>
-#include <mach/irqs.h>
 #include <mach/r7s72100.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include "irqs.h"
 
 /* Ether */
 static const struct sh_eth_plat_data ether_pdata __initconst = {
--- 0004/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ work/arch/arm/mach-shmobile/board-koelsch-reference.c	2014-06-17 16:03:57.000000000 +0900
@@ -24,11 +24,11 @@
 #include <linux/of_platform.h>
 #include <linux/platform_data/rcar-du.h>
 #include <mach/common.h>
-#include <mach/irqs.h>
 #include <mach/rcar-gen2.h>
 #include <mach/r8a7791.h>
 #include <asm/mach/arch.h>
 #include "clock.h"
+#include "irqs.h"
 
 /* DU */
 static struct rcar_du_encoder_data koelsch_du_encoders[] = {
--- 0001/arch/arm/mach-shmobile/board-koelsch.c
+++ work/arch/arm/mach-shmobile/board-koelsch.c	2014-06-17 16:03:57.000000000 +0900
@@ -46,11 +46,11 @@
 #include <linux/spi/rspi.h>
 #include <linux/spi/spi.h>
 #include <mach/common.h>
-#include <mach/irqs.h>
 #include <mach/r8a7791.h>
 #include <mach/rcar-gen2.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include "irqs.h"
 
 /* DU */
 static struct rcar_du_encoder_data koelsch_du_encoders[] = {
--- 0001/arch/arm/mach-shmobile/board-kzm9g.c
+++ work/arch/arm/mach-shmobile/board-kzm9g.c	2014-06-17 16:03:57.000000000 +0900
@@ -43,13 +43,13 @@
 #include <linux/videodev2.h>
 #include <sound/sh_fsi.h>
 #include <sound/simple_card.h>
-#include <mach/irqs.h>
 #include <mach/sh73a0.h>
 #include <mach/common.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <video/sh_mobile_lcdc.h>
+#include "irqs.h"
 
 /*
  * external GPIO
--- 0004/arch/arm/mach-shmobile/board-lager-reference.c
+++ work/arch/arm/mach-shmobile/board-lager-reference.c	2014-06-17 16:03:57.000000000 +0900
@@ -23,11 +23,11 @@
 #include <linux/of_platform.h>
 #include <linux/platform_data/rcar-du.h>
 #include <mach/common.h>
-#include <mach/irqs.h>
 #include <mach/rcar-gen2.h>
 #include <mach/r8a7790.h>
 #include <asm/mach/arch.h>
 #include "clock.h"
+#include "irqs.h"
 
 /* DU */
 static struct rcar_du_encoder_data lager_du_encoders[] = {
--- 0001/arch/arm/mach-shmobile/board-lager.c
+++ work/arch/arm/mach-shmobile/board-lager.c	2014-06-17 16:03:57.000000000 +0900
@@ -46,7 +46,6 @@
 #include <linux/usb/phy.h>
 #include <linux/usb/renesas_usbhs.h>
 #include <mach/common.h>
-#include <mach/irqs.h>
 #include <mach/r8a7790.h>
 #include <media/soc_camera.h>
 #include <asm/mach-types.h>
@@ -58,6 +57,7 @@
 #include <linux/spi/spi.h>
 #include <sound/rcar_snd.h>
 #include <sound/simple_card.h>
+#include "irqs.h"
 
 /*
  * SSI-AK4643
--- 0002/arch/arm/mach-shmobile/board-mackerel.c
+++ work/arch/arm/mach-shmobile/board-mackerel.c	2014-06-17 16:03:57.000000000 +0900
@@ -57,14 +57,11 @@
 #include <media/soc_camera_platform.h>
 #include <sound/sh_fsi.h>
 #include <sound/simple_card.h>
-
 #include <mach/common.h>
-#include <mach/irqs.h>
 #include <mach/sh7372.h>
-
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
-
+#include "irqs.h"
 #include "sh-gpio.h"
 
 /*
--- 0001/arch/arm/mach-shmobile/board-marzen-reference.c
+++ work/arch/arm/mach-shmobile/board-marzen-reference.c	2014-06-17 16:04:40.000000000 +0900
@@ -21,9 +21,9 @@
 
 #include <mach/r8a7779.h>
 #include <mach/common.h>
-#include <mach/irqs.h>
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
+#include "irqs.h"
 
 static void __init marzen_init(void)
 {
--- 0001/arch/arm/mach-shmobile/board-marzen.c
+++ work/arch/arm/mach-shmobile/board-marzen.c	2014-06-17 16:03:57.000000000 +0900
@@ -44,10 +44,10 @@
 #include <media/soc_camera.h>
 #include <mach/r8a7779.h>
 #include <mach/common.h>
-#include <mach/irqs.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/traps.h>
+#include "irqs.h"
 
 /* Fixed 3.3V regulator to be used by SDHI0 */
 static struct regulator_consumer_supply fixed3v3_power_consumers[] = {
--- 0001/arch/arm/mach-shmobile/include/mach/irqs.h
+++ work/arch/arm/mach-shmobile/include/mach/irqs.h	2014-06-17 16:03:57.000000000 +0900
@@ -1,24 +1,11 @@
 #ifndef __ASM_MACH_IRQS_H
 #define __ASM_MACH_IRQS_H
 
-#include <linux/sh_intc.h>
-
-/* GIC */
-#define gic_spi(nr)		((nr) + 32)
-#define gic_iid(nr)		(nr) /* ICCIAR / interrupt ID */
-
-/* INTCS */
-#define INTCS_VECT_BASE		0x3400
-#define INTCS_VECT(n, vect)	INTC_VECT((n), INTCS_VECT_BASE + (vect))
-#define intcs_evt2irq(evt)	evt2irq(INTCS_VECT_BASE + (evt))
+/* Stuck here until drivers/pinctl/sh-pfc gets rid of legacy code */
 
 /* External IRQ pins */
 #define IRQPIN_BASE		2000
 #define irq_pin(nr)		((nr) + IRQPIN_BASE)
 
-/* GPIO IRQ */
-#define _GPIO_IRQ_BASE		2500
-#define GPIO_IRQ_BASE(x)	(_GPIO_IRQ_BASE + (32 * x))
-#define GPIO_IRQ(x, y)		(_GPIO_IRQ_BASE + (32 * x) + y)
-
 #endif /* __ASM_MACH_IRQS_H */
+
--- 0002/arch/arm/mach-shmobile/intc-sh7372.c
+++ work/arch/arm/mach-shmobile/intc-sh7372.c	2014-06-17 16:03:57.000000000 +0900
@@ -22,10 +22,10 @@
 #include <linux/module.h>
 #include <linux/irq.h>
 #include <linux/io.h>
-#include <mach/irqs.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include "intc.h"
+#include "irqs.h"
 
 enum {
 	UNUSED_INTCA = 0,
--- 0002/arch/arm/mach-shmobile/intc-sh73a0.c
+++ work/arch/arm/mach-shmobile/intc-sh73a0.c	2014-06-17 16:03:57.000000000 +0900
@@ -24,11 +24,11 @@
 #include <linux/io.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic.h>
-#include <mach/irqs.h>
 #include <mach/sh73a0.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include "intc.h"
+#include "irqs.h"
 
 enum {
 	UNUSED = 0,
--- /dev/null
+++ work/arch/arm/mach-shmobile/irqs.h	2014-06-17 16:03:57.000000000 +0900
@@ -0,0 +1,21 @@
+#ifndef __SHMOBILE_IRQS_H
+#define __SHMOBILE_IRQS_H
+
+#include <linux/sh_intc.h>
+#include <mach/irqs.h>
+
+/* GIC */
+#define gic_spi(nr)		((nr) + 32)
+#define gic_iid(nr)		(nr) /* ICCIAR / interrupt ID */
+
+/* INTCS */
+#define INTCS_VECT_BASE		0x3400
+#define INTCS_VECT(n, vect)	INTC_VECT((n), INTCS_VECT_BASE + (vect))
+#define intcs_evt2irq(evt)	evt2irq(INTCS_VECT_BASE + (evt))
+
+/* GPIO IRQ */
+#define _GPIO_IRQ_BASE		2500
+#define GPIO_IRQ_BASE(x)	(_GPIO_IRQ_BASE + (32 * x))
+#define GPIO_IRQ(x, y)		(_GPIO_IRQ_BASE + (32 * x) + y)
+
+#endif /* __SHMOBILE_IRQS_H */
--- 0001/arch/arm/mach-shmobile/setup-r7s72100.c
+++ work/arch/arm/mach-shmobile/setup-r7s72100.c	2014-06-17 16:03:57.000000000 +0900
@@ -23,9 +23,9 @@
 #include <linux/of_platform.h>
 #include <linux/sh_timer.h>
 #include <mach/common.h>
-#include <mach/irqs.h>
 #include <mach/r7s72100.h>
 #include <asm/mach/arch.h>
+#include "irqs.h"
 
 static struct resource mtu2_resources[] __initdata = {
 	DEFINE_RES_MEM(0xfcff0000, 0x400),
--- 0003/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ work/arch/arm/mach-shmobile/setup-r8a73a4.c	2014-06-17 16:03:57.000000000 +0900
@@ -25,10 +25,10 @@
 #include <linux/sh_dma.h>
 #include <linux/sh_timer.h>
 #include <mach/common.h>
-#include <mach/irqs.h>
 #include <mach/r8a73a4.h>
 #include <asm/mach/arch.h>
 #include "dma-register.h"
+#include "irqs.h"
 
 static const struct resource pfc_resources[] = {
 	DEFINE_RES_MEM(0xe6050000, 0x9000),
--- 0003/arch/arm/mach-shmobile/setup-r8a7740.c
+++ work/arch/arm/mach-shmobile/setup-r8a7740.c	2014-06-17 16:03:57.000000000 +0900
@@ -34,12 +34,12 @@
 #include <mach/r8a7740.h>
 #include <mach/pm-rmobile.h>
 #include <mach/common.h>
-#include <mach/irqs.h>
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include "dma-register.h"
+#include "irqs.h"
 
 static struct map_desc r8a7740_io_desc[] __initdata = {
 	 /*
--- 0001/arch/arm/mach-shmobile/setup-r8a7778.c
+++ work/arch/arm/mach-shmobile/setup-r8a7778.c	2014-06-17 16:03:57.000000000 +0900
@@ -37,11 +37,11 @@
 #include <linux/usb/ehci_pdriver.h>
 #include <linux/usb/ohci_pdriver.h>
 #include <linux/dma-mapping.h>
-#include <mach/irqs.h>
 #include <mach/r8a7778.h>
 #include <mach/common.h>
 #include <asm/mach/arch.h>
 #include <asm/hardware/cache-l2x0.h>
+#include "irqs.h"
 
 /* SCIF */
 #define R8A7778_SCIF(index, baseaddr, irq)			\
--- 0001/arch/arm/mach-shmobile/setup-r8a7779.c
+++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2014-06-17 16:03:57.000000000 +0900
@@ -40,7 +40,6 @@
 #include <linux/usb/ehci_pdriver.h>
 #include <linux/usb/ohci_pdriver.h>
 #include <linux/pm_runtime.h>
-#include <mach/irqs.h>
 #include <mach/r8a7779.h>
 #include <mach/common.h>
 #include <asm/mach-types.h>
@@ -48,6 +47,7 @@
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
 #include <asm/hardware/cache-l2x0.h>
+#include "irqs.h"
 
 static struct map_desc r8a7779_io_desc[] __initdata = {
 	/* 2M entity map for 0xf0000000 (MPCORE) */
--- 0003/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2014-06-17 16:03:57.000000000 +0900
@@ -27,10 +27,10 @@
 #include <linux/sh_dma.h>
 #include <linux/sh_timer.h>
 #include <mach/common.h>
-#include <mach/irqs.h>
 #include <mach/r8a7790.h>
 #include <asm/mach/arch.h>
 #include "dma-register.h"
+#include "irqs.h"
 
 /* Audio-DMAC */
 #define AUDIO_DMAC_SLAVE(_id, _addr, t, r)			\
--- 0001/arch/arm/mach-shmobile/setup-r8a7791.c
+++ work/arch/arm/mach-shmobile/setup-r8a7791.c	2014-06-17 16:03:57.000000000 +0900
@@ -27,10 +27,10 @@
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
 #include <mach/common.h>
-#include <mach/irqs.h>
 #include <mach/r8a7791.h>
 #include <mach/rcar-gen2.h>
 #include <asm/mach/arch.h>
+#include "irqs.h"
 
 static const struct resource pfc_resources[] __initconst = {
 	DEFINE_RES_MEM(0xe6060000, 0x250),
--- 0003/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2014-06-17 16:03:57.000000000 +0900
@@ -33,7 +33,6 @@
 #include <linux/pm_domain.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_data/sh_ipmmu.h>
-#include <mach/irqs.h>
 #include <mach/sh7372.h>
 #include <mach/common.h>
 #include <asm/mach/map.h>
@@ -41,6 +40,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include "dma-register.h"
+#include "irqs.h"
 
 static struct map_desc sh7372_io_desc[] __initdata = {
 	/* create a 1:1 entity map for 0xe6xxxxxx
--- 0003/arch/arm/mach-shmobile/setup-sh73a0.c
+++ work/arch/arm/mach-shmobile/setup-sh73a0.c	2014-06-17 16:03:57.000000000 +0900
@@ -32,7 +32,6 @@
 #include <linux/sh_timer.h>
 #include <linux/platform_data/sh_ipmmu.h>
 #include <linux/platform_data/irq-renesas-intc-irqpin.h>
-#include <mach/irqs.h>
 #include <mach/sh73a0.h>
 #include <mach/common.h>
 #include <asm/mach-types.h>
@@ -40,6 +39,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include "dma-register.h"
+#include "irqs.h"
 
 static struct map_desc sh73a0_io_desc[] __initdata = {
 	/* create a 1:1 entity map for 0xe6xxxxxx
