From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:33 +0100
Subject: [PATCH 38/39] arm/imx: let platform files include the SoC-specific
	iomux header
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-38-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx1/mach-mx1ads.c              |    2 +-
 arch/arm/mach-mx1/mach-scb9328.c             |    2 +-
 arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c |    2 +-
 arch/arm/mach-mx2/mach-cpuimx27.c            |    2 +-
 arch/arm/mach-mx2/mach-imx27lite.c           |    2 +-
 arch/arm/mach-mx2/mach-mx21ads.c             |    2 +-
 arch/arm/mach-mx2/mach-mx27_3ds.c            |    2 +-
 arch/arm/mach-mx2/mach-mx27ads.c             |    2 +-
 arch/arm/mach-mx2/mach-mxt_td60.c            |    2 +-
 arch/arm/mach-mx2/mach-pca100.c              |    2 +-
 arch/arm/mach-mx2/mach-pcm038.c              |    2 +-
 arch/arm/mach-mx2/pcm970-baseboard.c         |    2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-mx1/mach-mx1ads.c b/arch/arm/mach-mx1/mach-mx1ads.c
index 69831aa..51f3cfd 100644
--- a/arch/arm/mach-mx1/mach-mx1ads.c
+++ b/arch/arm/mach-mx1/mach-mx1ads.c
@@ -27,7 +27,7 @@
 #include <mach/hardware.h>
 #include <mach/i2c.h>
 #include <mach/imx-uart.h>
-#include <mach/iomux.h>
+#include <mach/iomux-mx1.h>
 #include <mach/irqs.h>
 
 #include "devices.h"
diff --git a/arch/arm/mach-mx1/mach-scb9328.c b/arch/arm/mach-mx1/mach-scb9328.c
index b9530d7..7587a7a 100644
--- a/arch/arm/mach-mx1/mach-scb9328.c
+++ b/arch/arm/mach-mx1/mach-scb9328.c
@@ -23,7 +23,7 @@
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <mach/imx-uart.h>
-#include <mach/iomux.h>
+#include <mach/iomux-mx1.h>
 
 #include "devices.h"
 
diff --git a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
index 7382b6d..f3b169d 100644
--- a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
@@ -28,7 +28,7 @@
 #include <asm/mach/arch.h>
 
 #include <mach/common.h>
-#include <mach/iomux.h>
+#include <mach/iomux-mx27.h>
 #include <mach/imxfb.h>
 #include <mach/hardware.h>
 #include <mach/mmc.h>
diff --git a/arch/arm/mach-mx2/mach-cpuimx27.c b/arch/arm/mach-mx2/mach-cpuimx27.c
index e69c64e..1f616dc 100644
--- a/arch/arm/mach-mx2/mach-cpuimx27.c
+++ b/arch/arm/mach-mx2/mach-cpuimx27.c
@@ -36,7 +36,7 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/i2c.h>
-#include <mach/iomux.h>
+#include <mach/iomux-mx27.h>
 #include <mach/imx-uart.h>
 #include <mach/mxc_nand.h>
 
diff --git a/arch/arm/mach-mx2/mach-imx27lite.c b/arch/arm/mach-mx2/mach-imx27lite.c
index 621c2c1..b5710bf 100644
--- a/arch/arm/mach-mx2/mach-imx27lite.c
+++ b/arch/arm/mach-mx2/mach-imx27lite.c
@@ -27,7 +27,7 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/imx-uart.h>
-#include <mach/iomux.h>
+#include <mach/iomux-mx27.h>
 #include <mach/board-mx27lite.h>
 
 #include "devices.h"
diff --git a/arch/arm/mach-mx2/mach-mx21ads.c b/arch/arm/mach-mx2/mach-mx21ads.c
index 393bc07..113e58d 100644
--- a/arch/arm/mach-mx2/mach-mx21ads.c
+++ b/arch/arm/mach-mx2/mach-mx21ads.c
@@ -30,7 +30,7 @@
 #include <asm/mach/map.h>
 #include <mach/imx-uart.h>
 #include <mach/imxfb.h>
-#include <mach/iomux.h>
+#include <mach/iomux-mx21.h>
 #include <mach/mxc_nand.h>
 #include <mach/mmc.h>
 #include <mach/board-mx21ads.h>
diff --git a/arch/arm/mach-mx2/mach-mx27_3ds.c b/arch/arm/mach-mx2/mach-mx27_3ds.c
index 8c975f6..b2f4e0d 100644
--- a/arch/arm/mach-mx2/mach-mx27_3ds.c
+++ b/arch/arm/mach-mx2/mach-mx27_3ds.c
@@ -26,7 +26,7 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/imx-uart.h>
-#include <mach/iomux.h>
+#include <mach/iomux-mx27.h>
 #include <mach/board-mx27pdk.h>
 
 #include "devices.h"
diff --git a/arch/arm/mach-mx2/mach-mx27ads.c b/arch/arm/mach-mx2/mach-mx27ads.c
index 721f5c7..6ce3236 100644
--- a/arch/arm/mach-mx2/mach-mx27ads.c
+++ b/arch/arm/mach-mx2/mach-mx27ads.c
@@ -33,7 +33,7 @@
 #include <asm/mach/map.h>
 #include <mach/gpio.h>
 #include <mach/imx-uart.h>
-#include <mach/iomux.h>
+#include <mach/iomux-mx27.h>
 #include <mach/board-mx27ads.h>
 #include <mach/mxc_nand.h>
 #include <mach/i2c.h>
diff --git a/arch/arm/mach-mx2/mach-mxt_td60.c b/arch/arm/mach-mx2/mach-mxt_td60.c
index 43a4e86..bc38559 100644
--- a/arch/arm/mach-mx2/mach-mxt_td60.c
+++ b/arch/arm/mach-mx2/mach-mxt_td60.c
@@ -33,7 +33,7 @@
 #include <asm/mach/map.h>
 #include <linux/gpio.h>
 #include <mach/imx-uart.h>
-#include <mach/iomux.h>
+#include <mach/iomux-mx27.h>
 #include <mach/mxc_nand.h>
 #include <mach/i2c.h>
 #include <linux/i2c/pca953x.h>
diff --git a/arch/arm/mach-mx2/mach-pca100.c b/arch/arm/mach-mx2/mach-pca100.c
index 0c82ee1..cc1762d 100644
--- a/arch/arm/mach-mx2/mach-pca100.c
+++ b/arch/arm/mach-mx2/mach-pca100.c
@@ -31,7 +31,7 @@
 #include <asm/mach-types.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/iomux.h>
+#include <mach/iomux-mx27.h>
 #include <mach/i2c.h>
 #include <asm/mach/time.h>
 #if defined(CONFIG_SPI_IMX) || defined(CONFIG_SPI_IMX_MODULE)
diff --git a/arch/arm/mach-mx2/mach-pcm038.c b/arch/arm/mach-mx2/mach-pcm038.c
index 2290195..809392b 100644
--- a/arch/arm/mach-mx2/mach-pcm038.c
+++ b/arch/arm/mach-mx2/mach-pcm038.c
@@ -36,7 +36,7 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/i2c.h>
-#include <mach/iomux.h>
+#include <mach/iomux-mx27.h>
 #include <mach/imx-uart.h>
 #include <mach/mxc_nand.h>
 #include <mach/spi.h>
diff --git a/arch/arm/mach-mx2/pcm970-baseboard.c b/arch/arm/mach-mx2/pcm970-baseboard.c
index 60d5446..4aafd5b 100644
--- a/arch/arm/mach-mx2/pcm970-baseboard.c
+++ b/arch/arm/mach-mx2/pcm970-baseboard.c
@@ -24,7 +24,7 @@
 #include <asm/mach/arch.h>
 
 #include <mach/common.h>
-#include <mach/iomux.h>
+#include <mach/iomux-mx27.h>
 #include <mach/imxfb.h>
 #include <mach/hardware.h>
 #include <mach/mmc.h>
-- 
1.6.6.2
