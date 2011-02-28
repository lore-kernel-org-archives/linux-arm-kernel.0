From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 28 Feb 2011 18:04:34 +0100
Subject: [PATCH 2/2] ARM: imx: remove #includes already available from
	devices-common.h
In-Reply-To: <1298912674-15153-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1298912674-15153-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1298912674-15153-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most machine files include "devices-imxXX.h" which in turn includes
<mach/devices-common.h>.  The latter already includes many headers
that the machine files don't need to include again.

These were found by:

 $ grep \#include arch/arm/plat-mxc/include/mach/devices-common.h > tmpfile
 $ git grep -l 'devices-imx' arch/arm | xargs grep -f tmpfile -F

(but I kept linux/init.h, linux/kernel.h and linux/platform_device.h)

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c   |    1 -
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c |    1 -
 arch/arm/mach-imx/mach-cpuimx27.c              |    1 -
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c       |    2 --
 arch/arm/mach-imx/mach-mx1ads.c                |    1 -
 arch/arm/mach-imx/mach-mx21ads.c               |    1 -
 arch/arm/mach-imx/mach-mx25_3ds.c              |    1 -
 arch/arm/mach-imx/mach-mx27ads.c               |    1 -
 arch/arm/mach-imx/mach-mxt_td60.c              |    1 -
 arch/arm/mach-imx/mach-pca100.c                |    1 -
 arch/arm/mach-imx/mach-pcm038.c                |    1 -
 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c   |    1 -
 arch/arm/mach-mx3/mach-cpuimx35.c              |    1 -
 arch/arm/mach-mx3/mach-mx31moboard.c           |    1 -
 arch/arm/mach-mx3/mach-pcm037_eet.c            |    1 -
 arch/arm/mach-mx3/mx31moboard-marxbot.c        |    1 -
 arch/arm/mach-mx5/board-cpuimx51.c             |    2 --
 arch/arm/mach-mx5/board-cpuimx51sd.c           |    2 --
 arch/arm/mach-mx5/board-mx51_babbage.c         |    4 ----
 arch/arm/mach-mx5/board-mx51_efikamx.c         |    3 ---
 arch/arm/mach-mx5/board-mx53_evk.c             |    2 --
 arch/arm/mach-mx5/board-mx53_loco.c            |    2 --
 arch/arm/mach-mx5/board-mx53_smd.c             |    2 --
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c   |    2 --
 arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c   |    1 -
 25 files changed, 0 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index d12815d..cc8a2ff 100644
--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
@@ -32,7 +32,6 @@
 #include <mach/common.h>
 #include <mach/iomux-mx27.h>
 #include <mach/hardware.h>
-#include <mach/spi.h>
 #include <mach/audmux.h>
 
 #include "devices-imx27.h"
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
index 3745e50..71d0fe6 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
@@ -31,7 +31,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/mx25.h>
-#include <mach/imx-uart.h>
 #include <mach/audmux.h>
 
 #include "devices-imx25.h"
diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index 6cf04da..bb302f3 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -38,7 +38,6 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx27.h>
-#include <mach/mxc_nand.h>
 #include <mach/ulpi.h>
 
 #include "devices-imx27.h"
diff --git a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
index eb395ab..9122aba 100644
--- a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
+++ b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
@@ -36,8 +36,6 @@
 #include <asm/mach/map.h>
 #include <mach/common.h>
 #include <mach/mx25.h>
-#include <mach/mxc_nand.h>
-#include <mach/imxfb.h>
 #include <mach/iomux-mx25.h>
 
 #include "devices-imx25.h"
diff --git a/arch/arm/mach-imx/mach-mx1ads.c b/arch/arm/mach-imx/mach-mx1ads.c
index 1f446e5..832e87c 100644
--- a/arch/arm/mach-imx/mach-mx1ads.c
+++ b/arch/arm/mach-imx/mach-mx1ads.c
@@ -25,7 +25,6 @@
 
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/i2c.h>
 #include <mach/iomux-mx1.h>
 #include <mach/irqs.h>
 
diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
index 0a37257..36483b8 100644
--- a/arch/arm/mach-imx/mach-mx21ads.c
+++ b/arch/arm/mach-imx/mach-mx21ads.c
@@ -25,7 +25,6 @@
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
 #include <mach/iomux-mx21.h>
-#include <mach/mxc_nand.h>
 
 #include "devices-imx21.h"
 
diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c b/arch/arm/mach-imx/mach-mx25_3ds.c
index 8382e79..0c635d2 100644
--- a/arch/arm/mach-imx/mach-mx25_3ds.c
+++ b/arch/arm/mach-imx/mach-mx25_3ds.c
@@ -29,7 +29,6 @@
 #include <linux/irq.h>
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
-#include <linux/input/matrix_keypad.h>
 #include <linux/usb/otg.h>
 
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index b832f96..65645ee 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -29,7 +29,6 @@
 #include <asm/mach/map.h>
 #include <mach/gpio.h>
 #include <mach/iomux-mx27.h>
-#include <mach/mxc_nand.h>
 
 #include "devices-imx27.h"
 
diff --git a/arch/arm/mach-imx/mach-mxt_td60.c b/arch/arm/mach-imx/mach-mxt_td60.c
index 4ce71b0..719936f 100644
--- a/arch/arm/mach-imx/mach-mxt_td60.c
+++ b/arch/arm/mach-imx/mach-mxt_td60.c
@@ -29,7 +29,6 @@
 #include <asm/mach/map.h>
 #include <linux/gpio.h>
 #include <mach/iomux-mx27.h>
-#include <mach/mxc_nand.h>
 #include <linux/i2c/pca953x.h>
 
 #include "devices-imx27.h"
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index cccc0a0..354094f 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -37,7 +37,6 @@
 #include <mach/iomux-mx27.h>
 #include <asm/mach/time.h>
 #include <mach/audmux.h>
-#include <mach/mxc_nand.h>
 #include <mach/irqs.h>
 #include <mach/ulpi.h>
 
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index ca20117..ff09b5d 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -36,7 +36,6 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx27.h>
-#include <mach/mxc_nand.h>
 #include <mach/ulpi.h>
 
 #include "devices-imx27.h"
diff --git a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
index 0d3f4b5..5e28208 100644
--- a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
@@ -37,7 +37,6 @@
 
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx35.h>
 #include <mach/ipu.h>
 #include <mach/mx3fb.h>
diff --git a/arch/arm/mach-mx3/mach-cpuimx35.c b/arch/arm/mach-mx3/mach-cpuimx35.c
index 26ae90f..81436de 100644
--- a/arch/arm/mach-mx3/mach-cpuimx35.c
+++ b/arch/arm/mach-mx3/mach-cpuimx35.c
@@ -41,7 +41,6 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/iomux-mx35.h>
-#include <mach/mxc_nand.h>
 
 #include "devices-imx35.h"
 #include "devices.h"
diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
index 8fcf991..80764b3 100644
--- a/arch/arm/mach-mx3/mach-mx31moboard.c
+++ b/arch/arm/mach-mx3/mach-mx31moboard.c
@@ -41,7 +41,6 @@
 #include <mach/iomux-mx3.h>
 #include <mach/ipu.h>
 #include <mach/mx3_camera.h>
-#include <mach/spi.h>
 #include <mach/ulpi.h>
 
 #include "devices-imx31.h"
diff --git a/arch/arm/mach-mx3/mach-pcm037_eet.c b/arch/arm/mach-mx3/mach-pcm037_eet.c
index e5756d4..f2be3ae 100644
--- a/arch/arm/mach-mx3/mach-pcm037_eet.c
+++ b/arch/arm/mach-mx3/mach-pcm037_eet.c
@@ -13,7 +13,6 @@
 
 #include <mach/common.h>
 #include <mach/iomux-mx3.h>
-#include <mach/spi.h>
 
 #include <asm/mach-types.h>
 
diff --git a/arch/arm/mach-mx3/mx31moboard-marxbot.c b/arch/arm/mach-mx3/mx31moboard-marxbot.c
index f449a97..65b3c32 100644
--- a/arch/arm/mach-mx3/mx31moboard-marxbot.c
+++ b/arch/arm/mach-mx3/mx31moboard-marxbot.c
@@ -26,7 +26,6 @@
 
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 #include <mach/ulpi.h>
 
diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
index f8652ef..7a1186c 100644
--- a/arch/arm/mach-mx5/board-cpuimx51.c
+++ b/arch/arm/mach-mx5/board-cpuimx51.c
@@ -23,13 +23,11 @@
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/fsl_devices.h>
 
 #include <mach/eukrea-baseboards.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx51.h>
-#include <mach/mxc_ehci.h>
 
 #include <asm/irq.h>
 #include <asm/setup.h>
diff --git a/arch/arm/mach-mx5/board-cpuimx51sd.c b/arch/arm/mach-mx5/board-cpuimx51sd.c
index ad93189..920b791 100644
--- a/arch/arm/mach-mx5/board-cpuimx51sd.c
+++ b/arch/arm/mach-mx5/board-cpuimx51sd.c
@@ -23,7 +23,6 @@
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/fsl_devices.h>
 #include <linux/i2c-gpio.h>
 #include <linux/spi/spi.h>
 #include <linux/can/platform/mcp251x.h>
@@ -32,7 +31,6 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx51.h>
-#include <mach/mxc_ehci.h>
 
 #include <asm/irq.h>
 #include <asm/setup.h>
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 1d231e8..a8d509f 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -16,9 +16,6 @@
 #include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/io.h>
-#include <linux/fsl_devices.h>
-#include <linux/fec.h>
-#include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
@@ -26,7 +23,6 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx51.h>
-#include <mach/mxc_ehci.h>
 
 #include <asm/irq.h>
 #include <asm/setup.h>
diff --git a/arch/arm/mach-mx5/board-mx51_efikamx.c b/arch/arm/mach-mx5/board-mx51_efikamx.c
index b7946f8..33270e1 100644
--- a/arch/arm/mach-mx5/board-mx51_efikamx.c
+++ b/arch/arm/mach-mx5/board-mx51_efikamx.c
@@ -22,15 +22,12 @@
 #include <linux/input.h>
 #include <linux/delay.h>
 #include <linux/io.h>
-#include <linux/fsl_devices.h>
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
 
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx51.h>
-#include <mach/i2c.h>
-#include <mach/mxc_ehci.h>
 
 #include <asm/irq.h>
 #include <asm/setup.h>
diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
index caee04c..ec0f02a 100644
--- a/arch/arm/mach-mx5/board-mx53_evk.c
+++ b/arch/arm/mach-mx5/board-mx53_evk.c
@@ -21,7 +21,6 @@
 
 #include <linux/init.h>
 #include <linux/clk.h>
-#include <linux/fec.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/spi/flash.h>
@@ -31,7 +30,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx53.h>
 
 #define SMD_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index d1348e0..5e55520 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -20,13 +20,11 @@
 
 #include <linux/init.h>
 #include <linux/clk.h>
-#include <linux/fec.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
 
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx53.h>
 
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-mx5/board-mx53_smd.c
index 7970f7a..262813e 100644
--- a/arch/arm/mach-mx5/board-mx53_smd.c
+++ b/arch/arm/mach-mx5/board-mx53_smd.c
@@ -20,13 +20,11 @@
 
 #include <linux/init.h>
 #include <linux/clk.h>
-#include <linux/fec.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
 
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx53.h>
 
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
index e83ffad..a608337 100644
--- a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
+++ b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
@@ -18,13 +18,11 @@
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/fsl_devices.h>
 #include <linux/i2c/tsc2007.h>
 #include <linux/leds.h>
 
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx51.h>
 
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
index 606b7b2..db81ede 100644
--- a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
@@ -37,7 +37,6 @@
 
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx51.h>
 #include <mach/audmux.h>
 
-- 
1.7.2.3
