From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Sep 2012 13:34:30 +0800
Subject: [PATCH 01/34] ARM: imx: include board headers in the same folder
In-Reply-To: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1347860103-4141-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The headers that are only used by board files do not necessarily
need to be in plat-mxc/include/mach.  Move them to the same place
as those board files.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../include/mach => mach-imx}/3ds_debugboard.h     |    0
 .../include/mach => mach-imx}/board-mx31lilly.h    |    0
 .../include/mach => mach-imx}/board-mx31lite.h     |    0
 .../include/mach => mach-imx}/board-mx31moboard.h  |    0
 .../include/mach => mach-imx}/board-pcm038.h       |    0
 .../include/mach => mach-imx}/eukrea-baseboards.h  |    0
 arch/arm/mach-imx/mach-cpuimx27.c                  |    2 +-
 arch/arm/mach-imx/mach-cpuimx35.c                  |    2 +-
 arch/arm/mach-imx/mach-cpuimx51sd.c                |    2 +-
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c           |    2 +-
 arch/arm/mach-imx/mach-mx27_3ds.c                  |    2 +-
 arch/arm/mach-imx/mach-mx31_3ds.c                  |    2 +-
 arch/arm/mach-imx/mach-mx31lilly.c                 |    2 +-
 arch/arm/mach-imx/mach-mx31lite.c                  |    2 +-
 arch/arm/mach-imx/mach-mx31moboard.c               |    2 +-
 arch/arm/mach-imx/mach-mx35_3ds.c                  |    2 +-
 arch/arm/mach-imx/mach-mx51_3ds.c                  |    2 +-
 arch/arm/mach-imx/mach-pcm038.c                    |    2 +-
 arch/arm/mach-imx/mx31lilly-db.c                   |    2 +-
 arch/arm/mach-imx/mx31lite-db.c                    |    2 +-
 arch/arm/mach-imx/mx31moboard-smartbot.c           |    2 +-
 21 files changed, 15 insertions(+), 15 deletions(-)
 rename arch/arm/{plat-mxc/include/mach => mach-imx}/3ds_debugboard.h (100%)
 rename arch/arm/{plat-mxc/include/mach => mach-imx}/board-mx31lilly.h (100%)
 rename arch/arm/{plat-mxc/include/mach => mach-imx}/board-mx31lite.h (100%)
 rename arch/arm/{plat-mxc/include/mach => mach-imx}/board-mx31moboard.h (100%)
 rename arch/arm/{plat-mxc/include/mach => mach-imx}/board-pcm038.h (100%)
 rename arch/arm/{plat-mxc/include/mach => mach-imx}/eukrea-baseboards.h (100%)

diff --git a/arch/arm/plat-mxc/include/mach/3ds_debugboard.h b/arch/arm/mach-imx/3ds_debugboard.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/3ds_debugboard.h
rename to arch/arm/mach-imx/3ds_debugboard.h
diff --git a/arch/arm/plat-mxc/include/mach/board-mx31lilly.h b/arch/arm/mach-imx/board-mx31lilly.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/board-mx31lilly.h
rename to arch/arm/mach-imx/board-mx31lilly.h
diff --git a/arch/arm/plat-mxc/include/mach/board-mx31lite.h b/arch/arm/mach-imx/board-mx31lite.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/board-mx31lite.h
rename to arch/arm/mach-imx/board-mx31lite.h
diff --git a/arch/arm/plat-mxc/include/mach/board-mx31moboard.h b/arch/arm/mach-imx/board-mx31moboard.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/board-mx31moboard.h
rename to arch/arm/mach-imx/board-mx31moboard.h
diff --git a/arch/arm/plat-mxc/include/mach/board-pcm038.h b/arch/arm/mach-imx/board-pcm038.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/board-pcm038.h
rename to arch/arm/mach-imx/board-pcm038.h
diff --git a/arch/arm/plat-mxc/include/mach/eukrea-baseboards.h b/arch/arm/mach-imx/eukrea-baseboards.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/eukrea-baseboards.h
rename to arch/arm/mach-imx/eukrea-baseboards.h
diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index 2bb9e18..1734320 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -34,13 +34,13 @@
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
 
-#include <mach/eukrea-baseboards.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx27.h>
 #include <mach/ulpi.h>
 
 #include "devices-imx27.h"
+#include "eukrea-baseboards.h"
 
 static const int eukrea_cpuimx27_pins[] __initconst = {
 	/* UART1 */
diff --git a/arch/arm/mach-imx/mach-cpuimx35.c b/arch/arm/mach-imx/mach-cpuimx35.c
index d49b0ec..0abfcb4 100644
--- a/arch/arm/mach-imx/mach-cpuimx35.c
+++ b/arch/arm/mach-imx/mach-cpuimx35.c
@@ -37,12 +37,12 @@
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
 
-#include <mach/eukrea-baseboards.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/iomux-mx35.h>
 
 #include "devices-imx35.h"
+#include "eukrea-baseboards.h"
 
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
diff --git a/arch/arm/mach-imx/mach-cpuimx51sd.c b/arch/arm/mach-imx/mach-cpuimx51sd.c
index b87cc49..6cb3887 100644
--- a/arch/arm/mach-imx/mach-cpuimx51sd.c
+++ b/arch/arm/mach-imx/mach-cpuimx51sd.c
@@ -26,7 +26,6 @@
 #include <linux/spi/spi.h>
 #include <linux/can/platform/mcp251x.h>
 
-#include <mach/eukrea-baseboards.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx51.h>
@@ -38,6 +37,7 @@
 
 #include "devices-imx51.h"
 #include "cpu_op-mx51.h"
+#include "eukrea-baseboards.h"
 
 #define USBH1_RST		IMX_GPIO_NR(2, 28)
 #define ETH_RST			IMX_GPIO_NR(2, 31)
diff --git a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
index 017bbb70..4eab1d7 100644
--- a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
+++ b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
@@ -27,7 +27,6 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
 
-#include <mach/eukrea-baseboards.h>
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -39,6 +38,7 @@
 #include <mach/iomux-mx25.h>
 
 #include "devices-imx25.h"
+#include "eukrea-baseboards.h"
 
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 05996f3..c69df6c 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -40,8 +40,8 @@
 #include <mach/common.h>
 #include <mach/iomux-mx27.h>
 #include <mach/ulpi.h>
-#include <mach/3ds_debugboard.h>
 
+#include "3ds_debugboard.h"
 #include "devices-imx27.h"
 
 #define SD1_EN_GPIO		IMX_GPIO_NR(2, 25)
diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index 8915f93..6750443 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -39,9 +39,9 @@
 #include <asm/memblock.h>
 #include <mach/common.h>
 #include <mach/iomux-mx3.h>
-#include <mach/3ds_debugboard.h>
 #include <mach/ulpi.h>
 
+#include "3ds_debugboard.h"
 #include "devices-imx31.h"
 
 static int mx31_3ds_pins[] = {
diff --git a/arch/arm/mach-imx/mach-mx31lilly.c b/arch/arm/mach-imx/mach-mx31lilly.c
index 34b9bf0..2be500a 100644
--- a/arch/arm/mach-imx/mach-mx31lilly.c
+++ b/arch/arm/mach-imx/mach-mx31lilly.c
@@ -45,9 +45,9 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/iomux-mx3.h>
-#include <mach/board-mx31lilly.h>
 #include <mach/ulpi.h>
 
+#include "board-mx31lilly.h"
 #include "devices-imx31.h"
 
 /*
diff --git a/arch/arm/mach-imx/mach-mx31lite.c b/arch/arm/mach-imx/mach-mx31lite.c
index c8785b3..1704308 100644
--- a/arch/arm/mach-imx/mach-mx31lite.c
+++ b/arch/arm/mach-imx/mach-mx31lite.c
@@ -41,10 +41,10 @@
 
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/board-mx31lite.h>
 #include <mach/iomux-mx3.h>
 #include <mach/ulpi.h>
 
+#include "board-mx31lite.h"
 #include "devices-imx31.h"
 
 /*
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index 459e754..2290d30 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -42,13 +42,13 @@
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
 #include <asm/memblock.h>
-#include <mach/board-mx31moboard.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx3.h>
 #include <mach/ulpi.h>
 #include <linux/platform_data/asoc-imx-ssi.h>
 
+#include "board-mx31moboard.h"
 #include "devices-imx31.h"
 
 static unsigned int moboard_pins[] = {
diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
index 504983c..aac59b0 100644
--- a/arch/arm/mach-imx/mach-mx35_3ds.c
+++ b/arch/arm/mach-imx/mach-mx35_3ds.c
@@ -46,11 +46,11 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/iomux-mx35.h>
-#include <mach/3ds_debugboard.h>
 #include <video/platform_lcd.h>
 
 #include <media/soc_camera.h>
 
+#include "3ds_debugboard.h"
 #include "devices-imx35.h"
 
 #define GPIO_MC9S08DZ60_GPS_ENABLE 0
diff --git a/arch/arm/mach-imx/mach-mx51_3ds.c b/arch/arm/mach-imx/mach-mx51_3ds.c
index 9ee84a4..4e84f80 100644
--- a/arch/arm/mach-imx/mach-mx51_3ds.c
+++ b/arch/arm/mach-imx/mach-mx51_3ds.c
@@ -22,8 +22,8 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/iomux-mx51.h>
-#include <mach/3ds_debugboard.h>
 
+#include "3ds_debugboard.h"
 #include "devices-imx51.h"
 
 #define MX51_3DS_ECSPI2_CS	(GPIO_PORTC + 28)
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index 95f49d93..ad329d5 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -33,12 +33,12 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 
-#include <mach/board-pcm038.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx27.h>
 #include <mach/ulpi.h>
 
+#include "board-pcm038.h"
 #include "devices-imx27.h"
 
 static const int pcm038_pins[] __initconst = {
diff --git a/arch/arm/mach-imx/mx31lilly-db.c b/arch/arm/mach-imx/mx31lilly-db.c
index 29e890f..f2acf22 100644
--- a/arch/arm/mach-imx/mx31lilly-db.c
+++ b/arch/arm/mach-imx/mx31lilly-db.c
@@ -33,8 +33,8 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/iomux-mx3.h>
-#include <mach/board-mx31lilly.h>
 
+#include "board-mx31lilly.h"
 #include "devices-imx31.h"
 
 /*
diff --git a/arch/arm/mach-imx/mx31lite-db.c b/arch/arm/mach-imx/mx31lite-db.c
index 83d17d9..fe4048d 100644
--- a/arch/arm/mach-imx/mx31lite-db.c
+++ b/arch/arm/mach-imx/mx31lite-db.c
@@ -34,8 +34,8 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/iomux-mx3.h>
-#include <mach/board-mx31lite.h>
 
+#include "board-mx31lite.h"
 #include "devices-imx31.h"
 
 /*
diff --git a/arch/arm/mach-imx/mx31moboard-smartbot.c b/arch/arm/mach-imx/mx31moboard-smartbot.c
index fabb801..fc8d178 100644
--- a/arch/arm/mach-imx/mx31moboard-smartbot.c
+++ b/arch/arm/mach-imx/mx31moboard-smartbot.c
@@ -26,11 +26,11 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx3.h>
-#include <mach/board-mx31moboard.h>
 #include <mach/ulpi.h>
 
 #include <media/soc_camera.h>
 
+#include "board-mx31moboard.h"
 #include "devices-imx31.h"
 
 static unsigned int smartbot_pins[] = {
-- 
1.7.9.5
