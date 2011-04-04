From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  4 Apr 2011 16:25:29 +0200
Subject: [PATCH v2] ARM: imx: remove #includes already available from
	devices-common.h
In-Reply-To: <1298912674-15153-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1298912674-15153-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1301927129-20797-1-git-send-email-u.kleine-koenig@pengutronix.de>
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
changes since v1:
 - fix new hits from above script:
	arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c:#include <mach/esdhc.h>
	arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c:#include <mach/esdhc.h>
	arch/arm/mach-mx3/mach-bug.c:#include <mach/imx-uart.h>
	arch/arm/mach-mx3/mach-mx31_3ds.c:#include <mach/mmc.h>
	arch/arm/mach-mx3/mach-pcm043.c:#include <mach/esdhc.h>
	arch/arm/mach-mx3/mach-vpr200.c:#include <linux/gpio_keys.h>
	arch/arm/mach-mx5/board-mx50_rdp.c:#include <linux/fsl_devices.h>
	arch/arm/mach-mx5/board-mx51_efikasb.c:#include <linux/fsl_devices.h>
	arch/arm/mach-mx5/board-mx51_efikasb.c:#include <mach/i2c.h>
	arch/arm/mach-mx5/board-mx51_efikasb.c:#include <mach/mxc_ehci.h>
	arch/arm/mach-mx5/mx51_efika.c:#include <linux/fsl_devices.h>
	arch/arm/mach-mx5/mx51_efika.c:#include <mach/i2c.h>
	arch/arm/mach-mx5/mx51_efika.c:#include <mach/mxc_ehci.h>

 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c   |    1 -
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c |    2 --
 arch/arm/mach-imx/mach-cpuimx27.c              |    1 -
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c       |    2 --
 arch/arm/mach-imx/mach-mx1ads.c                |    1 -
 arch/arm/mach-imx/mach-mx21ads.c               |    1 -
 arch/arm/mach-imx/mach-mx25_3ds.c              |    1 -
 arch/arm/mach-imx/mach-mx27ads.c               |    1 -
 arch/arm/mach-imx/mach-mxt_td60.c              |    1 -
 arch/arm/mach-imx/mach-pca100.c                |    1 -
 arch/arm/mach-imx/mach-pcm038.c                |    1 -
 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c   |    2 --
 arch/arm/mach-mx3/mach-bug.c                   |    1 -
 arch/arm/mach-mx3/mach-cpuimx35.c              |    1 -
 arch/arm/mach-mx3/mach-mx31_3ds.c              |    1 -
 arch/arm/mach-mx3/mach-mx31moboard.c           |    1 -
 arch/arm/mach-mx3/mach-pcm037_eet.c            |    1 -
 arch/arm/mach-mx3/mach-pcm043.c                |    1 -
 arch/arm/mach-mx3/mach-vpr200.c                |    1 -
 arch/arm/mach-mx3/mx31moboard-marxbot.c        |    1 -
 arch/arm/mach-mx5/board-cpuimx51.c             |    2 --
 arch/arm/mach-mx5/board-cpuimx51sd.c           |    2 --
 arch/arm/mach-mx5/board-mx50_rdp.c             |    1 -
 arch/arm/mach-mx5/board-mx51_babbage.c         |    4 ----
 arch/arm/mach-mx5/board-mx51_efikamx.c         |    3 ---
 arch/arm/mach-mx5/board-mx51_efikasb.c         |    3 ---
 arch/arm/mach-mx5/board-mx53_evk.c             |    2 --
 arch/arm/mach-mx5/board-mx53_loco.c            |    2 --
 arch/arm/mach-mx5/board-mx53_smd.c             |    2 --
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c   |    2 --
 arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c   |    1 -
 arch/arm/mach-mx5/mx51_efika.c                 |    3 ---
 32 files changed, 0 insertions(+), 50 deletions(-)

diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index fa5288018..5911281 100644
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
index 176e61b..f9ef04a 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
@@ -31,9 +31,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/mx25.h>
-#include <mach/imx-uart.h>
 #include <mach/audmux.h>
-#include <mach/esdhc.h>
 
 #include "devices-imx25.h"
 
diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index 759299b..46a2e41 100644
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
index 9da8d18..148cff2 100644
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
index 47cf56a..38ec5cb 100644
--- a/arch/arm/mach-imx/mach-mx1ads.c
+++ b/arch/arm/mach-imx/mach-mx1ads.c
@@ -25,7 +25,6 @@
 
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/i2c.h>
 #include <mach/iomux-mx1.h>
 #include <mach/irqs.h>
 
diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
index fa52a10..74ac889 100644
--- a/arch/arm/mach-imx/mach-mx21ads.c
+++ b/arch/arm/mach-imx/mach-mx21ads.c
@@ -25,7 +25,6 @@
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
 #include <mach/iomux-mx21.h>
-#include <mach/mxc_nand.h>
 
 #include "devices-imx21.h"
 
diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c b/arch/arm/mach-imx/mach-mx25_3ds.c
index 378f433..58ea3fd 100644
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
index 367d1e4..1db7950 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -29,7 +29,6 @@
 #include <asm/mach/map.h>
 #include <mach/gpio.h>
 #include <mach/iomux-mx27.h>
-#include <mach/mxc_nand.h>
 
 #include "devices-imx27.h"
 
diff --git a/arch/arm/mach-imx/mach-mxt_td60.c b/arch/arm/mach-imx/mach-mxt_td60.c
index 69787c3..2774541 100644
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
index 63e1825..bbddc5a 100644
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
index 4cbce6d..853bb87 100644
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
index 63981ca..f61b2a9 100644
--- a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
@@ -37,12 +37,10 @@
 
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx35.h>
 #include <mach/ipu.h>
 #include <mach/mx3fb.h>
 #include <mach/audmux.h>
-#include <mach/esdhc.h>
 
 #include "devices-imx35.h"
 #include "devices.h"
diff --git a/arch/arm/mach-mx3/mach-bug.c b/arch/arm/mach-mx3/mach-bug.c
index d137d70..42e4f07 100644
--- a/arch/arm/mach-mx3/mach-bug.c
+++ b/arch/arm/mach-mx3/mach-bug.c
@@ -20,7 +20,6 @@
 #include <linux/platform_device.h>
 
 #include <mach/iomux-mx3.h>
-#include <mach/imx-uart.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
 
diff --git a/arch/arm/mach-mx3/mach-cpuimx35.c b/arch/arm/mach-mx3/mach-cpuimx35.c
index ec63d99..ae13fd7 100644
--- a/arch/arm/mach-mx3/mach-cpuimx35.c
+++ b/arch/arm/mach-mx3/mach-cpuimx35.c
@@ -41,7 +41,6 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/iomux-mx35.h>
-#include <mach/mxc_nand.h>
 
 #include "devices-imx35.h"
 #include "devices.h"
diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 034be62..477b2d2 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -39,7 +39,6 @@
 #include <mach/iomux-mx3.h>
 #include <mach/3ds_debugboard.h>
 #include <mach/ulpi.h>
-#include <mach/mmc.h>
 #include <mach/ipu.h>
 #include <mach/mx3fb.h>
 #include <mach/mx3_camera.h>
diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
index 3a021b0..9c16314 100644
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
index 3f81e35..20861d7 100644
--- a/arch/arm/mach-mx3/mach-pcm037_eet.c
+++ b/arch/arm/mach-mx3/mach-pcm037_eet.c
@@ -13,7 +13,6 @@
 
 #include <mach/common.h>
 #include <mach/iomux-mx3.h>
-#include <mach/spi.h>
 
 #include <asm/mach-types.h>
 
diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index 036ba1a..9caf38b 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -40,7 +40,6 @@
 #include <mach/mx3fb.h>
 #include <mach/ulpi.h>
 #include <mach/audmux.h>
-#include <mach/esdhc.h>
 
 #include "devices-imx35.h"
 #include "devices.h"
diff --git a/arch/arm/mach-mx3/mach-vpr200.c b/arch/arm/mach-mx3/mach-vpr200.c
index 2cf390f..4d5ca24 100644
--- a/arch/arm/mach-mx3/mach-vpr200.c
+++ b/arch/arm/mach-mx3/mach-vpr200.c
@@ -38,7 +38,6 @@
 #include <linux/i2c.h>
 #include <linux/i2c/at24.h>
 #include <linux/mfd/mc13xxx.h>
-#include <linux/gpio_keys.h>
 
 #include "devices-imx35.h"
 #include "devices.h"
diff --git a/arch/arm/mach-mx3/mx31moboard-marxbot.c b/arch/arm/mach-mx3/mx31moboard-marxbot.c
index 57f7b00..f3aa0ce 100644
--- a/arch/arm/mach-mx3/mx31moboard-marxbot.c
+++ b/arch/arm/mach-mx3/mx31moboard-marxbot.c
@@ -26,7 +26,6 @@
 
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 #include <mach/ulpi.h>
 
diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
index d0296a9..4efa02e 100644
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
index 29b1808..5ef25a5 100644
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
diff --git a/arch/arm/mach-mx5/board-mx50_rdp.c b/arch/arm/mach-mx5/board-mx50_rdp.c
index dedf7f2..11210e1 100644
--- a/arch/arm/mach-mx5/board-mx50_rdp.c
+++ b/arch/arm/mach-mx5/board-mx50_rdp.c
@@ -23,7 +23,6 @@
 #include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/io.h>
-#include <linux/fsl_devices.h>
 
 #include <mach/common.h>
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index ab50aa9..cba59f1 100644
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
index acab191..c7c9459 100644
--- a/arch/arm/mach-mx5/board-mx51_efikamx.c
+++ b/arch/arm/mach-mx5/board-mx51_efikamx.c
@@ -22,7 +22,6 @@
 #include <linux/input.h>
 #include <linux/delay.h>
 #include <linux/io.h>
-#include <linux/fsl_devices.h>
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
 #include <linux/mfd/mc13892.h>
@@ -32,8 +31,6 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx51.h>
-#include <mach/i2c.h>
-#include <mach/mxc_ehci.h>
 
 #include <asm/irq.h>
 #include <asm/setup.h>
diff --git a/arch/arm/mach-mx5/board-mx51_efikasb.c b/arch/arm/mach-mx5/board-mx51_efikasb.c
index db04ce8..57b4d6b 100644
--- a/arch/arm/mach-mx5/board-mx51_efikasb.c
+++ b/arch/arm/mach-mx5/board-mx51_efikasb.c
@@ -22,7 +22,6 @@
 #include <linux/input.h>
 #include <linux/delay.h>
 #include <linux/io.h>
-#include <linux/fsl_devices.h>
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
 #include <linux/mfd/mc13892.h>
@@ -35,8 +34,6 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx51.h>
-#include <mach/i2c.h>
-#include <mach/mxc_ehci.h>
 
 #include <asm/irq.h>
 #include <asm/setup.h>
diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
index 2af3f43..f87d571 100644
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
 
 #define MX53_EVK_FEC_PHY_RST	IMX_GPIO_NR(7, 6)
diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 10a1bea..4487779 100644
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
index 31e1732..f3da62a 100644
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
index 4a85505..97292d2 100644
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
index 0c80b62..31c871e 100644
--- a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
@@ -37,7 +37,6 @@
 
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx51.h>
 #include <mach/audmux.h>
 
diff --git a/arch/arm/mach-mx5/mx51_efika.c b/arch/arm/mach-mx5/mx51_efika.c
index d0c7075..56739c2 100644
--- a/arch/arm/mach-mx5/mx51_efika.c
+++ b/arch/arm/mach-mx5/mx51_efika.c
@@ -20,7 +20,6 @@
 #include <linux/input.h>
 #include <linux/delay.h>
 #include <linux/io.h>
-#include <linux/fsl_devices.h>
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
 #include <linux/mfd/mc13892.h>
@@ -30,8 +29,6 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx51.h>
-#include <mach/i2c.h>
-#include <mach/mxc_ehci.h>
 
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
-- 
1.7.2.3
