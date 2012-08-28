From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 28 Aug 2012 20:59:07 +0200
Subject: [PATCH 6/8] mtd: orion_nand: move <plat/orion_nand.h> to
 <linux/platform_data/orion_nand.h>
In-Reply-To: <1346180349-25123-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1346180349-25123-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1346180349-25123-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-kirkwood/common.c                    |    2 +-
 arch/arm/mach-mv78xx0/common.c                     |    2 +-
 arch/arm/mach-orion5x/common.c                     |    2 +-
 arch/arm/mach-orion5x/db88f5281-setup.c            |    2 +-
 arch/arm/mach-orion5x/kurobox_pro-setup.c          |    2 +-
 drivers/mtd/nand/orion_nand.c                      |    2 +-
 .../linux/platform_data}/orion_nand.h              |    6 ++----
 7 files changed, 8 insertions(+), 10 deletions(-)
 rename {arch/arm/plat-orion/include/plat => include/linux/platform_data}/orion_nand.h (82%)

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index a3d8836..3e14dfc 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -22,6 +22,7 @@
 #include <linux/platform_data/ehci-orion.h>
 #include <linux/platform_data/mvsdio.h>
 #include <linux/platform_data/mv_xor.h>
+#include <linux/platform_data/orion_nand.h>
 #include <net/dsa.h>
 #include <asm/page.h>
 #include <asm/timex.h>
@@ -31,7 +32,6 @@
 #include <mach/kirkwood.h>
 #include <mach/bridge-regs.h>
 #include <plat/cache-feroceon-l2.h>
-#include <plat/orion_nand.h>
 #include <plat/common.h>
 #include <plat/time.h>
 #include <plat/addr-map.h>
diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
index 7413c35..acc0791 100644
--- a/arch/arm/mach-mv78xx0/common.c
+++ b/arch/arm/mach-mv78xx0/common.c
@@ -16,12 +16,12 @@
 #include <linux/clk-provider.h>
 #include <linux/ethtool.h>
 #include <linux/platform_data/ehci-orion.h>
+#include <linux/platform_data/orion_nand.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <mach/mv78xx0.h>
 #include <mach/bridge-regs.h>
 #include <plat/cache-feroceon-l2.h>
-#include <plat/orion_nand.h>
 #include <plat/time.h>
 #include <plat/common.h>
 #include <plat/addr-map.h>
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index 7228eaa..e0db313 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/clk-provider.h>
 #include <linux/platform_data/ehci-orion.h>
+#include <linux/platform_data/orion_nand.h>
 #include <net/dsa.h>
 #include <asm/page.h>
 #include <asm/setup.h>
@@ -31,7 +32,6 @@
 #include <mach/bridge-regs.h>
 #include <mach/hardware.h>
 #include <mach/orion5x.h>
-#include <plat/orion_nand.h>
 #include <plat/time.h>
 #include <plat/common.h>
 #include <plat/addr-map.h>
diff --git a/arch/arm/mach-orion5x/db88f5281-setup.c b/arch/arm/mach-orion5x/db88f5281-setup.c
index 49a3fd6..be3080e 100644
--- a/arch/arm/mach-orion5x/db88f5281-setup.c
+++ b/arch/arm/mach-orion5x/db88f5281-setup.c
@@ -20,11 +20,11 @@
 #include <linux/timer.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/i2c.h>
+#include <linux/platform_data/orion_nand.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
-#include <plat/orion_nand.h>
 #include "common.h"
 #include "mpp.h"
 
diff --git a/arch/arm/mach-orion5x/kurobox_pro-setup.c b/arch/arm/mach-orion5x/kurobox_pro-setup.c
index 1e458ef..82cf706 100644
--- a/arch/arm/mach-orion5x/kurobox_pro-setup.c
+++ b/arch/arm/mach-orion5x/kurobox_pro-setup.c
@@ -20,11 +20,11 @@
 #include <linux/i2c.h>
 #include <linux/serial_reg.h>
 #include <linux/ata_platform.h>
+#include <linux/platform_data/orion_nand.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
-#include <plat/orion_nand.h>
 #include "common.h"
 #include "mpp.h"
 
diff --git a/drivers/mtd/nand/orion_nand.c b/drivers/mtd/nand/orion_nand.c
index fc5a868..eaf8fc7 100644
--- a/drivers/mtd/nand/orion_nand.c
+++ b/drivers/mtd/nand/orion_nand.c
@@ -19,10 +19,10 @@
 #include <linux/mtd/partitions.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/platform_data/orion_nand.h>
 #include <asm/io.h>
 #include <asm/sizes.h>
 #include <mach/hardware.h>
-#include <plat/orion_nand.h>
 
 static void orion_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
diff --git a/arch/arm/plat-orion/include/plat/orion_nand.h b/include/linux/platform_data/orion_nand.h
similarity index 82%
rename from arch/arm/plat-orion/include/plat/orion_nand.h
rename to include/linux/platform_data/orion_nand.h
index 9f3c180..baa1860 100644
--- a/arch/arm/plat-orion/include/plat/orion_nand.h
+++ b/include/linux/platform_data/orion_nand.h
@@ -1,13 +1,11 @@
 /*
- * arch/arm/plat-orion/include/plat/orion_nand.h
- *
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
 
-#ifndef __PLAT_ORION_NAND_H
-#define __PLAT_ORION_NAND_H
+#ifndef __ORION_NAND_PDATA_H
+#define __ORION_NAND_PDATA_H
 
 /*
  * Device bus NAND private data
-- 
1.7.9.5
