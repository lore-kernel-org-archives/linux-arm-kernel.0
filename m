From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Sep 2012 14:59:41 +0200
Subject: [PATCH 07/16] ARM: pxa: move platform_data definitions
In-Reply-To: <1347368390-31252-1-git-send-email-arnd@arndb.de>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-1-git-send-email-arnd@arndb.de>
Message-ID: <1347368390-31252-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Platform data for device drivers should be defined in
include/linux/platform_data/*.h, not in the architecture
and platform specific directories.

This moves such data out of the pxa include directories

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Daniel Ribeiro <drwyrm@gmail.com>
Cc: Stefan Schmidt <stefan@openezx.org>
Cc: Harald Welte <laforge@openezx.org>
Cc: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Paul Parsons <lost.distance@yahoo.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Tomas Cech <sleep_walker@suse.cz>
Cc: Sergey Lapin <slapin@ossfans.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <djbw@fb.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Chris Ball <cjb@laptop.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Samuel Ortiz <samuel@sortiz.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: openezx-devel at lists.openezx.org
---
 arch/arm/mach-mmp/aspenite.c                           |    2 +-
 arch/arm/mach-mmp/include/mach/mmp2.h                  |    2 +-
 arch/arm/mach-mmp/include/mach/pxa168.h                |    4 ++--
 arch/arm/mach-mmp/include/mach/pxa910.h                |    2 +-
 arch/arm/mach-mmp/sram.c                               |    2 +-
 arch/arm/mach-mmp/teton_bga.c                          |    2 +-
 arch/arm/mach-pxa/am200epd.c                           |    2 +-
 arch/arm/mach-pxa/am300epd.c                           |    2 +-
 arch/arm/mach-pxa/balloon3.c                           |    8 ++++----
 arch/arm/mach-pxa/cm-x270.c                            |    4 ++--
 arch/arm/mach-pxa/cm-x2xx.c                            |    2 +-
 arch/arm/mach-pxa/cm-x300.c                            |   10 +++++-----
 arch/arm/mach-pxa/colibri-evalboard.c                  |    4 ++--
 arch/arm/mach-pxa/colibri-pxa270-income.c              |    6 +++---
 arch/arm/mach-pxa/colibri-pxa300.c                     |    4 ++--
 arch/arm/mach-pxa/colibri-pxa320.c                     |    4 ++--
 arch/arm/mach-pxa/colibri-pxa3xx.c                     |    6 +++---
 arch/arm/mach-pxa/corgi.c                              |    4 ++--
 arch/arm/mach-pxa/csb726.c                             |    4 ++--
 arch/arm/mach-pxa/devices.c                            |   16 ++++++++--------
 arch/arm/mach-pxa/em-x270.c                            |   10 +++++-----
 arch/arm/mach-pxa/eseries.c                            |    4 ++--
 arch/arm/mach-pxa/ezx.c                                |    8 ++++----
 arch/arm/mach-pxa/gumstix.c                            |    2 +-
 arch/arm/mach-pxa/hx4700.c                             |    2 +-
 arch/arm/mach-pxa/idp.c                                |    4 ++--
 arch/arm/mach-pxa/littleton.c                          |    8 ++++----
 arch/arm/mach-pxa/lpd270.c                             |    8 ++++----
 arch/arm/mach-pxa/lubbock.c                            |    6 +++---
 arch/arm/mach-pxa/magician.c                           |    8 ++++----
 arch/arm/mach-pxa/mainstone.c                          |   10 +++++-----
 arch/arm/mach-pxa/mioa701.c                            |    8 ++++----
 arch/arm/mach-pxa/mxm8x10.c                            |    8 ++++----
 arch/arm/mach-pxa/palm27x.c                            |    8 ++++----
 arch/arm/mach-pxa/palmld.c                             |   10 +++++-----
 arch/arm/mach-pxa/palmt5.c                             |   10 +++++-----
 arch/arm/mach-pxa/palmtc.c                             |    6 +++---
 arch/arm/mach-pxa/palmte2.c                            |    8 ++++----
 arch/arm/mach-pxa/palmtreo.c                           |   14 +++++++-------
 arch/arm/mach-pxa/palmtx.c                             |   10 +++++-----
 arch/arm/mach-pxa/palmz72.c                            |   12 ++++++------
 arch/arm/mach-pxa/pcm990-baseboard.c                   |    8 ++++----
 arch/arm/mach-pxa/poodle.c                             |    6 +++---
 arch/arm/mach-pxa/pxa27x.c                             |    2 +-
 arch/arm/mach-pxa/pxa2xx.c                             |    2 +-
 arch/arm/mach-pxa/pxa3xx-ulpi.c                        |    2 +-
 arch/arm/mach-pxa/pxa3xx.c                             |    2 +-
 arch/arm/mach-pxa/raumfeld.c                           |    8 ++++----
 arch/arm/mach-pxa/saar.c                               |    2 +-
 arch/arm/mach-pxa/spitz.c                              |    8 ++++----
 arch/arm/mach-pxa/stargate2.c                          |    2 +-
 arch/arm/mach-pxa/tavorevb.c                           |    4 ++--
 arch/arm/mach-pxa/tosa.c                               |    4 ++--
 arch/arm/mach-pxa/trizeps4.c                           |    8 ++++----
 arch/arm/mach-pxa/viper.c                              |    4 ++--
 arch/arm/mach-pxa/vpac270.c                            |    8 ++++----
 arch/arm/mach-pxa/z2.c                                 |    6 +++---
 arch/arm/mach-pxa/zeus.c                               |    8 ++++----
 arch/arm/mach-pxa/zylonite.c                           |   10 +++++-----
 drivers/ata/pata_pxa.c                                 |    2 +-
 drivers/dma/mmp_tdma.c                                 |    2 +-
 drivers/input/keyboard/pxa27x_keypad.c                 |    2 +-
 drivers/input/keyboard/pxa930_rotary.c                 |    2 +-
 drivers/input/mouse/pxa930_trkball.c                   |    2 +-
 drivers/media/video/pxa_camera.c                       |    2 +-
 drivers/mmc/host/pxamci.c                              |    2 +-
 drivers/mtd/nand/pxa3xx_nand.c                         |    2 +-
 drivers/net/irda/pxaficp_ir.c                          |    2 +-
 drivers/pcmcia/pxa2xx_viper.c                          |    2 +-
 drivers/usb/host/ohci-pxa27x.c                         |    4 ++--
 drivers/video/pxafb.c                                  |    2 +-
 .../linux/platform_data/asoc-palm27x.h                 |    0
 .../linux/platform_data/ata-pxa.h                      |    0
 .../linux/platform_data/camera-pxa.h                   |    0
 .../linux/platform_data/dma-mmp_tdma.h                 |    0
 .../linux/platform_data/irda-pxaficp.h                 |    0
 .../linux/platform_data/keyboard-pxa930_rotary.h       |    0
 .../linux/platform_data/keypad-pxa27x.h                |    0
 .../mmc.h => include/linux/platform_data/mmc-pxamci.h  |    0
 .../linux/platform_data/mouse-pxa930_trkball.h         |    0
 .../linux/platform_data/mtd-nand-pxa3xx.h              |    0
 .../linux/platform_data/pcmcia-pxa2xx_viper.h          |    0
 .../linux/platform_data/usb-ohci-pxa27x.h              |    0
 .../linux/platform_data/usb-pxa3xx-ulpi.h              |    0
 .../linux/platform_data/video-pxafb.h                  |    0
 sound/soc/pxa/palm27x.c                                |    2 +-
 86 files changed, 188 insertions(+), 188 deletions(-)
 rename arch/arm/mach-pxa/include/mach/palmasoc.h => include/linux/platform_data/asoc-palm27x.h (100%)
 rename arch/arm/mach-pxa/include/mach/pata_pxa.h => include/linux/platform_data/ata-pxa.h (100%)
 rename arch/arm/mach-pxa/include/mach/camera.h => include/linux/platform_data/camera-pxa.h (100%)
 rename arch/arm/mach-mmp/include/mach/sram.h => include/linux/platform_data/dma-mmp_tdma.h (100%)
 rename arch/arm/mach-pxa/include/mach/irda.h => include/linux/platform_data/irda-pxaficp.h (100%)
 rename arch/arm/mach-pxa/include/mach/pxa930_rotary.h => include/linux/platform_data/keyboard-pxa930_rotary.h (100%)
 rename arch/arm/plat-pxa/include/plat/pxa27x_keypad.h => include/linux/platform_data/keypad-pxa27x.h (100%)
 rename arch/arm/mach-pxa/include/mach/mmc.h => include/linux/platform_data/mmc-pxamci.h (100%)
 rename arch/arm/mach-pxa/include/mach/pxa930_trkball.h => include/linux/platform_data/mouse-pxa930_trkball.h (100%)
 rename arch/arm/plat-pxa/include/plat/pxa3xx_nand.h => include/linux/platform_data/mtd-nand-pxa3xx.h (100%)
 rename arch/arm/mach-pxa/include/mach/arcom-pcmcia.h => include/linux/platform_data/pcmcia-pxa2xx_viper.h (100%)
 rename arch/arm/mach-pxa/include/mach/ohci.h => include/linux/platform_data/usb-ohci-pxa27x.h (100%)
 rename arch/arm/mach-pxa/include/mach/pxa3xx-u2d.h => include/linux/platform_data/usb-pxa3xx-ulpi.h (100%)
 rename arch/arm/mach-pxa/include/mach/pxafb.h => include/linux/platform_data/video-pxafb.h (100%)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 223090b..e5dba9c 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -27,7 +27,7 @@
 #include <mach/irqs.h>
 #include <video/pxa168fb.h>
 #include <linux/input.h>
-#include <plat/pxa27x_keypad.h>
+#include <linux/platform_data/keypad-pxa27x.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-mmp/include/mach/mmp2.h b/arch/arm/mach-mmp/include/mach/mmp2.h
index cba22fe..c4ca4d1 100644
--- a/arch/arm/mach-mmp/include/mach/mmp2.h
+++ b/arch/arm/mach-mmp/include/mach/mmp2.h
@@ -13,7 +13,7 @@ extern void mmp2_clear_pmic_int(void);
 #include <linux/i2c.h>
 #include <linux/i2c/pxa-i2c.h>
 #include <mach/devices.h>
-#include <mach/sram.h>
+#include <linux/platform_data/dma-mmp_tdma.h>
 
 extern struct pxa_device_desc mmp2_device_uart1;
 extern struct pxa_device_desc mmp2_device_uart2;
diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h b/arch/arm/mach-mmp/include/mach/pxa168.h
index 09dcd6e..37632d9 100644
--- a/arch/arm/mach-mmp/include/mach/pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/pxa168.h
@@ -11,9 +11,9 @@ extern void pxa168_clear_keypad_wakeup(void);
 #include <linux/i2c.h>
 #include <linux/i2c/pxa-i2c.h>
 #include <mach/devices.h>
-#include <plat/pxa3xx_nand.h>
+#include <linux/platform_data/mtd-nand-pxa3xx.h>
 #include <video/pxa168fb.h>
-#include <plat/pxa27x_keypad.h>
+#include <linux/platform_data/keypad-pxa27x.h>
 #include <mach/cputype.h>
 #include <linux/pxa168_eth.h>
 #include <linux/platform_data/mv_usb.h>
diff --git a/arch/arm/mach-mmp/include/mach/pxa910.h b/arch/arm/mach-mmp/include/mach/pxa910.h
index 793634c..3b58a3b 100644
--- a/arch/arm/mach-mmp/include/mach/pxa910.h
+++ b/arch/arm/mach-mmp/include/mach/pxa910.h
@@ -9,7 +9,7 @@ extern void __init pxa910_init_irq(void);
 #include <linux/i2c.h>
 #include <linux/i2c/pxa-i2c.h>
 #include <mach/devices.h>
-#include <plat/pxa3xx_nand.h>
+#include <linux/platform_data/mtd-nand-pxa3xx.h>
 
 extern struct pxa_device_desc pxa910_device_uart1;
 extern struct pxa_device_desc pxa910_device_uart2;
diff --git a/arch/arm/mach-mmp/sram.c b/arch/arm/mach-mmp/sram.c
index 4304f95..b4899b0 100644
--- a/arch/arm/mach-mmp/sram.c
+++ b/arch/arm/mach-mmp/sram.c
@@ -22,7 +22,7 @@
 #include <linux/slab.h>
 #include <linux/genalloc.h>
 
-#include <mach/sram.h>
+#include <linux/platform_data/dma-mmp_tdma.h>
 
 struct sram_bank_info {
 	char *pool_name;
diff --git a/arch/arm/mach-mmp/teton_bga.c b/arch/arm/mach-mmp/teton_bga.c
index 42bef66..dd30ea7 100644
--- a/arch/arm/mach-mmp/teton_bga.c
+++ b/arch/arm/mach-mmp/teton_bga.c
@@ -17,7 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/input.h>
-#include <plat/pxa27x_keypad.h>
+#include <linux/platform_data/keypad-pxa27x.h>
 #include <linux/i2c.h>
 
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-pxa/am200epd.c b/arch/arm/mach-pxa/am200epd.c
index ccdac4b..ffa6d81 100644
--- a/arch/arm/mach-pxa/am200epd.c
+++ b/arch/arm/mach-pxa/am200epd.c
@@ -32,7 +32,7 @@
 
 #include <mach/pxa25x.h>
 #include <mach/gumstix.h>
-#include <mach/pxafb.h>
+#include <linux/platform_data/video-pxafb.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-pxa/am300epd.c b/arch/arm/mach-pxa/am300epd.c
index 76c4b94..3dfec1e 100644
--- a/arch/arm/mach-pxa/am300epd.c
+++ b/arch/arm/mach-pxa/am300epd.c
@@ -30,7 +30,7 @@
 
 #include <mach/gumstix.h>
 #include <mach/mfp-pxa25x.h>
-#include <mach/pxafb.h>
+#include <linux/platform_data/video-pxafb.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index 9244493..2082293 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -45,12 +45,12 @@
 #include <mach/pxa27x.h>
 #include <mach/balloon3.h>
 #include <mach/audio.h>
-#include <mach/pxafb.h>
-#include <mach/mmc.h>
+#include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/mmc-pxamci.h>
 #include <mach/udc.h>
 #include <mach/pxa27x-udc.h>
-#include <mach/irda.h>
-#include <mach/ohci.h>
+#include <linux/platform_data/irda-pxaficp.h>
+#include <linux/platform_data/usb-ohci-pxa27x.h>
 
 #include "generic.h"
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/cm-x270.c b/arch/arm/mach-pxa/cm-x270.c
index 431ef56..2503db9 100644
--- a/arch/arm/mach-pxa/cm-x270.c
+++ b/arch/arm/mach-pxa/cm-x270.c
@@ -22,8 +22,8 @@
 #include <linux/spi/libertas_spi.h>
 
 #include <mach/pxa27x.h>
-#include <mach/ohci.h>
-#include <mach/mmc.h>
+#include <linux/platform_data/usb-ohci-pxa27x.h>
+#include <linux/platform_data/mmc-pxamci.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-pxa/cm-x2xx.c b/arch/arm/mach-pxa/cm-x2xx.c
index 8fa4ad2..fc3afc7 100644
--- a/arch/arm/mach-pxa/cm-x2xx.c
+++ b/arch/arm/mach-pxa/cm-x2xx.c
@@ -24,7 +24,7 @@
 #include <mach/pxa25x.h>
 #include <mach/pxa27x.h>
 #include <mach/audio.h>
-#include <mach/pxafb.h>
+#include <linux/platform_data/video-pxafb.h>
 #include <mach/smemc.h>
 
 #include <asm/hardware/it8152.h>
diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 3e4e9fe..cc2b23a 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -48,12 +48,12 @@
 
 #include <mach/pxa300.h>
 #include <mach/pxa27x-udc.h>
-#include <mach/pxafb.h>
-#include <mach/mmc.h>
-#include <mach/ohci.h>
-#include <plat/pxa3xx_nand.h>
+#include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/mmc-pxamci.h>
+#include <linux/platform_data/usb-ohci-pxa27x.h>
+#include <linux/platform_data/mtd-nand-pxa3xx.h>
 #include <mach/audio.h>
-#include <mach/pxa3xx-u2d.h>
+#include <linux/platform_data/usb-pxa3xx-ulpi.h>
 
 #include <asm/mach/map.h>
 
diff --git a/arch/arm/mach-pxa/colibri-evalboard.c b/arch/arm/mach-pxa/colibri-evalboard.c
index d28e802..8404b24 100644
--- a/arch/arm/mach-pxa/colibri-evalboard.c
+++ b/arch/arm/mach-pxa/colibri-evalboard.c
@@ -23,8 +23,8 @@
 
 #include <mach/pxa27x.h>
 #include <mach/colibri.h>
-#include <mach/mmc.h>
-#include <mach/ohci.h>
+#include <linux/platform_data/mmc-pxamci.h>
+#include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <mach/pxa27x-udc.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/colibri-pxa270-income.c b/arch/arm/mach-pxa/colibri-pxa270-income.c
index 248804b..2d4a7b4 100644
--- a/arch/arm/mach-pxa/colibri-pxa270-income.c
+++ b/arch/arm/mach-pxa/colibri-pxa270-income.c
@@ -27,11 +27,11 @@
 #include <asm/mach-types.h>
 
 #include <mach/hardware.h>
-#include <mach/mmc.h>
-#include <mach/ohci.h>
+#include <linux/platform_data/mmc-pxamci.h>
+#include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <mach/pxa27x.h>
 #include <mach/pxa27x-udc.h>
-#include <mach/pxafb.h>
+#include <linux/platform_data/video-pxafb.h>
 
 #include "devices.h"
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/colibri-pxa300.c b/arch/arm/mach-pxa/colibri-pxa300.c
index bb6def8..a9c9c16 100644
--- a/arch/arm/mach-pxa/colibri-pxa300.c
+++ b/arch/arm/mach-pxa/colibri-pxa300.c
@@ -24,8 +24,8 @@
 
 #include <mach/pxa300.h>
 #include <mach/colibri.h>
-#include <mach/ohci.h>
-#include <mach/pxafb.h>
+#include <linux/platform_data/usb-ohci-pxa27x.h>
+#include <linux/platform_data/video-pxafb.h>
 #include <mach/audio.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/colibri-pxa320.c b/arch/arm/mach-pxa/colibri-pxa320.c
index d88e7b3..25515cd 100644
--- a/arch/arm/mach-pxa/colibri-pxa320.c
+++ b/arch/arm/mach-pxa/colibri-pxa320.c
@@ -25,8 +25,8 @@
 
 #include <mach/pxa320.h>
 #include <mach/colibri.h>
-#include <mach/pxafb.h>
-#include <mach/ohci.h>
+#include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <mach/audio.h>
 #include <mach/pxa27x-udc.h>
 #include <mach/udc.h>
diff --git a/arch/arm/mach-pxa/colibri-pxa3xx.c b/arch/arm/mach-pxa/colibri-pxa3xx.c
index 68cc75f..8240291 100644
--- a/arch/arm/mach-pxa/colibri-pxa3xx.c
+++ b/arch/arm/mach-pxa/colibri-pxa3xx.c
@@ -24,9 +24,9 @@
 #include <mach/pxa3xx-regs.h>
 #include <mach/mfp-pxa300.h>
 #include <mach/colibri.h>
-#include <mach/mmc.h>
-#include <mach/pxafb.h>
-#include <plat/pxa3xx_nand.h>
+#include <linux/platform_data/mmc-pxamci.h>
+#include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/mtd-nand-pxa3xx.h>
 
 #include "generic.h"
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index c1fe32d..7c83f52 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -46,8 +46,8 @@
 #include <asm/mach/irq.h>
 
 #include <mach/pxa25x.h>
-#include <mach/irda.h>
-#include <mach/mmc.h>
+#include <linux/platform_data/irda-pxaficp.h>
+#include <linux/platform_data/mmc-pxamci.h>
 #include <mach/udc.h>
 #include <mach/corgi.h>
 #include <mach/sharpsl_pm.h>
diff --git a/arch/arm/mach-pxa/csb726.c b/arch/arm/mach-pxa/csb726.c
index 67f0de3..7039f44 100644
--- a/arch/arm/mach-pxa/csb726.c
+++ b/arch/arm/mach-pxa/csb726.c
@@ -23,8 +23,8 @@
 #include <asm/mach/arch.h>
 #include <mach/csb726.h>
 #include <mach/pxa27x.h>
-#include <mach/mmc.h>
-#include <mach/ohci.h>
+#include <linux/platform_data/mmc-pxamci.h>
+#include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <mach/audio.h>
 #include <mach/smemc.h>
 
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 166eee5..e66bd1b 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -8,17 +8,17 @@
 
 #include <asm/pmu.h>
 #include <mach/udc.h>
-#include <mach/pxa3xx-u2d.h>
-#include <mach/pxafb.h>
-#include <mach/mmc.h>
-#include <mach/irda.h>
+#include <linux/platform_data/usb-pxa3xx-ulpi.h>
+#include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/mmc-pxamci.h>
+#include <linux/platform_data/irda-pxaficp.h>
 #include <mach/irqs.h>
-#include <mach/ohci.h>
-#include <plat/pxa27x_keypad.h>
-#include <mach/camera.h>
+#include <linux/platform_data/usb-ohci-pxa27x.h>
+#include <linux/platform_data/keypad-pxa27x.h>
+#include <linux/platform_data/camera-pxa.h>
 #include <mach/audio.h>
 #include <mach/hardware.h>
-#include <plat/pxa3xx_nand.h>
+#include <linux/platform_data/mtd-nand-pxa3xx.h>
 
 #include "devices.h"
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index 97f82ad..1b64114 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -42,11 +42,11 @@
 #include <mach/pxa27x.h>
 #include <mach/pxa27x-udc.h>
 #include <mach/audio.h>
-#include <mach/pxafb.h>
-#include <mach/ohci.h>
-#include <mach/mmc.h>
-#include <plat/pxa27x_keypad.h>
-#include <mach/camera.h>
+#include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/usb-ohci-pxa27x.h>
+#include <linux/platform_data/mmc-pxamci.h>
+#include <linux/platform_data/keypad-pxa27x.h>
+#include <linux/platform_data/camera-pxa.h>
 
 #include "generic.h"
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index 4cb2391..be2ee9b 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -32,9 +32,9 @@
 #include <mach/eseries-gpio.h>
 #include <mach/eseries-irq.h>
 #include <mach/audio.h>
-#include <mach/pxafb.h>
+#include <linux/platform_data/video-pxafb.h>
 #include <mach/udc.h>
-#include <mach/irda.h>
+#include <linux/platform_data/irda-pxaficp.h>
 
 #include "devices.h"
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index 15ab253..dc58fa0 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -29,11 +29,11 @@
 #include <asm/mach/arch.h>
 
 #include <mach/pxa27x.h>
-#include <mach/pxafb.h>
-#include <mach/ohci.h>
+#include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <mach/hardware.h>
-#include <plat/pxa27x_keypad.h>
-#include <mach/camera.h>
+#include <linux/platform_data/keypad-pxa27x.h>
+#include <linux/platform_data/camera-pxa.h>
 
 #include "devices.h"
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
index e529a35..60755a6 100644
--- a/arch/arm/mach-pxa/gumstix.c
+++ b/arch/arm/mach-pxa/gumstix.c
@@ -41,7 +41,7 @@
 #include <asm/mach/flash.h>
 
 #include <mach/pxa25x.h>
-#include <mach/mmc.h>
+#include <linux/platform_data/mmc-pxamci.h>
 #include <mach/udc.h>
 #include <mach/gumstix.h>
 
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index e6311988..5ecbd17 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -45,7 +45,7 @@
 
 #include <mach/pxa27x.h>
 #include <mach/hx4700.h>
-#include <mach/irda.h>
+#include <linux/platform_data/irda-pxaficp.h>
 
 #include <sound/ak4641.h>
 #include <video/platform_lcd.h>
diff --git a/arch/arm/mach-pxa/idp.c b/arch/arm/mach-pxa/idp.c
index 6ff466b..c361519 100644
--- a/arch/arm/mach-pxa/idp.c
+++ b/arch/arm/mach-pxa/idp.c
@@ -33,9 +33,9 @@
 
 #include <mach/pxa25x.h>
 #include <mach/idp.h>
-#include <mach/pxafb.h>
+#include <linux/platform_data/video-pxafb.h>
 #include <mach/bitfield.h>
-#include <mach/mmc.h>
+#include <linux/platform_data/mmc-pxamci.h>
 
 #include "generic.h"
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index 1fb86ed..402874f 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -42,11 +42,11 @@
 #include <asm/mach/irq.h>
 
 #include <mach/pxa300.h>
-#include <mach/pxafb.h>
-#include <mach/mmc.h>
-#include <plat/pxa27x_keypad.h>
+#include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/mmc-pxamci.h>
+#include <linux/platform_data/keypad-pxa27x.h>
 #include <mach/littleton.h>
-#include <plat/pxa3xx_nand.h>
+#include <linux/platform_data/mtd-nand-pxa3xx.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index cee9ce2..1a63eaa 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -41,10 +41,10 @@
 #include <mach/pxa27x.h>
 #include <mach/lpd270.h>
 #include <mach/audio.h>
-#include <mach/pxafb.h>
-#include <mach/mmc.h>
-#include <mach/irda.h>
-#include <mach/ohci.h>
+#include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/mmc-pxamci.h>
+#include <linux/platform_data/irda-pxaficp.h>
+#include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <mach/smemc.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index 0ca0db7..44dd756 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -46,9 +46,9 @@
 #include <mach/audio.h>
 #include <mach/lubbock.h>
 #include <mach/udc.h>
-#include <mach/irda.h>
-#include <mach/pxafb.h>
-#include <mach/mmc.h>
+#include <linux/platform_data/irda-pxaficp.h>
+#include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/mmc-pxamci.h>
 #include <mach/pm.h>
 #include <mach/smemc.h>
 
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 39561dc..f792240 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -38,10 +38,10 @@
 
 #include <mach/pxa27x.h>
 #include <mach/magician.h>
-#include <mach/pxafb.h>
-#include <mach/mmc.h>
-#include <mach/irda.h>
-#include <mach/ohci.h>
+#include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/mmc-pxamci.h>
+#include <linux/platform_data/irda-pxaficp.h>
+#include <linux/platform_data/usb-ohci-pxa27x.h>
 
 #include "devices.h"
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index 1aebaf7..5d94757 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -45,11 +45,11 @@
 #include <mach/pxa27x.h>
 #include <mach/mainstone.h>
 #include <mach/audio.h>
-#include <mach/pxafb.h>
-#include <mach/mmc.h>
-#include <mach/irda.h>
-#include <mach/ohci.h>
-#include <plat/pxa27x_keypad.h>
+#include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/mmc-pxamci.h>
+#include <linux/platform_data/irda-pxaficp.h>
+#include <linux/platform_data/usb-ohci-pxa27x.h>
+#include <linux/platform_data/keypad-pxa27x.h>
 #include <mach/smemc.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index bf99022..2831308 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -46,12 +46,12 @@
 
 #include <mach/pxa27x.h>
 #include <mach/regs-rtc.h>
-#include <plat/pxa27x_keypad.h>
-#include <mach/pxafb.h>
-#include <mach/mmc.h>
+#include <linux/platform_data/keypad-pxa27x.h>
+#include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/mmc-pxamci.h>
 #include <mach/udc.h>
 #include <mach/pxa27x-udc.h>
-#include <mach/camera.h>
+#include <linux/platform_data/camera-pxa.h>
 #include <mach/audio.h>
 #include <mach/smemc.h>
 #include <media/soc_camera.h>
diff --git a/arch/arm/mach-pxa/mxm8x10.c b/arch/arm/mach-pxa/mxm8x10.c
index 83570a7..d04ed49 100644
--- a/arch/arm/mach-pxa/mxm8x10.c
+++ b/arch/arm/mach-pxa/mxm8x10.c
@@ -24,11 +24,11 @@
 #include <linux/gpio.h>
 #include <linux/i2c/pxa-i2c.h>
 
-#include <plat/pxa3xx_nand.h>
+#include <linux/platform_data/mtd-nand-pxa3xx.h>
 
-#include <mach/pxafb.h>
-#include <mach/mmc.h>
-#include <mach/ohci.h>
+#include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/mmc-pxamci.h>
+#include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <mach/pxa320.h>
 
 #include <mach/mxm8x10.h>
diff --git a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
index dad71cf..17d4c53 100644
--- a/arch/arm/mach-pxa/palm27x.c
+++ b/arch/arm/mach-pxa/palm27x.c
@@ -29,11 +29,11 @@
 
 #include <mach/pxa27x.h>
 #include <mach/audio.h>
-#include <mach/mmc.h>
-#include <mach/pxafb.h>
-#include <mach/irda.h>
+#include <linux/platform_data/mmc-pxamci.h>
+#include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/irda-pxaficp.h>
 #include <mach/udc.h>
-#include <mach/palmasoc.h>
+#include <linux/platform_data/asoc-palm27x.h>
 #include <mach/palm27x.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
index 31e0433d..8bcc96e 100644
--- a/arch/arm/mach-pxa/palmld.c
+++ b/arch/arm/mach-pxa/palmld.c
@@ -35,11 +35,11 @@
 #include <mach/pxa27x.h>
 #include <mach/audio.h>
 #include <mach/palmld.h>
-#include <mach/mmc.h>
-#include <mach/pxafb.h>
-#include <mach/irda.h>
-#include <plat/pxa27x_keypad.h>
-#include <mach/palmasoc.h>
+#include <linux/platform_data/mmc-pxamci.h>
+#include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/irda-pxaficp.h>
+#include <linux/platform_data/keypad-pxa27x.h>
+#include <linux/platform_data/asoc-palm27x.h>
 #include <mach/palm27x.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
index 0f6bd4f..5ca7b90 100644
--- a/arch/arm/mach-pxa/palmt5.c
+++ b/arch/arm/mach-pxa/palmt5.c
@@ -36,12 +36,12 @@
 #include <mach/pxa27x.h>
 #include <mach/audio.h>
 #include <mach/palmt5.h>
-#include <mach/mmc.h>
-#include <mach/pxafb.h>
-#include <mach/irda.h>
-#include <plat/pxa27x_keypad.h>
+#include <linux/platform_data/mmc-pxamci.h>
+#include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/irda-pxaficp.h>
+#include <linux/platform_data/keypad-pxa27x.h>
 #include <mach/udc.h>
-#include <mach/palmasoc.h>
+#include <linux/platform_data/asoc-palm27x.h>
 #include <mach/palm27x.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
index e2d97ee..ca924cf 100644
--- a/arch/arm/mach-pxa/palmtc.c
+++ b/arch/arm/mach-pxa/palmtc.c
@@ -34,9 +34,9 @@
 #include <mach/pxa25x.h>
 #include <mach/audio.h>
 #include <mach/palmtc.h>
-#include <mach/mmc.h>
-#include <mach/pxafb.h>
-#include <mach/irda.h>
+#include <linux/platform_data/mmc-pxamci.h>
+#include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/irda-pxaficp.h>
 #include <mach/udc.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/palmte2.c b/arch/arm/mach-pxa/palmte2.c
index c054827..997e6da 100644
--- a/arch/arm/mach-pxa/palmte2.c
+++ b/arch/arm/mach-pxa/palmte2.c
@@ -34,11 +34,11 @@
 #include <mach/pxa25x.h>
 #include <mach/audio.h>
 #include <mach/palmte2.h>
-#include <mach/mmc.h>
-#include <mach/pxafb.h>
-#include <mach/irda.h>
+#include <linux/platform_data/mmc-pxamci.h>
+#include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/irda-pxaficp.h>
 #include <mach/udc.h>
-#include <mach/palmasoc.h>
+#include <linux/platform_data/asoc-palm27x.h>
 
 #include "generic.h"
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
index fbdebee..3f3c48f 100644
--- a/arch/arm/mach-pxa/palmtreo.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@ -35,15 +35,15 @@
 #include <mach/pxa27x-udc.h>
 #include <mach/audio.h>
 #include <mach/palmtreo.h>
-#include <mach/mmc.h>
-#include <mach/pxafb.h>
-#include <mach/irda.h>
-#include <plat/pxa27x_keypad.h>
+#include <linux/platform_data/mmc-pxamci.h>
+#include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/irda-pxaficp.h>
+#include <linux/platform_data/keypad-pxa27x.h>
 #include <mach/udc.h>
-#include <mach/ohci.h>
+#include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <mach/pxa2xx-regs.h>
-#include <mach/palmasoc.h>
-#include <mach/camera.h>
+#include <linux/platform_data/asoc-palm27x.h>
+#include <linux/platform_data/camera-pxa.h>
 #include <mach/palm27x.h>
 
 #include <sound/pxa2xx-lib.h>
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index 0da35dc..8b43666 100644
--- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -40,12 +40,12 @@
 #include <mach/pxa27x.h>
 #include <mach/audio.h>
 #include <mach/palmtx.h>
-#include <mach/mmc.h>
-#include <mach/pxafb.h>
-#include <mach/irda.h>
-#include <plat/pxa27x_keypad.h>
+#include <linux/platform_data/mmc-pxamci.h>
+#include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/irda-pxaficp.h>
+#include <linux/platform_data/keypad-pxa27x.h>
 #include <mach/udc.h>
-#include <mach/palmasoc.h>
+#include <linux/platform_data/asoc-palm27x.h>
 #include <mach/palm27x.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index a97b599..8cdd4f5 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -40,16 +40,16 @@
 #include <mach/pxa27x.h>
 #include <mach/audio.h>
 #include <mach/palmz72.h>
-#include <mach/mmc.h>
-#include <mach/pxafb.h>
-#include <mach/irda.h>
-#include <plat/pxa27x_keypad.h>
+#include <linux/platform_data/mmc-pxamci.h>
+#include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/irda-pxaficp.h>
+#include <linux/platform_data/keypad-pxa27x.h>
 #include <mach/udc.h>
-#include <mach/palmasoc.h>
+#include <linux/platform_data/asoc-palm27x.h>
 #include <mach/palm27x.h>
 
 #include <mach/pm.h>
-#include <mach/camera.h>
+#include <linux/platform_data/camera-pxa.h>
 
 #include <media/soc_camera.h>
 
diff --git a/arch/arm/mach-pxa/pcm990-baseboard.c b/arch/arm/mach-pxa/pcm990-baseboard.c
index cb723e8..113c57a 100644
--- a/arch/arm/mach-pxa/pcm990-baseboard.c
+++ b/arch/arm/mach-pxa/pcm990-baseboard.c
@@ -28,14 +28,14 @@
 
 #include <media/soc_camera.h>
 
-#include <mach/camera.h>
+#include <linux/platform_data/camera-pxa.h>
 #include <asm/mach/map.h>
 #include <mach/pxa27x.h>
 #include <mach/audio.h>
-#include <mach/mmc.h>
-#include <mach/ohci.h>
+#include <linux/platform_data/mmc-pxamci.h>
+#include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <mach/pcm990_baseboard.h>
-#include <mach/pxafb.h>
+#include <linux/platform_data/video-pxafb.h>
 
 #include "devices.h"
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 89d98c8..2910bb9 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -40,11 +40,11 @@
 #include <asm/mach/irq.h>
 
 #include <mach/pxa25x.h>
-#include <mach/mmc.h>
+#include <linux/platform_data/mmc-pxamci.h>
 #include <mach/udc.h>
-#include <mach/irda.h>
+#include <linux/platform_data/irda-pxaficp.h>
 #include <mach/poodle.h>
-#include <mach/pxafb.h>
+#include <linux/platform_data/video-pxafb.h>
 
 #include <asm/hardware/scoop.h>
 #include <asm/hardware/locomo.h>
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 4726c246d..8047ee0 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -30,7 +30,7 @@
 #include <mach/irqs.h>
 #include <mach/pxa27x.h>
 #include <mach/reset.h>
-#include <mach/ohci.h>
+#include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <mach/pm.h>
 #include <mach/dma.h>
 #include <mach/smemc.h>
diff --git a/arch/arm/mach-pxa/pxa2xx.c b/arch/arm/mach-pxa/pxa2xx.c
index f8ec854..447dcbb 100644
--- a/arch/arm/mach-pxa/pxa2xx.c
+++ b/arch/arm/mach-pxa/pxa2xx.c
@@ -19,7 +19,7 @@
 #include <mach/pxa2xx-regs.h>
 #include <mach/mfp-pxa25x.h>
 #include <mach/reset.h>
-#include <mach/irda.h>
+#include <linux/platform_data/irda-pxaficp.h>
 
 void pxa2xx_clear_reset_status(unsigned int mask)
 {
diff --git a/arch/arm/mach-pxa/pxa3xx-ulpi.c b/arch/arm/mach-pxa/pxa3xx-ulpi.c
index 5ead6d4..7dbe3cc 100644
--- a/arch/arm/mach-pxa/pxa3xx-ulpi.c
+++ b/arch/arm/mach-pxa/pxa3xx-ulpi.c
@@ -27,7 +27,7 @@
 
 #include <mach/hardware.h>
 #include <mach/regs-u2d.h>
-#include <mach/pxa3xx-u2d.h>
+#include <linux/platform_data/usb-pxa3xx-ulpi.h>
 
 struct pxa3xx_u2d_ulpi {
 	struct clk		*clk;
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index dffb7e8..f65147c 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -27,7 +27,7 @@
 #include <mach/hardware.h>
 #include <mach/pxa3xx-regs.h>
 #include <mach/reset.h>
-#include <mach/ohci.h>
+#include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <mach/pm.h>
 #include <mach/dma.h>
 #include <mach/smemc.h>
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index d89d87ae..25b08bf 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -49,10 +49,10 @@
 #include <asm/mach/arch.h>
 
 #include <mach/pxa300.h>
-#include <mach/ohci.h>
-#include <mach/pxafb.h>
-#include <mach/mmc.h>
-#include <plat/pxa3xx_nand.h>
+#include <linux/platform_data/usb-ohci-pxa27x.h>
+#include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/mmc-pxamci.h>
+#include <linux/platform_data/mtd-nand-pxa3xx.h>
 
 #include "generic.h"
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/saar.c b/arch/arm/mach-pxa/saar.c
index 86c95a5..08d87a5 100644
--- a/arch/arm/mach-pxa/saar.c
+++ b/arch/arm/mach-pxa/saar.c
@@ -32,7 +32,7 @@
 #include <asm/mach/flash.h>
 
 #include <mach/pxa930.h>
-#include <mach/pxafb.h>
+#include <linux/platform_data/video-pxafb.h>
 
 #include "devices.h"
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 363d91b..2073f0e 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -41,10 +41,10 @@
 #include <mach/pxa27x.h>
 #include <mach/pxa27x-udc.h>
 #include <mach/reset.h>
-#include <mach/irda.h>
-#include <mach/mmc.h>
-#include <mach/ohci.h>
-#include <mach/pxafb.h>
+#include <linux/platform_data/irda-pxaficp.h>
+#include <linux/platform_data/mmc-pxamci.h>
+#include <linux/platform_data/usb-ohci-pxa27x.h>
+#include <linux/platform_data/video-pxafb.h>
 #include <mach/spitz.h>
 #include <mach/sharpsl_pm.h>
 #include <mach/smemc.h>
diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index 30b1b0b..08ea7a8 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -44,7 +44,7 @@
 #include <asm/mach/flash.h>
 
 #include <mach/pxa27x.h>
-#include <mach/mmc.h>
+#include <linux/platform_data/mmc-pxamci.h>
 #include <mach/udc.h>
 #include <mach/pxa27x-udc.h>
 #include <mach/smemc.h>
diff --git a/arch/arm/mach-pxa/tavorevb.c b/arch/arm/mach-pxa/tavorevb.c
index 736bfdc..1a25f8a 100644
--- a/arch/arm/mach-pxa/tavorevb.c
+++ b/arch/arm/mach-pxa/tavorevb.c
@@ -24,8 +24,8 @@
 #include <asm/mach/arch.h>
 
 #include <mach/pxa930.h>
-#include <mach/pxafb.h>
-#include <plat/pxa27x_keypad.h>
+#include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/keypad-pxa27x.h>
 
 #include "devices.h"
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 4d4eb60..233629e 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -42,8 +42,8 @@
 
 #include <mach/pxa25x.h>
 #include <mach/reset.h>
-#include <mach/irda.h>
-#include <mach/mmc.h>
+#include <linux/platform_data/irda-pxaficp.h>
+#include <linux/platform_data/mmc-pxamci.h>
 #include <mach/udc.h>
 #include <mach/tosa_bt.h>
 #include <mach/audio.h>
diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
index 166dd32..fbbcbed 100644
--- a/arch/arm/mach-pxa/trizeps4.c
+++ b/arch/arm/mach-pxa/trizeps4.c
@@ -43,10 +43,10 @@
 #include <mach/pxa27x.h>
 #include <mach/trizeps4.h>
 #include <mach/audio.h>
-#include <mach/pxafb.h>
-#include <mach/mmc.h>
-#include <mach/irda.h>
-#include <mach/ohci.h>
+#include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/mmc-pxamci.h>
+#include <linux/platform_data/irda-pxaficp.h>
+#include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <mach/smemc.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index 130379f..392412c 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -48,9 +48,9 @@
 
 #include <mach/pxa25x.h>
 #include <mach/audio.h>
-#include <mach/pxafb.h>
+#include <linux/platform_data/video-pxafb.h>
 #include <mach/regs-uart.h>
-#include <mach/arcom-pcmcia.h>
+#include <linux/platform_data/pcmcia-pxa2xx_viper.h>
 #include <mach/viper.h>
 
 #include <asm/setup.h>
diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
index e1740ac..491b6c9 100644
--- a/arch/arm/mach-pxa/vpac270.c
+++ b/arch/arm/mach-pxa/vpac270.c
@@ -33,12 +33,12 @@
 #include <mach/pxa27x.h>
 #include <mach/audio.h>
 #include <mach/vpac270.h>
-#include <mach/mmc.h>
-#include <mach/pxafb.h>
-#include <mach/ohci.h>
+#include <linux/platform_data/mmc-pxamci.h>
+#include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <mach/pxa27x-udc.h>
 #include <mach/udc.h>
-#include <mach/pata_pxa.h>
+#include <linux/platform_data/ata-pxa.h>
 
 #include "generic.h"
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index b9320cb..97529fa 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -37,9 +37,9 @@
 #include <mach/pxa27x.h>
 #include <mach/mfp-pxa27x.h>
 #include <mach/z2.h>
-#include <mach/pxafb.h>
-#include <mach/mmc.h>
-#include <plat/pxa27x_keypad.h>
+#include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/mmc-pxamci.h>
+#include <linux/platform_data/keypad-pxa27x.h>
 #include <mach/pm.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index af3d4f7..abd3aa1 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -38,14 +38,14 @@
 
 #include <mach/pxa27x.h>
 #include <mach/regs-uart.h>
-#include <mach/ohci.h>
-#include <mach/mmc.h>
+#include <linux/platform_data/usb-ohci-pxa27x.h>
+#include <linux/platform_data/mmc-pxamci.h>
 #include <mach/pxa27x-udc.h>
 #include <mach/udc.h>
-#include <mach/pxafb.h>
+#include <linux/platform_data/video-pxafb.h>
 #include <mach/pm.h>
 #include <mach/audio.h>
-#include <mach/arcom-pcmcia.h>
+#include <linux/platform_data/pcmcia-pxa2xx_viper.h>
 #include <mach/zeus.h>
 #include <mach/smemc.h>
 
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index 98eec80..226279f 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -26,12 +26,12 @@
 #include <asm/mach/arch.h>
 #include <mach/pxa3xx.h>
 #include <mach/audio.h>
-#include <mach/pxafb.h>
+#include <linux/platform_data/video-pxafb.h>
 #include <mach/zylonite.h>
-#include <mach/mmc.h>
-#include <mach/ohci.h>
-#include <plat/pxa27x_keypad.h>
-#include <plat/pxa3xx_nand.h>
+#include <linux/platform_data/mmc-pxamci.h>
+#include <linux/platform_data/usb-ohci-pxa27x.h>
+#include <linux/platform_data/keypad-pxa27x.h>
+#include <linux/platform_data/mtd-nand-pxa3xx.h>
 
 #include "devices.h"
 #include "generic.h"
diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index 0bb0fb7..4b8ba55 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -32,7 +32,7 @@
 #include <scsi/scsi_host.h>
 
 #include <mach/pxa2xx-regs.h>
-#include <mach/pata_pxa.h>
+#include <linux/platform_data/ata-pxa.h>
 #include <mach/dma.h>
 
 #define DRV_NAME	"pata_pxa"
diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index 8a15cf2..07fa486 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -19,7 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/device.h>
 #include <mach/regs-icu.h>
-#include <mach/sram.h>
+#include <linux/platform_data/dma-mmp_tdma.h>
 
 #include "dmaengine.h"
 
diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index 7f7b724..803ff6f 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -32,7 +32,7 @@
 #include <asm/mach/map.h>
 
 #include <mach/hardware.h>
-#include <plat/pxa27x_keypad.h>
+#include <linux/platform_data/keypad-pxa27x.h>
 /*
  * Keypad Controller registers
  */
diff --git a/drivers/input/keyboard/pxa930_rotary.c b/drivers/input/keyboard/pxa930_rotary.c
index d7f1134..41488f9 100644
--- a/drivers/input/keyboard/pxa930_rotary.c
+++ b/drivers/input/keyboard/pxa930_rotary.c
@@ -15,7 +15,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 
-#include <mach/pxa930_rotary.h>
+#include <linux/platform_data/keyboard-pxa930_rotary.h>
 
 #define SBCR	(0x04)
 #define ERCR	(0x0c)
diff --git a/drivers/input/mouse/pxa930_trkball.c b/drivers/input/mouse/pxa930_trkball.c
index a9e4bfd..4fe055f 100644
--- a/drivers/input/mouse/pxa930_trkball.c
+++ b/drivers/input/mouse/pxa930_trkball.c
@@ -20,7 +20,7 @@
 #include <linux/slab.h>
 
 #include <mach/hardware.h>
-#include <mach/pxa930_trkball.h>
+#include <linux/platform_data/mouse-pxa930_trkball.h>
 
 /* Trackball Controller Register Definitions */
 #define TBCR		(0x000C)
diff --git a/drivers/media/video/pxa_camera.c b/drivers/media/video/pxa_camera.c
index 9c21e01..1e3776d 100644
--- a/drivers/media/video/pxa_camera.c
+++ b/drivers/media/video/pxa_camera.c
@@ -37,7 +37,7 @@
 #include <linux/videodev2.h>
 
 #include <mach/dma.h>
-#include <mach/camera.h>
+#include <linux/platform_data/camera-pxa.h>
 
 #define PXA_CAM_VERSION "0.0.6"
 #define PXA_CAM_DRV_NAME "pxa27x-camera"
diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index cb2dc0e..ca3915d 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -35,7 +35,7 @@
 
 #include <mach/hardware.h>
 #include <mach/dma.h>
-#include <mach/mmc.h>
+#include <linux/platform_data/mmc-pxamci.h>
 
 #include "pxamci.h"
 
diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 252aaef..c53502f 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -24,7 +24,7 @@
 #include <linux/slab.h>
 
 #include <mach/dma.h>
-#include <plat/pxa3xx_nand.h>
+#include <linux/platform_data/mtd-nand-pxa3xx.h>
 
 #define	CHIP_DELAY_TIMEOUT	(2 * HZ/10)
 #define NAND_STOP_DELAY		(2 * HZ/50)
diff --git a/drivers/net/irda/pxaficp_ir.c b/drivers/net/irda/pxaficp_ir.c
index 8d54767..aa4b947 100644
--- a/drivers/net/irda/pxaficp_ir.c
+++ b/drivers/net/irda/pxaficp_ir.c
@@ -28,7 +28,7 @@
 #include <net/irda/irda_device.h>
 
 #include <mach/dma.h>
-#include <mach/irda.h>
+#include <linux/platform_data/irda-pxaficp.h>
 #include <mach/regs-uart.h>
 #include <mach/regs-ost.h>
 
diff --git a/drivers/pcmcia/pxa2xx_viper.c b/drivers/pcmcia/pxa2xx_viper.c
index cb0c37e..a76f495 100644
--- a/drivers/pcmcia/pxa2xx_viper.c
+++ b/drivers/pcmcia/pxa2xx_viper.c
@@ -25,7 +25,7 @@
 
 #include <asm/irq.h>
 
-#include <mach/arcom-pcmcia.h>
+#include <linux/platform_data/pcmcia-pxa2xx_viper.h>
 
 #include "soc_common.h"
 #include "pxa2xx_base.h"
diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
index e1a3cc6..955c410 100644
--- a/drivers/usb/host/ohci-pxa27x.c
+++ b/drivers/usb/host/ohci-pxa27x.c
@@ -24,8 +24,8 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <mach/hardware.h>
-#include <mach/ohci.h>
-#include <mach/pxa3xx-u2d.h>
+#include <linux/platform_data/usb-ohci-pxa27x.h>
+#include <linux/platform_data/usb-pxa3xx-ulpi.h>
 
 /*
  * UHC: USB Host Controller (OHCI-like) register definitions
diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 3f90255..4fa2ad4 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -61,7 +61,7 @@
 #include <asm/irq.h>
 #include <asm/div64.h>
 #include <mach/bitfield.h>
-#include <mach/pxafb.h>
+#include <linux/platform_data/video-pxafb.h>
 
 /*
  * Complain if VAR is out of range.
diff --git a/arch/arm/mach-pxa/include/mach/palmasoc.h b/include/linux/platform_data/asoc-palm27x.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/palmasoc.h
rename to include/linux/platform_data/asoc-palm27x.h
diff --git a/arch/arm/mach-pxa/include/mach/pata_pxa.h b/include/linux/platform_data/ata-pxa.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/pata_pxa.h
rename to include/linux/platform_data/ata-pxa.h
diff --git a/arch/arm/mach-pxa/include/mach/camera.h b/include/linux/platform_data/camera-pxa.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/camera.h
rename to include/linux/platform_data/camera-pxa.h
diff --git a/arch/arm/mach-mmp/include/mach/sram.h b/include/linux/platform_data/dma-mmp_tdma.h
similarity index 100%
rename from arch/arm/mach-mmp/include/mach/sram.h
rename to include/linux/platform_data/dma-mmp_tdma.h
diff --git a/arch/arm/mach-pxa/include/mach/irda.h b/include/linux/platform_data/irda-pxaficp.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/irda.h
rename to include/linux/platform_data/irda-pxaficp.h
diff --git a/arch/arm/mach-pxa/include/mach/pxa930_rotary.h b/include/linux/platform_data/keyboard-pxa930_rotary.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/pxa930_rotary.h
rename to include/linux/platform_data/keyboard-pxa930_rotary.h
diff --git a/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h b/include/linux/platform_data/keypad-pxa27x.h
similarity index 100%
rename from arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
rename to include/linux/platform_data/keypad-pxa27x.h
diff --git a/arch/arm/mach-pxa/include/mach/mmc.h b/include/linux/platform_data/mmc-pxamci.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/mmc.h
rename to include/linux/platform_data/mmc-pxamci.h
diff --git a/arch/arm/mach-pxa/include/mach/pxa930_trkball.h b/include/linux/platform_data/mouse-pxa930_trkball.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/pxa930_trkball.h
rename to include/linux/platform_data/mouse-pxa930_trkball.h
diff --git a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h b/include/linux/platform_data/mtd-nand-pxa3xx.h
similarity index 100%
rename from arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
rename to include/linux/platform_data/mtd-nand-pxa3xx.h
diff --git a/arch/arm/mach-pxa/include/mach/arcom-pcmcia.h b/include/linux/platform_data/pcmcia-pxa2xx_viper.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/arcom-pcmcia.h
rename to include/linux/platform_data/pcmcia-pxa2xx_viper.h
diff --git a/arch/arm/mach-pxa/include/mach/ohci.h b/include/linux/platform_data/usb-ohci-pxa27x.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/ohci.h
rename to include/linux/platform_data/usb-ohci-pxa27x.h
diff --git a/arch/arm/mach-pxa/include/mach/pxa3xx-u2d.h b/include/linux/platform_data/usb-pxa3xx-ulpi.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/pxa3xx-u2d.h
rename to include/linux/platform_data/usb-pxa3xx-ulpi.h
diff --git a/arch/arm/mach-pxa/include/mach/pxafb.h b/include/linux/platform_data/video-pxafb.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/pxafb.h
rename to include/linux/platform_data/video-pxafb.h
diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index db24bc6..aa3da91 100644
--- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -25,7 +25,7 @@
 
 #include <asm/mach-types.h>
 #include <mach/audio.h>
-#include <mach/palmasoc.h>
+#include <linux/platform_data/asoc-palm27x.h>
 
 #include "../codecs/wm9712.h"
 #include "pxa2xx-ac97.h"
-- 
1.7.10
