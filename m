From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 16:49:16 +0100
Subject: [PATCH 4/5] ARM: orion: clean up mach/*.h headers
In-Reply-To: <1448466557-435335-1-git-send-email-arnd@arndb.de>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
Message-ID: <1448466557-435335-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a simple move of all header files that are no longer
included by anything else from the include/mach directory
to the platform directory itself, for mv78xx0, dove, and orion5x,
as preparation for multiplatform support.

The mach/uncompress.h headers are left in place for now,
and are mildly modified to be independent of the other
headers. They will be removed entirely when ARCH_MULTIPLATFORM
gets enabled and they become obsolete.

Rather than updating the path names inside of the comments
of each header, I delete those comments to avoid having to
update them again, should they get moved or copied another
time.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-dove/{include/mach => }/bridge-regs.h   |  4 +---
 arch/arm/mach-dove/cm-a510.c                          |  3 +--
 arch/arm/mach-dove/common.c                           |  4 ++--
 arch/arm/mach-dove/dove-db-setup.c                    |  2 +-
 arch/arm/mach-dove/{include/mach => }/dove.h          |  4 +---
 arch/arm/mach-dove/include/mach/hardware.h            | 19 -------------------
 arch/arm/mach-dove/include/mach/uncompress.h          |  8 +++-----
 arch/arm/mach-dove/irq.c                              |  8 +++++---
 arch/arm/mach-dove/{include/mach => }/irqs.h          |  2 --
 arch/arm/mach-dove/mpp.c                              |  2 +-
 arch/arm/mach-dove/pcie.c                             |  4 ++--
 arch/arm/mach-dove/{include/mach => }/pm.h            |  4 +---
 .../arm/mach-mv78xx0/{include/mach => }/bridge-regs.h |  4 +---
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c             |  2 +-
 arch/arm/mach-mv78xx0/common.c                        |  4 ++--
 arch/arm/mach-mv78xx0/db78x00-bp-setup.c              |  2 +-
 arch/arm/mach-mv78xx0/include/mach/hardware.h         | 14 --------------
 arch/arm/mach-mv78xx0/include/mach/uncompress.h       |  4 +---
 arch/arm/mach-mv78xx0/irq.c                           |  2 +-
 arch/arm/mach-mv78xx0/{include/mach => }/irqs.h       |  2 --
 arch/arm/mach-mv78xx0/mpp.c                           |  2 +-
 arch/arm/mach-mv78xx0/{include/mach => }/mv78xx0.h    |  2 --
 arch/arm/mach-mv78xx0/pcie.c                          |  2 +-
 arch/arm/mach-mv78xx0/rd78x00-masa-setup.c            |  2 +-
 arch/arm/mach-orion5x/board-d2net.c                   |  2 +-
 arch/arm/mach-orion5x/board-dt.c                      |  4 ++--
 arch/arm/mach-orion5x/board-mss2.c                    |  4 ++--
 arch/arm/mach-orion5x/board-rd88f5182.c               |  2 +-
 .../arm/mach-orion5x/{include/mach => }/bridge-regs.h |  4 +---
 arch/arm/mach-orion5x/common.c                        |  6 +++---
 arch/arm/mach-orion5x/db88f5281-setup.c               |  2 +-
 arch/arm/mach-orion5x/dns323-setup.c                  |  2 +-
 arch/arm/mach-orion5x/include/mach/hardware.h         | 14 --------------
 arch/arm/mach-orion5x/include/mach/uncompress.h       |  4 +---
 arch/arm/mach-orion5x/irq.c                           |  2 +-
 arch/arm/mach-orion5x/{include/mach => }/irqs.h       |  2 --
 arch/arm/mach-orion5x/kurobox_pro-setup.c             |  2 +-
 arch/arm/mach-orion5x/ls-chl-setup.c                  |  2 +-
 arch/arm/mach-orion5x/ls_hgl-setup.c                  |  2 +-
 arch/arm/mach-orion5x/mpp.c                           |  2 +-
 arch/arm/mach-orion5x/mv2120-setup.c                  |  2 +-
 arch/arm/mach-orion5x/net2big-setup.c                 |  2 +-
 arch/arm/mach-orion5x/{include/mach => }/orion5x.h    |  4 +---
 arch/arm/mach-orion5x/pci.c                           |  2 +-
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c          |  2 +-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c           |  2 +-
 arch/arm/mach-orion5x/rd88f5182-setup.c               |  2 +-
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c          |  2 +-
 arch/arm/mach-orion5x/terastation_pro2-setup.c        |  2 +-
 arch/arm/mach-orion5x/ts209-setup.c                   |  2 +-
 arch/arm/mach-orion5x/ts409-setup.c                   |  2 +-
 arch/arm/mach-orion5x/ts78xx-setup.c                  |  2 +-
 arch/arm/mach-orion5x/tsx09-common.c                  |  2 +-
 arch/arm/mach-orion5x/wnr854t-setup.c                 |  2 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c              |  2 +-
 arch/arm/plat-orion/irq.c                             |  1 -
 arch/arm/plat-orion/mpp.c                             |  1 -
 57 files changed, 61 insertions(+), 135 deletions(-)
 rename arch/arm/mach-dove/{include/mach => }/bridge-regs.h (96%)
 rename arch/arm/mach-dove/{include/mach => }/dove.h (99%)
 delete mode 100644 arch/arm/mach-dove/include/mach/hardware.h
 rename arch/arm/mach-dove/{include/mach => }/irqs.h (98%)
 rename arch/arm/mach-dove/{include/mach => }/pm.h (97%)
 rename arch/arm/mach-mv78xx0/{include/mach => }/bridge-regs.h (92%)
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/hardware.h
 rename arch/arm/mach-mv78xx0/{include/mach => }/irqs.h (98%)
 rename arch/arm/mach-mv78xx0/{include/mach => }/mv78xx0.h (98%)
 rename arch/arm/mach-orion5x/{include/mach => }/bridge-regs.h (92%)
 delete mode 100644 arch/arm/mach-orion5x/include/mach/hardware.h
 rename arch/arm/mach-orion5x/{include/mach => }/irqs.h (97%)
 rename arch/arm/mach-orion5x/{include/mach => }/orion5x.h (98%)

diff --git a/arch/arm/mach-dove/include/mach/bridge-regs.h b/arch/arm/mach-dove/bridge-regs.h
similarity index 96%
rename from arch/arm/mach-dove/include/mach/bridge-regs.h
rename to arch/arm/mach-dove/bridge-regs.h
index f4a5b34489b7..ace0b0bfbf11 100644
--- a/arch/arm/mach-dove/include/mach/bridge-regs.h
+++ b/arch/arm/mach-dove/bridge-regs.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-dove/include/mach/bridge-regs.h
- *
  * Mbus-L to Mbus Bridge Registers
  *
  * This file is licensed under the terms of the GNU General Public
@@ -11,7 +9,7 @@
 #ifndef __ASM_ARCH_BRIDGE_REGS_H
 #define __ASM_ARCH_BRIDGE_REGS_H
 
-#include <mach/dove.h>
+#include "dove.h"
 
 #define CPU_CONFIG		(BRIDGE_VIRT_BASE + 0x0000)
 
diff --git a/arch/arm/mach-dove/cm-a510.c b/arch/arm/mach-dove/cm-a510.c
index b9a7c33db29a..9f25c993d863 100644
--- a/arch/arm/mach-dove/cm-a510.c
+++ b/arch/arm/mach-dove/cm-a510.c
@@ -22,8 +22,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/dove.h>
-
+#include "dove.h"
 #include "common.h"
 
 static struct mv643xx_eth_platform_data cm_a510_ge00_data = {
diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 0d1a89298ece..910788cd122d 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -20,11 +20,11 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
-#include <mach/bridge-regs.h>
-#include <mach/pm.h>
 #include <plat/common.h>
 #include <plat/irq.h>
 #include <plat/time.h>
+#include "bridge-regs.h"
+#include "pm.h"
 #include "common.h"
 
 /* These can go away once Dove uses the mvebu-mbus DT binding */
diff --git a/arch/arm/mach-dove/dove-db-setup.c b/arch/arm/mach-dove/dove-db-setup.c
index bcb678fd2415..6b9ac97f2d0f 100644
--- a/arch/arm/mach-dove/dove-db-setup.c
+++ b/arch/arm/mach-dove/dove-db-setup.c
@@ -24,7 +24,7 @@
 #include <linux/gpio.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <mach/dove.h>
+#include "dove.h"
 #include "common.h"
 
 static struct mv643xx_eth_platform_data dove_db_ge00_data = {
diff --git a/arch/arm/mach-dove/include/mach/dove.h b/arch/arm/mach-dove/dove.h
similarity index 99%
rename from arch/arm/mach-dove/include/mach/dove.h
rename to arch/arm/mach-dove/dove.h
index 00f45458b3ec..539e735f968d 100644
--- a/arch/arm/mach-dove/include/mach/dove.h
+++ b/arch/arm/mach-dove/dove.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-dove/include/mach/dove.h
- *
  * Generic definitions for Marvell Dove 88AP510 SoC
  *
  * This file is licensed under the terms of the GNU General Public
@@ -11,7 +9,7 @@
 #ifndef __ASM_ARCH_DOVE_H
 #define __ASM_ARCH_DOVE_H
 
-#include <mach/irqs.h>
+#include "irqs.h"
 
 /*
  * Marvell Dove address maps.
diff --git a/arch/arm/mach-dove/include/mach/hardware.h b/arch/arm/mach-dove/include/mach/hardware.h
deleted file mode 100644
index f1368b9a8ece..000000000000
--- a/arch/arm/mach-dove/include/mach/hardware.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-dove/include/mach/hardware.h
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __ASM_ARCH_HARDWARE_H
-#define __ASM_ARCH_HARDWARE_H
-
-#include "dove.h"
-
-/* Macros below are required for compatibility with PXA AC'97 driver.	*/
-#define __REG(x)	(*((volatile u32 *)((x) - DOVE_SB_REGS_PHYS_BASE + \
-				DOVE_SB_REGS_VIRT_BASE)))
-#define __PREG(x)	(((u32)&(x)) - DOVE_SB_REGS_VIRT_BASE + \
-		DOVE_SB_REGS_PHYS_BASE)
-#endif
diff --git a/arch/arm/mach-dove/include/mach/uncompress.h b/arch/arm/mach-dove/include/mach/uncompress.h
index 5c8ae9b9d39a..7a4bd8838036 100644
--- a/arch/arm/mach-dove/include/mach/uncompress.h
+++ b/arch/arm/mach-dove/include/mach/uncompress.h
@@ -1,15 +1,13 @@
 /*
- * arch/arm/mach-dove/include/mach/uncompress.h
- *
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
 
-#include <mach/dove.h>
+#define UART0_PHYS_BASE (0xf1000000 + 0x12000)
 
-#define UART_THR ((volatile unsigned char *)(DOVE_UART0_PHYS_BASE + 0x0))
-#define UART_LSR ((volatile unsigned char *)(DOVE_UART0_PHYS_BASE + 0x14))
+#define UART_THR ((volatile unsigned char *)(UART0_PHYS_BASE + 0x0))
+#define UART_LSR ((volatile unsigned char *)(UART0_PHYS_BASE + 0x14))
 
 #define LSR_THRE	0x20
 
diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
index ad785d34c1e7..ab38ad47716a 100644
--- a/arch/arm/mach-dove/irq.c
+++ b/arch/arm/mach-dove/irq.c
@@ -15,11 +15,13 @@
 #include <linux/io.h>
 #include <asm/exception.h>
 #include <asm/mach/arch.h>
-#include <plat/irq.h>
 #include <asm/mach/irq.h>
-#include <mach/pm.h>
-#include <mach/bridge-regs.h>
+
+#include <plat/irq.h>
 #include <plat/orion-gpio.h>
+
+#include "pm.h"
+#include "bridge-regs.h"
 #include "common.h"
 
 static void pmu_irq_mask(struct irq_data *d)
diff --git a/arch/arm/mach-dove/include/mach/irqs.h b/arch/arm/mach-dove/irqs.h
similarity index 98%
rename from arch/arm/mach-dove/include/mach/irqs.h
rename to arch/arm/mach-dove/irqs.h
index 8ff0fa8b4fcd..a0742179faff 100644
--- a/arch/arm/mach-dove/include/mach/irqs.h
+++ b/arch/arm/mach-dove/irqs.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-dove/include/mach/irqs.h
- *
  * IRQ definitions for Marvell Dove 88AP510 SoC
  *
  * This file is licensed under the terms of the GNU General Public
diff --git a/arch/arm/mach-dove/mpp.c b/arch/arm/mach-dove/mpp.c
index 8a433a51289c..6acd8488bb05 100644
--- a/arch/arm/mach-dove/mpp.c
+++ b/arch/arm/mach-dove/mpp.c
@@ -12,8 +12,8 @@
 #include <linux/gpio.h>
 #include <linux/io.h>
 #include <plat/mpp.h>
-#include <mach/dove.h>
 #include <plat/orion-gpio.h>
+#include "dove.h"
 #include "mpp.h"
 
 struct dove_mpp_grp {
diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
index 91fe97144570..46f08d44b5f5 100644
--- a/arch/arm/mach-dove/pcie.c
+++ b/arch/arm/mach-dove/pcie.c
@@ -17,9 +17,9 @@
 #include <asm/setup.h>
 #include <asm/delay.h>
 #include <plat/pcie.h>
-#include <mach/irqs.h>
-#include <mach/bridge-regs.h>
 #include <plat/addr-map.h>
+#include "irqs.h"
+#include "bridge-regs.h"
 #include "common.h"
 
 struct pcie_port {
diff --git a/arch/arm/mach-dove/include/mach/pm.h b/arch/arm/mach-dove/pm.h
similarity index 97%
rename from arch/arm/mach-dove/include/mach/pm.h
rename to arch/arm/mach-dove/pm.h
index 9834ba10cd13..3e2712a89c61 100644
--- a/arch/arm/mach-dove/include/mach/pm.h
+++ b/arch/arm/mach-dove/pm.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-dove/include/mach/pm.h
- *
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
@@ -10,7 +8,7 @@
 #define __ASM_ARCH_PM_H
 
 #include <asm/errno.h>
-#include <mach/irqs.h>
+#include "irqs.h"
 
 #define CLOCK_GATING_CONTROL	(DOVE_PMU_VIRT_BASE + 0x38)
 #define  CLOCK_GATING_BIT_USB0		0
diff --git a/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h b/arch/arm/mach-mv78xx0/bridge-regs.h
similarity index 92%
rename from arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
rename to arch/arm/mach-mv78xx0/bridge-regs.h
index e20d6da234a6..2f54e1753d45 100644
--- a/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
+++ b/arch/arm/mach-mv78xx0/bridge-regs.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
- *
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
@@ -9,7 +7,7 @@
 #ifndef __ASM_ARCH_BRIDGE_REGS_H
 #define __ASM_ARCH_BRIDGE_REGS_H
 
-#include <mach/mv78xx0.h>
+#include "mv78xx0.h"
 
 #define CPU_CONTROL		(BRIDGE_VIRT_BASE + 0x0104)
 #define L2_WRITETHROUGH		0x00020000
diff --git a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
index 1607fd5e206e..e112f2e7cc9a 100644
--- a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
+++ b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
@@ -17,9 +17,9 @@
 #include <linux/mv643xx_eth.h>
 #include <linux/ethtool.h>
 #include <linux/i2c.h>
-#include <mach/mv78xx0.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include "mv78xx0.h"
 #include "common.h"
 #include "mpp.h"
 
diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
index e6ac679bece9..a1a04df9c05c 100644
--- a/arch/arm/mach-mv78xx0/common.c
+++ b/arch/arm/mach-mv78xx0/common.c
@@ -18,13 +18,13 @@
 #include <asm/hardware/cache-feroceon-l2.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
-#include <mach/mv78xx0.h>
-#include <mach/bridge-regs.h>
 #include <linux/platform_data/usb-ehci-orion.h>
 #include <linux/platform_data/mtd-orion_nand.h>
 #include <plat/time.h>
 #include <plat/common.h>
 #include <plat/addr-map.h>
+#include "mv78xx0.h"
+#include "bridge-regs.h"
 #include "common.h"
 
 static int get_tclk(void);
diff --git a/arch/arm/mach-mv78xx0/db78x00-bp-setup.c b/arch/arm/mach-mv78xx0/db78x00-bp-setup.c
index 0c5dd6fceb6b..cf16e08d4cf5 100644
--- a/arch/arm/mach-mv78xx0/db78x00-bp-setup.c
+++ b/arch/arm/mach-mv78xx0/db78x00-bp-setup.c
@@ -15,9 +15,9 @@
 #include <linux/mv643xx_eth.h>
 #include <linux/ethtool.h>
 #include <linux/i2c.h>
-#include <mach/mv78xx0.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include "mv78xx0.h"
 #include "common.h"
 
 static struct mv643xx_eth_platform_data db78x00_ge00_data = {
diff --git a/arch/arm/mach-mv78xx0/include/mach/hardware.h b/arch/arm/mach-mv78xx0/include/mach/hardware.h
deleted file mode 100644
index 67cab0a08e07..000000000000
--- a/arch/arm/mach-mv78xx0/include/mach/hardware.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * arch/arm/mach-mv78xx0/include/mach/hardware.h
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __ASM_ARCH_HARDWARE_H
-#define __ASM_ARCH_HARDWARE_H
-
-#include "mv78xx0.h"
-
-#endif
diff --git a/arch/arm/mach-mv78xx0/include/mach/uncompress.h b/arch/arm/mach-mv78xx0/include/mach/uncompress.h
index 6a761c44a296..2787ef392262 100644
--- a/arch/arm/mach-mv78xx0/include/mach/uncompress.h
+++ b/arch/arm/mach-mv78xx0/include/mach/uncompress.h
@@ -1,14 +1,12 @@
 /*
- * arch/arm/mach-mv78xx0/include/mach/uncompress.h
- *
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
 
 #include <linux/serial_reg.h>
-#include <mach/mv78xx0.h>
 
+#define UART0_PHYS_BASE (0xf1000000 + 0x12000)
 #define SERIAL_BASE	((unsigned char *)UART0_PHYS_BASE)
 
 static void putc(const char c)
diff --git a/arch/arm/mach-mv78xx0/irq.c b/arch/arm/mach-mv78xx0/irq.c
index 2453c33faccf..788569e960e1 100644
--- a/arch/arm/mach-mv78xx0/irq.c
+++ b/arch/arm/mach-mv78xx0/irq.c
@@ -12,9 +12,9 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <asm/exception.h>
-#include <mach/bridge-regs.h>
 #include <plat/orion-gpio.h>
 #include <plat/irq.h>
+#include "bridge-regs.h"
 #include "common.h"
 
 static int __initdata gpio0_irqs[4] = {
diff --git a/arch/arm/mach-mv78xx0/include/mach/irqs.h b/arch/arm/mach-mv78xx0/irqs.h
similarity index 98%
rename from arch/arm/mach-mv78xx0/include/mach/irqs.h
rename to arch/arm/mach-mv78xx0/irqs.h
index ac96bcf3d268..67e0fe730a13 100644
--- a/arch/arm/mach-mv78xx0/include/mach/irqs.h
+++ b/arch/arm/mach-mv78xx0/irqs.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-mv78xx0/include/mach/irqs.h
- *
  * IRQ definitions for Marvell MV78xx0 SoCs
  *
  * This file is licensed under the terms of the GNU General Public
diff --git a/arch/arm/mach-mv78xx0/mpp.c b/arch/arm/mach-mv78xx0/mpp.c
index df50342179e2..72843c02e95a 100644
--- a/arch/arm/mach-mv78xx0/mpp.c
+++ b/arch/arm/mach-mv78xx0/mpp.c
@@ -12,7 +12,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <plat/mpp.h>
-#include <mach/hardware.h>
+#include "mv78xx0.h"
 #include "common.h"
 #include "mpp.h"
 
diff --git a/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h b/arch/arm/mach-mv78xx0/mv78xx0.h
similarity index 98%
rename from arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
rename to arch/arm/mach-mv78xx0/mv78xx0.h
index 0972d5f9b46d..2db1265ec121 100644
--- a/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
+++ b/arch/arm/mach-mv78xx0/mv78xx0.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
- *
  * Generic definitions for Marvell MV78xx0 SoC flavors:
  *  MV781x0 and MV782x0.
  *
diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
index 097ea4cb1136..13a7d72ee0c4 100644
--- a/arch/arm/mach-mv78xx0/pcie.c
+++ b/arch/arm/mach-mv78xx0/pcie.c
@@ -15,7 +15,7 @@
 #include <asm/irq.h>
 #include <asm/mach/pci.h>
 #include <plat/pcie.h>
-#include <mach/mv78xx0.h>
+#include "mv78xx0.h"
 #include "common.h"
 
 #define MV78XX0_MBUS_PCIE_MEM_TARGET(port, lane) ((port) ? 8 : 4)
diff --git a/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c b/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
index a0a3debf8c21..308ab71ec822 100644
--- a/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
+++ b/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
@@ -14,9 +14,9 @@
 #include <linux/ata_platform.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/ethtool.h>
-#include <mach/mv78xx0.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include "mv78xx0.h"
 #include "common.h"
 
 static struct mv643xx_eth_platform_data rd78x00_masa_ge00_data = {
diff --git a/arch/arm/mach-orion5x/board-d2net.c b/arch/arm/mach-orion5x/board-d2net.c
index 8a7284124153..a89376a5cd92 100644
--- a/arch/arm/mach-orion5x/board-d2net.c
+++ b/arch/arm/mach-orion5x/board-d2net.c
@@ -20,9 +20,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
 #include <plat/orion-gpio.h>
 #include "common.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * LaCie d2 Network Info
diff --git a/arch/arm/mach-orion5x/board-dt.c b/arch/arm/mach-orion5x/board-dt.c
index d0871786dd8a..6f4c2c4ae2a5 100644
--- a/arch/arm/mach-orion5x/board-dt.c
+++ b/arch/arm/mach-orion5x/board-dt.c
@@ -20,10 +20,10 @@
 #include <asm/system_misc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <mach/orion5x.h>
-#include <mach/bridge-regs.h>
 #include <plat/irq.h>
 #include <plat/time.h>
+#include "orion5x.h"
+#include "bridge-regs.h"
 #include "common.h"
 
 static struct of_dev_auxdata orion5x_auxdata_lookup[] __initdata = {
diff --git a/arch/arm/mach-orion5x/board-mss2.c b/arch/arm/mach-orion5x/board-mss2.c
index 66f9c3ba86cc..79202fd626df 100644
--- a/arch/arm/mach-orion5x/board-mss2.c
+++ b/arch/arm/mach-orion5x/board-mss2.c
@@ -17,8 +17,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
-#include <mach/bridge-regs.h>
+#include "orion5x.h"
+#include "bridge-regs.h"
 #include "common.h"
 
 /*****************************************************************************
diff --git a/arch/arm/mach-orion5x/board-rd88f5182.c b/arch/arm/mach-orion5x/board-rd88f5182.c
index 270824b0e50f..b7b0f52f4c0a 100644
--- a/arch/arm/mach-orion5x/board-rd88f5182.c
+++ b/arch/arm/mach-orion5x/board-rd88f5182.c
@@ -18,8 +18,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
 #include "common.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * RD-88F5182 Info
diff --git a/arch/arm/mach-orion5x/include/mach/bridge-regs.h b/arch/arm/mach-orion5x/bridge-regs.h
similarity index 92%
rename from arch/arm/mach-orion5x/include/mach/bridge-regs.h
rename to arch/arm/mach-orion5x/bridge-regs.h
index 5766e3fbff69..305598eaaee1 100644
--- a/arch/arm/mach-orion5x/include/mach/bridge-regs.h
+++ b/arch/arm/mach-orion5x/bridge-regs.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-orion5x/include/mach/bridge-regs.h
- *
  * Orion CPU Bridge Registers
  *
  * This file is licensed under the terms of the GNU General Public
@@ -11,7 +9,7 @@
 #ifndef __ASM_ARCH_BRIDGE_REGS_H
 #define __ASM_ARCH_BRIDGE_REGS_H
 
-#include <mach/orion5x.h>
+#include "orion5x.h"
 
 #define CPU_CONF		(ORION5X_BRIDGE_VIRT_BASE + 0x100)
 
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index 2b7889e3b7bc..70c3366c8d03 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -27,14 +27,14 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
-#include <mach/bridge-regs.h>
-#include <mach/hardware.h>
-#include <mach/orion5x.h>
 #include <linux/platform_data/mtd-orion_nand.h>
 #include <linux/platform_data/usb-ehci-orion.h>
 #include <plat/time.h>
 #include <plat/common.h>
+
+#include "bridge-regs.h"
 #include "common.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * I/O Address Mapping
diff --git a/arch/arm/mach-orion5x/db88f5281-setup.c b/arch/arm/mach-orion5x/db88f5281-setup.c
index 698528fee39d..12f74b46e2ff 100644
--- a/arch/arm/mach-orion5x/db88f5281-setup.c
+++ b/arch/arm/mach-orion5x/db88f5281-setup.c
@@ -23,10 +23,10 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
 #include <linux/platform_data/mtd-orion_nand.h>
 #include "common.h"
 #include "mpp.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * DB-88F5281 on board devices
diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
index 96a8c50e7223..cd483bfb5ca8 100644
--- a/arch/arm/mach-orion5x/dns323-setup.c
+++ b/arch/arm/mach-orion5x/dns323-setup.c
@@ -33,8 +33,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <asm/system_info.h>
-#include <mach/orion5x.h>
 #include <plat/orion-gpio.h>
+#include "orion5x.h"
 #include "common.h"
 #include "mpp.h"
 
diff --git a/arch/arm/mach-orion5x/include/mach/hardware.h b/arch/arm/mach-orion5x/include/mach/hardware.h
deleted file mode 100644
index 395735482473..000000000000
--- a/arch/arm/mach-orion5x/include/mach/hardware.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * arch/arm/mach-orion5x/include/mach/hardware.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_HARDWARE_H
-#define __ASM_ARCH_HARDWARE_H
-
-#include "orion5x.h"
-
-#endif
diff --git a/arch/arm/mach-orion5x/include/mach/uncompress.h b/arch/arm/mach-orion5x/include/mach/uncompress.h
index abd26b542c3c..25e5cb98fecc 100644
--- a/arch/arm/mach-orion5x/include/mach/uncompress.h
+++ b/arch/arm/mach-orion5x/include/mach/uncompress.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-orion5x/include/mach/uncompress.h
- *
  * Tzachi Perelstein <tzachi@marvell.com>
  *
  * This file is licensed under the terms of the GNU General Public
@@ -9,8 +7,8 @@
  */
 
 #include <linux/serial_reg.h>
-#include <mach/orion5x.h>
 
+#define UART0_PHYS_BASE (0xf1000000 + 0x12000)
 #define SERIAL_BASE	((unsigned char *)UART0_PHYS_BASE)
 
 static void putc(const char c)
diff --git a/arch/arm/mach-orion5x/irq.c b/arch/arm/mach-orion5x/irq.c
index 8678db1eb1bd..de980ef9cda1 100644
--- a/arch/arm/mach-orion5x/irq.c
+++ b/arch/arm/mach-orion5x/irq.c
@@ -13,10 +13,10 @@
 #include <linux/kernel.h>
 #include <linux/irq.h>
 #include <linux/io.h>
-#include <mach/bridge-regs.h>
 #include <plat/orion-gpio.h>
 #include <plat/irq.h>
 #include <asm/exception.h>
+#include "bridge-regs.h"
 #include "common.h"
 
 static int __initdata gpio0_irqs[4] = {
diff --git a/arch/arm/mach-orion5x/include/mach/irqs.h b/arch/arm/mach-orion5x/irqs.h
similarity index 97%
rename from arch/arm/mach-orion5x/include/mach/irqs.h
rename to arch/arm/mach-orion5x/irqs.h
index 4b8703cd1ccb..506c8e0b30c4 100644
--- a/arch/arm/mach-orion5x/include/mach/irqs.h
+++ b/arch/arm/mach-orion5x/irqs.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-orion5x/include/mach/irqs.h
- *
  * IRQ definitions for Orion SoC
  *
  *  Maintainer: Tzachi Perelstein <tzachi@marvell.com>
diff --git a/arch/arm/mach-orion5x/kurobox_pro-setup.c b/arch/arm/mach-orion5x/kurobox_pro-setup.c
index b1ebb3721638..9dc3f59bed9c 100644
--- a/arch/arm/mach-orion5x/kurobox_pro-setup.c
+++ b/arch/arm/mach-orion5x/kurobox_pro-setup.c
@@ -23,10 +23,10 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
 #include <linux/platform_data/mtd-orion_nand.h>
 #include "common.h"
 #include "mpp.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * KUROBOX-PRO Info
diff --git a/arch/arm/mach-orion5x/ls-chl-setup.c b/arch/arm/mach-orion5x/ls-chl-setup.c
index cb8720e6d02b..dfdaa8a498a4 100644
--- a/arch/arm/mach-orion5x/ls-chl-setup.c
+++ b/arch/arm/mach-orion5x/ls-chl-setup.c
@@ -22,9 +22,9 @@
 #include <linux/gpio.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <mach/orion5x.h>
 #include "common.h"
 #include "mpp.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * Linkstation LS-CHL Info
diff --git a/arch/arm/mach-orion5x/ls_hgl-setup.c b/arch/arm/mach-orion5x/ls_hgl-setup.c
index 0ddfa23821ec..47ba6e0502f5 100644
--- a/arch/arm/mach-orion5x/ls_hgl-setup.c
+++ b/arch/arm/mach-orion5x/ls_hgl-setup.c
@@ -21,9 +21,9 @@
 #include <linux/gpio.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <mach/orion5x.h>
 #include "common.h"
 #include "mpp.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * Linkstation LS-HGL Info
diff --git a/arch/arm/mach-orion5x/mpp.c b/arch/arm/mach-orion5x/mpp.c
index 5b70026f478c..19ef18594415 100644
--- a/arch/arm/mach-orion5x/mpp.c
+++ b/arch/arm/mach-orion5x/mpp.c
@@ -11,8 +11,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <mach/hardware.h>
 #include <plat/mpp.h>
+#include "orion5x.h"
 #include "mpp.h"
 #include "common.h"
 
diff --git a/arch/arm/mach-orion5x/mv2120-setup.c b/arch/arm/mach-orion5x/mv2120-setup.c
index 11985dc45c47..2bf8ec75e908 100644
--- a/arch/arm/mach-orion5x/mv2120-setup.c
+++ b/arch/arm/mach-orion5x/mv2120-setup.c
@@ -21,9 +21,9 @@
 #include <linux/ata_platform.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <mach/orion5x.h>
 #include "common.h"
 #include "mpp.h"
+#include "orion5x.h"
 
 #define MV2120_NOR_BOOT_BASE	0xf4000000
 #define MV2120_NOR_BOOT_SIZE	SZ_512K
diff --git a/arch/arm/mach-orion5x/net2big-setup.c b/arch/arm/mach-orion5x/net2big-setup.c
index e91abcc2213d..bf6be4cfd238 100644
--- a/arch/arm/mach-orion5x/net2big-setup.c
+++ b/arch/arm/mach-orion5x/net2big-setup.c
@@ -24,10 +24,10 @@
 #include <linux/delay.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <mach/orion5x.h>
 #include <plat/orion-gpio.h>
 #include "common.h"
 #include "mpp.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * LaCie 2Big Network Info
diff --git a/arch/arm/mach-orion5x/include/mach/orion5x.h b/arch/arm/mach-orion5x/orion5x.h
similarity index 98%
rename from arch/arm/mach-orion5x/include/mach/orion5x.h
rename to arch/arm/mach-orion5x/orion5x.h
index 7be7c2e05465..3364df331f01 100644
--- a/arch/arm/mach-orion5x/include/mach/orion5x.h
+++ b/arch/arm/mach-orion5x/orion5x.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-orion5x/include/mach/orion5x.h
- *
  * Generic definitions of Orion SoC flavors:
  *  Orion-1, Orion-VoIP, Orion-NAS, Orion-2, and Orion-1-90.
  *
@@ -14,7 +12,7 @@
 #ifndef __ASM_ARCH_ORION5X_H
 #define __ASM_ARCH_ORION5X_H
 
-#include <mach/irqs.h>
+#include "irqs.h"
 
 /*****************************************************************************
  * Orion Address Maps
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index b02f3947be51..ecb998e7f8dc 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -19,8 +19,8 @@
 #include <asm/mach/pci.h>
 #include <plat/pcie.h>
 #include <plat/addr-map.h>
-#include <mach/orion5x.h>
 #include "common.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * Orion has one PCIe controller and one PCI controller.
diff --git a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
index 69a6e5b20b0b..c742e7b40b0d 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
@@ -20,9 +20,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
 #include "common.h"
 #include "mpp.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * RD-88F5181L FXO Info
diff --git a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
index e19f8b7f87b3..7e977b794b0c 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
@@ -21,9 +21,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
 #include "common.h"
 #include "mpp.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * RD-88F5181L GE Info
diff --git a/arch/arm/mach-orion5x/rd88f5182-setup.c b/arch/arm/mach-orion5x/rd88f5182-setup.c
index 180a4f972d3d..fe3e67c81fb8 100644
--- a/arch/arm/mach-orion5x/rd88f5182-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5182-setup.c
@@ -23,9 +23,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
 #include "common.h"
 #include "mpp.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * RD-88F5182 Info
diff --git a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
index cc5bdbe70fa9..4bf80dd5478c 100644
--- a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
@@ -22,8 +22,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
 #include "common.h"
+#include "orion5x.h"
 
 static struct mv643xx_eth_platform_data rd88f6183ap_ge_eth_data = {
 	.phy_addr	= -1,
diff --git a/arch/arm/mach-orion5x/terastation_pro2-setup.c b/arch/arm/mach-orion5x/terastation_pro2-setup.c
index ad2057514deb..deb5e29ac669 100644
--- a/arch/arm/mach-orion5x/terastation_pro2-setup.c
+++ b/arch/arm/mach-orion5x/terastation_pro2-setup.c
@@ -22,9 +22,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
 #include "common.h"
 #include "mpp.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * Terastation Pro 2/Live Info
diff --git a/arch/arm/mach-orion5x/ts209-setup.c b/arch/arm/mach-orion5x/ts209-setup.c
index 1cfc364c9b1e..7bd671b2854c 100644
--- a/arch/arm/mach-orion5x/ts209-setup.c
+++ b/arch/arm/mach-orion5x/ts209-setup.c
@@ -25,9 +25,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
 #include "common.h"
 #include "mpp.h"
+#include "orion5x.h"
 #include "tsx09-common.h"
 
 #define QNAP_TS209_NOR_BOOT_BASE 0xf4000000
diff --git a/arch/arm/mach-orion5x/ts409-setup.c b/arch/arm/mach-orion5x/ts409-setup.c
index bc985cf44625..a77613b14db5 100644
--- a/arch/arm/mach-orion5x/ts409-setup.c
+++ b/arch/arm/mach-orion5x/ts409-setup.c
@@ -27,9 +27,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
 #include "common.h"
 #include "mpp.h"
+#include "orion5x.h"
 #include "tsx09-common.h"
 
 /*****************************************************************************
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index 5a61a66ce012..b67ace446576 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -23,9 +23,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <mach/orion5x.h>
 #include "common.h"
 #include "mpp.h"
+#include "orion5x.h"
 #include "ts78xx-fpga.h"
 
 /*****************************************************************************
diff --git a/arch/arm/mach-orion5x/tsx09-common.c b/arch/arm/mach-orion5x/tsx09-common.c
index d42e006597c7..89774985d380 100644
--- a/arch/arm/mach-orion5x/tsx09-common.c
+++ b/arch/arm/mach-orion5x/tsx09-common.c
@@ -15,7 +15,7 @@
 #include <linux/mv643xx_eth.h>
 #include <linux/timex.h>
 #include <linux/serial_reg.h>
-#include <mach/orion5x.h>
+#include "orion5x.h"
 #include "tsx09-common.h"
 #include "common.h"
 
diff --git a/arch/arm/mach-orion5x/wnr854t-setup.c b/arch/arm/mach-orion5x/wnr854t-setup.c
index bcc6e12dcdac..4e1e5c8f6111 100644
--- a/arch/arm/mach-orion5x/wnr854t-setup.c
+++ b/arch/arm/mach-orion5x/wnr854t-setup.c
@@ -19,7 +19,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
+#include "orion5x.h"
 #include "common.h"
 #include "mpp.h"
 
diff --git a/arch/arm/mach-orion5x/wrt350n-v2-setup.c b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
index 4068d7a3e466..61e9027ef224 100644
--- a/arch/arm/mach-orion5x/wrt350n-v2-setup.c
+++ b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
@@ -22,7 +22,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
+#include "orion5x.h"
 #include "common.h"
 #include "mpp.h"
 
diff --git a/arch/arm/plat-orion/irq.c b/arch/arm/plat-orion/irq.c
index 8c1fc06007c0..5b63b28b00ac 100644
--- a/arch/arm/plat-orion/irq.c
+++ b/arch/arm/plat-orion/irq.c
@@ -18,7 +18,6 @@
 #include <asm/exception.h>
 #include <plat/irq.h>
 #include <plat/orion-gpio.h>
-#include <mach/bridge-regs.h>
 
 void __init orion_irq_init(unsigned int irq_start, void __iomem *maskaddr)
 {
diff --git a/arch/arm/plat-orion/mpp.c b/arch/arm/plat-orion/mpp.c
index 7310bcfb299f..5b4ff9373c89 100644
--- a/arch/arm/plat-orion/mpp.c
+++ b/arch/arm/plat-orion/mpp.c
@@ -13,7 +13,6 @@
 #include <linux/mbus.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
-#include <mach/hardware.h>
 #include <plat/orion-gpio.h>
 #include <plat/mpp.h>
 
-- 
2.1.0.rc2
