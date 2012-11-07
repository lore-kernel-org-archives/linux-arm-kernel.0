From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed,  7 Nov 2012 12:22:47 +0100
Subject: [PATCH 03/10] arm: at91 move board.h to arch/arm/mach-at91
In-Reply-To: <1352287374-25176-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121107111235.GH20063@game.jcrosoft.org>
 <1352287374-25176-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1352287374-25176-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

as this is only used board old style board

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91rm9200_devices.c       |    2 +-
 arch/arm/mach-at91/at91sam9260_devices.c      |    2 +-
 arch/arm/mach-at91/at91sam9261_devices.c      |    2 +-
 arch/arm/mach-at91/at91sam9263_devices.c      |    2 +-
 arch/arm/mach-at91/at91sam9g45_devices.c      |    2 +-
 arch/arm/mach-at91/at91sam9n12.c              |    2 +-
 arch/arm/mach-at91/at91sam9rl_devices.c       |    2 +-
 arch/arm/mach-at91/at91sam9x5.c               |    2 +-
 arch/arm/mach-at91/board-1arm.c               |    2 +-
 arch/arm/mach-at91/board-afeb-9260v1.c        |    2 +-
 arch/arm/mach-at91/board-cam60.c              |    2 +-
 arch/arm/mach-at91/board-carmeva.c            |    2 +-
 arch/arm/mach-at91/board-cpu9krea.c           |    2 +-
 arch/arm/mach-at91/board-cpuat91.c            |    2 +-
 arch/arm/mach-at91/board-csb337.c             |    2 +-
 arch/arm/mach-at91/board-csb637.c             |    2 +-
 arch/arm/mach-at91/board-dt.c                 |    2 +-
 arch/arm/mach-at91/board-eb01.c               |    3 ++-
 arch/arm/mach-at91/board-eb9200.c             |    2 +-
 arch/arm/mach-at91/board-ecbat91.c            |    2 +-
 arch/arm/mach-at91/board-eco920.c             |    2 +-
 arch/arm/mach-at91/board-flexibity.c          |    2 +-
 arch/arm/mach-at91/board-foxg20.c             |    2 +-
 arch/arm/mach-at91/board-gsia18s.c            |    2 +-
 arch/arm/mach-at91/board-kafa.c               |    2 +-
 arch/arm/mach-at91/board-kb9202.c             |    2 +-
 arch/arm/mach-at91/board-neocore926.c         |    2 +-
 arch/arm/mach-at91/board-pcontrol-g20.c       |    2 +-
 arch/arm/mach-at91/board-picotux200.c         |    2 +-
 arch/arm/mach-at91/board-qil-a9260.c          |    2 +-
 arch/arm/mach-at91/board-rm9200dk.c           |    2 +-
 arch/arm/mach-at91/board-rm9200ek.c           |    2 +-
 arch/arm/mach-at91/board-rsi-ews.c            |    2 +-
 arch/arm/mach-at91/board-sam9-l9260.c         |    2 +-
 arch/arm/mach-at91/board-sam9260ek.c          |    2 +-
 arch/arm/mach-at91/board-sam9261ek.c          |    2 +-
 arch/arm/mach-at91/board-sam9263ek.c          |    2 +-
 arch/arm/mach-at91/board-sam9g20ek.c          |    2 +-
 arch/arm/mach-at91/board-sam9m10g45ek.c       |    2 +-
 arch/arm/mach-at91/board-sam9rlek.c           |    2 +-
 arch/arm/mach-at91/board-snapper9260.c        |    2 +-
 arch/arm/mach-at91/board-stamp9g20.c          |    2 +-
 arch/arm/mach-at91/board-usb-a926x.c          |    2 +-
 arch/arm/mach-at91/board-yl-9200.c            |    2 +-
 arch/arm/mach-at91/{include/mach => }/board.h |    0
 arch/arm/mach-at91/leds.c                     |    2 +-
 46 files changed, 46 insertions(+), 45 deletions(-)
 rename arch/arm/mach-at91/{include/mach => }/board.h (100%)

diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 1e122bc..94bbf7d 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -18,11 +18,11 @@
 #include <linux/platform_device.h>
 #include <linux/i2c-gpio.h>
 
-#include <mach/board.h>
 #include <mach/at91rm9200.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
 
+#include "board.h"
 #include "generic.h"
 
 
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index aa1e587..2670bac 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -19,7 +19,6 @@
 
 #include <linux/platform_data/at91_adc.h>
 
-#include <mach/board.h>
 #include <mach/cpu.h>
 #include <mach/at91sam9260.h>
 #include <mach/at91sam9260_matrix.h>
@@ -27,6 +26,7 @@
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_adc.h>
 
+#include "board.h"
 #include "generic.h"
 
 
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index b948769..a3c0d97 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -21,12 +21,12 @@
 #include <linux/fb.h>
 #include <video/atmel_lcdc.h>
 
-#include <mach/board.h>
 #include <mach/at91sam9261.h>
 #include <mach/at91sam9261_matrix.h>
 #include <mach/at91_matrix.h>
 #include <mach/at91sam9_smc.h>
 
+#include "board.h"
 #include "generic.h"
 
 
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index cb85da2..2ad7fea 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -20,12 +20,12 @@
 #include <linux/fb.h>
 #include <video/atmel_lcdc.h>
 
-#include <mach/board.h>
 #include <mach/at91sam9263.h>
 #include <mach/at91sam9263_matrix.h>
 #include <mach/at91_matrix.h>
 #include <mach/at91sam9_smc.h>
 
+#include "board.h"
 #include "generic.h"
 
 
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index b159607..ddc3285 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -26,7 +26,6 @@
 #include <video/atmel_lcdc.h>
 
 #include <mach/at91_adc.h>
-#include <mach/board.h>
 #include <mach/at91sam9g45.h>
 #include <mach/at91sam9g45_matrix.h>
 #include <mach/at91_matrix.h>
@@ -36,6 +35,7 @@
 
 #include <media/atmel-isi.h>
 
+#include "board.h"
 #include "generic.h"
 #include "clock.h"
 
diff --git a/arch/arm/mach-at91/at91sam9n12.c b/arch/arm/mach-at91/at91sam9n12.c
index 732d3d3..896d09e 100644
--- a/arch/arm/mach-at91/at91sam9n12.c
+++ b/arch/arm/mach-at91/at91sam9n12.c
@@ -15,8 +15,8 @@
 #include <mach/at91sam9n12.h>
 #include <mach/at91_pmc.h>
 #include <mach/cpu.h>
-#include <mach/board.h>
 
+#include "board.h"
 #include "soc.h"
 #include "generic.h"
 #include "clock.h"
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 5047bdc..160384d 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -17,13 +17,13 @@
 #include <linux/fb.h>
 #include <video/atmel_lcdc.h>
 
-#include <mach/board.h>
 #include <mach/at91sam9rl.h>
 #include <mach/at91sam9rl_matrix.h>
 #include <mach/at91_matrix.h>
 #include <mach/at91sam9_smc.h>
 #include <linux/platform_data/dma-atmel.h>
 
+#include "board.h"
 #include "generic.h"
 
 
diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index e503538..1d66551 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -15,8 +15,8 @@
 #include <mach/at91sam9x5.h>
 #include <mach/at91_pmc.h>
 #include <mach/cpu.h>
-#include <mach/board.h>
 
+#include "board.h"
 #include "soc.h"
 #include "generic.h"
 #include "clock.h"
diff --git a/arch/arm/mach-at91/board-1arm.c b/arch/arm/mach-at91/board-1arm.c
index 22d8856..0f22d25 100644
--- a/arch/arm/mach-at91/board-1arm.c
+++ b/arch/arm/mach-at91/board-1arm.c
@@ -34,10 +34,10 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/board.h>
 #include <mach/cpu.h>
 #include <mach/at91_aic.h>
 
+#include "board.h"
 #include "generic.h"
 
 
diff --git a/arch/arm/mach-at91/board-afeb-9260v1.c b/arch/arm/mach-at91/board-afeb-9260v1.c
index 93a832f..7935673 100644
--- a/arch/arm/mach-at91/board-afeb-9260v1.c
+++ b/arch/arm/mach-at91/board-afeb-9260v1.c
@@ -43,9 +43,9 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 
+#include "board.h"
 #include "generic.h"
 
 
diff --git a/arch/arm/mach-at91/board-cam60.c b/arch/arm/mach-at91/board-cam60.c
index 477e708..51dec43 100644
--- a/arch/arm/mach-at91/board-cam60.c
+++ b/arch/arm/mach-at91/board-cam60.c
@@ -38,10 +38,10 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 
+#include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-carmeva.c b/arch/arm/mach-at91/board-carmeva.c
index 71d8f36..2811763 100644
--- a/arch/arm/mach-at91/board-carmeva.c
+++ b/arch/arm/mach-at91/board-carmeva.c
@@ -35,9 +35,9 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 
+#include "board.h"
 #include "generic.h"
 
 
diff --git a/arch/arm/mach-at91/board-cpu9krea.c b/arch/arm/mach-at91/board-cpu9krea.c
index e71c473..9e6316d 100644
--- a/arch/arm/mach-at91/board-cpu9krea.c
+++ b/arch/arm/mach-at91/board-cpu9krea.c
@@ -40,12 +40,12 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91sam9260_matrix.h>
 #include <mach/at91_matrix.h>
 
+#include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-cpuat91.c b/arch/arm/mach-at91/board-cpuat91.c
index 2cbd1a2..e74d395 100644
--- a/arch/arm/mach-at91/board-cpuat91.c
+++ b/arch/arm/mach-at91/board-cpuat91.c
@@ -36,12 +36,12 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
 #include <mach/cpu.h>
 
+#include "board.h"
 #include "generic.h"
 
 static struct gpio_led cpuat91_leds[] = {
diff --git a/arch/arm/mach-at91/board-csb337.c b/arch/arm/mach-at91/board-csb337.c
index 3e37437..e4063bd 100644
--- a/arch/arm/mach-at91/board-csb337.c
+++ b/arch/arm/mach-at91/board-csb337.c
@@ -38,9 +38,9 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 
+#include "board.h"
 #include "generic.h"
 
 
diff --git a/arch/arm/mach-at91/board-csb637.c b/arch/arm/mach-at91/board-csb637.c
index 872871a..306e7b6 100644
--- a/arch/arm/mach-at91/board-csb637.c
+++ b/arch/arm/mach-at91/board-csb637.c
@@ -35,9 +35,9 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 
+#include "board.h"
 #include "generic.h"
 
 
diff --git a/arch/arm/mach-at91/board-dt.c b/arch/arm/mach-at91/board-dt.c
index e8f45c4..7ba737d 100644
--- a/arch/arm/mach-at91/board-dt.c
+++ b/arch/arm/mach-at91/board-dt.c
@@ -15,7 +15,6 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 
 #include <asm/setup.h>
@@ -24,6 +23,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
+#include "board.h"
 #include "generic.h"
 
 
diff --git a/arch/arm/mach-at91/board-eb01.c b/arch/arm/mach-at91/board-eb01.c
index 01f66e9..f6b85f0 100644
--- a/arch/arm/mach-at91/board-eb01.c
+++ b/arch/arm/mach-at91/board-eb01.c
@@ -27,8 +27,9 @@
 #include <mach/hardware.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <mach/board.h>
 #include <mach/at91_aic.h>
+
+#include "board.h"
 #include "generic.h"
 
 static void __init at91eb01_init_irq(void)
diff --git a/arch/arm/mach-at91/board-eb9200.c b/arch/arm/mach-at91/board-eb9200.c
index 0cfac16..6e53817 100644
--- a/arch/arm/mach-at91/board-eb9200.c
+++ b/arch/arm/mach-at91/board-eb9200.c
@@ -35,9 +35,9 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 
+#include "board.h"
 #include "generic.h"
 
 
diff --git a/arch/arm/mach-at91/board-ecbat91.c b/arch/arm/mach-at91/board-ecbat91.c
index 3d931ff..df23145 100644
--- a/arch/arm/mach-at91/board-ecbat91.c
+++ b/arch/arm/mach-at91/board-ecbat91.c
@@ -37,10 +37,10 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/board.h>
 #include <mach/cpu.h>
 #include <mach/at91_aic.h>
 
+#include "board.h"
 #include "generic.h"
 
 
diff --git a/arch/arm/mach-at91/board-eco920.c b/arch/arm/mach-at91/board-eco920.c
index d93658a..771e58b 100644
--- a/arch/arm/mach-at91/board-eco920.c
+++ b/arch/arm/mach-at91/board-eco920.c
@@ -24,12 +24,12 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
 #include <mach/cpu.h>
 
+#include "board.h"
 #include "generic.h"
 
 static void __init eco920_init_early(void)
diff --git a/arch/arm/mach-at91/board-flexibity.c b/arch/arm/mach-at91/board-flexibity.c
index fa98aba..2df0fe4 100644
--- a/arch/arm/mach-at91/board-flexibity.c
+++ b/arch/arm/mach-at91/board-flexibity.c
@@ -33,9 +33,9 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 
+#include "board.h"
 #include "generic.h"
 
 static void __init flexibity_init_early(void)
diff --git a/arch/arm/mach-at91/board-foxg20.c b/arch/arm/mach-at91/board-foxg20.c
index 6e47071..18e1777 100644
--- a/arch/arm/mach-at91/board-foxg20.c
+++ b/arch/arm/mach-at91/board-foxg20.c
@@ -41,10 +41,10 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 
+#include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-gsia18s.c b/arch/arm/mach-at91/board-gsia18s.c
index a9d5e78..0fefddc 100644
--- a/arch/arm/mach-at91/board-gsia18s.c
+++ b/arch/arm/mach-at91/board-gsia18s.c
@@ -30,12 +30,12 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/gsia18s.h>
 #include <mach/stamp9g20.h>
 
+#include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-kafa.c b/arch/arm/mach-at91/board-kafa.c
index 86050da..920cf4c 100644
--- a/arch/arm/mach-at91/board-kafa.c
+++ b/arch/arm/mach-at91/board-kafa.c
@@ -34,10 +34,10 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/cpu.h>
 
+#include "board.h"
 #include "generic.h"
 
 
diff --git a/arch/arm/mach-at91/board-kb9202.c b/arch/arm/mach-at91/board-kb9202.c
index abe9fed..2d37837 100644
--- a/arch/arm/mach-at91/board-kb9202.c
+++ b/arch/arm/mach-at91/board-kb9202.c
@@ -35,12 +35,12 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/board.h>
 #include <mach/cpu.h>
 #include <mach/at91_aic.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
 
+#include "board.h"
 #include "generic.h"
 
 
diff --git a/arch/arm/mach-at91/board-neocore926.c b/arch/arm/mach-at91/board-neocore926.c
index 6960778..935d11c 100644
--- a/arch/arm/mach-at91/board-neocore926.c
+++ b/arch/arm/mach-at91/board-neocore926.c
@@ -44,10 +44,10 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 
+#include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-pcontrol-g20.c b/arch/arm/mach-at91/board-pcontrol-g20.c
index 9ca3e32..e1e0766 100644
--- a/arch/arm/mach-at91/board-pcontrol-g20.c
+++ b/arch/arm/mach-at91/board-pcontrol-g20.c
@@ -29,11 +29,11 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/stamp9g20.h>
 
+#include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-picotux200.c b/arch/arm/mach-at91/board-picotux200.c
index f83e1de..a4a1d0f 100644
--- a/arch/arm/mach-at91/board-picotux200.c
+++ b/arch/arm/mach-at91/board-picotux200.c
@@ -37,11 +37,11 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
 
+#include "board.h"
 #include "generic.h"
 
 
diff --git a/arch/arm/mach-at91/board-qil-a9260.c b/arch/arm/mach-at91/board-qil-a9260.c
index 799f214..a816fb3 100644
--- a/arch/arm/mach-at91/board-qil-a9260.c
+++ b/arch/arm/mach-at91/board-qil-a9260.c
@@ -40,11 +40,11 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
 
+#include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-rm9200dk.c b/arch/arm/mach-at91/board-rm9200dk.c
index 66338e7..a91b03c 100644
--- a/arch/arm/mach-at91/board-rm9200dk.c
+++ b/arch/arm/mach-at91/board-rm9200dk.c
@@ -39,11 +39,11 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
 
+#include "board.h"
 #include "generic.h"
 
 
diff --git a/arch/arm/mach-at91/board-rm9200ek.c b/arch/arm/mach-at91/board-rm9200ek.c
index 5d1b572..7b0be62 100644
--- a/arch/arm/mach-at91/board-rm9200ek.c
+++ b/arch/arm/mach-at91/board-rm9200ek.c
@@ -39,11 +39,11 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
 
+#include "board.h"
 #include "generic.h"
 
 
diff --git a/arch/arm/mach-at91/board-rsi-ews.c b/arch/arm/mach-at91/board-rsi-ews.c
index a0ecf04..bc5d88a 100644
--- a/arch/arm/mach-at91/board-rsi-ews.c
+++ b/arch/arm/mach-at91/board-rsi-ews.c
@@ -25,11 +25,11 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 
 #include <linux/gpio.h>
 
+#include "board.h"
 #include "generic.h"
 
 static void __init rsi_ews_init_early(void)
diff --git a/arch/arm/mach-at91/board-sam9-l9260.c b/arch/arm/mach-at91/board-sam9-l9260.c
index c5f01ac..caea7e2 100644
--- a/arch/arm/mach-at91/board-sam9-l9260.c
+++ b/arch/arm/mach-at91/board-sam9-l9260.c
@@ -37,10 +37,10 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 
+#include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
index 8cd6e67..ac2c949 100644
--- a/arch/arm/mach-at91/board-sam9260ek.c
+++ b/arch/arm/mach-at91/board-sam9260ek.c
@@ -41,12 +41,12 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
 #include <mach/system_rev.h>
 
+#include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index a9167dd..06251bb 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -45,12 +45,12 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
 #include <mach/system_rev.h>
 
+#include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index b87dbe2..533c23a 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -44,12 +44,12 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
 #include <mach/system_rev.h>
 
+#include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index 3ab2b86..4c6f6e9 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -43,11 +43,11 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/system_rev.h>
 
+#include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index 3d48ec1..364a4bf 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -42,12 +42,12 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
 #include <mach/system_rev.h>
 
+#include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
index fb89ea9..5693caf 100644
--- a/arch/arm/mach-at91/board-sam9rlek.c
+++ b/arch/arm/mach-at91/board-sam9rlek.c
@@ -30,11 +30,11 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
 
+#include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-snapper9260.c b/arch/arm/mach-at91/board-snapper9260.c
index a4e031a..b79b56e 100644
--- a/arch/arm/mach-at91/board-snapper9260.c
+++ b/arch/arm/mach-at91/board-snapper9260.c
@@ -32,10 +32,10 @@
 #include <asm/mach/arch.h>
 
 #include <mach/hardware.h>
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 
+#include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-stamp9g20.c b/arch/arm/mach-at91/board-stamp9g20.c
index c3fb31d..5756462 100644
--- a/arch/arm/mach-at91/board-stamp9g20.c
+++ b/arch/arm/mach-at91/board-stamp9g20.c
@@ -25,10 +25,10 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 
+#include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-usb-a926x.c b/arch/arm/mach-at91/board-usb-a926x.c
index 6ea069b..013dfb6 100644
--- a/arch/arm/mach-at91/board-usb-a926x.c
+++ b/arch/arm/mach-at91/board-usb-a926x.c
@@ -41,11 +41,11 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
 
+#include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-yl-9200.c b/arch/arm/mach-at91/board-yl-9200.c
index f162fdf..5d3a40f 100644
--- a/arch/arm/mach-at91/board-yl-9200.c
+++ b/arch/arm/mach-at91/board-yl-9200.c
@@ -43,12 +43,12 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
 #include <mach/cpu.h>
 
+#include "board.h"
 #include "generic.h"
 
 
diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/board.h
similarity index 100%
rename from arch/arm/mach-at91/include/mach/board.h
rename to arch/arm/mach-at91/board.h
diff --git a/arch/arm/mach-at91/leds.c b/arch/arm/mach-at91/leds.c
index 1b1e62b..3e22978 100644
--- a/arch/arm/mach-at91/leds.c
+++ b/arch/arm/mach-at91/leds.c
@@ -15,7 +15,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 
-#include <mach/board.h>
+#include "board.h"
 
 
 /* ------------------------------------------------------------------------- */
-- 
1.7.10.4
