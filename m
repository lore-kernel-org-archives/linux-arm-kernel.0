From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 28 Aug 2012 20:59:08 +0200
Subject: [PATCH 7/8] i2c: mv643xx: move <linux/mv643xx_i2c.h> to
 <linux/platform_data/mv643xx_i2c.h>
In-Reply-To: <1346180349-25123-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1346180349-25123-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1346180349-25123-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even though this platform_data header was already in <linux/...> and
not in <plat/...>, it makes sense to move it as well to
<linux/platform_data/...>.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-kirkwood/common.c                 |    2 +-
 arch/arm/mach-orion5x/common.c                  |    2 +-
 arch/arm/plat-orion/common.c                    |    2 +-
 drivers/i2c/busses/i2c-mv64xxx.c                |    2 +-
 include/linux/mv643xx.h                         |    2 +-
 include/linux/{ => platform_data}/mv643xx_i2c.h |    4 ++--
 6 files changed, 7 insertions(+), 7 deletions(-)
 rename include/linux/{ => platform_data}/mv643xx_i2c.h (89%)

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 3e14dfc..7981012 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -17,11 +17,11 @@
 #include <linux/dma-mapping.h>
 #include <linux/clk-provider.h>
 #include <linux/spinlock.h>
-#include <linux/mv643xx_i2c.h>
 #include <linux/platform_data/kirkwood-audio.h>
 #include <linux/platform_data/ehci-orion.h>
 #include <linux/platform_data/mvsdio.h>
 #include <linux/platform_data/mv_xor.h>
+#include <linux/platform_data/mv643xx_i2c.h>
 #include <linux/platform_data/orion_nand.h>
 #include <net/dsa.h>
 #include <asm/page.h>
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index e0db313..43ae1b7 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -15,11 +15,11 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/serial_8250.h>
-#include <linux/mv643xx_i2c.h>
 #include <linux/ata_platform.h>
 #include <linux/delay.h>
 #include <linux/clk-provider.h>
 #include <linux/platform_data/ehci-orion.h>
+#include <linux/platform_data/mv643xx_i2c.h>
 #include <linux/platform_data/orion_nand.h>
 #include <net/dsa.h>
 #include <asm/page.h>
diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index 88dac08..3aeb28f 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -17,9 +17,9 @@
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/mv643xx_eth.h>
-#include <linux/mv643xx_i2c.h>
 #include <linux/platform_data/ehci-orion.h>
 #include <linux/platform_data/mv_xor.h>
+#include <linux/platform_data/mv643xx_i2c.h>
 #include <net/dsa.h>
 #include <mach/bridge-regs.h>
 
diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 2e9d567..c5e6993 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -15,7 +15,6 @@
 #include <linux/spinlock.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
-#include <linux/mv643xx_i2c.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -23,6 +22,7 @@
 #include <linux/of_i2c.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/platform_data/mv643xx_i2c.h>
 
 /* Register defines */
 #define	MV64XXX_I2C_REG_SLAVE_ADDR			0x00
diff --git a/include/linux/mv643xx.h b/include/linux/mv643xx.h
index 69327b7..7e293ce 100644
--- a/include/linux/mv643xx.h
+++ b/include/linux/mv643xx.h
@@ -15,7 +15,7 @@
 
 #include <asm/types.h>
 #include <linux/mv643xx_eth.h>
-#include <linux/mv643xx_i2c.h>
+#include <linux/platform_data/mv643xx_i2c.h>
 
 /****************************************/
 /* Processor Address Space              */
diff --git a/include/linux/mv643xx_i2c.h b/include/linux/platform_data/mv643xx_i2c.h
similarity index 89%
rename from include/linux/mv643xx_i2c.h
rename to include/linux/platform_data/mv643xx_i2c.h
index 5db5152..a00c687 100644
--- a/include/linux/mv643xx_i2c.h
+++ b/include/linux/platform_data/mv643xx_i2c.h
@@ -5,8 +5,8 @@
  * option) any later version.
  */
 
-#ifndef _MV64XXX_I2C_H_
-#define _MV64XXX_I2C_H_
+#ifndef _MV64XXX_I2C_PDATA_H_
+#define _MV64XXX_I2C_PDATA_H_
 
 #include <linux/types.h>
 
-- 
1.7.9.5
