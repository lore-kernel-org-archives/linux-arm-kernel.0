From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 20 Sep 2012 14:45:23 +0800
Subject: [PATCH v2 10/34] ARM: imx: include ulpi.h rather than mach/ulpi.h
In-Reply-To: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1348123547-31082-11-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename mach-imx/include/mach/ulpi.h to mach-imx/ulpi.h, and update
users to include ulpi.h rather than mach/ulpi.h.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/mach-armadillo5x0.c       |    3 +--
 arch/arm/mach-imx/mach-cpuimx27.c           |    2 +-
 arch/arm/mach-imx/mach-mx27_3ds.c           |    2 +-
 arch/arm/mach-imx/mach-mx31_3ds.c           |    2 +-
 arch/arm/mach-imx/mach-mx31lilly.c          |    2 +-
 arch/arm/mach-imx/mach-mx31lite.c           |    2 +-
 arch/arm/mach-imx/mach-mx31moboard.c        |    2 +-
 arch/arm/mach-imx/mach-pca100.c             |    2 +-
 arch/arm/mach-imx/mach-pcm037.c             |    2 +-
 arch/arm/mach-imx/mach-pcm038.c             |    2 +-
 arch/arm/mach-imx/mach-pcm043.c             |    2 +-
 arch/arm/mach-imx/mx31moboard-devboard.c    |    2 +-
 arch/arm/mach-imx/mx31moboard-marxbot.c     |    2 +-
 arch/arm/mach-imx/mx31moboard-smartbot.c    |    2 +-
 arch/arm/mach-imx/ulpi.c                    |    2 +-
 arch/arm/mach-imx/{include/mach => }/ulpi.h |    0
 16 files changed, 15 insertions(+), 16 deletions(-)
 rename arch/arm/mach-imx/{include/mach => }/ulpi.h (100%)

diff --git a/arch/arm/mach-imx/mach-armadillo5x0.c b/arch/arm/mach-imx/mach-armadillo5x0.c
index f8421e9..ea8731f 100644
--- a/arch/arm/mach-imx/mach-armadillo5x0.c
+++ b/arch/arm/mach-imx/mach-armadillo5x0.c
@@ -48,12 +48,11 @@
 #include <asm/memory.h>
 #include <asm/mach/map.h>
 
-#include <mach/ulpi.h>
-
 #include "common.h"
 #include "devices-imx31.h"
 #include "crmregs-imx3.h"
 #include "iomux-mx3.h"
+#include "ulpi.h"
 
 static int armadillo5x0_pins[] = {
 	/* UART1 */
diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index 271528b..37571f3 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -35,12 +35,12 @@
 #include <asm/mach/map.h>
 
 #include <mach/hardware.h>
-#include <mach/ulpi.h>
 
 #include "common.h"
 #include "devices-imx27.h"
 #include "eukrea-baseboards.h"
 #include "iomux-mx27.h"
+#include "ulpi.h"
 
 static const int eukrea_cpuimx27_pins[] __initconst = {
 	/* UART1 */
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index f75980e..43df9a9 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -37,12 +37,12 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <mach/hardware.h>
-#include <mach/ulpi.h>
 
 #include "3ds_debugboard.h"
 #include "common.h"
 #include "devices-imx27.h"
 #include "iomux-mx27.h"
+#include "ulpi.h"
 
 #define SD1_EN_GPIO		IMX_GPIO_NR(2, 25)
 #define OTG_PHY_RESET_GPIO	IMX_GPIO_NR(2, 23)
diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index ee6a3f3..5377c88 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -37,12 +37,12 @@
 #include <asm/memory.h>
 #include <asm/mach/map.h>
 #include <asm/memblock.h>
-#include <mach/ulpi.h>
 
 #include "3ds_debugboard.h"
 #include "common.h"
 #include "devices-imx31.h"
 #include "iomux-mx3.h"
+#include "ulpi.h"
 
 static int mx31_3ds_pins[] = {
 	/* UART1 */
diff --git a/arch/arm/mach-imx/mach-mx31lilly.c b/arch/arm/mach-imx/mach-mx31lilly.c
index 15d26a0..74b5fa9 100644
--- a/arch/arm/mach-imx/mach-mx31lilly.c
+++ b/arch/arm/mach-imx/mach-mx31lilly.c
@@ -43,12 +43,12 @@
 #include <asm/mach/map.h>
 
 #include <mach/hardware.h>
-#include <mach/ulpi.h>
 
 #include "board-mx31lilly.h"
 #include "common.h"
 #include "devices-imx31.h"
 #include "iomux-mx3.h"
+#include "ulpi.h"
 
 /*
  * This file contains module-specific initialization routines for LILLY-1131.
diff --git a/arch/arm/mach-imx/mach-mx31lite.c b/arch/arm/mach-imx/mach-mx31lite.c
index c5f8665..904aa63 100644
--- a/arch/arm/mach-imx/mach-mx31lite.c
+++ b/arch/arm/mach-imx/mach-mx31lite.c
@@ -40,12 +40,12 @@
 #include <asm/setup.h>
 
 #include <mach/hardware.h>
-#include <mach/ulpi.h>
 
 #include "board-mx31lite.h"
 #include "common.h"
 #include "devices-imx31.h"
 #include "iomux-mx3.h"
+#include "ulpi.h"
 
 /*
  * This file contains the module-specific initialization routines.
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index 955275b..e719c76 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -43,13 +43,13 @@
 #include <asm/mach/map.h>
 #include <asm/memblock.h>
 #include <mach/hardware.h>
-#include <mach/ulpi.h>
 #include <linux/platform_data/asoc-imx-ssi.h>
 
 #include "board-mx31moboard.h"
 #include "common.h"
 #include "devices-imx31.h"
 #include "iomux-mx3.h"
+#include "ulpi.h"
 
 static unsigned int moboard_pins[] = {
 	/* UART0 */
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index 826d326bd..743d7e9 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -34,11 +34,11 @@
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 #include <asm/mach/time.h>
-#include <mach/ulpi.h>
 
 #include "common.h"
 #include "devices-imx27.h"
 #include "iomux-mx27.h"
+#include "ulpi.h"
 
 #define OTG_PHY_CS_GPIO (GPIO_PORTB + 23)
 #define USBH2_PHY_CS_GPIO (GPIO_PORTB + 24)
diff --git a/arch/arm/mach-imx/mach-pcm037.c b/arch/arm/mach-imx/mach-pcm037.c
index 59d2274..525f057 100644
--- a/arch/arm/mach-imx/mach-pcm037.c
+++ b/arch/arm/mach-imx/mach-pcm037.c
@@ -43,12 +43,12 @@
 #include <asm/mach/map.h>
 #include <asm/memblock.h>
 #include <mach/hardware.h>
-#include <mach/ulpi.h>
 
 #include "common.h"
 #include "devices-imx31.h"
 #include "iomux-mx3.h"
 #include "pcm037.h"
+#include "ulpi.h"
 
 static enum pcm037_board_variant pcm037_instance = PCM037_PCM970;
 
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index 9ebc248..4a52340 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -34,12 +34,12 @@
 #include <asm/mach/time.h>
 
 #include <mach/hardware.h>
-#include <mach/ulpi.h>
 
 #include "board-pcm038.h"
 #include "common.h"
 #include "devices-imx27.h"
 #include "iomux-mx27.h"
+#include "ulpi.h"
 
 static const int pcm038_pins[] __initconst = {
 	/* UART1 */
diff --git a/arch/arm/mach-imx/mach-pcm043.c b/arch/arm/mach-imx/mach-pcm043.c
index 285ac8b..54ac947 100644
--- a/arch/arm/mach-imx/mach-pcm043.c
+++ b/arch/arm/mach-imx/mach-pcm043.c
@@ -34,11 +34,11 @@
 #include <asm/mach/map.h>
 
 #include <mach/hardware.h>
-#include <mach/ulpi.h>
 
 #include "common.h"
 #include "devices-imx35.h"
 #include "iomux-mx35.h"
+#include "ulpi.h"
 
 static const struct fb_videomode fb_modedb[] = {
 	{
diff --git a/arch/arm/mach-imx/mx31moboard-devboard.c b/arch/arm/mach-imx/mx31moboard-devboard.c
index 527f173..6489afc 100644
--- a/arch/arm/mach-imx/mx31moboard-devboard.c
+++ b/arch/arm/mach-imx/mx31moboard-devboard.c
@@ -23,11 +23,11 @@
 #include <linux/usb/otg.h>
 
 #include <mach/hardware.h>
-#include <mach/ulpi.h>
 
 #include "common.h"
 #include "devices-imx31.h"
 #include "iomux-mx3.h"
+#include "ulpi.h"
 
 static unsigned int devboard_pins[] = {
 	/* UART1 */
diff --git a/arch/arm/mach-imx/mx31moboard-marxbot.c b/arch/arm/mach-imx/mx31moboard-marxbot.c
index 4679309..ea973c4 100644
--- a/arch/arm/mach-imx/mx31moboard-marxbot.c
+++ b/arch/arm/mach-imx/mx31moboard-marxbot.c
@@ -25,13 +25,13 @@
 #include <linux/usb/otg.h>
 
 #include <mach/hardware.h>
-#include <mach/ulpi.h>
 
 #include <media/soc_camera.h>
 
 #include "common.h"
 #include "devices-imx31.h"
 #include "iomux-mx3.h"
+#include "ulpi.h"
 
 static unsigned int marxbot_pins[] = {
 	/* SDHC2 */
diff --git a/arch/arm/mach-imx/mx31moboard-smartbot.c b/arch/arm/mach-imx/mx31moboard-smartbot.c
index afb4d05..807e882 100644
--- a/arch/arm/mach-imx/mx31moboard-smartbot.c
+++ b/arch/arm/mach-imx/mx31moboard-smartbot.c
@@ -24,7 +24,6 @@
 #include <linux/usb/ulpi.h>
 
 #include <mach/hardware.h>
-#include <mach/ulpi.h>
 
 #include <media/soc_camera.h>
 
@@ -32,6 +31,7 @@
 #include "common.h"
 #include "devices-imx31.h"
 #include "iomux-mx3.h"
+#include "ulpi.h"
 
 static unsigned int smartbot_pins[] = {
 	/* UART1 */
diff --git a/arch/arm/mach-imx/ulpi.c b/arch/arm/mach-imx/ulpi.c
index d296342..0f05195 100644
--- a/arch/arm/mach-imx/ulpi.c
+++ b/arch/arm/mach-imx/ulpi.c
@@ -24,7 +24,7 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
 
-#include <mach/ulpi.h>
+#include "ulpi.h"
 
 /* ULPIVIEW register bits */
 #define ULPIVW_WU		(1 << 31)	/* Wakeup */
diff --git a/arch/arm/mach-imx/include/mach/ulpi.h b/arch/arm/mach-imx/ulpi.h
similarity index 100%
rename from arch/arm/mach-imx/include/mach/ulpi.h
rename to arch/arm/mach-imx/ulpi.h
-- 
1.7.9.5
