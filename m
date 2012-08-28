From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 28 Aug 2012 20:59:05 +0200
Subject: [PATCH 4/8] mmc: mvsdio: move <plat/mvsdio.h> to
 <linux/platform_data/mvsdio.h>
In-Reply-To: <1346180349-25123-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1346180349-25123-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1346180349-25123-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-kirkwood/board-dreamplug.c           |    2 +-
 arch/arm/mach-kirkwood/board-goflexnet.c           |    2 +-
 arch/arm/mach-kirkwood/common.c                    |    2 +-
 arch/arm/mach-kirkwood/db88f6281-bp-setup.c        |    2 +-
 arch/arm/mach-kirkwood/dockstar-setup.c            |    2 +-
 arch/arm/mach-kirkwood/guruplug-setup.c            |    2 +-
 arch/arm/mach-kirkwood/openrd-setup.c              |    2 +-
 arch/arm/mach-kirkwood/rd88f6281-setup.c           |    2 +-
 arch/arm/mach-kirkwood/sheevaplug-setup.c          |    2 +-
 drivers/mmc/host/mvsdio.c                          |    2 +-
 .../plat => include/linux/platform_data}/mvsdio.h  |    6 ++----
 11 files changed, 12 insertions(+), 14 deletions(-)
 rename {arch/arm/plat-orion/include/plat => include/linux/platform_data}/mvsdio.h (77%)

diff --git a/arch/arm/mach-kirkwood/board-dreamplug.c b/arch/arm/mach-kirkwood/board-dreamplug.c
index aeb234d..5256c1f 100644
--- a/arch/arm/mach-kirkwood/board-dreamplug.c
+++ b/arch/arm/mach-kirkwood/board-dreamplug.c
@@ -25,12 +25,12 @@
 #include <linux/mtd/physmap.h>
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
+#include <linux/platform_data/mvsdio.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <mach/kirkwood.h>
 #include <mach/bridge-regs.h>
-#include <plat/mvsdio.h>
 #include "common.h"
 #include "mpp.h"
 
diff --git a/arch/arm/mach-kirkwood/board-goflexnet.c b/arch/arm/mach-kirkwood/board-goflexnet.c
index 413e2c8..3d4ba64 100644
--- a/arch/arm/mach-kirkwood/board-goflexnet.c
+++ b/arch/arm/mach-kirkwood/board-goflexnet.c
@@ -27,12 +27,12 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/gpio.h>
+#include <linux/platform_data/mvsdio.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <mach/kirkwood.h>
 #include <mach/bridge-regs.h>
-#include <plat/mvsdio.h>
 #include "common.h"
 #include "mpp.h"
 
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 833fe07..e04bd6f 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -20,6 +20,7 @@
 #include <linux/mv643xx_i2c.h>
 #include <linux/platform_data/kirkwood-audio.h>
 #include <linux/platform_data/ehci-orion.h>
+#include <linux/platform_data/mvsdio.h>
 #include <net/dsa.h>
 #include <asm/page.h>
 #include <asm/timex.h>
@@ -29,7 +30,6 @@
 #include <mach/kirkwood.h>
 #include <mach/bridge-regs.h>
 #include <plat/cache-feroceon-l2.h>
-#include <plat/mvsdio.h>
 #include <plat/orion_nand.h>
 #include <plat/common.h>
 #include <plat/time.h>
diff --git a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
index d933593..c0a367b 100644
--- a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
+++ b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
@@ -14,10 +14,10 @@
 #include <linux/mtd/partitions.h>
 #include <linux/ata_platform.h>
 #include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mvsdio.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
-#include <plat/mvsdio.h>
 #include "common.h"
 #include "mpp.h"
 
diff --git a/arch/arm/mach-kirkwood/dockstar-setup.c b/arch/arm/mach-kirkwood/dockstar-setup.c
index 61d9a55..819cad1 100644
--- a/arch/arm/mach-kirkwood/dockstar-setup.c
+++ b/arch/arm/mach-kirkwood/dockstar-setup.c
@@ -16,10 +16,10 @@
 #include <linux/mv643xx_eth.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
+#include <linux/platform_data/mvsdio.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
-#include <plat/mvsdio.h>
 #include "common.h"
 #include "mpp.h"
 
diff --git a/arch/arm/mach-kirkwood/guruplug-setup.c b/arch/arm/mach-kirkwood/guruplug-setup.c
index bdaed38..be2b8fe 100644
--- a/arch/arm/mach-kirkwood/guruplug-setup.c
+++ b/arch/arm/mach-kirkwood/guruplug-setup.c
@@ -16,10 +16,10 @@
 #include <linux/mv643xx_eth.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
+#include <linux/platform_data/mvsdio.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
-#include <plat/mvsdio.h>
 #include "common.h"
 #include "mpp.h"
 
diff --git a/arch/arm/mach-kirkwood/openrd-setup.c b/arch/arm/mach-kirkwood/openrd-setup.c
index 7e99c3f..3b36ae7 100644
--- a/arch/arm/mach-kirkwood/openrd-setup.c
+++ b/arch/arm/mach-kirkwood/openrd-setup.c
@@ -17,10 +17,10 @@
 #include <linux/mv643xx_eth.h>
 #include <linux/i2c.h>
 #include <linux/gpio.h>
+#include <linux/platform_data/mvsdio.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
-#include <plat/mvsdio.h>
 #include "common.h"
 #include "mpp.h"
 
diff --git a/arch/arm/mach-kirkwood/rd88f6281-setup.c b/arch/arm/mach-kirkwood/rd88f6281-setup.c
index ef92207..78e1541 100644
--- a/arch/arm/mach-kirkwood/rd88f6281-setup.c
+++ b/arch/arm/mach-kirkwood/rd88f6281-setup.c
@@ -16,11 +16,11 @@
 #include <linux/ata_platform.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/ethtool.h>
+#include <linux/platform_data/mvsdio.h>
 #include <net/dsa.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
-#include <plat/mvsdio.h>
 #include "common.h"
 #include "mpp.h"
 
diff --git a/arch/arm/mach-kirkwood/sheevaplug-setup.c b/arch/arm/mach-kirkwood/sheevaplug-setup.c
index 4ea70e5..006dc69 100644
--- a/arch/arm/mach-kirkwood/sheevaplug-setup.c
+++ b/arch/arm/mach-kirkwood/sheevaplug-setup.c
@@ -16,10 +16,10 @@
 #include <linux/mv643xx_eth.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
+#include <linux/platform_data/mvsdio.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
-#include <plat/mvsdio.h>
 #include "common.h"
 #include "mpp.h"
 
diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index a61cb5f..0ae0a53 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -22,10 +22,10 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/mmc/host.h>
+#include <linux/platform_data/mvsdio.h>
 
 #include <asm/sizes.h>
 #include <asm/unaligned.h>
-#include <plat/mvsdio.h>
 
 #include "mvsdio.h"
 
diff --git a/arch/arm/plat-orion/include/plat/mvsdio.h b/include/linux/platform_data/mvsdio.h
similarity index 77%
rename from arch/arm/plat-orion/include/plat/mvsdio.h
rename to include/linux/platform_data/mvsdio.h
index 1190efe..a44eb86 100644
--- a/arch/arm/plat-orion/include/plat/mvsdio.h
+++ b/include/linux/platform_data/mvsdio.h
@@ -1,13 +1,11 @@
 /*
- * arch/arm/plat-orion/include/plat/mvsdio.h
- *
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
 
-#ifndef __MACH_MVSDIO_H
-#define __MACH_MVSDIO_H
+#ifndef __MVSDIO_PDATA_H
+#define __MVSDIO_PDATA_H
 
 #include <linux/mbus.h>
 
-- 
1.7.9.5
