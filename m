From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 20 Sep 2012 14:45:15 +0800
Subject: [PATCH v2 02/34] ARM: imx: move iomux drivers and headers into
 mach-imx
In-Reply-To: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1348123547-31082-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The board files in mach-imx are the only users of iomux drivers and
headers.  Move them into mach-imx from plat-mxc.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/Kconfig                          |    6 ++++++
 arch/arm/mach-imx/Makefile                         |    3 +++
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c       |    2 +-
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c     |    2 +-
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c     |    2 +-
 arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c     |    2 +-
 arch/arm/mach-imx/iomux-imx31.c                    |    3 ++-
 .../include/mach => mach-imx}/iomux-mx1.h          |    2 +-
 .../include/mach => mach-imx}/iomux-mx21.h         |    4 ++--
 .../include/mach => mach-imx}/iomux-mx25.h         |    2 +-
 .../include/mach => mach-imx}/iomux-mx27.h         |    4 ++--
 .../include/mach => mach-imx}/iomux-mx2x.h         |    0
 .../include/mach => mach-imx}/iomux-mx3.h          |    0
 .../include/mach => mach-imx}/iomux-mx35.h         |    2 +-
 .../include/mach => mach-imx}/iomux-mx50.h         |    2 +-
 .../include/mach => mach-imx}/iomux-mx51.h         |    2 +-
 arch/arm/{plat-mxc => mach-imx}/iomux-v1.c         |    3 ++-
 .../{plat-mxc/include/mach => mach-imx}/iomux-v1.h |    0
 arch/arm/{plat-mxc => mach-imx}/iomux-v3.c         |    3 ++-
 .../{plat-mxc/include/mach => mach-imx}/iomux-v3.h |    0
 arch/arm/mach-imx/mach-apf9328.c                   |    2 +-
 arch/arm/mach-imx/mach-armadillo5x0.c              |    2 +-
 arch/arm/mach-imx/mach-bug.c                       |    2 +-
 arch/arm/mach-imx/mach-cpuimx27.c                  |    2 +-
 arch/arm/mach-imx/mach-cpuimx35.c                  |    2 +-
 arch/arm/mach-imx/mach-cpuimx51sd.c                |    2 +-
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c           |    2 +-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c        |    2 +-
 arch/arm/mach-imx/mach-imx27ipcam.c                |    2 +-
 arch/arm/mach-imx/mach-imx27lite.c                 |    2 +-
 arch/arm/mach-imx/mach-kzm_arm11_01.c              |    2 +-
 arch/arm/mach-imx/mach-mx1ads.c                    |    2 +-
 arch/arm/mach-imx/mach-mx21ads.c                   |    2 +-
 arch/arm/mach-imx/mach-mx25_3ds.c                  |    2 +-
 arch/arm/mach-imx/mach-mx27_3ds.c                  |    2 +-
 arch/arm/mach-imx/mach-mx27ads.c                   |    2 +-
 arch/arm/mach-imx/mach-mx31_3ds.c                  |    2 +-
 arch/arm/mach-imx/mach-mx31ads.c                   |    2 +-
 arch/arm/mach-imx/mach-mx31lilly.c                 |    2 +-
 arch/arm/mach-imx/mach-mx31lite.c                  |    2 +-
 arch/arm/mach-imx/mach-mx31moboard.c               |    2 +-
 arch/arm/mach-imx/mach-mx35_3ds.c                  |    2 +-
 arch/arm/mach-imx/mach-mx50_rdp.c                  |    2 +-
 arch/arm/mach-imx/mach-mx51_3ds.c                  |    2 +-
 arch/arm/mach-imx/mach-mx51_babbage.c              |    2 +-
 arch/arm/mach-imx/mach-mxt_td60.c                  |    2 +-
 arch/arm/mach-imx/mach-pca100.c                    |    2 +-
 arch/arm/mach-imx/mach-pcm037.c                    |    2 +-
 arch/arm/mach-imx/mach-pcm037_eet.c                |    2 +-
 arch/arm/mach-imx/mach-pcm038.c                    |    2 +-
 arch/arm/mach-imx/mach-pcm043.c                    |    2 +-
 arch/arm/mach-imx/mach-qong.c                      |    2 +-
 arch/arm/mach-imx/mach-scb9328.c                   |    2 +-
 arch/arm/mach-imx/mach-vpr200.c                    |    2 +-
 arch/arm/mach-imx/mm-imx1.c                        |    3 ++-
 arch/arm/mach-imx/mm-imx21.c                       |    3 ++-
 arch/arm/mach-imx/mm-imx25.c                       |    3 ++-
 arch/arm/mach-imx/mm-imx27.c                       |    3 ++-
 arch/arm/mach-imx/mm-imx3.c                        |    2 +-
 arch/arm/mach-imx/mm-imx5.c                        |    3 ++-
 arch/arm/mach-imx/mx31lilly-db.c                   |    2 +-
 arch/arm/mach-imx/mx31lite-db.c                    |    2 +-
 arch/arm/mach-imx/mx31moboard-devboard.c           |    2 +-
 arch/arm/mach-imx/mx31moboard-marxbot.c            |    2 +-
 arch/arm/mach-imx/mx31moboard-smartbot.c           |    2 +-
 arch/arm/mach-imx/pcm970-baseboard.c               |    2 +-
 arch/arm/plat-mxc/Kconfig                          |    6 ------
 arch/arm/plat-mxc/Makefile                         |    2 --
 68 files changed, 79 insertions(+), 70 deletions(-)
 rename arch/arm/{plat-mxc/include/mach => mach-imx}/iomux-mx1.h (99%)
 rename arch/arm/{plat-mxc/include/mach => mach-imx}/iomux-mx21.h (99%)
 rename arch/arm/{plat-mxc/include/mach => mach-imx}/iomux-mx25.h (99%)
 rename arch/arm/{plat-mxc/include/mach => mach-imx}/iomux-mx27.h (99%)
 rename arch/arm/{plat-mxc/include/mach => mach-imx}/iomux-mx2x.h (100%)
 rename arch/arm/{plat-mxc/include/mach => mach-imx}/iomux-mx3.h (100%)
 rename arch/arm/{plat-mxc/include/mach => mach-imx}/iomux-mx35.h (99%)
 rename arch/arm/{plat-mxc/include/mach => mach-imx}/iomux-mx50.h (99%)
 rename arch/arm/{plat-mxc/include/mach => mach-imx}/iomux-mx51.h (99%)
 rename arch/arm/{plat-mxc => mach-imx}/iomux-v1.c (99%)
 rename arch/arm/{plat-mxc/include/mach => mach-imx}/iomux-v1.h (100%)
 rename arch/arm/{plat-mxc => mach-imx}/iomux-v3.c (98%)
 rename arch/arm/{plat-mxc/include/mach => mach-imx}/iomux-v3.h (100%)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 7ca5fe4..d34c026 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -7,6 +7,12 @@ config HAVE_IMX_MMDC
 config HAVE_IMX_SRC
 	bool
 
+config IMX_HAVE_IOMUX_V1
+	bool
+
+config ARCH_MXC_IOMUX_V3
+	bool
+
 config ARCH_MX1
 	bool
 
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 895754a..5025a9d 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -15,6 +15,9 @@ obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o mm-imx5.o clk-imx51-imx53.o ehci-imx5.o $(i
 obj-$(CONFIG_COMMON_CLK) += clk-pllv1.o clk-pllv2.o clk-pllv3.o clk-gate2.o \
 			    clk-pfd.o clk-busy.o clk.o
 
+obj-$(CONFIG_IMX_HAVE_IOMUX_V1) += iomux-v1.o
+obj-$(CONFIG_ARCH_MXC_IOMUX_V3) += iomux-v3.o
+
 # Support for CMOS sensor interface
 obj-$(CONFIG_MX1_VIDEO) += mx1-camera-fiq.o mx1-camera-fiq-ksym.o
 
diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index fd3177f..3962dcd 100644
--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
@@ -30,10 +30,10 @@
 #include <asm/mach/arch.h>
 
 #include <mach/common.h>
-#include <mach/iomux-mx27.h>
 #include <mach/hardware.h>
 
 #include "devices-imx27.h"
+#include "iomux-mx27.h"
 
 static const int eukrea_mbimx27_pins[] __initconst = {
 	/* UART2 */
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
index dfd2da8..5901f0a 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
@@ -27,13 +27,13 @@
 #include <video/platform_lcd.h>
 
 #include <mach/hardware.h>
-#include <mach/iomux-mx25.h>
 #include <mach/common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/mx25.h>
 
 #include "devices-imx25.h"
+#include "iomux-mx25.h"
 
 static iomux_v3_cfg_t eukrea_mbimxsd_pads[] = {
 	/* LCD */
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
index 6e9dd12..44e9ce5 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
@@ -38,9 +38,9 @@
 
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/iomux-mx35.h>
 
 #include "devices-imx35.h"
+#include "iomux-mx35.h"
 
 static const struct fb_videomode fb_modedb[] = {
 	{
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c
index 96a24b7..3e45726 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c
@@ -38,9 +38,9 @@
 
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/iomux-mx51.h>
 
 #include "devices-imx51.h"
+#include "iomux-mx51.h"
 
 static iomux_v3_cfg_t eukrea_mbimxsd51_pads[] = {
 	/* LED */
diff --git a/arch/arm/mach-imx/iomux-imx31.c b/arch/arm/mach-imx/iomux-imx31.c
index 82bd440..7c3ba2b 100644
--- a/arch/arm/mach-imx/iomux-imx31.c
+++ b/arch/arm/mach-imx/iomux-imx31.c
@@ -23,7 +23,8 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <mach/hardware.h>
-#include <mach/iomux-mx3.h>
+
+#include "iomux-mx3.h"
 
 /*
  * IOMUX register (base) addresses
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx1.h b/arch/arm/mach-imx/iomux-mx1.h
similarity index 99%
rename from arch/arm/plat-mxc/include/mach/iomux-mx1.h
rename to arch/arm/mach-imx/iomux-mx1.h
index 6b1507c..95f4681 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx1.h
+++ b/arch/arm/mach-imx/iomux-mx1.h
@@ -18,7 +18,7 @@
 #ifndef __MACH_IOMUX_MX1_H__
 #define __MACH_IOMUX_MX1_H__
 
-#include <mach/iomux-v1.h>
+#include "iomux-v1.h"
 
 #define PA0_AIN_SPI2_CLK	(GPIO_PORTA | GPIO_AIN | GPIO_OUT | 0)
 #define PA0_AF_ETMTRACESYNC	(GPIO_PORTA | GPIO_AF | 0)
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx21.h b/arch/arm/mach-imx/iomux-mx21.h
similarity index 99%
rename from arch/arm/plat-mxc/include/mach/iomux-mx21.h
rename to arch/arm/mach-imx/iomux-mx21.h
index 1495dfd..a70cffc 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx21.h
+++ b/arch/arm/mach-imx/iomux-mx21.h
@@ -18,8 +18,8 @@
 #ifndef __MACH_IOMUX_MX21_H__
 #define __MACH_IOMUX_MX21_H__
 
-#include <mach/iomux-mx2x.h>
-#include <mach/iomux-v1.h>
+#include "iomux-mx2x.h"
+#include "iomux-v1.h"
 
 /* Primary GPIO pin functions */
 
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx25.h b/arch/arm/mach-imx/iomux-mx25.h
similarity index 99%
rename from arch/arm/plat-mxc/include/mach/iomux-mx25.h
rename to arch/arm/mach-imx/iomux-mx25.h
index c61ec0f..be51e83 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx25.h
+++ b/arch/arm/mach-imx/iomux-mx25.h
@@ -19,7 +19,7 @@
 #ifndef __MACH_IOMUX_MX25_H__
 #define __MACH_IOMUX_MX25_H__
 
-#include <mach/iomux-v3.h>
+#include "iomux-v3.h"
 
 /*
  * IOMUX/PAD Bit field definitions
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx27.h b/arch/arm/mach-imx/iomux-mx27.h
similarity index 99%
rename from arch/arm/plat-mxc/include/mach/iomux-mx27.h
rename to arch/arm/mach-imx/iomux-mx27.h
index d9f9a6e..218e99e 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx27.h
+++ b/arch/arm/mach-imx/iomux-mx27.h
@@ -19,8 +19,8 @@
 #ifndef __MACH_IOMUX_MX27_H__
 #define __MACH_IOMUX_MX27_H__
 
-#include <mach/iomux-mx2x.h>
-#include <mach/iomux-v1.h>
+#include "iomux-mx2x.h"
+#include "iomux-v1.h"
 
 /* Primary GPIO pin functions */
 
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx2x.h b/arch/arm/mach-imx/iomux-mx2x.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/iomux-mx2x.h
rename to arch/arm/mach-imx/iomux-mx2x.h
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx3.h b/arch/arm/mach-imx/iomux-mx3.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/iomux-mx3.h
rename to arch/arm/mach-imx/iomux-mx3.h
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx35.h b/arch/arm/mach-imx/iomux-mx35.h
similarity index 99%
rename from arch/arm/plat-mxc/include/mach/iomux-mx35.h
rename to arch/arm/mach-imx/iomux-mx35.h
index 3117c18..90bfa6b 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx35.h
+++ b/arch/arm/mach-imx/iomux-mx35.h
@@ -19,7 +19,7 @@
 #ifndef __MACH_IOMUX_MX35_H__
 #define __MACH_IOMUX_MX35_H__
 
-#include <mach/iomux-v3.h>
+#include "iomux-v3.h"
 
 /*
  * The naming convention for the pad modes is MX35_PAD_<padname>__<padmode>
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx50.h b/arch/arm/mach-imx/iomux-mx50.h
similarity index 99%
rename from arch/arm/plat-mxc/include/mach/iomux-mx50.h
rename to arch/arm/mach-imx/iomux-mx50.h
index 98e7fd0..00f56e0 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx50.h
+++ b/arch/arm/mach-imx/iomux-mx50.h
@@ -19,7 +19,7 @@
 #ifndef __MACH_IOMUX_MX50_H__
 #define __MACH_IOMUX_MX50_H__
 
-#include <mach/iomux-v3.h>
+#include "iomux-v3.h"
 
 #define MX50_ELCDIF_PAD_CTRL	(PAD_CTL_PKE | PAD_CTL_DSE_HIGH)
 
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/mach-imx/iomux-mx51.h
similarity index 99%
rename from arch/arm/plat-mxc/include/mach/iomux-mx51.h
rename to arch/arm/mach-imx/iomux-mx51.h
index 2623e7a..75bbcc4 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
+++ b/arch/arm/mach-imx/iomux-mx51.h
@@ -13,7 +13,7 @@
 #ifndef __MACH_IOMUX_MX51_H__
 #define __MACH_IOMUX_MX51_H__
 
-#include <mach/iomux-v3.h>
+#include "iomux-v3.h"
 #define __NA_	0x000
 
 
diff --git a/arch/arm/plat-mxc/iomux-v1.c b/arch/arm/mach-imx/iomux-v1.c
similarity index 99%
rename from arch/arm/plat-mxc/iomux-v1.c
rename to arch/arm/mach-imx/iomux-v1.c
index 1f73963..2ac5580 100644
--- a/arch/arm/plat-mxc/iomux-v1.c
+++ b/arch/arm/mach-imx/iomux-v1.c
@@ -30,7 +30,8 @@
 
 #include <mach/hardware.h>
 #include <asm/mach/map.h>
-#include <mach/iomux-v1.h>
+
+#include "iomux-v1.h"
 
 static void __iomem *imx_iomuxv1_baseaddr;
 static unsigned imx_iomuxv1_numports;
diff --git a/arch/arm/plat-mxc/include/mach/iomux-v1.h b/arch/arm/mach-imx/iomux-v1.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/iomux-v1.h
rename to arch/arm/mach-imx/iomux-v1.h
diff --git a/arch/arm/plat-mxc/iomux-v3.c b/arch/arm/mach-imx/iomux-v3.c
similarity index 98%
rename from arch/arm/plat-mxc/iomux-v3.c
rename to arch/arm/mach-imx/iomux-v3.c
index 99a9cdb..de1459c 100644
--- a/arch/arm/plat-mxc/iomux-v3.c
+++ b/arch/arm/mach-imx/iomux-v3.c
@@ -27,7 +27,8 @@
 
 #include <mach/hardware.h>
 #include <asm/mach/map.h>
-#include <mach/iomux-v3.h>
+
+#include "iomux-v3.h"
 
 static void __iomem *base;
 
diff --git a/arch/arm/plat-mxc/include/mach/iomux-v3.h b/arch/arm/mach-imx/iomux-v3.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/iomux-v3.h
rename to arch/arm/mach-imx/iomux-v3.h
diff --git a/arch/arm/mach-imx/mach-apf9328.c b/arch/arm/mach-imx/mach-apf9328.c
index 7b99a79..b24f4b6 100644
--- a/arch/arm/mach-imx/mach-apf9328.c
+++ b/arch/arm/mach-imx/mach-apf9328.c
@@ -27,9 +27,9 @@
 
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/iomux-mx1.h>
 
 #include "devices-imx1.h"
+#include "iomux-mx1.h"
 
 static const int apf9328_pins[] __initconst = {
 	/* UART1 */
diff --git a/arch/arm/mach-imx/mach-armadillo5x0.c b/arch/arm/mach-imx/mach-armadillo5x0.c
index 2c6ab32..6915e4a 100644
--- a/arch/arm/mach-imx/mach-armadillo5x0.c
+++ b/arch/arm/mach-imx/mach-armadillo5x0.c
@@ -49,11 +49,11 @@
 #include <asm/mach/map.h>
 
 #include <mach/common.h>
-#include <mach/iomux-mx3.h>
 #include <mach/ulpi.h>
 
 #include "devices-imx31.h"
 #include "crmregs-imx3.h"
+#include "iomux-mx3.h"
 
 static int armadillo5x0_pins[] = {
 	/* UART1 */
diff --git a/arch/arm/mach-imx/mach-bug.c b/arch/arm/mach-imx/mach-bug.c
index 9a98977..55b71d1 100644
--- a/arch/arm/mach-imx/mach-bug.c
+++ b/arch/arm/mach-imx/mach-bug.c
@@ -19,7 +19,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 
-#include <mach/iomux-mx3.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
 
@@ -28,6 +27,7 @@
 #include <asm/mach-types.h>
 
 #include "devices-imx31.h"
+#include "iomux-mx3.h"
 
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index 1734320..0a05eab 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -36,11 +36,11 @@
 
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/iomux-mx27.h>
 #include <mach/ulpi.h>
 
 #include "devices-imx27.h"
 #include "eukrea-baseboards.h"
+#include "iomux-mx27.h"
 
 static const int eukrea_cpuimx27_pins[] __initconst = {
 	/* UART1 */
diff --git a/arch/arm/mach-imx/mach-cpuimx35.c b/arch/arm/mach-imx/mach-cpuimx35.c
index 0abfcb4..132243b 100644
--- a/arch/arm/mach-imx/mach-cpuimx35.c
+++ b/arch/arm/mach-imx/mach-cpuimx35.c
@@ -39,10 +39,10 @@
 
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/iomux-mx35.h>
 
 #include "devices-imx35.h"
 #include "eukrea-baseboards.h"
+#include "iomux-mx35.h"
 
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
diff --git a/arch/arm/mach-imx/mach-cpuimx51sd.c b/arch/arm/mach-imx/mach-cpuimx51sd.c
index 6cb3887..3c2ceed 100644
--- a/arch/arm/mach-imx/mach-cpuimx51sd.c
+++ b/arch/arm/mach-imx/mach-cpuimx51sd.c
@@ -28,7 +28,6 @@
 
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/iomux-mx51.h>
 
 #include <asm/setup.h>
 #include <asm/mach-types.h>
@@ -38,6 +37,7 @@
 #include "devices-imx51.h"
 #include "cpu_op-mx51.h"
 #include "eukrea-baseboards.h"
+#include "iomux-mx51.h"
 
 #define USBH1_RST		IMX_GPIO_NR(2, 28)
 #define ETH_RST			IMX_GPIO_NR(2, 31)
diff --git a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
index 4eab1d7..7dece34 100644
--- a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
+++ b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
@@ -35,10 +35,10 @@
 #include <asm/mach/map.h>
 #include <mach/common.h>
 #include <mach/mx25.h>
-#include <mach/iomux-mx25.h>
 
 #include "devices-imx25.h"
 #include "eukrea-baseboards.h"
+#include "iomux-mx25.h"
 
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 5627229..c85735a 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -42,9 +42,9 @@
 #include <asm/system_info.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/iomux-mx27.h>
 
 #include "devices-imx27.h"
+#include "iomux-mx27.h"
 
 #define TVP5150_RSTN (GPIO_PORTC + 18)
 #define TVP5150_PWDN (GPIO_PORTC + 19)
diff --git a/arch/arm/mach-imx/mach-imx27ipcam.c b/arch/arm/mach-imx/mach-imx27ipcam.c
index 7381387..4e2dcd3c1 100644
--- a/arch/arm/mach-imx/mach-imx27ipcam.c
+++ b/arch/arm/mach-imx/mach-imx27ipcam.c
@@ -19,9 +19,9 @@
 #include <asm/mach/time.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/iomux-mx27.h>
 
 #include "devices-imx27.h"
+#include "iomux-mx27.h"
 
 static const int mx27ipcam_pins[] __initconst = {
 	/* UART1 */
diff --git a/arch/arm/mach-imx/mach-imx27lite.c b/arch/arm/mach-imx/mach-imx27lite.c
index 1f45b91..49be646 100644
--- a/arch/arm/mach-imx/mach-imx27lite.c
+++ b/arch/arm/mach-imx/mach-imx27lite.c
@@ -22,9 +22,9 @@
 #include <asm/mach/map.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/iomux-mx27.h>
 
 #include "devices-imx27.h"
+#include "iomux-mx27.h"
 
 static const int mx27lite_pins[] __initconst = {
 	/* UART1 */
diff --git a/arch/arm/mach-imx/mach-kzm_arm11_01.c b/arch/arm/mach-imx/mach-kzm_arm11_01.c
index 8dc9d3e..b68db42 100644
--- a/arch/arm/mach-imx/mach-kzm_arm11_01.c
+++ b/arch/arm/mach-imx/mach-kzm_arm11_01.c
@@ -38,9 +38,9 @@
 
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/iomux-mx3.h>
 
 #include "devices-imx31.h"
+#include "iomux-mx3.h"
 
 #define KZM_ARM11_IO_ADDRESS(x) (IOMEM(					\
 	IMX_IO_P2V_MODULE(x, MX31_CS4) ?:				\
diff --git a/arch/arm/mach-imx/mach-mx1ads.c b/arch/arm/mach-imx/mach-mx1ads.c
index 667f359..e9e2401 100644
--- a/arch/arm/mach-imx/mach-mx1ads.c
+++ b/arch/arm/mach-imx/mach-mx1ads.c
@@ -25,9 +25,9 @@
 
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/iomux-mx1.h>
 
 #include "devices-imx1.h"
+#include "iomux-mx1.h"
 
 static const int mx1ads_pins[] __initconst = {
 	/* UART1 */
diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
index ed22e3f..0df370a 100644
--- a/arch/arm/mach-imx/mach-mx21ads.c
+++ b/arch/arm/mach-imx/mach-mx21ads.c
@@ -24,9 +24,9 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
-#include <mach/iomux-mx21.h>
 
 #include "devices-imx21.h"
+#include "iomux-mx21.h"
 
 /*
  * Memory-mapped I/O on MX21ADS base board
diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c b/arch/arm/mach-imx/mach-mx25_3ds.c
index ce247fd..4e741c5 100644
--- a/arch/arm/mach-imx/mach-mx25_3ds.c
+++ b/arch/arm/mach-imx/mach-mx25_3ds.c
@@ -39,9 +39,9 @@
 #include <asm/mach/map.h>
 #include <mach/common.h>
 #include <mach/mx25.h>
-#include <mach/iomux-mx25.h>
 
 #include "devices-imx25.h"
+#include "iomux-mx25.h"
 
 #define MX25PDK_CAN_PWDN	IMX_GPIO_NR(4, 6)
 
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 16dff39..7f7053b 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -38,11 +38,11 @@
 #include <asm/mach/time.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/iomux-mx27.h>
 #include <mach/ulpi.h>
 
 #include "3ds_debugboard.h"
 #include "devices-imx27.h"
+#include "iomux-mx27.h"
 
 #define SD1_EN_GPIO		IMX_GPIO_NR(2, 25)
 #define OTG_PHY_RESET_GPIO	IMX_GPIO_NR(2, 23)
diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index 7dc59ba..50b5d04 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -27,9 +27,9 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
-#include <mach/iomux-mx27.h>
 
 #include "devices-imx27.h"
+#include "iomux-mx27.h"
 
 /*
  * Base address of PBC controller, CS4
diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index 6750443..d38b696e 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -38,11 +38,11 @@
 #include <asm/mach/map.h>
 #include <asm/memblock.h>
 #include <mach/common.h>
-#include <mach/iomux-mx3.h>
 #include <mach/ulpi.h>
 
 #include "3ds_debugboard.h"
 #include "devices-imx31.h"
+#include "iomux-mx3.h"
 
 static int mx31_3ds_pins[] = {
 	/* UART1 */
diff --git a/arch/arm/mach-imx/mach-mx31ads.c b/arch/arm/mach-imx/mach-mx31ads.c
index d37f480..3d95d03 100644
--- a/arch/arm/mach-imx/mach-mx31ads.c
+++ b/arch/arm/mach-imx/mach-mx31ads.c
@@ -29,7 +29,6 @@
 #include <asm/memory.h>
 #include <asm/mach/map.h>
 #include <mach/common.h>
-#include <mach/iomux-mx3.h>
 
 #ifdef CONFIG_MACH_MX31ADS_WM1133_EV1
 #include <linux/mfd/wm8350/audio.h>
@@ -38,6 +37,7 @@
 #endif
 
 #include "devices-imx31.h"
+#include "iomux-mx3.h"
 
 /* Base address of PBC controller */
 #define PBC_BASE_ADDRESS	MX31_CS4_BASE_ADDR_VIRT
diff --git a/arch/arm/mach-imx/mach-mx31lilly.c b/arch/arm/mach-imx/mach-mx31lilly.c
index 2be500a..ae2dc78 100644
--- a/arch/arm/mach-imx/mach-mx31lilly.c
+++ b/arch/arm/mach-imx/mach-mx31lilly.c
@@ -44,11 +44,11 @@
 
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/iomux-mx3.h>
 #include <mach/ulpi.h>
 
 #include "board-mx31lilly.h"
 #include "devices-imx31.h"
+#include "iomux-mx3.h"
 
 /*
  * This file contains module-specific initialization routines for LILLY-1131.
diff --git a/arch/arm/mach-imx/mach-mx31lite.c b/arch/arm/mach-imx/mach-mx31lite.c
index 1704308..dc85c25 100644
--- a/arch/arm/mach-imx/mach-mx31lite.c
+++ b/arch/arm/mach-imx/mach-mx31lite.c
@@ -41,11 +41,11 @@
 
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/iomux-mx3.h>
 #include <mach/ulpi.h>
 
 #include "board-mx31lite.h"
 #include "devices-imx31.h"
+#include "iomux-mx3.h"
 
 /*
  * This file contains the module-specific initialization routines.
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index 2290d30..6c2e058 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -44,12 +44,12 @@
 #include <asm/memblock.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/iomux-mx3.h>
 #include <mach/ulpi.h>
 #include <linux/platform_data/asoc-imx-ssi.h>
 
 #include "board-mx31moboard.h"
 #include "devices-imx31.h"
+#include "iomux-mx3.h"
 
 static unsigned int moboard_pins[] = {
 	/* UART0 */
diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
index aac59b0..63d7a76 100644
--- a/arch/arm/mach-imx/mach-mx35_3ds.c
+++ b/arch/arm/mach-imx/mach-mx35_3ds.c
@@ -45,13 +45,13 @@
 
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/iomux-mx35.h>
 #include <video/platform_lcd.h>
 
 #include <media/soc_camera.h>
 
 #include "3ds_debugboard.h"
 #include "devices-imx35.h"
+#include "iomux-mx35.h"
 
 #define GPIO_MC9S08DZ60_GPS_ENABLE 0
 #define GPIO_MC9S08DZ60_HDD_ENABLE 4
diff --git a/arch/arm/mach-imx/mach-mx50_rdp.c b/arch/arm/mach-imx/mach-mx50_rdp.c
index 42b66e8..4762a3f 100644
--- a/arch/arm/mach-imx/mach-mx50_rdp.c
+++ b/arch/arm/mach-imx/mach-mx50_rdp.c
@@ -26,7 +26,6 @@
 
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/iomux-mx50.h>
 
 #include <asm/irq.h>
 #include <asm/setup.h>
@@ -35,6 +34,7 @@
 #include <asm/mach/time.h>
 
 #include "devices-imx50.h"
+#include "iomux-mx50.h"
 
 #define FEC_EN		IMX_GPIO_NR(6, 23)
 #define FEC_RESET_B	IMX_GPIO_NR(4, 12)
diff --git a/arch/arm/mach-imx/mach-mx51_3ds.c b/arch/arm/mach-imx/mach-mx51_3ds.c
index 4e84f80..4eb4299 100644
--- a/arch/arm/mach-imx/mach-mx51_3ds.c
+++ b/arch/arm/mach-imx/mach-mx51_3ds.c
@@ -21,10 +21,10 @@
 
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/iomux-mx51.h>
 
 #include "3ds_debugboard.h"
 #include "devices-imx51.h"
+#include "iomux-mx51.h"
 
 #define MX51_3DS_ECSPI2_CS	(GPIO_PORTC + 28)
 
diff --git a/arch/arm/mach-imx/mach-mx51_babbage.c b/arch/arm/mach-imx/mach-mx51_babbage.c
index 7b31cbd..20e6b9e 100644
--- a/arch/arm/mach-imx/mach-mx51_babbage.c
+++ b/arch/arm/mach-imx/mach-mx51_babbage.c
@@ -22,7 +22,6 @@
 
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/iomux-mx51.h>
 
 #include <asm/setup.h>
 #include <asm/mach-types.h>
@@ -31,6 +30,7 @@
 
 #include "devices-imx51.h"
 #include "cpu_op-mx51.h"
+#include "iomux-mx51.h"
 
 #define BABBAGE_USB_HUB_RESET	IMX_GPIO_NR(1, 7)
 #define BABBAGE_USBH1_STP	IMX_GPIO_NR(1, 27)
diff --git a/arch/arm/mach-imx/mach-mxt_td60.c b/arch/arm/mach-imx/mach-mxt_td60.c
index 0bf6d30..b5c036a 100644
--- a/arch/arm/mach-imx/mach-mxt_td60.c
+++ b/arch/arm/mach-imx/mach-mxt_td60.c
@@ -28,10 +28,10 @@
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
 #include <linux/gpio.h>
-#include <mach/iomux-mx27.h>
 #include <linux/i2c/pca953x.h>
 
 #include "devices-imx27.h"
+#include "iomux-mx27.h"
 
 static const int mxt_td60_pins[] __initconst = {
 	/* UART0 */
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index de8516b..42f407b 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -34,11 +34,11 @@
 #include <asm/mach-types.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/iomux-mx27.h>
 #include <asm/mach/time.h>
 #include <mach/ulpi.h>
 
 #include "devices-imx27.h"
+#include "iomux-mx27.h"
 
 #define OTG_PHY_CS_GPIO (GPIO_PORTB + 23)
 #define USBH2_PHY_CS_GPIO (GPIO_PORTB + 24)
diff --git a/arch/arm/mach-imx/mach-pcm037.c b/arch/arm/mach-imx/mach-pcm037.c
index e3c4513..0bdec55 100644
--- a/arch/arm/mach-imx/mach-pcm037.c
+++ b/arch/arm/mach-imx/mach-pcm037.c
@@ -44,10 +44,10 @@
 #include <asm/memblock.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/iomux-mx3.h>
 #include <mach/ulpi.h>
 
 #include "devices-imx31.h"
+#include "iomux-mx3.h"
 #include "pcm037.h"
 
 static enum pcm037_board_variant pcm037_instance = PCM037_PCM970;
diff --git a/arch/arm/mach-imx/mach-pcm037_eet.c b/arch/arm/mach-imx/mach-pcm037_eet.c
index 11ffa81..727dd63 100644
--- a/arch/arm/mach-imx/mach-pcm037_eet.c
+++ b/arch/arm/mach-imx/mach-pcm037_eet.c
@@ -12,12 +12,12 @@
 #include <linux/spi/spi.h>
 
 #include <mach/common.h>
-#include <mach/iomux-mx3.h>
 
 #include <asm/mach-types.h>
 
 #include "pcm037.h"
 #include "devices-imx31.h"
+#include "iomux-mx3.h"
 
 static unsigned int pcm037_eet_pins[] = {
 	/* Reserve and hardwire GPIO 57 high - S6E63D6 chipselect */
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index ad329d5..288838c 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -35,11 +35,11 @@
 
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/iomux-mx27.h>
 #include <mach/ulpi.h>
 
 #include "board-pcm038.h"
 #include "devices-imx27.h"
+#include "iomux-mx27.h"
 
 static const int pcm038_pins[] __initconst = {
 	/* UART1 */
diff --git a/arch/arm/mach-imx/mach-pcm043.c b/arch/arm/mach-imx/mach-pcm043.c
index e4bd438..051e883 100644
--- a/arch/arm/mach-imx/mach-pcm043.c
+++ b/arch/arm/mach-imx/mach-pcm043.c
@@ -35,10 +35,10 @@
 
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/iomux-mx35.h>
 #include <mach/ulpi.h>
 
 #include "devices-imx35.h"
+#include "iomux-mx35.h"
 
 static const struct fb_videomode fb_modedb[] = {
 	{
diff --git a/arch/arm/mach-imx/mach-qong.c b/arch/arm/mach-imx/mach-qong.c
index fb25fbd..c85425f 100644
--- a/arch/arm/mach-imx/mach-qong.c
+++ b/arch/arm/mach-imx/mach-qong.c
@@ -29,9 +29,9 @@
 #include <mach/common.h>
 #include <asm/page.h>
 #include <asm/setup.h>
-#include <mach/iomux-mx3.h>
 
 #include "devices-imx31.h"
+#include "iomux-mx3.h"
 
 /* FPGA defines */
 #define QONG_FPGA_VERSION(major, minor, rev)	\
diff --git a/arch/arm/mach-imx/mach-scb9328.c b/arch/arm/mach-imx/mach-scb9328.c
index 67ff38e..7528bb2 100644
--- a/arch/arm/mach-imx/mach-scb9328.c
+++ b/arch/arm/mach-imx/mach-scb9328.c
@@ -22,9 +22,9 @@
 
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/iomux-mx1.h>
 
 #include "devices-imx1.h"
+#include "iomux-mx1.h"
 
 /*
  * This scb9328 has a 32MiB flash
diff --git a/arch/arm/mach-imx/mach-vpr200.c b/arch/arm/mach-imx/mach-vpr200.c
index 39eb796..37fff61 100644
--- a/arch/arm/mach-imx/mach-vpr200.c
+++ b/arch/arm/mach-imx/mach-vpr200.c
@@ -30,13 +30,13 @@
 
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/iomux-mx35.h>
 
 #include <linux/i2c.h>
 #include <linux/i2c/at24.h>
 #include <linux/mfd/mc13xxx.h>
 
 #include "devices-imx35.h"
+#include "iomux-mx35.h"
 
 #define GPIO_LCDPWR	IMX_GPIO_NR(1, 2)
 #define GPIO_PMIC_INT	IMX_GPIO_NR(2, 0)
diff --git a/arch/arm/mach-imx/mm-imx1.c b/arch/arm/mach-imx/mm-imx1.c
index 6d60d51..af61242 100644
--- a/arch/arm/mach-imx/mm-imx1.c
+++ b/arch/arm/mach-imx/mm-imx1.c
@@ -24,7 +24,8 @@
 
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/iomux-v1.h>
+
+#include "iomux-v1.h"
 
 static struct map_desc imx_io_desc[] __initdata = {
 	imx_map_entry(MX1, IO, MT_DEVICE),
diff --git a/arch/arm/mach-imx/mm-imx21.c b/arch/arm/mach-imx/mm-imx21.c
index d056dad..5fda681 100644
--- a/arch/arm/mach-imx/mm-imx21.c
+++ b/arch/arm/mach-imx/mm-imx21.c
@@ -26,7 +26,8 @@
 #include <mach/devices-common.h>
 #include <asm/pgtable.h>
 #include <asm/mach/map.h>
-#include <mach/iomux-v1.h>
+
+#include "iomux-v1.h"
 
 /* MX21 memory map definition */
 static struct map_desc imx21_io_desc[] __initdata = {
diff --git a/arch/arm/mach-imx/mm-imx25.c b/arch/arm/mach-imx/mm-imx25.c
index f3f5c65..47bde02 100644
--- a/arch/arm/mach-imx/mm-imx25.c
+++ b/arch/arm/mach-imx/mm-imx25.c
@@ -28,7 +28,8 @@
 #include <mach/devices-common.h>
 #include <mach/hardware.h>
 #include <mach/mx25.h>
-#include <mach/iomux-v3.h>
+
+#include "iomux-v3.h"
 
 /*
  * This table defines static virtual address mappings for I/O regions.
diff --git a/arch/arm/mach-imx/mm-imx27.c b/arch/arm/mach-imx/mm-imx27.c
index e7e24af..8d8133e 100644
--- a/arch/arm/mach-imx/mm-imx27.c
+++ b/arch/arm/mach-imx/mm-imx27.c
@@ -26,7 +26,8 @@
 #include <mach/devices-common.h>
 #include <asm/pgtable.h>
 #include <asm/mach/map.h>
-#include <mach/iomux-v1.h>
+
+#include "iomux-v1.h"
 
 /* MX27 memory map definition */
 static struct map_desc imx27_io_desc[] __initdata = {
diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 9d2c843..87fb8644 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -29,9 +29,9 @@
 #include <mach/common.h>
 #include <mach/devices-common.h>
 #include <mach/hardware.h>
-#include <mach/iomux-v3.h>
 
 #include "crmregs-imx3.h"
+#include "iomux-v3.h"
 
 void __iomem *mx3_ccm_base;
 
diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
index acb0aad..b721b79 100644
--- a/arch/arm/mach-imx/mm-imx5.c
+++ b/arch/arm/mach-imx/mm-imx5.c
@@ -21,7 +21,8 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/devices-common.h>
-#include <mach/iomux-v3.h>
+
+#include "iomux-v3.h"
 
 /*
  * Define the MX50 memory map.
diff --git a/arch/arm/mach-imx/mx31lilly-db.c b/arch/arm/mach-imx/mx31lilly-db.c
index f2acf22..d364d52 100644
--- a/arch/arm/mach-imx/mx31lilly-db.c
+++ b/arch/arm/mach-imx/mx31lilly-db.c
@@ -32,10 +32,10 @@
 
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/iomux-mx3.h>
 
 #include "board-mx31lilly.h"
 #include "devices-imx31.h"
+#include "iomux-mx3.h"
 
 /*
  * This file contains board-specific initialization routines for the
diff --git a/arch/arm/mach-imx/mx31lite-db.c b/arch/arm/mach-imx/mx31lite-db.c
index fe4048d..944f7a8 100644
--- a/arch/arm/mach-imx/mx31lite-db.c
+++ b/arch/arm/mach-imx/mx31lite-db.c
@@ -33,10 +33,10 @@
 
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/iomux-mx3.h>
 
 #include "board-mx31lite.h"
 #include "devices-imx31.h"
+#include "iomux-mx3.h"
 
 /*
  * This file contains board-specific initialization routines for the
diff --git a/arch/arm/mach-imx/mx31moboard-devboard.c b/arch/arm/mach-imx/mx31moboard-devboard.c
index cc285e5..3dfb344 100644
--- a/arch/arm/mach-imx/mx31moboard-devboard.c
+++ b/arch/arm/mach-imx/mx31moboard-devboard.c
@@ -23,11 +23,11 @@
 #include <linux/usb/otg.h>
 
 #include <mach/common.h>
-#include <mach/iomux-mx3.h>
 #include <mach/hardware.h>
 #include <mach/ulpi.h>
 
 #include "devices-imx31.h"
+#include "iomux-mx3.h"
 
 static unsigned int devboard_pins[] = {
 	/* UART1 */
diff --git a/arch/arm/mach-imx/mx31moboard-marxbot.c b/arch/arm/mach-imx/mx31moboard-marxbot.c
index 135c90e..21cb93e 100644
--- a/arch/arm/mach-imx/mx31moboard-marxbot.c
+++ b/arch/arm/mach-imx/mx31moboard-marxbot.c
@@ -26,12 +26,12 @@
 
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/iomux-mx3.h>
 #include <mach/ulpi.h>
 
 #include <media/soc_camera.h>
 
 #include "devices-imx31.h"
+#include "iomux-mx3.h"
 
 static unsigned int marxbot_pins[] = {
 	/* SDHC2 */
diff --git a/arch/arm/mach-imx/mx31moboard-smartbot.c b/arch/arm/mach-imx/mx31moboard-smartbot.c
index fc8d178..318be44 100644
--- a/arch/arm/mach-imx/mx31moboard-smartbot.c
+++ b/arch/arm/mach-imx/mx31moboard-smartbot.c
@@ -25,13 +25,13 @@
 
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/iomux-mx3.h>
 #include <mach/ulpi.h>
 
 #include <media/soc_camera.h>
 
 #include "board-mx31moboard.h"
 #include "devices-imx31.h"
+#include "iomux-mx3.h"
 
 static unsigned int smartbot_pins[] = {
 	/* UART1 */
diff --git a/arch/arm/mach-imx/pcm970-baseboard.c b/arch/arm/mach-imx/pcm970-baseboard.c
index 9917e2f..8e45807 100644
--- a/arch/arm/mach-imx/pcm970-baseboard.c
+++ b/arch/arm/mach-imx/pcm970-baseboard.c
@@ -24,10 +24,10 @@
 #include <asm/mach/arch.h>
 
 #include <mach/common.h>
-#include <mach/iomux-mx27.h>
 #include <mach/hardware.h>
 
 #include "devices-imx27.h"
+#include "iomux-mx27.h"
 
 static const int pcm970_pins[] __initconst = {
 	/* SDHC */
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index baf9064..2450a98 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -76,12 +76,6 @@ config MXC_ULPI
 config ARCH_HAS_RNGA
 	bool
 
-config IMX_HAVE_IOMUX_V1
-	bool
-
-config ARCH_MXC_IOMUX_V3
-	bool
-
 config IRAM_ALLOC
 	bool
 	select GENERIC_ALLOCATOR
diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index 149237e..7cc047c 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -8,8 +8,6 @@ obj-y := time.o devices.o cpu.o system.o irq-common.o
 obj-$(CONFIG_MXC_TZIC) += tzic.o
 obj-$(CONFIG_MXC_AVIC) += avic.o
 
-obj-$(CONFIG_IMX_HAVE_IOMUX_V1) += iomux-v1.o
-obj-$(CONFIG_ARCH_MXC_IOMUX_V3) += iomux-v3.o
 obj-$(CONFIG_IRAM_ALLOC) += iram_alloc.o
 obj-$(CONFIG_MXC_ULPI) += ulpi.o
 obj-$(CONFIG_MXC_USE_EPIT) += epit.o
-- 
1.7.9.5
