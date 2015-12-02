From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  2 Dec 2015 22:27:06 +0100
Subject: [PATCH 4/7] ARM: mv78xx0: clean up mach/*.h headers
In-Reply-To: <1449091629-2155735-1-git-send-email-arnd@arndb.de>
References: <1449091629-2155735-1-git-send-email-arnd@arndb.de>
Message-ID: <1449091629-2155735-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a simple move of all header files that are no longer
included by anything else from the include/mach directory
to the platform directory itself as preparation for
multiplatform support.

The mach/uncompress.h headers are left in place for now,
and are mildly modified to be independent of the other
headers. They will be removed entirely when ARCH_MULTIPLATFORM
gets enabled and they become obsolete.

Rather than updating the path names inside of the comments
of each header, I delete those comments to avoid having to
update them again, should they get moved or copied another
time.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-mv78xx0/{include/mach => }/bridge-regs.h |  4 +---
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c              |  2 +-
 arch/arm/mach-mv78xx0/common.c                         |  4 ++--
 arch/arm/mach-mv78xx0/db78x00-bp-setup.c               |  2 +-
 arch/arm/mach-mv78xx0/include/mach/hardware.h          | 14 --------------
 arch/arm/mach-mv78xx0/include/mach/uncompress.h        |  4 +---
 arch/arm/mach-mv78xx0/irq.c                            |  2 +-
 arch/arm/mach-mv78xx0/{include/mach => }/irqs.h        |  2 --
 arch/arm/mach-mv78xx0/mpp.c                            |  2 +-
 arch/arm/mach-mv78xx0/{include/mach => }/mv78xx0.h     |  2 --
 arch/arm/mach-mv78xx0/pcie.c                           |  2 +-
 arch/arm/mach-mv78xx0/rd78x00-masa-setup.c             |  2 +-
 12 files changed, 10 insertions(+), 32 deletions(-)
 rename arch/arm/mach-mv78xx0/{include/mach => }/bridge-regs.h (92%)
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/hardware.h
 rename arch/arm/mach-mv78xx0/{include/mach => }/irqs.h (98%)
 rename arch/arm/mach-mv78xx0/{include/mach => }/mv78xx0.h (98%)

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
-- 
2.1.0.rc2
