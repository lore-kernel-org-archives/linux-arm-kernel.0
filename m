From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:25:00 +0900
Subject: [PATCH 4/8] ARM: shmobile: Move most of irqs.h, keep some for pinctl
In-Reply-To: <cover.1403487267.git.horms+renesas@verge.net.au>
References: <cover.1403487267.git.horms+renesas@verge.net.au>
Message-ID: <b6bab1263c61e39cfc3427f54baff6f683f54298.1403487267.git.horms+renesas@verge.net.au>
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
[horms+renesas at verge.net.au: Do not add trailing blank line to irqs.h]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ape6evm.c           |  2 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c   |  3 +--
 arch/arm/mach-shmobile/board-bockw.c             |  2 +-
 arch/arm/mach-shmobile/board-genmai.c            |  2 +-
 arch/arm/mach-shmobile/board-koelsch-reference.c |  2 +-
 arch/arm/mach-shmobile/board-koelsch.c           |  2 +-
 arch/arm/mach-shmobile/board-kzm9g.c             |  2 +-
 arch/arm/mach-shmobile/board-lager-reference.c   |  2 +-
 arch/arm/mach-shmobile/board-lager.c             |  2 +-
 arch/arm/mach-shmobile/board-mackerel.c          |  5 +----
 arch/arm/mach-shmobile/board-marzen-reference.c  |  2 +-
 arch/arm/mach-shmobile/board-marzen.c            |  2 +-
 arch/arm/mach-shmobile/include/mach/irqs.h       | 16 +---------------
 arch/arm/mach-shmobile/intc-sh7372.c             |  2 +-
 arch/arm/mach-shmobile/intc-sh73a0.c             |  2 +-
 arch/arm/mach-shmobile/irqs.h                    | 21 +++++++++++++++++++++
 arch/arm/mach-shmobile/setup-r7s72100.c          |  2 +-
 arch/arm/mach-shmobile/setup-r8a73a4.c           |  2 +-
 arch/arm/mach-shmobile/setup-r8a7740.c           |  2 +-
 arch/arm/mach-shmobile/setup-r8a7778.c           |  2 +-
 arch/arm/mach-shmobile/setup-r8a7779.c           |  2 +-
 arch/arm/mach-shmobile/setup-r8a7790.c           |  2 +-
 arch/arm/mach-shmobile/setup-r8a7791.c           |  2 +-
 arch/arm/mach-shmobile/setup-sh7372.c            |  2 +-
 arch/arm/mach-shmobile/setup-sh73a0.c            |  2 +-
 25 files changed, 45 insertions(+), 42 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/irqs.h

diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index fe071a9..48ec144 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
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
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 30fcac7..252e689 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
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
diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index f444be2..22252fb 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
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
diff --git a/arch/arm/mach-shmobile/board-genmai.c b/arch/arm/mach-shmobile/board-genmai.c
index c94201e..5ce1025 100644
--- a/arch/arm/mach-shmobile/board-genmai.c
+++ b/arch/arm/mach-shmobile/board-genmai.c
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
diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index 4a6dd63..fc174e1 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
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
diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index c6c6889..52665ad 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
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
diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index f94ec8c..ae8692e 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
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
diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 1d198b0..31cf06d 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
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
diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index f8b1e05..8f6d4e6 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
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
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 0864a63..92fbc47 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
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
diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index 2773936..08eb1c0 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -21,9 +21,9 @@
 
 #include <mach/r8a7779.h>
 #include <mach/common.h>
-#include <mach/irqs.h>
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
+#include "irqs.h"
 
 static void __init marzen_init(void)
 {
diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index d832a44..a9529ba 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
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
diff --git a/arch/arm/mach-shmobile/include/mach/irqs.h b/arch/arm/mach-shmobile/include/mach/irqs.h
index d241bfd..5aee83f 100644
--- a/arch/arm/mach-shmobile/include/mach/irqs.h
+++ b/arch/arm/mach-shmobile/include/mach/irqs.h
@@ -1,24 +1,10 @@
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
diff --git a/arch/arm/mach-shmobile/intc-sh7372.c b/arch/arm/mach-shmobile/intc-sh7372.c
index bd02123..e2af00b 100644
--- a/arch/arm/mach-shmobile/intc-sh7372.c
+++ b/arch/arm/mach-shmobile/intc-sh7372.c
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
diff --git a/arch/arm/mach-shmobile/intc-sh73a0.c b/arch/arm/mach-shmobile/intc-sh73a0.c
index facb70e..1a8f9a7 100644
--- a/arch/arm/mach-shmobile/intc-sh73a0.c
+++ b/arch/arm/mach-shmobile/intc-sh73a0.c
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
diff --git a/arch/arm/mach-shmobile/irqs.h b/arch/arm/mach-shmobile/irqs.h
new file mode 100644
index 0000000..4ff2d2a
--- /dev/null
+++ b/arch/arm/mach-shmobile/irqs.h
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
diff --git a/arch/arm/mach-shmobile/setup-r7s72100.c b/arch/arm/mach-shmobile/setup-r7s72100.c
index 412e179..a185f69 100644
--- a/arch/arm/mach-shmobile/setup-r7s72100.c
+++ b/arch/arm/mach-shmobile/setup-r7s72100.c
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
diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index 985739e..7efa77d7 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
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
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 7cf4bbd..e87c642 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
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
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index d311ef9..d8ae968 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
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
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index aba4ed6..ffbe331 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
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
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 3eed626..925327d 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
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
diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index 04a96dd..8055cff 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
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
diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 062929b..0fab666 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
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
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 370d55c..bb51002 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
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
-- 
2.0.0.rc2
