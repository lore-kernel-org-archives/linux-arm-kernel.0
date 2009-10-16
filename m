From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:47 -0700
Subject: [PATCH 43/46] DaVinci: remove unneeded #include's
In-Reply-To: <1255720190-7452-44-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-8-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-9-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-10-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-11-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-12-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-13-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-14-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-15-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-16-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-17-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-18-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-19-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-20-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-21-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-22-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-23-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-24-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-25-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-26-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-27-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-28-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-29-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-30-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-31-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-32-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-33-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-34-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-35-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-36-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-37-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-38-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-39-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-40-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-41-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-42-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-43-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-44-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-45-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>

There have accumulated quite a lot of them after the code reorganizations...

In several cases I had to replace #include <linux/dma-mapping.h> which wasn't
needed directly but happened to #include <linux/err.h> which was needed.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-da830-evm.c     |    4 ----
 arch/arm/mach-davinci/board-da850-evm.c     |    3 ---
 arch/arm/mach-davinci/board-dm355-evm.c     |    9 +--------
 arch/arm/mach-davinci/board-dm355-leopard.c |    9 +--------
 arch/arm/mach-davinci/board-dm365-evm.c     |   10 +++-------
 arch/arm/mach-davinci/board-dm644x-evm.c    |   12 ------------
 arch/arm/mach-davinci/board-dm646x-evm.c    |   15 ---------------
 arch/arm/mach-davinci/board-sffsdr.c        |   12 ------------
 arch/arm/mach-davinci/clock.c               |    1 -
 arch/arm/mach-davinci/cp_intc.c             |    3 ---
 arch/arm/mach-davinci/da830.c               |    5 -----
 arch/arm/mach-davinci/da850.c               |    5 +----
 arch/arm/mach-davinci/devices-da8xx.c       |    2 --
 arch/arm/mach-davinci/devices.c             |    4 ----
 arch/arm/mach-davinci/dm355.c               |    2 --
 arch/arm/mach-davinci/dm365.c               |    2 --
 arch/arm/mach-davinci/dm644x.c              |    2 --
 arch/arm/mach-davinci/dm646x.c              |    2 --
 arch/arm/mach-davinci/dma.c                 |    9 ---------
 arch/arm/mach-davinci/gpio.c                |    9 ---------
 arch/arm/mach-davinci/include/mach/dm644x.h |    1 -
 arch/arm/mach-davinci/include/mach/system.h |    2 --
 arch/arm/mach-davinci/mux.c                 |    1 -
 arch/arm/mach-davinci/psc.c                 |    3 ---
 arch/arm/mach-davinci/serial.c              |    6 ------
 arch/arm/mach-davinci/sram.c                |    3 ---
 arch/arm/mach-davinci/time.c                |    6 ------
 arch/arm/mach-davinci/usb.c                 |    4 ----
 28 files changed, 6 insertions(+), 140 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index fb706db..bfac437 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -10,7 +10,6 @@
  * or implied.
  */
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/console.h>
 #include <linux/interrupt.h>
@@ -22,12 +21,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/common.h>
-#include <mach/irqs.h>
 #include <mach/cp_intc.h>
 #include <mach/mux.h>
 #include <mach/da8xx.h>
-#include <mach/asp.h>
 #include <mach/usb.h>
 
 #define DA830_EVM_PHY_MASK		0x0
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 53e434b..23e2024 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -12,7 +12,6 @@
  * or implied.
  */
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/console.h>
 #include <linux/i2c.h>
@@ -29,8 +28,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/common.h>
-#include <mach/irqs.h>
 #include <mach/cp_intc.h>
 #include <mach/da8xx.h>
 #include <mach/nand.h>
diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index f87ef58..42b24a7 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -9,15 +9,13 @@
  * or implied.
  */
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/init.h>
-#include <linux/dma-mapping.h>
+#include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand.h>
 #include <linux/i2c.h>
-#include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/clk.h>
 #include <linux/videodev2.h>
@@ -25,15 +23,10 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/eeprom.h>
 
-#include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <asm/mach/flash.h>
 
-#include <mach/hardware.h>
 #include <mach/dm355.h>
-#include <mach/psc.h>
 #include <mach/common.h>
 #include <mach/i2c.h>
 #include <mach/serial.h>
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index 84ad5d1..d9dcc2f 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -8,29 +8,22 @@
  * warranty of any kind, whether express or implied.
  */
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/init.h>
-#include <linux/dma-mapping.h>
+#include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand.h>
 #include <linux/i2c.h>
-#include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/clk.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/eeprom.h>
 
-#include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <asm/mach/flash.h>
 
-#include <mach/hardware.h>
 #include <mach/dm355.h>
-#include <mach/psc.h>
 #include <mach/common.h>
 #include <mach/i2c.h>
 #include <mach/serial.h>
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 8f49d09..3d7b5bb 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -13,9 +13,8 @@
  * GNU General Public License for more details.
  */
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/init.h>
-#include <linux/dma-mapping.h>
+#include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/io.h>
 #include <linux/clk.h>
@@ -24,21 +23,18 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand.h>
-#include <asm/setup.h>
+
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/map.h>
+
 #include <mach/mux.h>
-#include <mach/hardware.h>
 #include <mach/dm365.h>
-#include <mach/psc.h>
 #include <mach/common.h>
 #include <mach/i2c.h>
 #include <mach/serial.h>
 #include <mach/mmc.h>
 #include <mach/nand.h>
 
-
 static inline int have_imager(void)
 {
 	/* REVISIT when it's supported, trigger via Kconfig */
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 1213a00..00a8046 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -9,45 +9,33 @@
  * or implied.
  */
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
-#include <linux/leds.h>
-#include <linux/memory.h>
-
 #include <linux/i2c.h>
 #include <linux/i2c/pcf857x.h>
 #include <linux/i2c/at24.h>
-#include <linux/etherdevice.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
-#include <linux/io.h>
 #include <linux/phy.h>
 #include <linux/clk.h>
 #include <linux/videodev2.h>
 
 #include <media/tvp514x.h>
 
-#include <asm/setup.h>
 #include <asm/mach-types.h>
-
 #include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <asm/mach/flash.h>
 
 #include <mach/dm644x.h>
 #include <mach/common.h>
 #include <mach/i2c.h>
 #include <mach/serial.h>
 #include <mach/mux.h>
-#include <mach/psc.h>
 #include <mach/nand.h>
 #include <mach/mmc.h>
-#include <mach/emac.h>
 
 #define DM644X_EVM_PHY_MASK		(0x2)
 #define DM644X_EVM_MDIO_FREQUENCY	(2200000) /* PHY bus frequency */
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 24e0e13..8cf4979 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -17,38 +17,23 @@
  **************************************************************************/
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/init.h>
-#include <linux/fs.h>
-#include <linux/major.h>
-#include <linux/root_dev.h>
-#include <linux/dma-mapping.h>
-#include <linux/serial.h>
-#include <linux/serial_8250.h>
 #include <linux/leds.h>
 #include <linux/gpio.h>
-#include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
 #include <linux/i2c/at24.h>
 #include <linux/i2c/pcf857x.h>
-#include <linux/etherdevice.h>
 
 #include <media/tvp514x.h>
 
-#include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <asm/mach/flash.h>
 
 #include <mach/dm646x.h>
 #include <mach/common.h>
-#include <mach/psc.h>
 #include <mach/serial.h>
 #include <mach/i2c.h>
-#include <mach/mmc.h>
-#include <mach/emac.h>
 
 #if defined(CONFIG_BLK_DEV_PALMCHIP_BK3710) || \
     defined(CONFIG_BLK_DEV_PALMCHIP_BK3710_MODULE)
diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index 7acdfd8..e665487 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -23,34 +23,22 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/init.h>
-#include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
-#include <linux/gpio.h>
-
 #include <linux/i2c.h>
 #include <linux/i2c/at24.h>
-#include <linux/etherdevice.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
-#include <linux/mtd/physmap.h>
-#include <linux/io.h>
 
-#include <asm/setup.h>
 #include <asm/mach-types.h>
-
 #include <asm/mach/arch.h>
-#include <asm/mach/map.h>
 #include <asm/mach/flash.h>
 
 #include <mach/dm644x.h>
 #include <mach/common.h>
 #include <mach/i2c.h>
 #include <mach/serial.h>
-#include <mach/psc.h>
 #include <mach/mux.h>
 
 #define SFFSDR_PHY_MASK		(0x2)
diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index c882371..dfdeab5 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -17,7 +17,6 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
-#include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/delay.h>
 
diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 96c8e97..52b287c 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -10,9 +10,6 @@
  */
 
 #include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
 #include <linux/irq.h>
 #include <linux/io.h>
 
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 215d2ec..b22b5cf 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -8,22 +8,17 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
-#include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/clk.h>
-#include <linux/platform_device.h>
 
 #include <asm/mach/map.h>
 
-#include <mach/clock.h>
 #include <mach/psc.h>
-#include <mach/mux.h>
 #include <mach/irqs.h>
 #include <mach/cputype.h>
 #include <mach/common.h>
 #include <mach/time.h>
 #include <mach/da8xx.h>
-#include <mach/asp.h>
 
 #include "clock.h"
 #include "mux.h"
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index b804d57..120ede0 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -11,24 +11,21 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
-#include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/clk.h>
-#include <linux/platform_device.h>
 #include <linux/cpufreq.h>
 #include <linux/regulator/consumer.h>
 
 #include <asm/mach/map.h>
 
-#include <mach/clock.h>
 #include <mach/psc.h>
-#include <mach/mux.h>
 #include <mach/irqs.h>
 #include <mach/cputype.h>
 #include <mach/common.h>
 #include <mach/time.h>
 #include <mach/da8xx.h>
 #include <mach/cpufreq.h>
+#include <linux/platform_device.h>
 
 #include "clock.h"
 #include "mux.h"
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index dd0ea08..fda83f8 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -10,8 +10,6 @@
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  */
-#include <linux/module.h>
-#include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index 34dc0e9..1479496 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -9,15 +9,11 @@
  * (at your option) any later version.
  */
 
-#include <linux/module.h>
-#include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 
-#include <asm/mach/map.h>
-
 #include <mach/hardware.h>
 #include <mach/i2c.h>
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 0596700..dedf4d4 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -8,7 +8,6 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
-#include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/clk.h>
 #include <linux/serial_8250.h>
@@ -21,7 +20,6 @@
 #include <asm/mach/map.h>
 
 #include <mach/dm355.h>
-#include <mach/clock.h>
 #include <mach/cputype.h>
 #include <mach/edma.h>
 #include <mach/psc.h>
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 2674438..0fbc2f2 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -12,7 +12,6 @@
  * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
-#include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/clk.h>
 #include <linux/serial_8250.h>
@@ -23,7 +22,6 @@
 #include <asm/mach/map.h>
 
 #include <mach/dm365.h>
-#include <mach/clock.h>
 #include <mach/cputype.h>
 #include <mach/edma.h>
 #include <mach/psc.h>
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index d6e0fa5..84d3d26 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -8,7 +8,6 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
-#include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/clk.h>
 #include <linux/serial_8250.h>
@@ -18,7 +17,6 @@
 #include <asm/mach/map.h>
 
 #include <mach/dm644x.h>
-#include <mach/clock.h>
 #include <mach/cputype.h>
 #include <mach/edma.h>
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 36e4fb4..829a44b 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -8,7 +8,6 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
-#include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/clk.h>
 #include <linux/serial_8250.h>
@@ -18,7 +17,6 @@
 #include <asm/mach/map.h>
 
 #include <mach/dm646x.h>
-#include <mach/clock.h>
 #include <mach/cputype.h>
 #include <mach/edma.h>
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
index 4ff1f93..648fbb7 100644
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/mach-davinci/dma.c
@@ -18,22 +18,13 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
-#include <linux/spinlock.h>
-#include <linux/compiler.h>
 #include <linux/io.h>
 
-#include <mach/cputype.h>
-#include <mach/memory.h>
-#include <mach/hardware.h>
-#include <mach/irqs.h>
 #include <mach/edma.h>
-#include <mach/mux.h>
-
 
 /* Offsets matching "struct edmacc_param" */
 #define PARM_OPT		0x00
diff --git a/arch/arm/mach-davinci/gpio.c b/arch/arm/mach-davinci/gpio.c
index f6ea9db..744755b 100644
--- a/arch/arm/mach-davinci/gpio.c
+++ b/arch/arm/mach-davinci/gpio.c
@@ -12,23 +12,14 @@
 
 #include <linux/errno.h>
 #include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
-#include <linux/irq.h>
-#include <linux/bitops.h>
 
-#include <mach/cputype.h>
-#include <mach/irqs.h>
-#include <mach/hardware.h>
-#include <mach/common.h>
 #include <mach/gpio.h>
 
 #include <asm/mach/irq.h>
 
-
 static DEFINE_SPINLOCK(gpio_lock);
 
 struct davinci_gpio {
diff --git a/arch/arm/mach-davinci/include/mach/dm644x.h b/arch/arm/mach-davinci/include/mach/dm644x.h
index 0efb738..44e8f0f 100644
--- a/arch/arm/mach-davinci/include/mach/dm644x.h
+++ b/arch/arm/mach-davinci/include/mach/dm644x.h
@@ -22,7 +22,6 @@
 #ifndef __ASM_ARCH_DM644X_H
 #define __ASM_ARCH_DM644X_H
 
-#include <linux/platform_device.h>
 #include <mach/hardware.h>
 #include <mach/emac.h>
 #include <mach/asp.h>
diff --git a/arch/arm/mach-davinci/include/mach/system.h b/arch/arm/mach-davinci/include/mach/system.h
index f1a5f3d..539ed11 100644
--- a/arch/arm/mach-davinci/include/mach/system.h
+++ b/arch/arm/mach-davinci/include/mach/system.h
@@ -11,8 +11,6 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H
 
-#include <linux/io.h>
-#include <mach/hardware.h>
 #include <asm/proc-fns.h>
 
 extern void davinci_watchdog_reset(void);
diff --git a/arch/arm/mach-davinci/mux.c b/arch/arm/mach-davinci/mux.c
index 898905e..f757e83 100644
--- a/arch/arm/mach-davinci/mux.c
+++ b/arch/arm/mach-davinci/mux.c
@@ -19,7 +19,6 @@
 #include <linux/module.h>
 #include <linux/spinlock.h>
 
-#include <mach/hardware.h>
 #include <mach/mux.h>
 #include <mach/common.h>
 
diff --git a/arch/arm/mach-davinci/psc.c b/arch/arm/mach-davinci/psc.c
index a78b657..04a3cb7 100644
--- a/arch/arm/mach-davinci/psc.c
+++ b/arch/arm/mach-davinci/psc.c
@@ -19,14 +19,11 @@
  *
  */
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/io.h>
 
 #include <mach/cputype.h>
-#include <mach/hardware.h>
 #include <mach/psc.h>
-#include <mach/mux.h>
 
 /* PSC register offsets */
 #define EPCPR		0x070
diff --git a/arch/arm/mach-davinci/serial.c b/arch/arm/mach-davinci/serial.c
index c530c73..7ce5ba0 100644
--- a/arch/arm/mach-davinci/serial.c
+++ b/arch/arm/mach-davinci/serial.c
@@ -28,14 +28,8 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <asm/irq.h>
-#include <mach/hardware.h>
 #include <mach/serial.h>
-#include <mach/irqs.h>
 #include <mach/cputype.h>
-#include <mach/common.h>
-
-#include "clock.h"
 
 static inline unsigned int serial_read_reg(struct plat_serial8250_port *up,
 					   int offset)
diff --git a/arch/arm/mach-davinci/sram.c b/arch/arm/mach-davinci/sram.c
index 4f1fc9b..db0f778 100644
--- a/arch/arm/mach-davinci/sram.c
+++ b/arch/arm/mach-davinci/sram.c
@@ -9,15 +9,12 @@
  * (at your option) any later version.
  */
 #include <linux/module.h>
-#include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/genalloc.h>
 
 #include <mach/common.h>
-#include <mach/memory.h>
 #include <mach/sram.h>
 
-
 static struct gen_pool *sram_pool;
 
 void *sram_alloc(size_t len, dma_addr_t *dma)
diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index 0d1b6d4..42d985b 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -14,20 +14,14 @@
 #include <linux/interrupt.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
-#include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/err.h>
-#include <linux/device.h>
 #include <linux/platform_device.h>
 
 #include <mach/hardware.h>
-#include <asm/system.h>
-#include <asm/irq.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
-#include <asm/errno.h>
-#include <mach/io.h>
 #include <mach/cputype.h>
 #include <mach/time.h>
 #include "clock.h"
diff --git a/arch/arm/mach-davinci/usb.c b/arch/arm/mach-davinci/usb.c
index 2fff9a6..31eec87 100644
--- a/arch/arm/mach-davinci/usb.c
+++ b/arch/arm/mach-davinci/usb.c
@@ -1,17 +1,13 @@
 /*
  * USB
  */
-#include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 
 #include <linux/usb/musb.h>
-#include <linux/usb/otg.h>
 
 #include <mach/common.h>
-#include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <mach/cputype.h>
 #include <mach/usb.h>
-- 
1.6.4.3
