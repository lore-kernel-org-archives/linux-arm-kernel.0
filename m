From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:25:01 +0900
Subject: [PATCH 5/8] ARM: shmobile: Move common.h
In-Reply-To: <cover.1403487267.git.horms+renesas@verge.net.au>
References: <cover.1403487267.git.horms+renesas@verge.net.au>
Message-ID: <fd44aa5e570d1d8c7d361dcbf94c2b8cd25cfe92.1403487267.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Change location for common.h so it can be used as #include "common.h"
instead of the old style #include <mach/common.h>.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ape6evm-reference.c   |  2 +-
 arch/arm/mach-shmobile/board-ape6evm.c             |  2 +-
 .../board-armadillo800eva-reference.c              |  2 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c     |  2 +-
 arch/arm/mach-shmobile/board-bockw-reference.c     |  2 +-
 arch/arm/mach-shmobile/board-bockw.c               |  2 +-
 arch/arm/mach-shmobile/board-genmai-reference.c    |  2 +-
 arch/arm/mach-shmobile/board-genmai.c              |  2 +-
 arch/arm/mach-shmobile/board-koelsch-reference.c   |  2 +-
 arch/arm/mach-shmobile/board-koelsch.c             |  2 +-
 arch/arm/mach-shmobile/board-kzm9g-reference.c     |  2 +-
 arch/arm/mach-shmobile/board-kzm9g.c               |  2 +-
 arch/arm/mach-shmobile/board-lager-reference.c     |  2 +-
 arch/arm/mach-shmobile/board-lager.c               |  2 +-
 arch/arm/mach-shmobile/board-mackerel.c            |  2 +-
 arch/arm/mach-shmobile/board-marzen-reference.c    |  2 +-
 arch/arm/mach-shmobile/board-marzen.c              |  2 +-
 arch/arm/mach-shmobile/clock-r7s72100.c            |  2 +-
 arch/arm/mach-shmobile/clock-r8a73a4.c             |  2 +-
 arch/arm/mach-shmobile/clock-r8a7740.c             |  2 +-
 arch/arm/mach-shmobile/clock-r8a7778.c             |  2 +-
 arch/arm/mach-shmobile/clock-r8a7779.c             |  2 +-
 arch/arm/mach-shmobile/clock-r8a7790.c             |  2 +-
 arch/arm/mach-shmobile/clock-r8a7791.c             |  2 +-
 arch/arm/mach-shmobile/clock-sh7372.c              |  2 +-
 arch/arm/mach-shmobile/clock-sh73a0.c              |  2 +-
 arch/arm/mach-shmobile/clock.c                     |  2 +-
 arch/arm/mach-shmobile/common.h                    | 56 ++++++++++++++++++++++
 arch/arm/mach-shmobile/console.c                   |  2 +-
 arch/arm/mach-shmobile/include/mach/common.h       | 56 ----------------------
 arch/arm/mach-shmobile/platsmp-apmu.c              |  2 +-
 arch/arm/mach-shmobile/platsmp-scu.c               |  2 +-
 arch/arm/mach-shmobile/platsmp.c                   |  2 +-
 arch/arm/mach-shmobile/pm-r8a7740.c                |  2 +-
 arch/arm/mach-shmobile/pm-r8a7779.c                |  2 +-
 arch/arm/mach-shmobile/pm-sh7372.c                 |  2 +-
 arch/arm/mach-shmobile/pm-sh73a0.c                 |  2 +-
 arch/arm/mach-shmobile/setup-emev2.c               |  2 +-
 arch/arm/mach-shmobile/setup-r7s72100.c            |  2 +-
 arch/arm/mach-shmobile/setup-r8a73a4.c             |  2 +-
 arch/arm/mach-shmobile/setup-r8a7740.c             |  2 +-
 arch/arm/mach-shmobile/setup-r8a7778.c             |  2 +-
 arch/arm/mach-shmobile/setup-r8a7779.c             |  2 +-
 arch/arm/mach-shmobile/setup-r8a7790.c             |  2 +-
 arch/arm/mach-shmobile/setup-r8a7791.c             |  2 +-
 arch/arm/mach-shmobile/setup-rcar-gen2.c           |  2 +-
 arch/arm/mach-shmobile/setup-sh7372.c              |  2 +-
 arch/arm/mach-shmobile/setup-sh73a0.c              |  2 +-
 arch/arm/mach-shmobile/smp-emev2.c                 |  2 +-
 arch/arm/mach-shmobile/smp-r8a7779.c               |  2 +-
 arch/arm/mach-shmobile/smp-r8a7790.c               |  2 +-
 arch/arm/mach-shmobile/smp-r8a7791.c               |  2 +-
 arch/arm/mach-shmobile/smp-sh73a0.c                |  2 +-
 53 files changed, 107 insertions(+), 107 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/common.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/common.h

diff --git a/arch/arm/mach-shmobile/board-ape6evm-reference.c b/arch/arm/mach-shmobile/board-ape6evm-reference.c
index 3276afc..76e4ff1 100644
--- a/arch/arm/mach-shmobile/board-ape6evm-reference.c
+++ b/arch/arm/mach-shmobile/board-ape6evm-reference.c
@@ -24,10 +24,10 @@
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <linux/sh_clk.h>
-#include <mach/common.h>
 #include <mach/r8a73a4.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include "common.h"
 
 static void __init ape6evm_add_standard_devices(void)
 {
diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index 48ec144..8f8da25 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -33,10 +33,10 @@
 #include <linux/regulator/machine.h>
 #include <linux/sh_clk.h>
 #include <linux/smsc911x.h>
-#include <mach/common.h>
 #include <mach/r8a73a4.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include "common.h"
 #include "irqs.h"
 
 /* LEDS */
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
index f660fbb..368518b 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
@@ -24,10 +24,10 @@
 #include <linux/kernel.h>
 #include <linux/gpio.h>
 #include <linux/io.h>
-#include <mach/common.h>
 #include <mach/r8a7740.h>
 #include <asm/mach/arch.h>
 #include <asm/hardware/cache-l2x0.h>
+#include "common.h"
 
 /*
  * CON1		Camera Module
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 252e689..12b01df 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -45,7 +45,6 @@
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/i2c-gpio.h>
 #include <linux/reboot.h>
-#include <mach/common.h>
 #include <mach/r8a7740.h>
 #include <media/mt9t112.h>
 #include <media/sh_mobile_ceu.h>
@@ -60,6 +59,7 @@
 #include <video/sh_mobile_hdmi.h>
 #include <sound/sh_fsi.h>
 #include <sound/simple_card.h>
+#include "common.h"
 #include "irqs.h"
 #include "sh-gpio.h"
 
diff --git a/arch/arm/mach-shmobile/board-bockw-reference.c b/arch/arm/mach-shmobile/board-bockw-reference.c
index 027373f..91ff3a2 100644
--- a/arch/arm/mach-shmobile/board-bockw-reference.c
+++ b/arch/arm/mach-shmobile/board-bockw-reference.c
@@ -19,9 +19,9 @@
  */
 
 #include <linux/of_platform.h>
-#include <mach/common.h>
 #include <mach/r8a7778.h>
 #include <asm/mach/arch.h>
+#include "common.h"
 
 /*
  *	see board-bock.c for checking detail of dip-switch
diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 22252fb..8cb057f 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -35,11 +35,11 @@
 #include <linux/spi/flash.h>
 #include <linux/usb/renesas_usbhs.h>
 #include <media/soc_camera.h>
-#include <mach/common.h>
 #include <mach/r8a7778.h>
 #include <asm/mach/arch.h>
 #include <sound/rcar_snd.h>
 #include <sound/simple_card.h>
+#include "common.h"
 #include "irqs.h"
 
 #define FPGA	0x18200000
diff --git a/arch/arm/mach-shmobile/board-genmai-reference.c b/arch/arm/mach-shmobile/board-genmai-reference.c
index c353585..d341ef0 100644
--- a/arch/arm/mach-shmobile/board-genmai-reference.c
+++ b/arch/arm/mach-shmobile/board-genmai-reference.c
@@ -20,11 +20,11 @@
 
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
-#include <mach/common.h>
 #include <mach/r7s72100.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include "clock.h"
+#include "common.h"
 
 /*
  * This is a really crude hack to provide clkdev support to platform
diff --git a/arch/arm/mach-shmobile/board-genmai.c b/arch/arm/mach-shmobile/board-genmai.c
index 5ce1025..f0a8eca 100644
--- a/arch/arm/mach-shmobile/board-genmai.c
+++ b/arch/arm/mach-shmobile/board-genmai.c
@@ -25,10 +25,10 @@
 #include <linux/sh_eth.h>
 #include <linux/spi/rspi.h>
 #include <linux/spi/spi.h>
-#include <mach/common.h>
 #include <mach/r7s72100.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include "common.h"
 #include "irqs.h"
 
 /* Ether */
diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index fc174e1..10fd085 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -23,11 +23,11 @@
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/rcar-du.h>
-#include <mach/common.h>
 #include <mach/rcar-gen2.h>
 #include <mach/r8a7791.h>
 #include <asm/mach/arch.h>
 #include "clock.h"
+#include "common.h"
 #include "irqs.h"
 
 /* DU */
diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index 52665ad..1d8b6e6 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -45,11 +45,11 @@
 #include <linux/spi/flash.h>
 #include <linux/spi/rspi.h>
 #include <linux/spi/spi.h>
-#include <mach/common.h>
 #include <mach/r8a7791.h>
 #include <mach/rcar-gen2.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include "common.h"
 #include "irqs.h"
 
 /* DU */
diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index a735a1d..e6285de 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -26,10 +26,10 @@
 #include <linux/input.h>
 #include <linux/of_platform.h>
 #include <mach/sh73a0.h>
-#include <mach/common.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include "common.h"
 
 static void __init kzm_init(void)
 {
diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index ae8692e..fff330f 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -44,11 +44,11 @@
 #include <sound/sh_fsi.h>
 #include <sound/simple_card.h>
 #include <mach/sh73a0.h>
-#include <mach/common.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <video/sh_mobile_lcdc.h>
+#include "common.h"
 #include "irqs.h"
 
 /*
diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 31cf06d..6e1a261 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -22,11 +22,11 @@
 #include <linux/init.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/rcar-du.h>
-#include <mach/common.h>
 #include <mach/rcar-gen2.h>
 #include <mach/r8a7790.h>
 #include <asm/mach/arch.h>
 #include "clock.h"
+#include "common.h"
 #include "irqs.h"
 
 /* DU */
diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 8f6d4e6..f0249ca 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -45,7 +45,6 @@
 #include <linux/sh_eth.h>
 #include <linux/usb/phy.h>
 #include <linux/usb/renesas_usbhs.h>
-#include <mach/common.h>
 #include <mach/r8a7790.h>
 #include <media/soc_camera.h>
 #include <asm/mach-types.h>
@@ -57,6 +56,7 @@
 #include <linux/spi/spi.h>
 #include <sound/rcar_snd.h>
 #include <sound/simple_card.h>
+#include "common.h"
 #include "irqs.h"
 
 /*
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 92fbc47..3558ff0 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -57,10 +57,10 @@
 #include <media/soc_camera_platform.h>
 #include <sound/sh_fsi.h>
 #include <sound/simple_card.h>
-#include <mach/common.h>
 #include <mach/sh7372.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
+#include "common.h"
 #include "irqs.h"
 #include "sh-gpio.h"
 
diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index 08eb1c0..94bd572 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -20,9 +20,9 @@
  */
 
 #include <mach/r8a7779.h>
-#include <mach/common.h>
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
+#include "common.h"
 #include "irqs.h"
 
 static void __init marzen_init(void)
diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index a9529ba..fe445ef 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -43,10 +43,10 @@
 #include <linux/mfd/tmio.h>
 #include <media/soc_camera.h>
 #include <mach/r8a7779.h>
-#include <mach/common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/traps.h>
+#include "common.h"
 #include "irqs.h"
 
 /* Fixed 3.3V regulator to be used by SDHI0 */
diff --git a/arch/arm/mach-shmobile/clock-r7s72100.c b/arch/arm/mach-shmobile/clock-r7s72100.c
index df18748..457dab0 100644
--- a/arch/arm/mach-shmobile/clock-r7s72100.c
+++ b/arch/arm/mach-shmobile/clock-r7s72100.c
@@ -19,8 +19,8 @@
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/common.h>
 #include <mach/r7s72100.h>
+#include "common.h"
 
 /* Frequency Control Registers */
 #define FRQCR		0xfcfe0010
diff --git a/arch/arm/mach-shmobile/clock-r8a73a4.c b/arch/arm/mach-shmobile/clock-r8a73a4.c
index 857b142..0f43149 100644
--- a/arch/arm/mach-shmobile/clock-r8a73a4.c
+++ b/arch/arm/mach-shmobile/clock-r8a73a4.c
@@ -22,7 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/common.h>
+#include "common.h"
 #include "clock.h"
 
 #define CPG_BASE 0xe6150000
diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 6986527..ffefec5 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -22,9 +22,9 @@
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/common.h>
 #include <mach/r8a7740.h>
 #include "clock.h"
+#include "common.h"
 
 /*
  *        |  MDx  |  XTAL1/EXTAL1   |  System   | EXTALR |
diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c b/arch/arm/mach-shmobile/clock-r8a7778.c
index 017fa50..16bbc94 100644
--- a/arch/arm/mach-shmobile/clock-r8a7778.c
+++ b/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -39,8 +39,8 @@
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/common.h>
 #include "clock.h"
+#include "common.h"
 
 #define MSTPCR0		IOMEM(0xffc80030)
 #define MSTPCR1		IOMEM(0xffc80034)
diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index eb7b131..d81539a 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -23,8 +23,8 @@
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/common.h>
 #include "clock.h"
+#include "common.h"
 
 /*
  *		MD1 = 1			MD1 = 0
diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index 8c62446..b6781a0 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -22,9 +22,9 @@
 #include <linux/kernel.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/common.h>
 #include <mach/r8a7790.h>
 #include "clock.h"
+#include "common.h"
 
 /*
  *   MD		EXTAL		PLL0	PLL1	PLL3
diff --git a/arch/arm/mach-shmobile/clock-r8a7791.c b/arch/arm/mach-shmobile/clock-r8a7791.c
index 20cad4a..494aaf6 100644
--- a/arch/arm/mach-shmobile/clock-r8a7791.c
+++ b/arch/arm/mach-shmobile/clock-r8a7791.c
@@ -23,9 +23,9 @@
 #include <linux/kernel.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/common.h>
 #include <mach/rcar-gen2.h>
 #include "clock.h"
+#include "common.h"
 
 /*
  *   MD		EXTAL		PLL0	PLL1	PLL3
diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index b19bc7e..7071676 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -21,8 +21,8 @@
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/common.h>
 #include "clock.h"
+#include "common.h"
 
 /* SH7372 registers */
 #define FRQCRA		IOMEM(0xe6150000)
diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 3956b95..37f4838 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -22,8 +22,8 @@
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
 #include <asm/processor.h>
-#include <mach/common.h>
 #include "clock.h"
+#include "common.h"
 
 #define FRQCRA		IOMEM(0xe6150000)
 #define FRQCRB		IOMEM(0xe6150004)
diff --git a/arch/arm/mach-shmobile/clock.c b/arch/arm/mach-shmobile/clock.c
index 2a58a78..806f940 100644
--- a/arch/arm/mach-shmobile/clock.c
+++ b/arch/arm/mach-shmobile/clock.c
@@ -49,8 +49,8 @@ void __init shmobile_clk_workaround(const struct clk_name *clks,
 #else /* CONFIG_COMMON_CLK */
 #include <linux/sh_clk.h>
 #include <linux/export.h>
-#include <mach/common.h>
 #include "clock.h"
+#include "common.h"
 
 unsigned long shmobile_fixed_ratio_clk_recalc(struct clk *clk)
 {
diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
new file mode 100644
index 0000000..f7a360e
--- /dev/null
+++ b/arch/arm/mach-shmobile/common.h
@@ -0,0 +1,56 @@
+#ifndef __ARCH_MACH_COMMON_H
+#define __ARCH_MACH_COMMON_H
+
+extern void shmobile_earlytimer_init(void);
+extern void shmobile_setup_delay(unsigned int max_cpu_core_mhz,
+			 unsigned int mult, unsigned int div);
+extern void shmobile_init_delay(void);
+struct twd_local_timer;
+extern void shmobile_setup_console(void);
+extern void shmobile_boot_vector(void);
+extern unsigned long shmobile_boot_fn;
+extern unsigned long shmobile_boot_arg;
+extern unsigned long shmobile_boot_size;
+extern void shmobile_smp_boot(void);
+extern void shmobile_smp_sleep(void);
+extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
+			      unsigned long arg);
+extern int shmobile_smp_cpu_disable(unsigned int cpu);
+extern void shmobile_invalidate_start(void);
+extern void shmobile_boot_scu(void);
+extern void shmobile_smp_scu_prepare_cpus(unsigned int max_cpus);
+extern void shmobile_smp_scu_cpu_die(unsigned int cpu);
+extern int shmobile_smp_scu_cpu_kill(unsigned int cpu);
+extern void shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus);
+extern int shmobile_smp_apmu_boot_secondary(unsigned int cpu,
+					    struct task_struct *idle);
+extern void shmobile_smp_apmu_cpu_die(unsigned int cpu);
+extern int shmobile_smp_apmu_cpu_kill(unsigned int cpu);
+struct clk;
+extern int shmobile_clk_init(void);
+extern void shmobile_handle_irq_intc(struct pt_regs *);
+extern struct platform_suspend_ops shmobile_suspend_ops;
+struct cpuidle_driver;
+extern void shmobile_cpuidle_set_driver(struct cpuidle_driver *drv);
+
+#ifdef CONFIG_SUSPEND
+int shmobile_suspend_init(void);
+#else
+static inline int shmobile_suspend_init(void) { return 0; }
+#endif
+
+#ifdef CONFIG_CPU_IDLE
+int shmobile_cpuidle_init(void);
+#else
+static inline int shmobile_cpuidle_init(void) { return 0; }
+#endif
+
+extern void __iomem *shmobile_scu_base;
+
+static inline void __init shmobile_init_late(void)
+{
+	shmobile_suspend_init();
+	shmobile_cpuidle_init();
+}
+
+#endif /* __ARCH_MACH_COMMON_H */
diff --git a/arch/arm/mach-shmobile/console.c b/arch/arm/mach-shmobile/console.c
index 9411a5b..f2e79f2 100644
--- a/arch/arm/mach-shmobile/console.c
+++ b/arch/arm/mach-shmobile/console.c
@@ -19,8 +19,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <mach/common.h>
 #include <asm/mach/map.h>
+#include "common.h"
 
 void __init shmobile_setup_console(void)
 {
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
deleted file mode 100644
index f7a360e..0000000
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ /dev/null
@@ -1,56 +0,0 @@
-#ifndef __ARCH_MACH_COMMON_H
-#define __ARCH_MACH_COMMON_H
-
-extern void shmobile_earlytimer_init(void);
-extern void shmobile_setup_delay(unsigned int max_cpu_core_mhz,
-			 unsigned int mult, unsigned int div);
-extern void shmobile_init_delay(void);
-struct twd_local_timer;
-extern void shmobile_setup_console(void);
-extern void shmobile_boot_vector(void);
-extern unsigned long shmobile_boot_fn;
-extern unsigned long shmobile_boot_arg;
-extern unsigned long shmobile_boot_size;
-extern void shmobile_smp_boot(void);
-extern void shmobile_smp_sleep(void);
-extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
-			      unsigned long arg);
-extern int shmobile_smp_cpu_disable(unsigned int cpu);
-extern void shmobile_invalidate_start(void);
-extern void shmobile_boot_scu(void);
-extern void shmobile_smp_scu_prepare_cpus(unsigned int max_cpus);
-extern void shmobile_smp_scu_cpu_die(unsigned int cpu);
-extern int shmobile_smp_scu_cpu_kill(unsigned int cpu);
-extern void shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus);
-extern int shmobile_smp_apmu_boot_secondary(unsigned int cpu,
-					    struct task_struct *idle);
-extern void shmobile_smp_apmu_cpu_die(unsigned int cpu);
-extern int shmobile_smp_apmu_cpu_kill(unsigned int cpu);
-struct clk;
-extern int shmobile_clk_init(void);
-extern void shmobile_handle_irq_intc(struct pt_regs *);
-extern struct platform_suspend_ops shmobile_suspend_ops;
-struct cpuidle_driver;
-extern void shmobile_cpuidle_set_driver(struct cpuidle_driver *drv);
-
-#ifdef CONFIG_SUSPEND
-int shmobile_suspend_init(void);
-#else
-static inline int shmobile_suspend_init(void) { return 0; }
-#endif
-
-#ifdef CONFIG_CPU_IDLE
-int shmobile_cpuidle_init(void);
-#else
-static inline int shmobile_cpuidle_init(void) { return 0; }
-#endif
-
-extern void __iomem *shmobile_scu_base;
-
-static inline void __init shmobile_init_late(void)
-{
-	shmobile_suspend_init();
-	shmobile_cpuidle_init();
-}
-
-#endif /* __ARCH_MACH_COMMON_H */
diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 8cb641c..fe648f5 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -16,7 +16,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
 #include <asm/smp_plat.h>
-#include <mach/common.h>
+#include "common.h"
 
 static struct {
 	void __iomem *iomem;
diff --git a/arch/arm/mach-shmobile/platsmp-scu.c b/arch/arm/mach-shmobile/platsmp-scu.c
index 673ad6e..6466311 100644
--- a/arch/arm/mach-shmobile/platsmp-scu.c
+++ b/arch/arm/mach-shmobile/platsmp-scu.c
@@ -15,7 +15,7 @@
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
-#include <mach/common.h>
+#include "common.h"
 
 static int shmobile_smp_scu_notifier_call(struct notifier_block *nfb,
 					  unsigned long action, void *hcpu)
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
index 9ebc246..3923e09 100644
--- a/arch/arm/mach-shmobile/platsmp.c
+++ b/arch/arm/mach-shmobile/platsmp.c
@@ -13,7 +13,7 @@
 #include <linux/init.h>
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
-#include <mach/common.h>
+#include "common.h"
 
 extern unsigned long shmobile_smp_fn[];
 extern unsigned long shmobile_smp_arg[];
diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index 40b87aa..a8a0d05 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -11,7 +11,7 @@
 #include <linux/console.h>
 #include <linux/suspend.h>
 #include <mach/pm-rmobile.h>
-#include <mach/common.h>
+#include "common.h"
 
 #ifdef CONFIG_PM
 static int r8a7740_pd_a4s_suspend(void)
diff --git a/arch/arm/mach-shmobile/pm-r8a7779.c b/arch/arm/mach-shmobile/pm-r8a7779.c
index d6fe189..2b79bac 100644
--- a/arch/arm/mach-shmobile/pm-r8a7779.c
+++ b/arch/arm/mach-shmobile/pm-r8a7779.c
@@ -19,9 +19,9 @@
 #include <linux/interrupt.h>
 #include <linux/console.h>
 #include <asm/io.h>
-#include <mach/common.h>
 #include <mach/pm-rcar.h>
 #include <mach/r8a7779.h>
+#include "common.h"
 
 /* SYSC */
 #define SYSCIER 0x0c
diff --git a/arch/arm/mach-shmobile/pm-sh7372.c b/arch/arm/mach-shmobile/pm-sh7372.c
index 0de75fd..0b1b4de 100644
--- a/arch/arm/mach-shmobile/pm-sh7372.c
+++ b/arch/arm/mach-shmobile/pm-sh7372.c
@@ -25,9 +25,9 @@
 #include <asm/io.h>
 #include <asm/tlbflush.h>
 #include <asm/suspend.h>
-#include <mach/common.h>
 #include <mach/sh7372.h>
 #include <mach/pm-rmobile.h>
+#include "common.h"
 
 /* DBG */
 #define DBGREG1 IOMEM(0xe6100020)
diff --git a/arch/arm/mach-shmobile/pm-sh73a0.c b/arch/arm/mach-shmobile/pm-sh73a0.c
index 99086e9..a7e4668 100644
--- a/arch/arm/mach-shmobile/pm-sh73a0.c
+++ b/arch/arm/mach-shmobile/pm-sh73a0.c
@@ -9,7 +9,7 @@
  */
 
 #include <linux/suspend.h>
-#include <mach/common.h>
+#include "common.h"
 
 #ifdef CONFIG_SUSPEND
 static int sh73a0_enter_suspend(suspend_state_t suspend_state)
diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
index d953ff6..6e4ffa7 100644
--- a/arch/arm/mach-shmobile/setup-emev2.c
+++ b/arch/arm/mach-shmobile/setup-emev2.c
@@ -20,10 +20,10 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/of_platform.h>
-#include <mach/common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include "common.h"
 
 static struct map_desc emev2_io_desc[] __initdata = {
 #ifdef CONFIG_SMP
diff --git a/arch/arm/mach-shmobile/setup-r7s72100.c b/arch/arm/mach-shmobile/setup-r7s72100.c
index a185f69..17a74d3 100644
--- a/arch/arm/mach-shmobile/setup-r7s72100.c
+++ b/arch/arm/mach-shmobile/setup-r7s72100.c
@@ -22,9 +22,9 @@
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <linux/sh_timer.h>
-#include <mach/common.h>
 #include <mach/r7s72100.h>
 #include <asm/mach/arch.h>
+#include "common.h"
 #include "irqs.h"
 
 static struct resource mtu2_resources[] __initdata = {
diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index 7efa77d7..da94d9b 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -24,9 +24,9 @@
 #include <linux/serial_sci.h>
 #include <linux/sh_dma.h>
 #include <linux/sh_timer.h>
-#include <mach/common.h>
 #include <mach/r8a73a4.h>
 #include <asm/mach/arch.h>
+#include "common.h"
 #include "dma-register.h"
 #include "irqs.h"
 
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index e87c642..d86a128 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -33,11 +33,11 @@
 #include <linux/platform_data/sh_ipmmu.h>
 #include <mach/r8a7740.h>
 #include <mach/pm-rmobile.h>
-#include <mach/common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
+#include "common.h"
 #include "dma-register.h"
 #include "irqs.h"
 
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index d8ae968..d9f4529 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -38,9 +38,9 @@
 #include <linux/usb/ohci_pdriver.h>
 #include <linux/dma-mapping.h>
 #include <mach/r8a7778.h>
-#include <mach/common.h>
 #include <asm/mach/arch.h>
 #include <asm/hardware/cache-l2x0.h>
+#include "common.h"
 #include "irqs.h"
 
 /* SCIF */
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index ffbe331..86ec4b6 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -41,12 +41,12 @@
 #include <linux/usb/ohci_pdriver.h>
 #include <linux/pm_runtime.h>
 #include <mach/r8a7779.h>
-#include <mach/common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
 #include <asm/hardware/cache-l2x0.h>
+#include "common.h"
 #include "irqs.h"
 
 static struct map_desc r8a7779_io_desc[] __initdata = {
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 925327d..7bbe5c0 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -26,9 +26,9 @@
 #include <linux/serial_sci.h>
 #include <linux/sh_dma.h>
 #include <linux/sh_timer.h>
-#include <mach/common.h>
 #include <mach/r8a7790.h>
 #include <asm/mach/arch.h>
+#include "common.h"
 #include "dma-register.h"
 #include "irqs.h"
 
diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index 8055cff..6d8c61f 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -26,10 +26,10 @@
 #include <linux/platform_data/irq-renesas-irqc.h>
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
-#include <mach/common.h>
 #include <mach/r8a7791.h>
 #include <mach/rcar-gen2.h>
 #include <asm/mach/arch.h>
+#include "common.h"
 #include "irqs.h"
 
 static const struct resource pfc_resources[] __initconst = {
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 542c5a4..1c41227 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -22,9 +22,9 @@
 #include <linux/clocksource.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <mach/common.h>
 #include <mach/rcar-gen2.h>
 #include <asm/mach/arch.h>
+#include "common.h"
 
 #define MODEMR 0xe6160060
 
diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 0fab666..8da836a 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -34,11 +34,11 @@
 #include <linux/dma-mapping.h>
 #include <linux/platform_data/sh_ipmmu.h>
 #include <mach/sh7372.h>
-#include <mach/common.h>
 #include <asm/mach/map.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
+#include "common.h"
 #include "dma-register.h"
 #include "irqs.h"
 
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index bb51002..b30bbee 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -33,11 +33,11 @@
 #include <linux/platform_data/sh_ipmmu.h>
 #include <linux/platform_data/irq-renesas-intc-irqpin.h>
 #include <mach/sh73a0.h>
-#include <mach/common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
+#include "common.h"
 #include "dma-register.h"
 #include "irqs.h"
 
diff --git a/arch/arm/mach-shmobile/smp-emev2.c b/arch/arm/mach-shmobile/smp-emev2.c
index 2dfd748..6ff1df1 100644
--- a/arch/arm/mach-shmobile/smp-emev2.c
+++ b/arch/arm/mach-shmobile/smp-emev2.c
@@ -23,9 +23,9 @@
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/delay.h>
-#include <mach/common.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
+#include "common.h"
 
 #define EMEV2_SCU_BASE 0x1e000000
 #define EMEV2_SMU_BASE 0xe0110000
diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index e7a3201..e063cd2 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -23,13 +23,13 @@
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/delay.h>
-#include <mach/common.h>
 #include <mach/pm-rcar.h>
 #include <mach/r8a7779.h>
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 #include <asm/smp_twd.h>
+#include "common.h"
 
 #define AVECR IOMEM(0xfe700040)
 #define R8A7779_SCU_BASE 0xf0000000
diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c b/arch/arm/mach-shmobile/smp-r8a7790.c
index 5910527..fea53d5 100644
--- a/arch/arm/mach-shmobile/smp-r8a7790.c
+++ b/arch/arm/mach-shmobile/smp-r8a7790.c
@@ -18,9 +18,9 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 #include <asm/smp_plat.h>
-#include <mach/common.h>
 #include <mach/pm-rcar.h>
 #include <mach/r8a7790.h>
+#include "common.h"
 
 #define RST		0xe6160000
 #define CA15BAR		0x0020
diff --git a/arch/arm/mach-shmobile/smp-r8a7791.c b/arch/arm/mach-shmobile/smp-r8a7791.c
index ec97952..bf88c66 100644
--- a/arch/arm/mach-shmobile/smp-r8a7791.c
+++ b/arch/arm/mach-shmobile/smp-r8a7791.c
@@ -18,9 +18,9 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 #include <asm/smp_plat.h>
-#include <mach/common.h>
 #include <mach/r8a7791.h>
 #include <mach/rcar-gen2.h>
+#include "common.h"
 
 #define RST		0xe6160000
 #define CA15BAR		0x0020
diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index 13ba36a..bf4aff9 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -22,10 +22,10 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 #include <linux/delay.h>
-#include <mach/common.h>
 #include <mach/sh73a0.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_twd.h>
+#include "common.h"
 
 #define WUPCR		IOMEM(0xe6151010)
 #define SRESCR		IOMEM(0xe6151018)
-- 
2.0.0.rc2
