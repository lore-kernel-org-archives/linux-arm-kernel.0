From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 28 Aug 2012 20:59:04 +0200
Subject: [PATCH 3/8] usb: ehci-orion: move <plat/ehci-orion.h> to
 <linux/platform_data/ehci-orion.h>
In-Reply-To: <1346180349-25123-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1346180349-25123-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1346180349-25123-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-dove/common.c                        |    2 +-
 arch/arm/mach-kirkwood/common.c                    |    2 +-
 arch/arm/mach-mv78xx0/common.c                     |    2 +-
 arch/arm/mach-orion5x/common.c                     |    2 +-
 arch/arm/plat-orion/common.c                       |    2 +-
 drivers/usb/host/ehci-orion.c                      |    2 +-
 .../linux/platform_data}/ehci-orion.h              |    6 ++----
 7 files changed, 8 insertions(+), 10 deletions(-)
 rename {arch/arm/plat-orion/include/plat => include/linux/platform_data}/ehci-orion.h (78%)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 4db5de5..c8e657b 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -16,6 +16,7 @@
 #include <linux/clk-provider.h>
 #include <linux/ata_platform.h>
 #include <linux/gpio.h>
+#include <linux/platform_data/ehci-orion.h>
 #include <asm/page.h>
 #include <asm/setup.h>
 #include <asm/timex.h>
@@ -28,7 +29,6 @@
 #include <asm/mach/arch.h>
 #include <linux/irq.h>
 #include <plat/time.h>
-#include <plat/ehci-orion.h>
 #include <plat/common.h>
 #include <plat/addr-map.h>
 #include "common.h"
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 138ba47..833fe07 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -19,6 +19,7 @@
 #include <linux/spinlock.h>
 #include <linux/mv643xx_i2c.h>
 #include <linux/platform_data/kirkwood-audio.h>
+#include <linux/platform_data/ehci-orion.h>
 #include <net/dsa.h>
 #include <asm/page.h>
 #include <asm/timex.h>
@@ -30,7 +31,6 @@
 #include <plat/cache-feroceon-l2.h>
 #include <plat/mvsdio.h>
 #include <plat/orion_nand.h>
-#include <plat/ehci-orion.h>
 #include <plat/common.h>
 #include <plat/time.h>
 #include <plat/addr-map.h>
diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
index b4c53b8..7413c35 100644
--- a/arch/arm/mach-mv78xx0/common.c
+++ b/arch/arm/mach-mv78xx0/common.c
@@ -15,12 +15,12 @@
 #include <linux/ata_platform.h>
 #include <linux/clk-provider.h>
 #include <linux/ethtool.h>
+#include <linux/platform_data/ehci-orion.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <mach/mv78xx0.h>
 #include <mach/bridge-regs.h>
 #include <plat/cache-feroceon-l2.h>
-#include <plat/ehci-orion.h>
 #include <plat/orion_nand.h>
 #include <plat/time.h>
 #include <plat/common.h>
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index 9148b22..7228eaa 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -19,6 +19,7 @@
 #include <linux/ata_platform.h>
 #include <linux/delay.h>
 #include <linux/clk-provider.h>
+#include <linux/platform_data/ehci-orion.h>
 #include <net/dsa.h>
 #include <asm/page.h>
 #include <asm/setup.h>
@@ -31,7 +32,6 @@
 #include <mach/hardware.h>
 #include <mach/orion5x.h>
 #include <plat/orion_nand.h>
-#include <plat/ehci-orion.h>
 #include <plat/time.h>
 #include <plat/common.h>
 #include <plat/addr-map.h>
diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index d245a87..ebcf727 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -18,9 +18,9 @@
 #include <linux/clkdev.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/mv643xx_i2c.h>
+#include <linux/platform_data/ehci-orion.h>
 #include <net/dsa.h>
 #include <plat/mv_xor.h>
-#include <plat/ehci-orion.h>
 #include <mach/bridge-regs.h>
 
 /* Create a clkdev entry for a given device/clk */
diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index 8892d36..b34b928 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -13,7 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/mbus.h>
 #include <linux/clk.h>
-#include <plat/ehci-orion.h>
+#include <linux/platform_data/ehci-orion.h>
 
 #define rdl(off)	__raw_readl(hcd->regs + (off))
 #define wrl(off, val)	__raw_writel((val), hcd->regs + (off))
diff --git a/arch/arm/plat-orion/include/plat/ehci-orion.h b/include/linux/platform_data/ehci-orion.h
similarity index 78%
rename from arch/arm/plat-orion/include/plat/ehci-orion.h
rename to include/linux/platform_data/ehci-orion.h
index 6fc78e4..f01933d 100644
--- a/arch/arm/plat-orion/include/plat/ehci-orion.h
+++ b/include/linux/platform_data/ehci-orion.h
@@ -1,13 +1,11 @@
 /*
- * arch/arm/plat-orion/include/plat/ehci-orion.h
- *
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
 
-#ifndef __PLAT_EHCI_ORION_H
-#define __PLAT_EHCI_ORION_H
+#ifndef __EHCI_ORION_PDATA_H
+#define __EHCI_ORION_PDATA_H
 
 #include <linux/mbus.h>
 
-- 
1.7.9.5
