From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  4 Mar 2015 20:33:11 +0100
Subject: [RFC PATCH 17/18] ARM: msm: make all header files local
In-Reply-To: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
References: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
Message-ID: <1425497592-1831064-18-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nothing outside of mach-msm includes the headers any more,
so we can simply move them all into the main platform
directory for msm.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-msm/board-halibut.c                     |  8 +++-----
 arch/arm/mach-msm/board-msm7x30.c                     | 11 +++++------
 arch/arm/mach-msm/board-qsd8x50.c                     | 13 ++++++-------
 arch/arm/mach-msm/board-sapphire.c                    | 11 ++++-------
 arch/arm/mach-msm/board-trout-gpio.c                  |  2 +-
 arch/arm/mach-msm/board-trout-mmc.c                   | 14 +++++---------
 arch/arm/mach-msm/board-trout-panel.c                 |  2 +-
 arch/arm/mach-msm/board-trout.c                       |  8 +++-----
 arch/arm/mach-msm/board-trout.h                       |  2 +-
 arch/arm/mach-msm/{include/mach => }/clk.h            |  0
 arch/arm/mach-msm/clock-pcom.c                        |  5 ++---
 arch/arm/mach-msm/clock.h                             |  2 +-
 arch/arm/mach-msm/devices-msm7x00.c                   | 13 ++++++-------
 arch/arm/mach-msm/devices-msm7x30.c                   | 19 ++++++++-----------
 arch/arm/mach-msm/devices-qsd8x50.c                   | 17 +++++++----------
 arch/arm/mach-msm/gpio-msm-v1.c                       |  2 +-
 arch/arm/mach-msm/gpiomux.h                           |  2 +-
 arch/arm/mach-msm/include/mach/hardware.h             | 18 ------------------
 arch/arm/mach-msm/irq-vic.c                           |  5 +----
 arch/arm/mach-msm/irq.c                               |  6 ++----
 arch/arm/mach-msm/{include/mach => }/irqs-7x00.h      |  0
 arch/arm/mach-msm/{include/mach => }/irqs-7x30.h      |  0
 arch/arm/mach-msm/{include/mach => }/irqs-8x50.h      |  0
 arch/arm/mach-msm/{include/mach => }/msm_gpiomux.h    |  0
 arch/arm/mach-msm/{include/mach => }/msm_iomap-7x00.h |  3 +--
 arch/arm/mach-msm/{include/mach => }/msm_iomap-7x30.h |  0
 arch/arm/mach-msm/{include/mach => }/msm_iomap-8x50.h |  0
 arch/arm/mach-msm/{include/mach => }/msm_iomap.h      |  0
 arch/arm/mach-msm/proc_comm.c                         |  2 +-
 arch/arm/mach-msm/sirc.c                              |  5 +++--
 arch/arm/mach-msm/{include/mach => }/sirc.h           |  0
 arch/arm/mach-msm/smd.c                               |  2 +-
 arch/arm/mach-msm/smd_debug.c                         |  3 +--
 arch/arm/mach-msm/smd_private.h                       |  2 +-
 arch/arm/mach-msm/vreg.c                              |  2 +-
 arch/arm/mach-msm/{include/mach => }/vreg.h           |  0
 36 files changed, 67 insertions(+), 112 deletions(-)
 rename arch/arm/mach-msm/{include/mach => }/clk.h (100%)
 delete mode 100644 arch/arm/mach-msm/include/mach/hardware.h
 rename arch/arm/mach-msm/{include/mach => }/irqs-7x00.h (100%)
 rename arch/arm/mach-msm/{include/mach => }/irqs-7x30.h (100%)
 rename arch/arm/mach-msm/{include/mach => }/irqs-8x50.h (100%)
 rename arch/arm/mach-msm/{include/mach => }/msm_gpiomux.h (100%)
 rename arch/arm/mach-msm/{include/mach => }/msm_iomap-7x00.h (98%)
 rename arch/arm/mach-msm/{include/mach => }/msm_iomap-7x30.h (100%)
 rename arch/arm/mach-msm/{include/mach => }/msm_iomap-8x50.h (100%)
 rename arch/arm/mach-msm/{include/mach => }/msm_iomap.h (100%)
 rename arch/arm/mach-msm/{include/mach => }/sirc.h (100%)
 rename arch/arm/mach-msm/{include/mach => }/vreg.h (100%)

diff --git a/arch/arm/mach-msm/board-halibut.c b/arch/arm/mach-msm/board-halibut.c
index 15fd63e88018..04f6822b05c1 100644
--- a/arch/arm/mach-msm/board-halibut.c
+++ b/arch/arm/mach-msm/board-halibut.c
@@ -21,21 +21,19 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/flash.h>
 #include <asm/setup.h>
 
-#include <mach/irqs-7x00.h>
-#include <mach/msm_iomap-7x00.h>
-
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 
-#include "devices.h"
 #include "common.h"
+#include "devices.h"
+#include "irqs-7x00.h"
+#include "msm_iomap-7x00.h"
 
 static struct resource smc91x_resources[] = {
 	[0] = {
diff --git a/arch/arm/mach-msm/board-msm7x30.c b/arch/arm/mach-msm/board-msm7x30.c
index e0eb8cf9c53c..d9223e5eaccc 100644
--- a/arch/arm/mach-msm/board-msm7x30.c
+++ b/arch/arm/mach-msm/board-msm7x30.c
@@ -30,15 +30,14 @@
 #include <asm/memory.h>
 #include <asm/setup.h>
 
-#include <mach/clk.h>
-#include <mach/irqs-7x30.h>
-#include <mach/msm_iomap-7x30.h>
-
-#include <mach/vreg.h>
+#include "clk.h"
+#include "common.h"
 #include "devices.h"
 #include "gpiomux.h"
+#include "irqs-7x30.h"
+#include "msm_iomap-7x30.h"
 #include "proc_comm.h"
-#include "common.h"
+#include "vreg.h"
 
 static void __init msm7x30_fixup(struct tag *tag, char **cmdline)
 {
diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
index 14c3c240fc44..4d467a51f259 100644
--- a/arch/arm/mach-msm/board-qsd8x50.c
+++ b/arch/arm/mach-msm/board-qsd8x50.c
@@ -17,6 +17,7 @@
 #include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/irq.h>
+#include <linux/platform_data/mmc-msm_sdcc.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/usb/msm_hsusb.h>
@@ -28,15 +29,13 @@
 #include <asm/io.h>
 #include <asm/setup.h>
 
-#include <mach/irqs-8x50.h>
-#include <mach/sirc.h>
-#include <mach/vreg.h>
-#include <mach/clk.h>
-#include <linux/platform_data/mmc-msm_sdcc.h>
-
-#include "devices.h"
+#include "clk.h"
 #include "common.h"
+#include "devices.h"
 #include "gpiomux.h"
+#include "irqs-8x50.h"
+#include "sirc.h"
+#include "vreg.h"
 
 static const resource_size_t qsd8x50_surf_smc91x_base __initconst = 0x70000300;
 static const unsigned        qsd8x50_surf_smc91x_gpio __initconst = 156;
diff --git a/arch/arm/mach-msm/board-sapphire.c b/arch/arm/mach-msm/board-sapphire.c
index e3aa71e839f4..5cd3056e3497 100644
--- a/arch/arm/mach-msm/board-sapphire.c
+++ b/arch/arm/mach-msm/board-sapphire.c
@@ -19,16 +19,12 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/device.h>
-
 #include <linux/delay.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/flash.h>
-#include <mach/vreg.h>
-
 #include <asm/io.h>
 #include <asm/delay.h>
 #include <asm/setup.h>
@@ -37,11 +33,12 @@
 #include <linux/mtd/partitions.h>
 #include <linux/memblock.h>
 
-#include "gpio_chip.h"
 #include "board-sapphire.h"
-#include "proc_comm.h"
-#include "devices.h"
 #include "common.h"
+#include "devices.h"
+#include "gpio_chip.h"
+#include "proc_comm.h"
+#include "vreg.h"
 
 void msm_init_irq(void);
 void msm_init_gpio(void);
diff --git a/arch/arm/mach-msm/board-trout-gpio.c b/arch/arm/mach-msm/board-trout-gpio.c
index 4daf7816c736..d8e75a4e2a44 100644
--- a/arch/arm/mach-msm/board-trout-gpio.c
+++ b/arch/arm/mach-msm/board-trout-gpio.c
@@ -18,8 +18,8 @@
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
 
-#include <mach/irqs-7x00.h>
 #include "board-trout.h"
+#include "irqs-7x00.h"
 
 static uint8_t trout_int_mask[2] = {
 	[0] = 0xff, /* mask all interrupts */
diff --git a/arch/arm/mach-msm/board-trout-mmc.c b/arch/arm/mach-msm/board-trout-mmc.c
index 334de79de87e..382dcd166707 100644
--- a/arch/arm/mach-msm/board-trout-mmc.c
+++ b/arch/arm/mach-msm/board-trout-mmc.c
@@ -5,6 +5,7 @@
 #include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/platform_data/mmc-msm_sdcc.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/mmc/host.h>
@@ -14,17 +15,12 @@
 
 #include <asm/io.h>
 
-#include <mach/vreg.h>
-#include <mach/clk.h>
-#include <mach/irqs-7x00.h>
-
-#include <linux/platform_data/mmc-msm_sdcc.h>
-
-#include "devices.h"
-
 #include "board-trout.h"
-
+#include "clk.h"
+#include "devices.h"
+#include "irqs-7x00.h"
 #include "proc_comm.h"
+#include "vreg.h"
 
 #define DEBUG_SDSLOT_VDD 1
 
diff --git a/arch/arm/mach-msm/board-trout-panel.c b/arch/arm/mach-msm/board-trout-panel.c
index e06c4f309fda..3e5961787271 100644
--- a/arch/arm/mach-msm/board-trout-panel.c
+++ b/arch/arm/mach-msm/board-trout-panel.c
@@ -14,12 +14,12 @@
 #include <asm/system_info.h>
 
 #include <linux/platform_data/video-msm_fb.h>
-#include <mach/vreg.h>
 
 #include "board-trout.h"
 #include "proc_comm.h"
 #include "clock-pcom.h"
 #include "devices.h"
+#include "vreg.h"
 
 #define TROUT_DEFAULT_BACKLIGHT_BRIGHTNESS 255
 
diff --git a/arch/arm/mach-msm/board-trout.c b/arch/arm/mach-msm/board-trout.c
index 16a2f8912d3b..d3e3840e7366 100644
--- a/arch/arm/mach-msm/board-trout.c
+++ b/arch/arm/mach-msm/board-trout.c
@@ -27,13 +27,11 @@
 #include <asm/mach/map.h>
 #include <asm/setup.h>
 
-#include <mach/hardware.h>
-#include <mach/irqs-7x00.h>
-#include <mach/msm_iomap-7x00.h>
-
-#include "devices.h"
 #include "board-trout.h"
 #include "common.h"
+#include "devices.h"
+#include "irqs-7x00.h"
+#include "msm_iomap-7x00.h"
 
 extern int trout_init_mmc(unsigned int);
 
diff --git a/arch/arm/mach-msm/board-trout.h b/arch/arm/mach-msm/board-trout.h
index adb757abbb92..fc96b09cfaee 100644
--- a/arch/arm/mach-msm/board-trout.h
+++ b/arch/arm/mach-msm/board-trout.h
@@ -41,7 +41,7 @@
 #endif
 
 #define DECLARE_MSM_IOMAP
-#include <mach/msm_iomap.h>
+#include "msm_iomap.h"
 
 #define TROUT_4_BALL_UP_0     1
 #define TROUT_4_BALL_LEFT_0   18
diff --git a/arch/arm/mach-msm/include/mach/clk.h b/arch/arm/mach-msm/clk.h
similarity index 100%
rename from arch/arm/mach-msm/include/mach/clk.h
rename to arch/arm/mach-msm/clk.h
diff --git a/arch/arm/mach-msm/clock-pcom.c b/arch/arm/mach-msm/clock-pcom.c
index f5b69d736ee5..a1a926790873 100644
--- a/arch/arm/mach-msm/clock-pcom.c
+++ b/arch/arm/mach-msm/clock-pcom.c
@@ -20,11 +20,10 @@
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 
-#include <mach/clk.h>
-
-#include "proc_comm.h"
+#include "clk.h"
 #include "clock.h"
 #include "clock-pcom.h"
+#include "proc_comm.h"
 
 struct clk_pcom {
 	unsigned id;
diff --git a/arch/arm/mach-msm/clock.h b/arch/arm/mach-msm/clock.h
index 42d29dd7aafc..a49837da79dd 100644
--- a/arch/arm/mach-msm/clock.h
+++ b/arch/arm/mach-msm/clock.h
@@ -18,7 +18,7 @@
 #define __ARCH_ARM_MACH_MSM_CLOCK_H
 
 #include <linux/clk-provider.h>
-#include <mach/clk.h>
+#include "clk.h"
 
 #define CLK_FIRST_AVAILABLE_FLAG	0x00000100
 #define CLKFLAG_AUTO_OFF		0x00000200
diff --git a/arch/arm/mach-msm/devices-msm7x00.c b/arch/arm/mach-msm/devices-msm7x00.c
index 84bd323aff5e..e08f00338fd4 100644
--- a/arch/arm/mach-msm/devices-msm7x00.c
+++ b/arch/arm/mach-msm/devices-msm7x00.c
@@ -14,22 +14,21 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/platform_data/mmc-msm_sdcc.h>
 #include <linux/platform_device.h>
 #include <linux/clkdev.h>
 #include <asm/mach/map.h>
 
-#include <mach/irqs-7x00.h>
-#include <mach/msm_iomap.h>
-#include <mach/msm_iomap-7x00.h>
-#include "devices.h"
-
 #include <asm/mach/flash.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 
-#include "clock.h"
 #include "clock-pcom.h"
-#include <linux/platform_data/mmc-msm_sdcc.h>
+#include "clock.h"
+#include "devices.h"
+#include "irqs-7x00.h"
+#include "msm_iomap-7x00.h"
+#include "msm_iomap.h"
 
 static struct map_desc msm_io_desc[] __initdata = {
 	MSM_DEVICE_TYPE(VIC, MT_DEVICE_NONSHARED),
diff --git a/arch/arm/mach-msm/devices-msm7x30.c b/arch/arm/mach-msm/devices-msm7x30.c
index 0094278f24d2..f88db1d3f36a 100644
--- a/arch/arm/mach-msm/devices-msm7x30.c
+++ b/arch/arm/mach-msm/devices-msm7x30.c
@@ -14,25 +14,22 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/platform_data/mmc-msm_sdcc.h>
 #include <linux/platform_device.h>
-
 #include <linux/dma-mapping.h>
 #include <linux/clkdev.h>
-#include <asm/mach/map.h>
-#include <mach/irqs-7x30.h>
-#include <mach/msm_iomap-7x30.h>
-
-#include "devices.h"
-#include "smd_private.h"
-#include "common.h"
 
+#include <asm/mach/map.h>
 #include <asm/mach/flash.h>
 
-#include "clock.h"
 #include "clock-pcom.h"
+#include "clock.h"
+#include "common.h"
+#include "devices.h"
+#include "irqs-7x30.h"
+#include "msm_iomap-7x30.h"
 #include "proc_comm.h"
-
-#include <linux/platform_data/mmc-msm_sdcc.h>
+#include "smd_private.h"
 
 static struct map_desc msm7x30_io_desc[] __initdata = {
 	MSM_DEVICE(VIC),
diff --git a/arch/arm/mach-msm/devices-qsd8x50.c b/arch/arm/mach-msm/devices-qsd8x50.c
index e96c1e6a36e3..bfec5b8f7071 100644
--- a/arch/arm/mach-msm/devices-qsd8x50.c
+++ b/arch/arm/mach-msm/devices-qsd8x50.c
@@ -14,23 +14,20 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/platform_data/mmc-msm_sdcc.h>
 #include <linux/platform_device.h>
 #include <linux/clkdev.h>
 #include <linux/dma-mapping.h>
 #include <asm/mach/map.h>
-
-#include <mach/irqs-8x50.h>
-#include <mach/msm_iomap.h>
-#include <mach/msm_iomap-8x50.h>
-
-#include "devices.h"
-#include "common.h"
-
 #include <asm/mach/flash.h>
 
-#include <linux/platform_data/mmc-msm_sdcc.h>
-#include "clock.h"
 #include "clock-pcom.h"
+#include "clock.h"
+#include "common.h"
+#include "devices.h"
+#include "irqs-8x50.h"
+#include "msm_iomap-8x50.h"
+#include "msm_iomap.h"
 
 static struct map_desc qsd8x50_io_desc[] __initdata = {
 	MSM_DEVICE(VIC),
diff --git a/arch/arm/mach-msm/gpio-msm-v1.c b/arch/arm/mach-msm/gpio-msm-v1.c
index 2700f9bda455..e90cdbf391ab 100644
--- a/arch/arm/mach-msm/gpio-msm-v1.c
+++ b/arch/arm/mach-msm/gpio-msm-v1.c
@@ -23,7 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/err.h>
 
-#include <mach/msm_gpiomux.h>
+#include "msm_gpiomux.h"
 
 /* see 80-VA736-2 Rev C pp 695-751
 **
diff --git a/arch/arm/mach-msm/gpiomux.h b/arch/arm/mach-msm/gpiomux.h
index cdc1578d1e73..fbb3bb969547 100644
--- a/arch/arm/mach-msm/gpiomux.h
+++ b/arch/arm/mach-msm/gpiomux.h
@@ -19,7 +19,7 @@
 
 #include <linux/bitops.h>
 #include <linux/errno.h>
-#include <mach/msm_gpiomux.h>
+#include "msm_gpiomux.h"
 #include "gpiomux-v1.h"
 
 /**
diff --git a/arch/arm/mach-msm/include/mach/hardware.h b/arch/arm/mach-msm/include/mach/hardware.h
deleted file mode 100644
index 2d126091ae41..000000000000
--- a/arch/arm/mach-msm/include/mach/hardware.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* arch/arm/mach-msm/include/mach/hardware.h
- *
- * Copyright (C) 2007 Google, Inc.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#ifndef __ASM_ARCH_MSM_HARDWARE_H
-
-#endif
diff --git a/arch/arm/mach-msm/irq-vic.c b/arch/arm/mach-msm/irq-vic.c
index 55a39cdaf3f8..5c8d0f2715e0 100644
--- a/arch/arm/mach-msm/irq-vic.c
+++ b/arch/arm/mach-msm/irq-vic.c
@@ -25,10 +25,7 @@
 #include <asm/exception.h>
 #include <asm/cacheflush.h>
 
-#include <mach/hardware.h>
-
-#include <mach/msm_iomap.h>
-
+#include "msm_iomap.h"
 #include "smd_private.h"
 
 enum {
diff --git a/arch/arm/mach-msm/irq.c b/arch/arm/mach-msm/irq.c
index 6b1a918c7592..fe51a2cf9d6d 100644
--- a/arch/arm/mach-msm/irq.c
+++ b/arch/arm/mach-msm/irq.c
@@ -23,10 +23,8 @@
 #include <linux/io.h>
 #include <asm/exception.h>
 
-#include <mach/irqs-7x00.h>
-#include <mach/hardware.h>
-
-#include <mach/msm_iomap.h>
+#include "irqs-7x00.h"
+#include "msm_iomap.h"
 
 #define VIC_REG(off) (MSM_VIC_BASE + (off))
 
diff --git a/arch/arm/mach-msm/include/mach/irqs-7x00.h b/arch/arm/mach-msm/irqs-7x00.h
similarity index 100%
rename from arch/arm/mach-msm/include/mach/irqs-7x00.h
rename to arch/arm/mach-msm/irqs-7x00.h
diff --git a/arch/arm/mach-msm/include/mach/irqs-7x30.h b/arch/arm/mach-msm/irqs-7x30.h
similarity index 100%
rename from arch/arm/mach-msm/include/mach/irqs-7x30.h
rename to arch/arm/mach-msm/irqs-7x30.h
diff --git a/arch/arm/mach-msm/include/mach/irqs-8x50.h b/arch/arm/mach-msm/irqs-8x50.h
similarity index 100%
rename from arch/arm/mach-msm/include/mach/irqs-8x50.h
rename to arch/arm/mach-msm/irqs-8x50.h
diff --git a/arch/arm/mach-msm/include/mach/msm_gpiomux.h b/arch/arm/mach-msm/msm_gpiomux.h
similarity index 100%
rename from arch/arm/mach-msm/include/mach/msm_gpiomux.h
rename to arch/arm/mach-msm/msm_gpiomux.h
diff --git a/arch/arm/mach-msm/include/mach/msm_iomap-7x00.h b/arch/arm/mach-msm/msm_iomap-7x00.h
similarity index 98%
rename from arch/arm/mach-msm/include/mach/msm_iomap-7x00.h
rename to arch/arm/mach-msm/msm_iomap-7x00.h
index 27c7f5c0e708..058612bb23bf 100644
--- a/arch/arm/mach-msm/include/mach/msm_iomap-7x00.h
+++ b/arch/arm/mach-msm/msm_iomap-7x00.h
@@ -1,5 +1,4 @@
-/* arch/arm/mach-msm/include/mach/msm_iomap.h
- *
+/*
  * Copyright (C) 2007 Google, Inc.
  * Copyright (c) 2011, Code Aurora Forum. All rights reserved.
  * Author: Brian Swetland <swetland@google.com>
diff --git a/arch/arm/mach-msm/include/mach/msm_iomap-7x30.h b/arch/arm/mach-msm/msm_iomap-7x30.h
similarity index 100%
rename from arch/arm/mach-msm/include/mach/msm_iomap-7x30.h
rename to arch/arm/mach-msm/msm_iomap-7x30.h
diff --git a/arch/arm/mach-msm/include/mach/msm_iomap-8x50.h b/arch/arm/mach-msm/msm_iomap-8x50.h
similarity index 100%
rename from arch/arm/mach-msm/include/mach/msm_iomap-8x50.h
rename to arch/arm/mach-msm/msm_iomap-8x50.h
diff --git a/arch/arm/mach-msm/include/mach/msm_iomap.h b/arch/arm/mach-msm/msm_iomap.h
similarity index 100%
rename from arch/arm/mach-msm/include/mach/msm_iomap.h
rename to arch/arm/mach-msm/msm_iomap.h
diff --git a/arch/arm/mach-msm/proc_comm.c b/arch/arm/mach-msm/proc_comm.c
index f79f57d7a0dd..44788f346b1b 100644
--- a/arch/arm/mach-msm/proc_comm.c
+++ b/arch/arm/mach-msm/proc_comm.c
@@ -18,8 +18,8 @@
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/spinlock.h>
-#include <mach/msm_iomap.h>
 
+#include "msm_iomap.h"
 #include "proc_comm.h"
 
 /* msm7x00 uses a different method and needs to override
diff --git a/arch/arm/mach-msm/sirc.c b/arch/arm/mach-msm/sirc.c
index bfef62c0e8dc..60b305918097 100644
--- a/arch/arm/mach-msm/sirc.c
+++ b/arch/arm/mach-msm/sirc.c
@@ -20,8 +20,9 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <asm/irq.h>
-#include <mach/msm_iomap-8x50.h>
-#include <mach/sirc.h>
+
+#include "msm_iomap-8x50.h"
+#include "sirc.h"
 
 #define SPSS_SIRC_INT_SELECT          (MSM_SIRC_BASE + 0x00)
 #define SPSS_SIRC_INT_ENABLE          (MSM_SIRC_BASE + 0x04)
diff --git a/arch/arm/mach-msm/include/mach/sirc.h b/arch/arm/mach-msm/sirc.h
similarity index 100%
rename from arch/arm/mach-msm/include/mach/sirc.h
rename to arch/arm/mach-msm/sirc.h
diff --git a/arch/arm/mach-msm/smd.c b/arch/arm/mach-msm/smd.c
index b50b495ab281..54fb5703809e 100644
--- a/arch/arm/mach-msm/smd.c
+++ b/arch/arm/mach-msm/smd.c
@@ -31,8 +31,8 @@
 
 #include <linux/msm_smd.h>
 
-#include "smd_private.h"
 #include "proc_comm.h"
+#include "smd_private.h"
 
 enum msm_smd_version {
 	SMD_MSM7X00,
diff --git a/arch/arm/mach-msm/smd_debug.c b/arch/arm/mach-msm/smd_debug.c
index daffcc9e802d..e81ff1224f63 100644
--- a/arch/arm/mach-msm/smd_debug.c
+++ b/arch/arm/mach-msm/smd_debug.c
@@ -17,8 +17,7 @@
 #include <linux/debugfs.h>
 #include <linux/list.h>
 
-#include <mach/msm_iomap.h>
-
+#include "msm_iomap.h"
 #include "smd_private.h"
 
 static char *chstate(unsigned n)
diff --git a/arch/arm/mach-msm/smd_private.h b/arch/arm/mach-msm/smd_private.h
index 50f7b7d22023..7f88fa61f487 100644
--- a/arch/arm/mach-msm/smd_private.h
+++ b/arch/arm/mach-msm/smd_private.h
@@ -21,7 +21,7 @@
 #include <linux/list.h>
 #include <linux/io.h>
 
-#include <mach/msm_iomap.h>
+#include "msm_iomap.h"
 
 struct smem_heap_info {
 	unsigned initialized;
diff --git a/arch/arm/mach-msm/vreg.c b/arch/arm/mach-msm/vreg.c
index bd66ed04d6dc..c947c8180b85 100644
--- a/arch/arm/mach-msm/vreg.c
+++ b/arch/arm/mach-msm/vreg.c
@@ -21,9 +21,9 @@
 #include <linux/debugfs.h>
 #include <linux/module.h>
 #include <linux/string.h>
-#include <mach/vreg.h>
 
 #include "proc_comm.h"
+#include "vreg.h"
 
 struct vreg {
 	const char *name;
diff --git a/arch/arm/mach-msm/include/mach/vreg.h b/arch/arm/mach-msm/vreg.h
similarity index 100%
rename from arch/arm/mach-msm/include/mach/vreg.h
rename to arch/arm/mach-msm/vreg.h
-- 
2.1.0.rc2
