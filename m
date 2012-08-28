From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 28 Aug 2012 20:59:06 +0200
Subject: [PATCH 5/8] dma: mv_xor: move <plat/mv_xor.h> to
 <linux/platform_data/mv_xor.h>
In-Reply-To: <1346180349-25123-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1346180349-25123-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1346180349-25123-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-kirkwood/common.c                    |    2 +-
 arch/arm/plat-orion/common.c                       |    2 +-
 drivers/dma/mv_xor.c                               |    2 +-
 .../plat => include/linux/platform_data}/mv_xor.h  |    6 ++----
 4 files changed, 5 insertions(+), 7 deletions(-)
 rename {arch/arm/plat-orion/include/plat => include/linux/platform_data}/mv_xor.h (77%)

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index e04bd6f..a3d8836 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -21,6 +21,7 @@
 #include <linux/platform_data/kirkwood-audio.h>
 #include <linux/platform_data/ehci-orion.h>
 #include <linux/platform_data/mvsdio.h>
+#include <linux/platform_data/mv_xor.h>
 #include <net/dsa.h>
 #include <asm/page.h>
 #include <asm/timex.h>
@@ -34,7 +35,6 @@
 #include <plat/common.h>
 #include <plat/time.h>
 #include <plat/addr-map.h>
-#include <plat/mv_xor.h>
 #include "common.h"
 
 /*****************************************************************************
diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index ebcf727..88dac08 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -19,8 +19,8 @@
 #include <linux/mv643xx_eth.h>
 #include <linux/mv643xx_i2c.h>
 #include <linux/platform_data/ehci-orion.h>
+#include <linux/platform_data/mv_xor.h>
 #include <net/dsa.h>
-#include <plat/mv_xor.h>
 #include <mach/bridge-regs.h>
 
 /* Create a clkdev entry for a given device/clk */
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 0b12e68..ec9c570 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -26,7 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/memory.h>
 #include <linux/clk.h>
-#include <plat/mv_xor.h>
+#include <linux/platform_data/mv_xor.h>
 
 #include "dmaengine.h"
 #include "mv_xor.h"
diff --git a/arch/arm/plat-orion/include/plat/mv_xor.h b/include/linux/platform_data/mv_xor.h
similarity index 77%
rename from arch/arm/plat-orion/include/plat/mv_xor.h
rename to include/linux/platform_data/mv_xor.h
index 2ba1f7d..cbfc6e1 100644
--- a/arch/arm/plat-orion/include/plat/mv_xor.h
+++ b/include/linux/platform_data/mv_xor.h
@@ -1,11 +1,9 @@
 /*
- * arch/arm/plat-orion/include/plat/mv_xor.h
- *
  * Marvell XOR platform device data definition file.
  */
 
-#ifndef __PLAT_MV_XOR_H
-#define __PLAT_MV_XOR_H
+#ifndef __MV_XOR_PDATA_H
+#define __MV_XOR_PDATA_H
 
 #include <linux/dmaengine.h>
 #include <linux/mbus.h>
-- 
1.7.9.5
