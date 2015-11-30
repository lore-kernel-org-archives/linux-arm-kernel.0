From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Nov 2015 15:53:01 +0100
Subject: [PATCH] ARM: pxa: make more mach/*.h files local
Message-ID: <1905725.SU2iekYqHg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lots of header files are never included outside of a mach-pxa
directory and do not need to be made visible in include/mach,
so let's just move them all down one level.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I've been carrying patches like this one in my multiplatform series
for a while, the PXA one is the largest.

I'd like to merge that for 4.5, any objections?

Do you want to take it into a PXA branch to avoid conflicts, or should
I put it into arm-soc directly?

 Documentation/arm/pxa/mfp.txt                      | 26 +++++++++++-----------
 arch/arm/mach-pxa/am200epd.c                       |  4 ++--
 arch/arm/mach-pxa/am300epd.c                       |  4 ++--
 arch/arm/mach-pxa/balloon3.c                       |  6 ++---
 arch/arm/mach-pxa/capc7117.c                       |  4 ++--
 arch/arm/mach-pxa/cm-x255.c                        |  2 +-
 arch/arm/mach-pxa/cm-x270.c                        |  2 +-
 arch/arm/mach-pxa/cm-x2xx.c                        |  4 ++--
 arch/arm/mach-pxa/cm-x300.c                        |  4 ++--
 arch/arm/mach-pxa/colibri-evalboard.c              |  6 ++---
 arch/arm/mach-pxa/colibri-pxa270-income.c          |  4 ++--
 arch/arm/mach-pxa/colibri-pxa270.c                 |  4 ++--
 arch/arm/mach-pxa/colibri-pxa300.c                 |  4 ++--
 arch/arm/mach-pxa/colibri-pxa320.c                 |  8 +++----
 arch/arm/mach-pxa/colibri-pxa3xx.c                 |  4 ++--
 arch/arm/mach-pxa/{include/mach => }/colibri.h     |  0
 arch/arm/mach-pxa/corgi.c                          |  6 ++---
 arch/arm/mach-pxa/corgi_pm.c                       |  2 +-
 arch/arm/mach-pxa/csb726.c                         |  4 ++--
 arch/arm/mach-pxa/{include/mach => }/csb726.h      |  2 +-
 arch/arm/mach-pxa/devices.c                        |  2 +-
 arch/arm/mach-pxa/em-x270.c                        |  4 ++--
 arch/arm/mach-pxa/{include/mach => }/eseries-irq.h |  0
 arch/arm/mach-pxa/eseries.c                        |  6 ++---
 arch/arm/mach-pxa/ezx.c                            |  2 +-
 arch/arm/mach-pxa/gumstix.c                        |  6 ++---
 arch/arm/mach-pxa/{include/mach => }/gumstix.h     |  2 +-
 arch/arm/mach-pxa/h5000.c                          |  6 ++---
 arch/arm/mach-pxa/{include/mach => }/h5000.h       |  2 +-
 arch/arm/mach-pxa/himalaya.c                       |  2 +-
 arch/arm/mach-pxa/hx4700.c                         |  2 +-
 arch/arm/mach-pxa/icontrol.c                       |  4 ++--
 arch/arm/mach-pxa/idp.c                            |  4 ++--
 arch/arm/mach-pxa/{include/mach => }/idp.h         |  2 +-
 arch/arm/mach-pxa/littleton.c                      |  4 ++--
 arch/arm/mach-pxa/{include/mach => }/littleton.h   |  0
 arch/arm/mach-pxa/lpd270.c                         |  4 ++--
 arch/arm/mach-pxa/{include/mach => }/lpd270.h      |  0
 arch/arm/mach-pxa/lubbock.c                        |  6 ++---
 arch/arm/mach-pxa/magician.c                       |  6 ++---
 arch/arm/mach-pxa/mainstone.c                      |  2 +-
 arch/arm/mach-pxa/{include/mach => }/mfp-pxa25x.h  |  2 +-
 arch/arm/mach-pxa/{include/mach => }/mfp-pxa27x.h  |  2 +-
 arch/arm/mach-pxa/mfp-pxa2xx.c                     |  2 +-
 arch/arm/mach-pxa/{include/mach => }/mfp-pxa2xx.h  |  0
 arch/arm/mach-pxa/{include/mach => }/mfp-pxa300.h  |  2 +-
 arch/arm/mach-pxa/{include/mach => }/mfp-pxa320.h  |  2 +-
 arch/arm/mach-pxa/mfp-pxa3xx.c                     |  2 +-
 arch/arm/mach-pxa/{include/mach => }/mfp-pxa3xx.h  |  0
 arch/arm/mach-pxa/{include/mach => }/mfp-pxa930.h  |  2 +-
 arch/arm/mach-pxa/mioa701.c                        | 10 ++++-----
 arch/arm/mach-pxa/{include/mach => }/mioa701.h     |  0
 arch/arm/mach-pxa/mp900.c                          |  2 +-
 arch/arm/mach-pxa/mxm8x10.c                        |  4 ++--
 arch/arm/mach-pxa/{include/mach => }/mxm8x10.h     |  0
 arch/arm/mach-pxa/palm27x.c                        |  6 ++---
 arch/arm/mach-pxa/{include/mach => }/palm27x.h     |  0
 arch/arm/mach-pxa/palmld.c                         |  4 ++--
 arch/arm/mach-pxa/palmt5.c                         |  8 +++----
 arch/arm/mach-pxa/{include/mach => }/palmt5.h      |  2 +-
 arch/arm/mach-pxa/palmtc.c                         |  4 ++--
 arch/arm/mach-pxa/palmte2.c                        |  6 ++---
 arch/arm/mach-pxa/{include/mach => }/palmte2.h     |  0
 arch/arm/mach-pxa/palmtreo.c                       | 10 ++++-----
 arch/arm/mach-pxa/{include/mach => }/palmtreo.h    |  0
 arch/arm/mach-pxa/palmtx.c                         |  6 ++---
 arch/arm/mach-pxa/palmz72.c                        | 10 ++++-----
 arch/arm/mach-pxa/{include/mach => }/palmz72.h     |  0
 arch/arm/mach-pxa/pcm027.c                         |  4 ++--
 arch/arm/mach-pxa/{include/mach => }/pcm027.h      |  2 +-
 arch/arm/mach-pxa/pcm990-baseboard.c               |  4 ++--
 .../mach-pxa/{include/mach => }/pcm990_baseboard.h |  4 ++--
 arch/arm/mach-pxa/pm.c                             |  2 +-
 arch/arm/mach-pxa/{include/mach => }/pm.h          |  0
 arch/arm/mach-pxa/poodle.c                         |  4 ++--
 arch/arm/mach-pxa/pxa25x.c                         |  4 ++--
 arch/arm/mach-pxa/{include/mach => }/pxa25x.h      |  2 +-
 arch/arm/mach-pxa/{include/mach => }/pxa27x-udc.h  |  0
 arch/arm/mach-pxa/pxa27x.c                         |  4 ++--
 arch/arm/mach-pxa/{include/mach => }/pxa27x.h      |  2 +-
 arch/arm/mach-pxa/pxa2xx.c                         |  2 +-
 arch/arm/mach-pxa/pxa300.c                         |  2 +-
 arch/arm/mach-pxa/{include/mach => }/pxa300.h      |  4 ++--
 arch/arm/mach-pxa/pxa320.c                         |  2 +-
 arch/arm/mach-pxa/{include/mach => }/pxa320.h      |  4 ++--
 arch/arm/mach-pxa/pxa3xx-ulpi.c                    |  2 +-
 arch/arm/mach-pxa/pxa3xx.c                         |  2 +-
 arch/arm/mach-pxa/{include/mach => }/pxa3xx.h      |  0
 arch/arm/mach-pxa/pxa930.c                         |  2 +-
 arch/arm/mach-pxa/{include/mach => }/pxa930.h      |  4 ++--
 arch/arm/mach-pxa/raumfeld.c                       |  2 +-
 arch/arm/mach-pxa/{include/mach => }/regs-rtc.h    |  0
 arch/arm/mach-pxa/{include/mach => }/regs-u2d.h    |  0
 arch/arm/mach-pxa/saar.c                           |  2 +-
 arch/arm/mach-pxa/sharpsl_pm.c                     |  6 ++---
 arch/arm/mach-pxa/{include/mach => }/sharpsl_pm.h  |  0
 arch/arm/mach-pxa/spitz.c                          |  6 ++---
 arch/arm/mach-pxa/spitz_pm.c                       |  4 ++--
 arch/arm/mach-pxa/stargate2.c                      |  6 ++---
 arch/arm/mach-pxa/tavorevb.c                       |  2 +-
 arch/arm/mach-pxa/tosa-bt.c                        |  2 +-
 arch/arm/mach-pxa/tosa.c                           |  6 ++---
 arch/arm/mach-pxa/{include/mach => }/tosa_bt.h     |  0
 arch/arm/mach-pxa/trizeps4.c                       |  2 +-
 arch/arm/mach-pxa/{include/mach => }/udc.h         |  0
 arch/arm/mach-pxa/viper.c                          |  4 ++--
 arch/arm/mach-pxa/{include/mach => }/viper.h       |  0
 arch/arm/mach-pxa/vpac270.c                        |  6 ++---
 arch/arm/mach-pxa/xcep.c                           |  2 +-
 arch/arm/mach-pxa/z2.c                             |  6 ++---
 arch/arm/mach-pxa/zeus.c                           | 10 ++++-----
 arch/arm/mach-pxa/{include/mach => }/zeus.h        |  0
 arch/arm/mach-pxa/zylonite.c                       |  4 ++--
 arch/arm/mach-pxa/{include/mach => }/zylonite.h    |  0
 arch/arm/mach-pxa/zylonite_pxa300.c                |  4 ++--
 arch/arm/mach-pxa/zylonite_pxa320.c                |  4 ++--
 drivers/clk/pxa/clk-pxa25x.c                       |  1 -
 117 files changed, 193 insertions(+), 194 deletions(-)



diff --git a/Documentation/arm/pxa/mfp.txt b/Documentation/arm/pxa/mfp.txt
index a179e5bc02c9..0b7cab978c02 100644
--- a/Documentation/arm/pxa/mfp.txt
+++ b/Documentation/arm/pxa/mfp.txt
@@ -49,7 +49,7 @@ to this new MFP mechanism, here are several key points:
      internal controllers like PWM, SSP and UART, with 128 internal signals
      which can be routed to external through one or more MFPs (e.g. GPIO<0>
      can be routed through either MFP_PIN_GPIO0 as well as MFP_PIN_GPIO0_2,
-     see arch/arm/mach-pxa/mach/include/mfp-pxa300.h)
+     see arch/arm/mach-pxa/mfp-pxa300.h)
 
   2. Alternate function configuration is removed from this GPIO controller,
      the remaining functions are pure GPIO-specific, i.e.
@@ -76,11 +76,11 @@ For board code writers, here are some guidelines:
 
 1. include ONE of the following header files in your <board>.c:
 
-   - #include <mach/mfp-pxa25x.h>
-   - #include <mach/mfp-pxa27x.h>
-   - #include <mach/mfp-pxa300.h>
-   - #include <mach/mfp-pxa320.h>
-   - #include <mach/mfp-pxa930.h>
+   - #include "mfp-pxa25x.h"
+   - #include "mfp-pxa27x.h"
+   - #include "mfp-pxa300.h"
+   - #include "mfp-pxa320.h"
+   - #include "mfp-pxa930.h"
 
    NOTE: only one file in your <board>.c, depending on the processors used,
    because pin configuration definitions may conflict in these file (i.e.
@@ -203,20 +203,20 @@ make them effective there-after.
     1. Unified pin definitions - enum constants for all configurable pins
     2. processor-neutral bit definitions for a possible MFP configuration
 
-  - arch/arm/mach-pxa/include/mach/mfp-pxa3xx.h
+  - arch/arm/mach-pxa/mfp-pxa3xx.h
 
   for PXA3xx specific MFPR register bit definitions and PXA3xx common pin
   configurations
 
-  - arch/arm/mach-pxa/include/mach/mfp-pxa2xx.h
+  - arch/arm/mach-pxa/mfp-pxa2xx.h
 
   for PXA2xx specific definitions and PXA25x/PXA27x common pin configurations
 
-  - arch/arm/mach-pxa/include/mach/mfp-pxa25x.h
-    arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
-    arch/arm/mach-pxa/include/mach/mfp-pxa300.h
-    arch/arm/mach-pxa/include/mach/mfp-pxa320.h
-    arch/arm/mach-pxa/include/mach/mfp-pxa930.h
+  - arch/arm/mach-pxa/mfp-pxa25x.h
+    arch/arm/mach-pxa/mfp-pxa27x.h
+    arch/arm/mach-pxa/mfp-pxa300.h
+    arch/arm/mach-pxa/mfp-pxa320.h
+    arch/arm/mach-pxa/mfp-pxa930.h
 
   for processor specific definitions
 
diff --git a/arch/arm/mach-pxa/am200epd.c b/arch/arm/mach-pxa/am200epd.c
index 12fb0f4ae359..50e18ed37fa6 100644
--- a/arch/arm/mach-pxa/am200epd.c
+++ b/arch/arm/mach-pxa/am200epd.c
@@ -30,8 +30,8 @@
 #include <linux/irq.h>
 #include <linux/gpio.h>
 
-#include <mach/pxa25x.h>
-#include <mach/gumstix.h>
+#include "pxa25x.h"
+#include "gumstix.h"
 #include <linux/platform_data/video-pxafb.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/am300epd.c b/arch/arm/mach-pxa/am300epd.c
index 8b90c4f2d430..17d08abeeb17 100644
--- a/arch/arm/mach-pxa/am300epd.c
+++ b/arch/arm/mach-pxa/am300epd.c
@@ -28,8 +28,8 @@
 #include <linux/irq.h>
 #include <linux/gpio.h>
 
-#include <mach/gumstix.h>
-#include <mach/mfp-pxa25x.h>
+#include "gumstix.h"
+#include "mfp-pxa25x.h"
 #include <mach/irqs.h>
 #include <linux/platform_data/video-pxafb.h>
 
diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index a727282bfa99..782a0a883c01 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -42,13 +42,13 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/flash.h>
 
-#include <mach/pxa27x.h>
+#include "pxa27x.h"
 #include <mach/balloon3.h>
 #include <mach/audio.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/mmc-pxamci.h>
-#include <mach/udc.h>
-#include <mach/pxa27x-udc.h>
+#include "udc.h"
+#include "pxa27x-udc.h"
 #include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 
diff --git a/arch/arm/mach-pxa/capc7117.c b/arch/arm/mach-pxa/capc7117.c
index bf366b39fa61..1c3cbfca9f40 100644
--- a/arch/arm/mach-pxa/capc7117.c
+++ b/arch/arm/mach-pxa/capc7117.c
@@ -29,8 +29,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/pxa320.h>
-#include <mach/mxm8x10.h>
+#include "pxa320.h"
+#include "mxm8x10.h"
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-pxa/cm-x255.c b/arch/arm/mach-pxa/cm-x255.c
index be751470d37b..b592f79a1742 100644
--- a/arch/arm/mach-pxa/cm-x255.c
+++ b/arch/arm/mach-pxa/cm-x255.c
@@ -22,7 +22,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 
-#include <mach/pxa25x.h>
+#include "pxa25x.h"
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-pxa/cm-x270.c b/arch/arm/mach-pxa/cm-x270.c
index 2503db9e3253..fa5f51d633a3 100644
--- a/arch/arm/mach-pxa/cm-x270.c
+++ b/arch/arm/mach-pxa/cm-x270.c
@@ -21,7 +21,7 @@
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/spi/libertas_spi.h>
 
-#include <mach/pxa27x.h>
+#include "pxa27x.h"
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <linux/platform_data/mmc-pxamci.h>
 
diff --git a/arch/arm/mach-pxa/cm-x2xx.c b/arch/arm/mach-pxa/cm-x2xx.c
index a17a91eb8e9a..f2d801160079 100644
--- a/arch/arm/mach-pxa/cm-x2xx.c
+++ b/arch/arm/mach-pxa/cm-x2xx.c
@@ -22,9 +22,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 
-#include <mach/pxa25x.h>
+#include "pxa25x.h"
 #undef GPIO24_SSP1_SFRM
-#include <mach/pxa27x.h>
+#include "pxa27x.h"
 #include <mach/audio.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <mach/smemc.h>
diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index a7dae60810e8..5f5ac7c8faf0 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -47,8 +47,8 @@
 #include <asm/setup.h>
 #include <asm/system_info.h>
 
-#include <mach/pxa300.h>
-#include <mach/pxa27x-udc.h>
+#include "pxa300.h"
+#include "pxa27x-udc.h"
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
diff --git a/arch/arm/mach-pxa/colibri-evalboard.c b/arch/arm/mach-pxa/colibri-evalboard.c
index 638b0bb88426..dc44fbbe5073 100644
--- a/arch/arm/mach-pxa/colibri-evalboard.c
+++ b/arch/arm/mach-pxa/colibri-evalboard.c
@@ -22,11 +22,11 @@
 #include <linux/i2c/pxa-i2c.h>
 #include <asm/io.h>
 
-#include <mach/pxa27x.h>
-#include <mach/colibri.h>
+#include "pxa27x.h"
+#include "colibri.h"
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
-#include <mach/pxa27x-udc.h>
+#include "pxa27x-udc.h"
 
 #include "generic.h"
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/colibri-pxa270-income.c b/arch/arm/mach-pxa/colibri-pxa270-income.c
index db20d25daaab..8cff770e6a00 100644
--- a/arch/arm/mach-pxa/colibri-pxa270-income.c
+++ b/arch/arm/mach-pxa/colibri-pxa270-income.c
@@ -30,8 +30,8 @@
 #include <mach/hardware.h>
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
-#include <mach/pxa27x.h>
-#include <mach/pxa27x-udc.h>
+#include "pxa27x.h"
+#include "pxa27x-udc.h"
 #include <linux/platform_data/video-pxafb.h>
 
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/colibri-pxa270.c b/arch/arm/mach-pxa/colibri-pxa270.c
index 3503826333c7..e68acdd0cdbb 100644
--- a/arch/arm/mach-pxa/colibri-pxa270.c
+++ b/arch/arm/mach-pxa/colibri-pxa270.c
@@ -27,8 +27,8 @@
 #include <asm/sizes.h>
 
 #include <mach/audio.h>
-#include <mach/colibri.h>
-#include <mach/pxa27x.h>
+#include "colibri.h"
+#include "pxa27x.h"
 
 #include "devices.h"
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/colibri-pxa300.c b/arch/arm/mach-pxa/colibri-pxa300.c
index f1a1ac1fbd85..6a5558d95d4e 100644
--- a/arch/arm/mach-pxa/colibri-pxa300.c
+++ b/arch/arm/mach-pxa/colibri-pxa300.c
@@ -22,8 +22,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
 
-#include <mach/pxa300.h>
-#include <mach/colibri.h>
+#include "pxa300.h"
+#include "colibri.h"
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <mach/audio.h>
diff --git a/arch/arm/mach-pxa/colibri-pxa320.c b/arch/arm/mach-pxa/colibri-pxa320.c
index f6cc8b0ab82f..17067a3039a8 100644
--- a/arch/arm/mach-pxa/colibri-pxa320.c
+++ b/arch/arm/mach-pxa/colibri-pxa320.c
@@ -23,13 +23,13 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
 
-#include <mach/pxa320.h>
-#include <mach/colibri.h>
+#include "pxa320.h"
+#include "colibri.h"
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <mach/audio.h>
-#include <mach/pxa27x-udc.h>
-#include <mach/udc.h>
+#include "pxa27x-udc.h"
+#include "udc.h"
 
 #include "generic.h"
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/colibri-pxa3xx.c b/arch/arm/mach-pxa/colibri-pxa3xx.c
index 8240291ab8cf..b04431bb4ba7 100644
--- a/arch/arm/mach-pxa/colibri-pxa3xx.c
+++ b/arch/arm/mach-pxa/colibri-pxa3xx.c
@@ -22,8 +22,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
 #include <mach/pxa3xx-regs.h>
-#include <mach/mfp-pxa300.h>
-#include <mach/colibri.h>
+#include "mfp-pxa300.h"
+#include "colibri.h"
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/mtd-nand-pxa3xx.h>
diff --git a/arch/arm/mach-pxa/include/mach/colibri.h b/arch/arm/mach-pxa/colibri.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/colibri.h
rename to arch/arm/mach-pxa/colibri.h
diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 89f790dda93e..dc109dc3a622 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -48,12 +48,12 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/pxa25x.h>
+#include "pxa25x.h"
 #include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/mmc-pxamci.h>
-#include <mach/udc.h>
+#include "udc.h"
 #include <mach/corgi.h>
-#include <mach/sharpsl_pm.h>
+#include "sharpsl_pm.h"
 
 #include <asm/mach/sharpsl_param.h>
 #include <asm/hardware/scoop.h>
diff --git a/arch/arm/mach-pxa/corgi_pm.c b/arch/arm/mach-pxa/corgi_pm.c
index 7a39efc50865..d9206811be9b 100644
--- a/arch/arm/mach-pxa/corgi_pm.c
+++ b/arch/arm/mach-pxa/corgi_pm.c
@@ -27,7 +27,7 @@
 
 #include <mach/corgi.h>
 #include <mach/pxa2xx-regs.h>
-#include <mach/sharpsl_pm.h>
+#include "sharpsl_pm.h"
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-pxa/csb726.c b/arch/arm/mach-pxa/csb726.c
index fadfff8feaef..bf19b8426d2c 100644
--- a/arch/arm/mach-pxa/csb726.c
+++ b/arch/arm/mach-pxa/csb726.c
@@ -21,8 +21,8 @@
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <mach/csb726.h>
-#include <mach/pxa27x.h>
+#include "csb726.h"
+#include "pxa27x.h"
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <mach/audio.h>
diff --git a/arch/arm/mach-pxa/include/mach/csb726.h b/arch/arm/mach-pxa/csb726.h
similarity index 93%
rename from arch/arm/mach-pxa/include/mach/csb726.h
rename to arch/arm/mach-pxa/csb726.h
index 00cfbbbf73f7..f1f2a78cfd16 100644
--- a/arch/arm/mach-pxa/include/mach/csb726.h
+++ b/arch/arm/mach-pxa/csb726.h
@@ -11,7 +11,7 @@
 #ifndef CSB726_H
 #define CSB726_H
 
-#include "irqs.h" /* PXA_GPIO_TO_IRQ */
+#include <mach/irqs.h> /* PXA_GPIO_TO_IRQ */
 
 #define CSB726_GPIO_IRQ_LAN	52
 #define CSB726_GPIO_IRQ_SM501	53
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index d1211a40f400..37d8d85662f0 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -6,7 +6,7 @@
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/i2c/pxa-i2c.h>
 
-#include <mach/udc.h>
+#include "udc.h"
 #include <linux/platform_data/usb-pxa3xx-ulpi.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/mmc-pxamci.h>
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index 8b1f89e096c6..45a6110d9ce7 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -39,8 +39,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/pxa27x.h>
-#include <mach/pxa27x-udc.h>
+#include "pxa27x.h"
+#include "pxa27x-udc.h"
 #include <mach/audio.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
diff --git a/arch/arm/mach-pxa/include/mach/eseries-irq.h b/arch/arm/mach-pxa/eseries-irq.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/eseries-irq.h
rename to arch/arm/mach-pxa/eseries-irq.h
diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index 16dc95f68125..0b00b226f54b 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -31,12 +31,12 @@
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
-#include <mach/pxa25x.h>
+#include "pxa25x.h"
 #include <mach/eseries-gpio.h>
-#include <mach/eseries-irq.h>
+#include "eseries-irq.h"
 #include <mach/audio.h>
 #include <linux/platform_data/video-pxafb.h>
-#include <mach/udc.h>
+#include "udc.h"
 #include <linux/platform_data/irda-pxaficp.h>
 
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index 12af6e2d597c..b61b7971b54f 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -29,7 +29,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/pxa27x.h>
+#include "pxa27x.h"
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
index f6c76a3ee3b2..6815a9357774 100644
--- a/arch/arm/mach-pxa/gumstix.c
+++ b/arch/arm/mach-pxa/gumstix.c
@@ -40,10 +40,10 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/flash.h>
 
-#include <mach/pxa25x.h>
+#include "pxa25x.h"
 #include <linux/platform_data/mmc-pxamci.h>
-#include <mach/udc.h>
-#include <mach/gumstix.h>
+#include "udc.h"
+#include "gumstix.h"
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-pxa/include/mach/gumstix.h b/arch/arm/mach-pxa/gumstix.h
similarity index 98%
rename from arch/arm/mach-pxa/include/mach/gumstix.h
rename to arch/arm/mach-pxa/gumstix.h
index f7df27bbb42e..825f2d1260ae 100644
--- a/arch/arm/mach-pxa/include/mach/gumstix.h
+++ b/arch/arm/mach-pxa/gumstix.h
@@ -6,7 +6,7 @@
  * published by the Free Software Foundation.
  */
 
-#include "irqs.h" /* PXA_GPIO_TO_IRQ */
+#include <mach/irqs.h> /* PXA_GPIO_TO_IRQ */
 
 /* BTRESET - Reset line to Bluetooth module, active low signal. */
 #define GPIO_GUMSTIX_BTRESET          7
diff --git a/arch/arm/mach-pxa/h5000.c b/arch/arm/mach-pxa/h5000.c
index 875ec3351499..be2a9c3fd55b 100644
--- a/arch/arm/mach-pxa/h5000.c
+++ b/arch/arm/mach-pxa/h5000.c
@@ -30,9 +30,9 @@
 #include <asm/mach/map.h>
 #include <asm/irq.h>
 
-#include <mach/pxa25x.h>
-#include <mach/h5000.h>
-#include <mach/udc.h>
+#include "pxa25x.h"
+#include "h5000.h"
+#include "udc.h"
 #include <mach/smemc.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/include/mach/h5000.h b/arch/arm/mach-pxa/h5000.h
similarity index 99%
rename from arch/arm/mach-pxa/include/mach/h5000.h
rename to arch/arm/mach-pxa/h5000.h
index 2a5ae3802787..252461fd2ac8 100644
--- a/arch/arm/mach-pxa/include/mach/h5000.h
+++ b/arch/arm/mach-pxa/h5000.h
@@ -18,7 +18,7 @@
 #ifndef __ASM_ARCH_H5000_H
 #define __ASM_ARCH_H5000_H
 
-#include <mach/mfp-pxa25x.h>
+#include "mfp-pxa25x.h"
 
 /*
  * CPU GPIOs
diff --git a/arch/arm/mach-pxa/himalaya.c b/arch/arm/mach-pxa/himalaya.c
index 7a8d749a07b8..70e9c06595f6 100644
--- a/arch/arm/mach-pxa/himalaya.c
+++ b/arch/arm/mach-pxa/himalaya.c
@@ -24,7 +24,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/pxa25x.h>
+#include "pxa25x.h"
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index b076a835eb21..4a2f9aba93ea 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -44,7 +44,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/pxa27x.h>
+#include "pxa27x.h"
 #include <mach/hx4700.h>
 #include <linux/platform_data/irda-pxaficp.h>
 
diff --git a/arch/arm/mach-pxa/icontrol.c b/arch/arm/mach-pxa/icontrol.c
index a1869f9b6219..cbaf4f6edcda 100644
--- a/arch/arm/mach-pxa/icontrol.c
+++ b/arch/arm/mach-pxa/icontrol.c
@@ -20,8 +20,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/pxa320.h>
-#include <mach/mxm8x10.h>
+#include "pxa320.h"
+#include "mxm8x10.h"
 
 #include <linux/spi/spi.h>
 #include <linux/spi/pxa2xx_spi.h>
diff --git a/arch/arm/mach-pxa/idp.c b/arch/arm/mach-pxa/idp.c
index f6d02e4cbcda..c410d84b243d 100644
--- a/arch/arm/mach-pxa/idp.c
+++ b/arch/arm/mach-pxa/idp.c
@@ -31,8 +31,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/pxa25x.h>
-#include <mach/idp.h>
+#include "pxa25x.h"
+#include "idp.h"
 #include <linux/platform_data/video-pxafb.h>
 #include <mach/bitfield.h>
 #include <linux/platform_data/mmc-pxamci.h>
diff --git a/arch/arm/mach-pxa/include/mach/idp.h b/arch/arm/mach-pxa/idp.h
similarity index 99%
rename from arch/arm/mach-pxa/include/mach/idp.h
rename to arch/arm/mach-pxa/idp.h
index 7e63f4680271..7182ff92b732 100644
--- a/arch/arm/mach-pxa/include/mach/idp.h
+++ b/arch/arm/mach-pxa/idp.h
@@ -23,7 +23,7 @@
  * IDP hardware.
  */
 
-#include "irqs.h" /* PXA_GPIO_TO_IRQ */
+#include <mach/irqs.h> /* PXA_GPIO_TO_IRQ */
 
 #define IDP_FLASH_PHYS		(PXA_CS0_PHYS)
 #define IDP_ALT_FLASH_PHYS	(PXA_CS1_PHYS)
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index 5d665588c7eb..051c554776a6 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -41,11 +41,11 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/pxa300.h>
+#include "pxa300.h"
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/keypad-pxa27x.h>
-#include <mach/littleton.h>
+#include "littleton.h"
 #include <linux/platform_data/mtd-nand-pxa3xx.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/include/mach/littleton.h b/arch/arm/mach-pxa/littleton.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/littleton.h
rename to arch/arm/mach-pxa/littleton.h
diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index 5fcd4f094900..e9f401b0a432 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -40,8 +40,8 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/flash.h>
 
-#include <mach/pxa27x.h>
-#include <mach/lpd270.h>
+#include "pxa27x.h"
+#include "lpd270.h"
 #include <mach/audio.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/mmc-pxamci.h>
diff --git a/arch/arm/mach-pxa/include/mach/lpd270.h b/arch/arm/mach-pxa/lpd270.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/lpd270.h
rename to arch/arm/mach-pxa/lpd270.h
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index 6de32fa0e251..7245f3359564 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -47,14 +47,14 @@
 
 #include <asm/hardware/sa1111.h>
 
-#include <mach/pxa25x.h>
+#include "pxa25x.h"
 #include <mach/audio.h>
 #include <mach/lubbock.h>
-#include <mach/udc.h>
+#include "udc.h"
 #include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/mmc-pxamci.h>
-#include <mach/pm.h>
+#include "pm.h"
 #include <mach/smemc.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 896b268c3ab7..abc918169367 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -38,7 +38,7 @@
 #include <asm/mach/arch.h>
 #include <asm/system_info.h>
 
-#include <mach/pxa27x.h>
+#include "pxa27x.h"
 #include <mach/magician.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/mmc-pxamci.h>
@@ -48,9 +48,9 @@
 #include <linux/regulator/max1586.h>
 
 #include <linux/platform_data/pxa2xx_udc.h>
-#include <mach/udc.h>
-#include <mach/pxa27x-udc.h>
 
+#include "udc.h"
+#include "pxa27x-udc.h"
 #include "devices.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index c3a87c176d72..40964069a17c 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -46,7 +46,7 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/flash.h>
 
-#include <mach/pxa27x.h>
+#include "pxa27x.h"
 #include <mach/mainstone.h>
 #include <mach/audio.h>
 #include <linux/platform_data/video-pxafb.h>
diff --git a/arch/arm/mach-pxa/include/mach/mfp-pxa25x.h b/arch/arm/mach-pxa/mfp-pxa25x.h
similarity index 99%
rename from arch/arm/mach-pxa/include/mach/mfp-pxa25x.h
rename to arch/arm/mach-pxa/mfp-pxa25x.h
index cafadc33dfd8..1c59d4b3b19b 100644
--- a/arch/arm/mach-pxa/include/mach/mfp-pxa25x.h
+++ b/arch/arm/mach-pxa/mfp-pxa25x.h
@@ -1,7 +1,7 @@
 #ifndef __ASM_ARCH_MFP_PXA25X_H
 #define __ASM_ARCH_MFP_PXA25X_H
 
-#include <mach/mfp-pxa2xx.h>
+#include "mfp-pxa2xx.h"
 
 /* GPIO */
 #define GPIO2_GPIO		MFP_CFG_IN(GPIO2, AF0)
diff --git a/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h b/arch/arm/mach-pxa/mfp-pxa27x.h
similarity index 99%
rename from arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
rename to arch/arm/mach-pxa/mfp-pxa27x.h
index b6132aa95dc0..9fe5601ce668 100644
--- a/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
+++ b/arch/arm/mach-pxa/mfp-pxa27x.h
@@ -8,7 +8,7 @@
  * specific controller, and this should work in most cases.
  */
 
-#include <mach/mfp-pxa2xx.h>
+#include "mfp-pxa2xx.h"
 
 /* Note: GPIO3/GPIO4 will be driven by Power I2C when PCFR/PI2C_EN
  * bit is set, regardless of the GPIO configuration
diff --git a/arch/arm/mach-pxa/mfp-pxa2xx.c b/arch/arm/mach-pxa/mfp-pxa2xx.c
index 666b78972c40..3732aec76750 100644
--- a/arch/arm/mach-pxa/mfp-pxa2xx.c
+++ b/arch/arm/mach-pxa/mfp-pxa2xx.c
@@ -21,7 +21,7 @@
 #include <linux/syscore_ops.h>
 
 #include <mach/pxa2xx-regs.h>
-#include <mach/mfp-pxa2xx.h>
+#include "mfp-pxa2xx.h"
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-pxa/include/mach/mfp-pxa2xx.h b/arch/arm/mach-pxa/mfp-pxa2xx.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/mfp-pxa2xx.h
rename to arch/arm/mach-pxa/mfp-pxa2xx.h
diff --git a/arch/arm/mach-pxa/include/mach/mfp-pxa300.h b/arch/arm/mach-pxa/mfp-pxa300.h
similarity index 99%
rename from arch/arm/mach-pxa/include/mach/mfp-pxa300.h
rename to arch/arm/mach-pxa/mfp-pxa300.h
index 4e1287070d21..5ee51e28304d 100644
--- a/arch/arm/mach-pxa/include/mach/mfp-pxa300.h
+++ b/arch/arm/mach-pxa/mfp-pxa300.h
@@ -15,7 +15,7 @@
 #ifndef __ASM_ARCH_MFP_PXA300_H
 #define __ASM_ARCH_MFP_PXA300_H
 
-#include <mach/mfp-pxa3xx.h>
+#include "mfp-pxa3xx.h"
 
 /* GPIO */
 #define GPIO46_GPIO		MFP_CFG(GPIO46, AF1)
diff --git a/arch/arm/mach-pxa/include/mach/mfp-pxa320.h b/arch/arm/mach-pxa/mfp-pxa320.h
similarity index 99%
rename from arch/arm/mach-pxa/include/mach/mfp-pxa320.h
rename to arch/arm/mach-pxa/mfp-pxa320.h
index 3ce4682eabb6..e8797cfc72e0 100644
--- a/arch/arm/mach-pxa/include/mach/mfp-pxa320.h
+++ b/arch/arm/mach-pxa/mfp-pxa320.h
@@ -15,7 +15,7 @@
 #ifndef __ASM_ARCH_MFP_PXA320_H
 #define __ASM_ARCH_MFP_PXA320_H
 
-#include <mach/mfp-pxa3xx.h>
+#include "mfp-pxa3xx.h"
 
 /* GPIO */
 #define GPIO46_GPIO		MFP_CFG(GPIO46, AF0)
diff --git a/arch/arm/mach-pxa/mfp-pxa3xx.c b/arch/arm/mach-pxa/mfp-pxa3xx.c
index 89863a01ecd7..994edc0158d4 100644
--- a/arch/arm/mach-pxa/mfp-pxa3xx.c
+++ b/arch/arm/mach-pxa/mfp-pxa3xx.c
@@ -20,7 +20,7 @@
 #include <linux/syscore_ops.h>
 
 #include <mach/hardware.h>
-#include <mach/mfp-pxa3xx.h>
+#include "mfp-pxa3xx.h"
 #include <mach/pxa3xx-regs.h>
 
 #ifdef CONFIG_PM
diff --git a/arch/arm/mach-pxa/include/mach/mfp-pxa3xx.h b/arch/arm/mach-pxa/mfp-pxa3xx.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/mfp-pxa3xx.h
rename to arch/arm/mach-pxa/mfp-pxa3xx.h
diff --git a/arch/arm/mach-pxa/include/mach/mfp-pxa930.h b/arch/arm/mach-pxa/mfp-pxa930.h
similarity index 99%
rename from arch/arm/mach-pxa/include/mach/mfp-pxa930.h
rename to arch/arm/mach-pxa/mfp-pxa930.h
index 04f7c97044f3..113967beeb67 100644
--- a/arch/arm/mach-pxa/include/mach/mfp-pxa930.h
+++ b/arch/arm/mach-pxa/mfp-pxa930.h
@@ -13,7 +13,7 @@
 #ifndef __ASM_ARCH_MFP_PXA9xx_H
 #define __ASM_ARCH_MFP_PXA9xx_H
 
-#include <mach/mfp-pxa3xx.h>
+#include "mfp-pxa3xx.h"
 
 /* GPIO */
 #define GPIO46_GPIO		MFP_CFG(GPIO46, AF0)
diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index ccfd2b63c6a4..38a96a193dc4 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -47,19 +47,19 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/pxa27x.h>
-#include <mach/regs-rtc.h>
+#include "pxa27x.h"
+#include "regs-rtc.h"
 #include <linux/platform_data/keypad-pxa27x.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/mmc-pxamci.h>
-#include <mach/udc.h>
-#include <mach/pxa27x-udc.h>
+#include "udc.h"
+#include "pxa27x-udc.h"
 #include <linux/platform_data/media/camera-pxa.h>
 #include <mach/audio.h>
 #include <mach/smemc.h>
 #include <media/soc_camera.h>
 
-#include <mach/mioa701.h>
+#include "mioa701.h"
 
 #include "generic.h"
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/include/mach/mioa701.h b/arch/arm/mach-pxa/mioa701.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/mioa701.h
rename to arch/arm/mach-pxa/mioa701.h
diff --git a/arch/arm/mach-pxa/mp900.c b/arch/arm/mach-pxa/mp900.c
index 14f6aaf8fcc9..4d89029e5401 100644
--- a/arch/arm/mach-pxa/mp900.c
+++ b/arch/arm/mach-pxa/mp900.c
@@ -22,7 +22,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/pxa25x.h>
+#include "pxa25x.h"
 #include "generic.h"
 
 static void isp116x_pfm_delay(struct device *dev, int delay)
diff --git a/arch/arm/mach-pxa/mxm8x10.c b/arch/arm/mach-pxa/mxm8x10.c
index d04ed4961e60..9a22ae0ad8c9 100644
--- a/arch/arm/mach-pxa/mxm8x10.c
+++ b/arch/arm/mach-pxa/mxm8x10.c
@@ -29,9 +29,9 @@
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
-#include <mach/pxa320.h>
+#include "pxa320.h"
 
-#include <mach/mxm8x10.h>
+#include "mxm8x10.h"
 
 #include "devices.h"
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/include/mach/mxm8x10.h b/arch/arm/mach-pxa/mxm8x10.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/mxm8x10.h
rename to arch/arm/mach-pxa/mxm8x10.h
diff --git a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
index 8fbfb10047ec..e5ae99db1de4 100644
--- a/arch/arm/mach-pxa/palm27x.c
+++ b/arch/arm/mach-pxa/palm27x.c
@@ -28,14 +28,14 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/pxa27x.h>
+#include "pxa27x.h"
 #include <mach/audio.h>
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/irda-pxaficp.h>
-#include <mach/udc.h>
+#include "udc.h"
 #include <linux/platform_data/asoc-palm27x.h>
-#include <mach/palm27x.h>
+#include "palm27x.h"
 
 #include "generic.h"
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/include/mach/palm27x.h b/arch/arm/mach-pxa/palm27x.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/palm27x.h
rename to arch/arm/mach-pxa/palm27x.h
diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
index cf210b11ffcc..980f2847f5b5 100644
--- a/arch/arm/mach-pxa/palmld.c
+++ b/arch/arm/mach-pxa/palmld.c
@@ -32,7 +32,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/pxa27x.h>
+#include "pxa27x.h"
 #include <mach/audio.h>
 #include <mach/palmld.h>
 #include <linux/platform_data/mmc-pxamci.h>
@@ -40,7 +40,7 @@
 #include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/keypad-pxa27x.h>
 #include <linux/platform_data/asoc-palm27x.h>
-#include <mach/palm27x.h>
+#include "palm27x.h"
 
 #include "generic.h"
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
index 3ed9b029428b..876144aa3564 100644
--- a/arch/arm/mach-pxa/palmt5.c
+++ b/arch/arm/mach-pxa/palmt5.c
@@ -33,16 +33,16 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/pxa27x.h>
+#include "pxa27x.h"
 #include <mach/audio.h>
-#include <mach/palmt5.h>
+#include "palmt5.h"
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/keypad-pxa27x.h>
-#include <mach/udc.h>
+#include "udc.h"
 #include <linux/platform_data/asoc-palm27x.h>
-#include <mach/palm27x.h>
+#include "palm27x.h"
 
 #include "generic.h"
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/include/mach/palmt5.h b/arch/arm/mach-pxa/palmt5.h
similarity index 98%
rename from arch/arm/mach-pxa/include/mach/palmt5.h
rename to arch/arm/mach-pxa/palmt5.h
index e342c5921405..f850cc9de1b4 100644
--- a/arch/arm/mach-pxa/include/mach/palmt5.h
+++ b/arch/arm/mach-pxa/palmt5.h
@@ -15,7 +15,7 @@
 #ifndef _INCLUDE_PALMT5_H_
 #define _INCLUDE_PALMT5_H_
 
-#include "irqs.h" /* PXA_GPIO_TO_IRQ */
+#include <mach/irqs.h> /* PXA_GPIO_TO_IRQ */
 
 /** HERE ARE GPIOs **/
 
diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
index 0b5c3876720c..18946594a7c8 100644
--- a/arch/arm/mach-pxa/palmtc.c
+++ b/arch/arm/mach-pxa/palmtc.c
@@ -32,13 +32,13 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/pxa25x.h>
+#include "pxa25x.h"
 #include <mach/audio.h>
 #include <mach/palmtc.h>
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/irda-pxaficp.h>
-#include <mach/udc.h>
+#include "udc.h"
 
 #include "generic.h"
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/palmte2.c b/arch/arm/mach-pxa/palmte2.c
index e64bb4326e69..36b46141a28b 100644
--- a/arch/arm/mach-pxa/palmte2.c
+++ b/arch/arm/mach-pxa/palmte2.c
@@ -32,13 +32,13 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/pxa25x.h>
+#include "pxa25x.h"
 #include <mach/audio.h>
-#include <mach/palmte2.h>
+#include "palmte2.h"
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/irda-pxaficp.h>
-#include <mach/udc.h>
+#include "udc.h"
 #include <linux/platform_data/asoc-palm27x.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/include/mach/palmte2.h b/arch/arm/mach-pxa/palmte2.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/palmte2.h
rename to arch/arm/mach-pxa/palmte2.h
diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
index 2dc56062fb7e..4cc05ecce618 100644
--- a/arch/arm/mach-pxa/palmtreo.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@ -31,20 +31,20 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/pxa27x.h>
-#include <mach/pxa27x-udc.h>
+#include "pxa27x.h"
+#include "pxa27x-udc.h"
 #include <mach/audio.h>
-#include <mach/palmtreo.h>
+#include "palmtreo.h"
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/keypad-pxa27x.h>
-#include <mach/udc.h>
+#include "udc.h"
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <mach/pxa2xx-regs.h>
 #include <linux/platform_data/asoc-palm27x.h>
 #include <linux/platform_data/media/camera-pxa.h>
-#include <mach/palm27x.h>
+#include "palm27x.h"
 
 #include <sound/pxa2xx-lib.h>
 
diff --git a/arch/arm/mach-pxa/include/mach/palmtreo.h b/arch/arm/mach-pxa/palmtreo.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/palmtreo.h
rename to arch/arm/mach-pxa/palmtreo.h
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index 83f830dd8ad8..b84b2eb24ccd 100644
--- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -37,16 +37,16 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/pxa27x.h>
+#include "pxa27x.h"
 #include <mach/audio.h>
 #include <mach/palmtx.h>
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/keypad-pxa27x.h>
-#include <mach/udc.h>
+#include "udc.h"
 #include <linux/platform_data/asoc-palm27x.h>
-#include <mach/palm27x.h>
+#include "palm27x.h"
 
 #include "generic.h"
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index e3df17a7e8d4..9c308de158c6 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -37,18 +37,18 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/pxa27x.h>
+#include "pxa27x.h"
 #include <mach/audio.h>
-#include <mach/palmz72.h>
+#include "palmz72.h"
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/keypad-pxa27x.h>
-#include <mach/udc.h>
+#include "udc.h"
 #include <linux/platform_data/asoc-palm27x.h>
-#include <mach/palm27x.h>
+#include "palm27x.h"
 
-#include <mach/pm.h>
+#include "pm.h"
 #include <linux/platform_data/media/camera-pxa.h>
 
 #include <media/soc_camera.h>
diff --git a/arch/arm/mach-pxa/include/mach/palmz72.h b/arch/arm/mach-pxa/palmz72.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/palmz72.h
rename to arch/arm/mach-pxa/palmz72.h
diff --git a/arch/arm/mach-pxa/pcm027.c b/arch/arm/mach-pxa/pcm027.c
index 69918c7e3f1f..ccca9f7575c3 100644
--- a/arch/arm/mach-pxa/pcm027.c
+++ b/arch/arm/mach-pxa/pcm027.c
@@ -30,8 +30,8 @@
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <mach/pxa27x.h>
-#include <mach/pcm027.h>
+#include "pxa27x.h"
+#include "pcm027.h"
 #include "generic.h"
 
 /*
diff --git a/arch/arm/mach-pxa/include/mach/pcm027.h b/arch/arm/mach-pxa/pcm027.h
similarity index 98%
rename from arch/arm/mach-pxa/include/mach/pcm027.h
rename to arch/arm/mach-pxa/pcm027.h
index 86ebd7b6c960..047cdf234f25 100644
--- a/arch/arm/mach-pxa/include/mach/pcm027.h
+++ b/arch/arm/mach-pxa/pcm027.h
@@ -23,7 +23,7 @@
  * Definitions of CPU card resources only
  */
 
-#include "irqs.h" /* PXA_GPIO_TO_IRQ */
+#include <mach/irqs.h> /* PXA_GPIO_TO_IRQ */
 
 /* phyCORE-PXA270 (PCM027) Interrupts */
 #define PCM027_IRQ(x)          (IRQ_BOARD_START + (x))
diff --git a/arch/arm/mach-pxa/pcm990-baseboard.c b/arch/arm/mach-pxa/pcm990-baseboard.c
index 8459239a093c..0bd5959ef7d5 100644
--- a/arch/arm/mach-pxa/pcm990-baseboard.c
+++ b/arch/arm/mach-pxa/pcm990-baseboard.c
@@ -32,11 +32,11 @@
 
 #include <linux/platform_data/media/camera-pxa.h>
 #include <asm/mach/map.h>
-#include <mach/pxa27x.h>
+#include "pxa27x.h"
 #include <mach/audio.h>
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
-#include <mach/pcm990_baseboard.h>
+#include "pcm990_baseboard.h"
 #include <linux/platform_data/video-pxafb.h>
 
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/include/mach/pcm990_baseboard.h b/arch/arm/mach-pxa/pcm990_baseboard.h
similarity index 99%
rename from arch/arm/mach-pxa/include/mach/pcm990_baseboard.h
rename to arch/arm/mach-pxa/pcm990_baseboard.h
index 7e544c14967e..79d35adfa786 100644
--- a/arch/arm/mach-pxa/include/mach/pcm990_baseboard.h
+++ b/arch/arm/mach-pxa/pcm990_baseboard.h
@@ -19,8 +19,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include <mach/pcm027.h>
-#include "irqs.h" /* PXA_GPIO_TO_IRQ */
+#include "pcm027.h"
+#include <mach/irqs.h> /* PXA_GPIO_TO_IRQ */
 
 /*
  * definitions relevant only when the PCM-990
diff --git a/arch/arm/mach-pxa/pm.c b/arch/arm/mach-pxa/pm.c
index 37178a8559b1..388463b99090 100644
--- a/arch/arm/mach-pxa/pm.c
+++ b/arch/arm/mach-pxa/pm.c
@@ -16,7 +16,7 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 
-#include <mach/pm.h>
+#include "pm.h"
 
 struct pxa_cpu_pm_fns *pxa_cpu_pm_fns;
 static unsigned long *sleep_save;
diff --git a/arch/arm/mach-pxa/include/mach/pm.h b/arch/arm/mach-pxa/pm.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/pm.h
rename to arch/arm/mach-pxa/pm.h
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 195b1121c8f1..62a119137be7 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -41,9 +41,9 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/pxa25x.h>
+#include "pxa25x.h"
 #include <linux/platform_data/mmc-pxamci.h>
-#include <mach/udc.h>
+#include "udc.h"
 #include <linux/platform_data/irda-pxaficp.h>
 #include <mach/poodle.h>
 #include <linux/platform_data/video-pxafb.h>
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 1dc85ffc3e20..a177bf45feef 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -30,9 +30,9 @@
 #include <asm/suspend.h>
 #include <mach/hardware.h>
 #include <mach/irqs.h>
-#include <mach/pxa25x.h>
+#include "pxa25x.h"
 #include <mach/reset.h>
-#include <mach/pm.h>
+#include "pm.h"
 #include <mach/dma.h>
 #include <mach/smemc.h>
 
diff --git a/arch/arm/mach-pxa/include/mach/pxa25x.h b/arch/arm/mach-pxa/pxa25x.h
similarity index 84%
rename from arch/arm/mach-pxa/include/mach/pxa25x.h
rename to arch/arm/mach-pxa/pxa25x.h
index 5a341752e32c..2011e8da0592 100644
--- a/arch/arm/mach-pxa/include/mach/pxa25x.h
+++ b/arch/arm/mach-pxa/pxa25x.h
@@ -3,7 +3,7 @@
 
 #include <mach/hardware.h>
 #include <mach/pxa2xx-regs.h>
-#include <mach/mfp-pxa25x.h>
+#include "mfp-pxa25x.h"
 #include <mach/irqs.h>
 
 #endif /* __MACH_PXA25x_H */
diff --git a/arch/arm/mach-pxa/include/mach/pxa27x-udc.h b/arch/arm/mach-pxa/pxa27x-udc.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/pxa27x-udc.h
rename to arch/arm/mach-pxa/pxa27x-udc.h
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index ffc424028557..8dfd1755c659 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -28,10 +28,10 @@
 #include <asm/irq.h>
 #include <asm/suspend.h>
 #include <mach/irqs.h>
-#include <mach/pxa27x.h>
+#include "pxa27x.h"
 #include <mach/reset.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
-#include <mach/pm.h>
+#include "pm.h"
 #include <mach/dma.h>
 #include <mach/smemc.h>
 
diff --git a/arch/arm/mach-pxa/include/mach/pxa27x.h b/arch/arm/mach-pxa/pxa27x.h
similarity index 97%
rename from arch/arm/mach-pxa/include/mach/pxa27x.h
rename to arch/arm/mach-pxa/pxa27x.h
index 1a4291936c58..075131d83eab 100644
--- a/arch/arm/mach-pxa/include/mach/pxa27x.h
+++ b/arch/arm/mach-pxa/pxa27x.h
@@ -4,7 +4,7 @@
 #include <linux/suspend.h>
 #include <mach/hardware.h>
 #include <mach/pxa2xx-regs.h>
-#include <mach/mfp-pxa27x.h>
+#include "mfp-pxa27x.h"
 #include <mach/irqs.h>
 
 #define ARB_CNTRL	__REG(0x48000048)  /* Arbiter Control Register */
diff --git a/arch/arm/mach-pxa/pxa2xx.c b/arch/arm/mach-pxa/pxa2xx.c
index 447dcbb22f6f..6b5e566f52c8 100644
--- a/arch/arm/mach-pxa/pxa2xx.c
+++ b/arch/arm/mach-pxa/pxa2xx.c
@@ -17,7 +17,7 @@
 
 #include <mach/hardware.h>
 #include <mach/pxa2xx-regs.h>
-#include <mach/mfp-pxa25x.h>
+#include "mfp-pxa25x.h"
 #include <mach/reset.h>
 #include <linux/platform_data/irda-pxaficp.h>
 
diff --git a/arch/arm/mach-pxa/pxa300.c b/arch/arm/mach-pxa/pxa300.c
index 28c5b5686638..df83b1bddf34 100644
--- a/arch/arm/mach-pxa/pxa300.c
+++ b/arch/arm/mach-pxa/pxa300.c
@@ -18,7 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
-#include <mach/pxa300.h>
+#include "pxa300.h"
 
 #include "generic.h"
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/include/mach/pxa300.h b/arch/arm/mach-pxa/pxa300.h
similarity index 59%
rename from arch/arm/mach-pxa/include/mach/pxa300.h
rename to arch/arm/mach-pxa/pxa300.h
index 733b6412c3df..59fa41025c80 100644
--- a/arch/arm/mach-pxa/include/mach/pxa300.h
+++ b/arch/arm/mach-pxa/pxa300.h
@@ -1,7 +1,7 @@
 #ifndef __MACH_PXA300_H
 #define __MACH_PXA300_H
 
-#include <mach/pxa3xx.h>
-#include <mach/mfp-pxa300.h>
+#include "pxa3xx.h"
+#include "mfp-pxa300.h"
 
 #endif /* __MACH_PXA300_H */
diff --git a/arch/arm/mach-pxa/pxa320.c b/arch/arm/mach-pxa/pxa320.c
index 2f55bb4b9087..a26eec57eec6 100644
--- a/arch/arm/mach-pxa/pxa320.c
+++ b/arch/arm/mach-pxa/pxa320.c
@@ -18,7 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
-#include <mach/pxa320.h>
+#include "pxa320.h"
 
 #include "generic.h"
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/include/mach/pxa320.h b/arch/arm/mach-pxa/pxa320.h
similarity index 59%
rename from arch/arm/mach-pxa/include/mach/pxa320.h
rename to arch/arm/mach-pxa/pxa320.h
index b6204e470d89..b9e5115a1c30 100644
--- a/arch/arm/mach-pxa/include/mach/pxa320.h
+++ b/arch/arm/mach-pxa/pxa320.h
@@ -1,8 +1,8 @@
 #ifndef __MACH_PXA320_H
 #define __MACH_PXA320_H
 
-#include <mach/pxa3xx.h>
-#include <mach/mfp-pxa320.h>
+#include "pxa3xx.h"
+#include "mfp-pxa320.h"
 
 #endif /* __MACH_PXA320_H */
 
diff --git a/arch/arm/mach-pxa/pxa3xx-ulpi.c b/arch/arm/mach-pxa/pxa3xx-ulpi.c
index 1c85275cb768..eba595fac8ca 100644
--- a/arch/arm/mach-pxa/pxa3xx-ulpi.c
+++ b/arch/arm/mach-pxa/pxa3xx-ulpi.c
@@ -26,7 +26,7 @@
 #include <linux/usb/otg.h>
 
 #include <mach/hardware.h>
-#include <mach/regs-u2d.h>
+#include "regs-u2d.h"
 #include <linux/platform_data/usb-pxa3xx-ulpi.h>
 
 struct pxa3xx_u2d_ulpi {
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 20ce2d386f17..a1c4c888f246 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -30,7 +30,7 @@
 #include <mach/pxa3xx-regs.h>
 #include <mach/reset.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
-#include <mach/pm.h>
+#include "pm.h"
 #include <mach/dma.h>
 #include <mach/smemc.h>
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-pxa/include/mach/pxa3xx.h b/arch/arm/mach-pxa/pxa3xx.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/pxa3xx.h
rename to arch/arm/mach-pxa/pxa3xx.h
diff --git a/arch/arm/mach-pxa/pxa930.c b/arch/arm/mach-pxa/pxa930.c
index ab624487cf39..da912be6eae7 100644
--- a/arch/arm/mach-pxa/pxa930.c
+++ b/arch/arm/mach-pxa/pxa930.c
@@ -17,7 +17,7 @@
 #include <linux/gpio-pxa.h>
 #include <linux/platform_device.h>
 
-#include <mach/pxa930.h>
+#include "pxa930.h"
 
 #include "devices.h"
 
diff --git a/arch/arm/mach-pxa/include/mach/pxa930.h b/arch/arm/mach-pxa/pxa930.h
similarity index 59%
rename from arch/arm/mach-pxa/include/mach/pxa930.h
rename to arch/arm/mach-pxa/pxa930.h
index 190363b98d01..4eceb02978e8 100644
--- a/arch/arm/mach-pxa/include/mach/pxa930.h
+++ b/arch/arm/mach-pxa/pxa930.h
@@ -1,7 +1,7 @@
 #ifndef __MACH_PXA930_H
 #define __MACH_PXA930_H
 
-#include <mach/pxa3xx.h>
-#include <mach/mfp-pxa930.h>
+#include "pxa3xx.h"
+#include "mfp-pxa930.h"
 
 #endif /* __MACH_PXA930_H */
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 36571a9a44fe..0f67d94be297 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -49,7 +49,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/pxa300.h>
+#include "pxa300.h"
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/mmc-pxamci.h>
diff --git a/arch/arm/mach-pxa/include/mach/regs-rtc.h b/arch/arm/mach-pxa/regs-rtc.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/regs-rtc.h
rename to arch/arm/mach-pxa/regs-rtc.h
diff --git a/arch/arm/mach-pxa/include/mach/regs-u2d.h b/arch/arm/mach-pxa/regs-u2d.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/regs-u2d.h
rename to arch/arm/mach-pxa/regs-u2d.h
diff --git a/arch/arm/mach-pxa/saar.c b/arch/arm/mach-pxa/saar.c
index 710c493eac89..1414b5f29114 100644
--- a/arch/arm/mach-pxa/saar.c
+++ b/arch/arm/mach-pxa/saar.c
@@ -31,7 +31,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 
-#include <mach/pxa930.h>
+#include "pxa930.h"
 #include <linux/platform_data/video-pxafb.h>
 
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
index bdc0c41bc4fd..b80eab9993c5 100644
--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -27,10 +27,10 @@
 #include <linux/io.h>
 
 #include <asm/mach-types.h>
-#include <mach/pm.h>
+#include "pm.h"
 #include <mach/pxa2xx-regs.h>
-#include <mach/regs-rtc.h>
-#include <mach/sharpsl_pm.h>
+#include "regs-rtc.h"
+#include "sharpsl_pm.h"
 
 /*
  * Constants
diff --git a/arch/arm/mach-pxa/include/mach/sharpsl_pm.h b/arch/arm/mach-pxa/sharpsl_pm.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/sharpsl_pm.h
rename to arch/arm/mach-pxa/sharpsl_pm.h
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index f4e2e2719580..825f903ab77e 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -40,15 +40,15 @@
 #include <asm/mach/sharpsl_param.h>
 #include <asm/hardware/scoop.h>
 
-#include <mach/pxa27x.h>
-#include <mach/pxa27x-udc.h>
+#include "pxa27x.h"
+#include "pxa27x-udc.h"
 #include <mach/reset.h>
 #include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <mach/spitz.h>
-#include <mach/sharpsl_pm.h>
+#include "sharpsl_pm.h"
 #include <mach/smemc.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/spitz_pm.c b/arch/arm/mach-pxa/spitz_pm.c
index e191f9996b26..ea9f9034cb54 100644
--- a/arch/arm/mach-pxa/spitz_pm.c
+++ b/arch/arm/mach-pxa/spitz_pm.c
@@ -25,8 +25,8 @@
 #include <mach/hardware.h>
 
 #include <mach/spitz.h>
-#include <mach/pxa27x.h>
-#include <mach/sharpsl_pm.h>
+#include "pxa27x.h"
+#include "sharpsl_pm.h"
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index 01de542432a6..702f4f14b708 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -43,10 +43,10 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/flash.h>
 
-#include <mach/pxa27x.h>
+#include "pxa27x.h"
 #include <linux/platform_data/mmc-pxamci.h>
-#include <mach/udc.h>
-#include <mach/pxa27x-udc.h>
+#include "udc.h"
+#include "pxa27x-udc.h"
 #include <mach/smemc.h>
 
 #include <linux/spi/spi.h>
diff --git a/arch/arm/mach-pxa/tavorevb.c b/arch/arm/mach-pxa/tavorevb.c
index 349a13a76215..4b38e821ac9c 100644
--- a/arch/arm/mach-pxa/tavorevb.c
+++ b/arch/arm/mach-pxa/tavorevb.c
@@ -24,7 +24,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/pxa930.h>
+#include "pxa930.h"
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/keypad-pxa27x.h>
 
diff --git a/arch/arm/mach-pxa/tosa-bt.c b/arch/arm/mach-pxa/tosa-bt.c
index e0a53208880a..107f37210fb9 100644
--- a/arch/arm/mach-pxa/tosa-bt.c
+++ b/arch/arm/mach-pxa/tosa-bt.c
@@ -16,7 +16,7 @@
 #include <linux/delay.h>
 #include <linux/rfkill.h>
 
-#include <mach/tosa_bt.h>
+#include "tosa_bt.h"
 
 static void tosa_bt_on(struct tosa_bt_data *data)
 {
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index e6e27c0468e4..13de6602966f 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -43,12 +43,12 @@
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 
-#include <mach/pxa25x.h>
+#include "pxa25x.h"
 #include <mach/reset.h>
 #include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/mmc-pxamci.h>
-#include <mach/udc.h>
-#include <mach/tosa_bt.h>
+#include "udc.h"
+#include "tosa_bt.h"
 #include <mach/audio.h>
 #include <mach/smemc.h>
 
diff --git a/arch/arm/mach-pxa/include/mach/tosa_bt.h b/arch/arm/mach-pxa/tosa_bt.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/tosa_bt.h
rename to arch/arm/mach-pxa/tosa_bt.h
diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
index 066e3a250ee0..ea78bc5c4198 100644
--- a/arch/arm/mach-pxa/trizeps4.c
+++ b/arch/arm/mach-pxa/trizeps4.c
@@ -41,7 +41,7 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/flash.h>
 
-#include <mach/pxa27x.h>
+#include "pxa27x.h"
 #include <mach/trizeps4.h>
 #include <mach/audio.h>
 #include <linux/platform_data/video-pxafb.h>
diff --git a/arch/arm/mach-pxa/include/mach/udc.h b/arch/arm/mach-pxa/udc.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/udc.h
rename to arch/arm/mach-pxa/udc.h
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index 7ecc61ad2bed..8e89d91b206b 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -47,12 +47,12 @@
 #include <linux/mtd/physmap.h>
 #include <linux/syscore_ops.h>
 
-#include <mach/pxa25x.h>
+#include "pxa25x.h"
 #include <mach/audio.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <mach/regs-uart.h>
 #include <linux/platform_data/pcmcia-pxa2xx_viper.h>
-#include <mach/viper.h>
+#include "viper.h"
 
 #include <asm/setup.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-pxa/include/mach/viper.h b/arch/arm/mach-pxa/viper.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/viper.h
rename to arch/arm/mach-pxa/viper.h
diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
index 54122a983ae3..c006ee902a8f 100644
--- a/arch/arm/mach-pxa/vpac270.c
+++ b/arch/arm/mach-pxa/vpac270.c
@@ -31,14 +31,14 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/pxa27x.h>
+#include "pxa27x.h"
 #include <mach/audio.h>
 #include <mach/vpac270.h>
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
-#include <mach/pxa27x-udc.h>
-#include <mach/udc.h>
+#include "pxa27x-udc.h"
+#include "udc.h"
 #include <linux/platform_data/ata-pxa.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/xcep.c b/arch/arm/mach-pxa/xcep.c
index 13b1d4586d7d..3f06cd90567a 100644
--- a/arch/arm/mach-pxa/xcep.c
+++ b/arch/arm/mach-pxa/xcep.c
@@ -28,7 +28,7 @@
 #include <asm/mach/map.h>
 
 #include <mach/hardware.h>
-#include <mach/pxa25x.h>
+#include "pxa25x.h"
 #include <mach/smemc.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index d9899d73e46b..510e533871f3 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -35,13 +35,13 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/pxa27x.h>
-#include <mach/mfp-pxa27x.h>
+#include "pxa27x.h"
+#include "mfp-pxa27x.h"
 #include <mach/z2.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/keypad-pxa27x.h>
-#include <mach/pm.h>
+#include "pm.h"
 
 #include "generic.h"
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index 30e62a3f0701..515b7ddda8aa 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -38,17 +38,17 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/pxa27x.h>
+#include "pxa27x.h"
 #include <mach/regs-uart.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <linux/platform_data/mmc-pxamci.h>
-#include <mach/pxa27x-udc.h>
-#include <mach/udc.h>
+#include "pxa27x-udc.h"
+#include "udc.h"
 #include <linux/platform_data/video-pxafb.h>
-#include <mach/pm.h>
+#include "pm.h"
 #include <mach/audio.h>
 #include <linux/platform_data/pcmcia-pxa2xx_viper.h>
-#include <mach/zeus.h>
+#include "zeus.h"
 #include <mach/smemc.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/include/mach/zeus.h b/arch/arm/mach-pxa/zeus.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/zeus.h
rename to arch/arm/mach-pxa/zeus.h
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index e20359a7433c..3642389b301a 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -25,10 +25,10 @@
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <mach/pxa3xx.h>
+#include "pxa3xx.h"
 #include <mach/audio.h>
 #include <linux/platform_data/video-pxafb.h>
-#include <mach/zylonite.h>
+#include "zylonite.h"
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <linux/platform_data/keypad-pxa27x.h>
diff --git a/arch/arm/mach-pxa/include/mach/zylonite.h b/arch/arm/mach-pxa/zylonite.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/zylonite.h
rename to arch/arm/mach-pxa/zylonite.h
diff --git a/arch/arm/mach-pxa/zylonite_pxa300.c b/arch/arm/mach-pxa/zylonite_pxa300.c
index 869bce7c3f24..e247acf1400a 100644
--- a/arch/arm/mach-pxa/zylonite_pxa300.c
+++ b/arch/arm/mach-pxa/zylonite_pxa300.c
@@ -21,8 +21,8 @@
 #include <linux/platform_data/pca953x.h>
 #include <linux/gpio.h>
 
-#include <mach/pxa300.h>
-#include <mach/zylonite.h>
+#include "pxa300.h"
+#include "zylonite.h"
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-pxa/zylonite_pxa320.c b/arch/arm/mach-pxa/zylonite_pxa320.c
index 9942bac4cf7d..47961ae0c448 100644
--- a/arch/arm/mach-pxa/zylonite_pxa320.c
+++ b/arch/arm/mach-pxa/zylonite_pxa320.c
@@ -18,8 +18,8 @@
 #include <linux/init.h>
 #include <linux/gpio.h>
 
-#include <mach/pxa320.h>
-#include <mach/zylonite.h>
+#include "pxa320.h"
+#include "zylonite.h"
 
 #include "generic.h"
 
diff --git a/drivers/clk/pxa/clk-pxa25x.c b/drivers/clk/pxa/clk-pxa25x.c
index 542e45ef5087..b7747229db9a 100644
--- a/drivers/clk/pxa/clk-pxa25x.c
+++ b/drivers/clk/pxa/clk-pxa25x.c
@@ -17,7 +17,6 @@
 #include <linux/clkdev.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <mach/pxa25x.h>
 #include <mach/pxa2xx-regs.h>
 
 #include <dt-bindings/clock/pxa-clock.h>
