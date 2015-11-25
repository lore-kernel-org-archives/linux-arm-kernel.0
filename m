From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 16:37:54 +0100
Subject: [PATCH 6/7] ARM: mmp: make all header files local
In-Reply-To: <1448465875-435039-1-git-send-email-arnd@arndb.de>
References: <1448465875-435039-1-git-send-email-arnd@arndb.de>
Message-ID: <1448465875-435039-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mach/*.h headers are now inaccessible to any external code,
so we can move them all into the mach-mmp directory itself
and remove the subdirectories.

A few headers are not used at all, so we remove them here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-mmp/{include/mach => }/addr-map.h    |  2 --
 arch/arm/mach-mmp/aspenite.c                       |  8 ++---
 arch/arm/mach-mmp/avengers_lite.c                  |  8 ++---
 arch/arm/mach-mmp/brownstone.c                     |  8 ++---
 arch/arm/mach-mmp/clock-mmp2.c                     |  2 +-
 arch/arm/mach-mmp/clock-pxa168.c                   |  2 +-
 arch/arm/mach-mmp/clock-pxa910.c                   |  2 +-
 arch/arm/mach-mmp/clock.c                          |  2 +-
 arch/arm/mach-mmp/clock.h                          |  2 --
 arch/arm/mach-mmp/common.c                         |  4 +--
 arch/arm/mach-mmp/{include/mach => }/cputype.h     |  0
 arch/arm/mach-mmp/devices.c                        |  8 ++---
 arch/arm/mach-mmp/{include/mach => }/devices.h     |  0
 arch/arm/mach-mmp/flint.c                          |  8 ++---
 arch/arm/mach-mmp/gplugd.c                         |  6 ++--
 arch/arm/mach-mmp/include/mach/hardware.h          |  4 ---
 arch/arm/mach-mmp/include/mach/regs-smc.h          | 37 ----------------------
 arch/arm/mach-mmp/{include/mach => }/irqs.h        |  0
 arch/arm/mach-mmp/jasper.c                         |  8 ++---
 arch/arm/mach-mmp/{include/mach => }/mfp-mmp2.h    |  2 +-
 arch/arm/mach-mmp/{include/mach => }/mfp-pxa168.h  |  2 +-
 arch/arm/mach-mmp/{include/mach => }/mfp-pxa910.h  |  2 +-
 arch/arm/mach-mmp/{include/mach => }/mfp.h         |  0
 arch/arm/mach-mmp/mmp2.c                           | 16 +++++-----
 arch/arm/mach-mmp/{include/mach => }/mmp2.h        |  3 +-
 arch/arm/mach-mmp/pm-mmp2.c                        | 12 +++----
 arch/arm/mach-mmp/{include/mach => }/pm-mmp2.h     |  2 +-
 arch/arm/mach-mmp/pm-pxa910.c                      | 12 +++----
 arch/arm/mach-mmp/{include/mach => }/pm-pxa910.h   |  0
 arch/arm/mach-mmp/pxa168.c                         | 22 ++++++-------
 arch/arm/mach-mmp/{include/mach => }/pxa168.h      |  5 +--
 arch/arm/mach-mmp/pxa910.c                         | 16 +++++-----
 arch/arm/mach-mmp/{include/mach => }/pxa910.h      |  3 +-
 arch/arm/mach-mmp/{include/mach => }/regs-apbc.h   |  4 +--
 arch/arm/mach-mmp/{include/mach => }/regs-apmu.h   |  4 +--
 arch/arm/mach-mmp/{include/mach => }/regs-icu.h    |  4 +--
 arch/arm/mach-mmp/{include/mach => }/regs-timers.h |  4 +--
 arch/arm/mach-mmp/{include/mach => }/regs-usb.h    |  0
 arch/arm/mach-mmp/tavorevb.c                       |  8 ++---
 arch/arm/mach-mmp/teton_bga.c                      | 10 +++---
 arch/arm/mach-mmp/{include/mach => }/teton_bga.h   |  2 --
 arch/arm/mach-mmp/time.c                           | 11 +++----
 arch/arm/mach-mmp/ttc_dkb.c                        | 10 +++---
 43 files changed, 106 insertions(+), 159 deletions(-)
 rename arch/arm/mach-mmp/{include/mach => }/addr-map.h (96%)
 rename arch/arm/mach-mmp/{include/mach => }/cputype.h (100%)
 rename arch/arm/mach-mmp/{include/mach => }/devices.h (100%)
 delete mode 100644 arch/arm/mach-mmp/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-mmp/include/mach/regs-smc.h
 rename arch/arm/mach-mmp/{include/mach => }/irqs.h (100%)
 rename arch/arm/mach-mmp/{include/mach => }/mfp-mmp2.h (99%)
 rename arch/arm/mach-mmp/{include/mach => }/mfp-pxa168.h (99%)
 rename arch/arm/mach-mmp/{include/mach => }/mfp-pxa910.h (99%)
 rename arch/arm/mach-mmp/{include/mach => }/mfp.h (100%)
 rename arch/arm/mach-mmp/{include/mach => }/mmp2.h (99%)
 rename arch/arm/mach-mmp/{include/mach => }/pm-mmp2.h (98%)
 rename arch/arm/mach-mmp/{include/mach => }/pm-pxa910.h (100%)
 rename arch/arm/mach-mmp/{include/mach => }/pxa168.h (98%)
 rename arch/arm/mach-mmp/{include/mach => }/pxa910.h (98%)
 rename arch/arm/mach-mmp/{include/mach => }/regs-apbc.h (88%)
 rename arch/arm/mach-mmp/{include/mach => }/regs-apmu.h (91%)
 rename arch/arm/mach-mmp/{include/mach => }/regs-icu.h (96%)
 rename arch/arm/mach-mmp/{include/mach => }/regs-timers.h (93%)
 rename arch/arm/mach-mmp/{include/mach => }/regs-usb.h (100%)
 rename arch/arm/mach-mmp/{include/mach => }/teton_bga.h (92%)

diff --git a/arch/arm/mach-mmp/include/mach/addr-map.h b/arch/arm/mach-mmp/addr-map.h
similarity index 96%
rename from arch/arm/mach-mmp/include/mach/addr-map.h
rename to arch/arm/mach-mmp/addr-map.h
index f88a44c0ef91..2739d27bc89d 100644
--- a/arch/arm/mach-mmp/include/mach/addr-map.h
+++ b/arch/arm/mach-mmp/addr-map.h
@@ -1,6 +1,4 @@
 /*
- * linux/arch/arm/mach-mmp/include/mach/addr-map.h
- *
  *   Common address map definitions
  *
  * This program is free software; you can redistribute it and/or modify
diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 7e0248582efd..5db0edf716dd 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -22,14 +22,14 @@
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <mach/addr-map.h>
-#include <mach/mfp-pxa168.h>
-#include <mach/pxa168.h>
-#include <mach/irqs.h>
 #include <video/pxa168fb.h>
 #include <linux/input.h>
 #include <linux/platform_data/keypad-pxa27x.h>
 
+#include "addr-map.h"
+#include "mfp-pxa168.h"
+#include "pxa168.h"
+#include "irqs.h"
 #include "common.h"
 
 static unsigned long common_pin_config[] __initdata = {
diff --git a/arch/arm/mach-mmp/avengers_lite.c b/arch/arm/mach-mmp/avengers_lite.c
index a451a0f4d512..3d2aea830ef7 100644
--- a/arch/arm/mach-mmp/avengers_lite.c
+++ b/arch/arm/mach-mmp/avengers_lite.c
@@ -17,10 +17,10 @@
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <mach/addr-map.h>
-#include <mach/mfp-pxa168.h>
-#include <mach/pxa168.h>
-#include <mach/irqs.h>
+#include "addr-map.h"
+#include "mfp-pxa168.h"
+#include "pxa168.h"
+#include "irqs.h"
 
 
 #include "common.h"
diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index ac25544b8cdb..d1613b954926 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -22,10 +22,10 @@
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <mach/addr-map.h>
-#include <mach/mfp-mmp2.h>
-#include <mach/mmp2.h>
-#include <mach/irqs.h>
+#include "addr-map.h"
+#include "mfp-mmp2.h"
+#include "mmp2.h"
+#include "irqs.h"
 
 #include "common.h"
 
diff --git a/arch/arm/mach-mmp/clock-mmp2.c b/arch/arm/mach-mmp/clock-mmp2.c
index 6847c49bbb39..835c3e7cc67e 100644
--- a/arch/arm/mach-mmp/clock-mmp2.c
+++ b/arch/arm/mach-mmp/clock-mmp2.c
@@ -6,7 +6,7 @@
 #include <linux/clk.h>
 #include <linux/clk/mmp.h>
 
-#include <mach/addr-map.h>
+#include "addr-map.h"
 
 #include "common.h"
 #include "clock.h"
diff --git a/arch/arm/mach-mmp/clock-pxa168.c b/arch/arm/mach-mmp/clock-pxa168.c
index bfa54bb16449..f726a3692431 100644
--- a/arch/arm/mach-mmp/clock-pxa168.c
+++ b/arch/arm/mach-mmp/clock-pxa168.c
@@ -6,7 +6,7 @@
 #include <linux/clk.h>
 #include <linux/clk/mmp.h>
 
-#include <mach/addr-map.h>
+#include "addr-map.h"
 
 #include "common.h"
 #include "clock.h"
diff --git a/arch/arm/mach-mmp/clock-pxa910.c b/arch/arm/mach-mmp/clock-pxa910.c
index ef7d3dbc8731..bca60a224e07 100644
--- a/arch/arm/mach-mmp/clock-pxa910.c
+++ b/arch/arm/mach-mmp/clock-pxa910.c
@@ -6,7 +6,7 @@
 #include <linux/clk.h>
 #include <linux/clk/mmp.h>
 
-#include <mach/addr-map.h>
+#include "addr-map.h"
 
 #include "common.h"
 #include "clock.h"
diff --git a/arch/arm/mach-mmp/clock.c b/arch/arm/mach-mmp/clock.c
index 7c6f95f29142..ac6633d0b69b 100644
--- a/arch/arm/mach-mmp/clock.c
+++ b/arch/arm/mach-mmp/clock.c
@@ -13,7 +13,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <mach/regs-apbc.h>
+#include "regs-apbc.h"
 #include "clock.h"
 
 static void apbc_clk_enable(struct clk *clk)
diff --git a/arch/arm/mach-mmp/clock.h b/arch/arm/mach-mmp/clock.h
index 149b30cd1469..8194445183fe 100644
--- a/arch/arm/mach-mmp/clock.h
+++ b/arch/arm/mach-mmp/clock.h
@@ -1,6 +1,4 @@
 /*
- *  linux/arch/arm/mach-mmp/clock.h
- *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
  *  published by the Free Software Foundation.
diff --git a/arch/arm/mach-mmp/common.c b/arch/arm/mach-mmp/common.c
index c03b4ab582db..685a0993cff6 100644
--- a/arch/arm/mach-mmp/common.c
+++ b/arch/arm/mach-mmp/common.c
@@ -15,8 +15,8 @@
 #include <asm/page.h>
 #include <asm/mach/map.h>
 #include <asm/system_misc.h>
-#include <mach/addr-map.h>
-#include <mach/cputype.h>
+#include "addr-map.h"
+#include "cputype.h"
 
 #include "common.h"
 
diff --git a/arch/arm/mach-mmp/include/mach/cputype.h b/arch/arm/mach-mmp/cputype.h
similarity index 100%
rename from arch/arm/mach-mmp/include/mach/cputype.h
rename to arch/arm/mach-mmp/cputype.h
diff --git a/arch/arm/mach-mmp/devices.c b/arch/arm/mach-mmp/devices.c
index 2bcb766af05d..335c97aa9a2c 100644
--- a/arch/arm/mach-mmp/devices.c
+++ b/arch/arm/mach-mmp/devices.c
@@ -12,10 +12,10 @@
 #include <linux/delay.h>
 
 #include <asm/irq.h>
-#include <mach/irqs.h>
-#include <mach/devices.h>
-#include <mach/cputype.h>
-#include <mach/regs-usb.h>
+#include "irqs.h"
+#include "devices.h"
+#include "cputype.h"
+#include "regs-usb.h"
 
 int __init pxa_register_device(struct pxa_device_desc *desc,
 				void *data, size_t size)
diff --git a/arch/arm/mach-mmp/include/mach/devices.h b/arch/arm/mach-mmp/devices.h
similarity index 100%
rename from arch/arm/mach-mmp/include/mach/devices.h
rename to arch/arm/mach-mmp/devices.h
diff --git a/arch/arm/mach-mmp/flint.c b/arch/arm/mach-mmp/flint.c
index 6291c33d83e2..078b98034960 100644
--- a/arch/arm/mach-mmp/flint.c
+++ b/arch/arm/mach-mmp/flint.c
@@ -21,10 +21,10 @@
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <mach/addr-map.h>
-#include <mach/mfp-mmp2.h>
-#include <mach/mmp2.h>
-#include <mach/irqs.h>
+#include "addr-map.h"
+#include "mfp-mmp2.h"
+#include "mmp2.h"
+#include "irqs.h"
 
 #include "common.h"
 
diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
index 22762a1f9f72..c224119dc0f4 100644
--- a/arch/arm/mach-mmp/gplugd.c
+++ b/arch/arm/mach-mmp/gplugd.c
@@ -16,9 +16,9 @@
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
-#include <mach/irqs.h>
-#include <mach/pxa168.h>
-#include <mach/mfp-pxa168.h>
+#include "irqs.h"
+#include "pxa168.h"
+#include "mfp-pxa168.h"
 
 #include "common.h"
 
diff --git a/arch/arm/mach-mmp/include/mach/hardware.h b/arch/arm/mach-mmp/include/mach/hardware.h
deleted file mode 100644
index 99264a5ce5e4..000000000000
--- a/arch/arm/mach-mmp/include/mach/hardware.h
+++ /dev/null
@@ -1,4 +0,0 @@
-#ifndef __ASM_MACH_HARDWARE_H
-#define __ASM_MACH_HARDWARE_H
-
-#endif /* __ASM_MACH_HARDWARE_H */
diff --git a/arch/arm/mach-mmp/include/mach/regs-smc.h b/arch/arm/mach-mmp/include/mach/regs-smc.h
deleted file mode 100644
index e484d40d71bd..000000000000
--- a/arch/arm/mach-mmp/include/mach/regs-smc.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * linux/arch/arm/mach-mmp/include/mach/regs-smc.h
- *
- *  Static Memory Controller Registers
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_MACH_REGS_SMC_H
-#define __ASM_MACH_REGS_SMC_H
-
-#include <mach/addr-map.h>
-
-#define SMC_VIRT_BASE		(AXI_VIRT_BASE + 0x83800)
-#define SMC_REG(x)		(SMC_VIRT_BASE + (x))
-
-#define SMC_MSC0		SMC_REG(0x0020)
-#define SMC_MSC1		SMC_REG(0x0024)
-#define SMC_SXCNFG0		SMC_REG(0x0030)
-#define SMC_SXCNFG1		SMC_REG(0x0034)
-#define SMC_MEMCLKCFG		SMC_REG(0x0068)
-#define SMC_CSDFICFG0		SMC_REG(0x0090)
-#define SMC_CSDFICFG1		SMC_REG(0x0094)
-#define SMC_CLK_RET_DEL		SMC_REG(0x00b0)
-#define SMC_ADV_RET_DEL		SMC_REG(0x00b4)
-#define SMC_CSADRMAP0		SMC_REG(0x00c0)
-#define SMC_CSADRMAP1		SMC_REG(0x00c4)
-#define SMC_WE_AP0		SMC_REG(0x00e0)
-#define SMC_WE_AP1		SMC_REG(0x00e4)
-#define SMC_OE_AP0		SMC_REG(0x00f0)
-#define SMC_OE_AP1		SMC_REG(0x00f4)
-#define SMC_ADV_AP0		SMC_REG(0x0100)
-#define SMC_ADV_AP1		SMC_REG(0x0104)
-
-#endif /* __ASM_MACH_REGS_SMC_H */
diff --git a/arch/arm/mach-mmp/include/mach/irqs.h b/arch/arm/mach-mmp/irqs.h
similarity index 100%
rename from arch/arm/mach-mmp/include/mach/irqs.h
rename to arch/arm/mach-mmp/irqs.h
diff --git a/arch/arm/mach-mmp/jasper.c b/arch/arm/mach-mmp/jasper.c
index 0e9e5c05b37c..5dbb753a77ac 100644
--- a/arch/arm/mach-mmp/jasper.c
+++ b/arch/arm/mach-mmp/jasper.c
@@ -20,12 +20,12 @@
 #include <linux/mfd/max8925.h>
 #include <linux/interrupt.h>
 
-#include <mach/irqs.h>
+#include "irqs.h"
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <mach/addr-map.h>
-#include <mach/mfp-mmp2.h>
-#include <mach/mmp2.h>
+#include "addr-map.h"
+#include "mfp-mmp2.h"
+#include "mmp2.h"
 
 #include "common.h"
 
diff --git a/arch/arm/mach-mmp/include/mach/mfp-mmp2.h b/arch/arm/mach-mmp/mfp-mmp2.h
similarity index 99%
rename from arch/arm/mach-mmp/include/mach/mfp-mmp2.h
rename to arch/arm/mach-mmp/mfp-mmp2.h
index 4ad38629c3f6..b2744349725d 100644
--- a/arch/arm/mach-mmp/include/mach/mfp-mmp2.h
+++ b/arch/arm/mach-mmp/mfp-mmp2.h
@@ -1,7 +1,7 @@
 #ifndef __ASM_MACH_MFP_MMP2_H
 #define __ASM_MACH_MFP_MMP2_H
 
-#include <mach/mfp.h>
+#include "mfp.h"
 
 #define MFP_DRIVE_VERY_SLOW	(0x0 << 13)
 #define MFP_DRIVE_SLOW		(0x2 << 13)
diff --git a/arch/arm/mach-mmp/include/mach/mfp-pxa168.h b/arch/arm/mach-mmp/mfp-pxa168.h
similarity index 99%
rename from arch/arm/mach-mmp/include/mach/mfp-pxa168.h
rename to arch/arm/mach-mmp/mfp-pxa168.h
index 92aaa3c19d61..9050d032377e 100644
--- a/arch/arm/mach-mmp/include/mach/mfp-pxa168.h
+++ b/arch/arm/mach-mmp/mfp-pxa168.h
@@ -1,7 +1,7 @@
 #ifndef __ASM_MACH_MFP_PXA168_H
 #define __ASM_MACH_MFP_PXA168_H
 
-#include <mach/mfp.h>
+#include "mfp.h"
 
 #define MFP_DRIVE_VERY_SLOW	(0x0 << 13)
 #define MFP_DRIVE_SLOW		(0x1 << 13)
diff --git a/arch/arm/mach-mmp/include/mach/mfp-pxa910.h b/arch/arm/mach-mmp/mfp-pxa910.h
similarity index 99%
rename from arch/arm/mach-mmp/include/mach/mfp-pxa910.h
rename to arch/arm/mach-mmp/mfp-pxa910.h
index 8c78f2b16452..f06db5cd3ad3 100644
--- a/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
+++ b/arch/arm/mach-mmp/mfp-pxa910.h
@@ -1,7 +1,7 @@
 #ifndef __ASM_MACH_MFP_PXA910_H
 #define __ASM_MACH_MFP_PXA910_H
 
-#include <mach/mfp.h>
+#include "mfp.h"
 
 #define MFP_DRIVE_VERY_SLOW	(0x0 << 13)
 #define MFP_DRIVE_SLOW		(0x2 << 13)
diff --git a/arch/arm/mach-mmp/include/mach/mfp.h b/arch/arm/mach-mmp/mfp.h
similarity index 100%
rename from arch/arm/mach-mmp/include/mach/mfp.h
rename to arch/arm/mach-mmp/mfp.h
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index 82eb53f5136a..afba5460cdaf 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -21,14 +21,14 @@
 #include <asm/hardware/cache-tauros2.h>
 
 #include <asm/mach/time.h>
-#include <mach/addr-map.h>
-#include <mach/regs-apbc.h>
-#include <mach/cputype.h>
-#include <mach/irqs.h>
-#include <mach/mfp.h>
-#include <mach/devices.h>
-#include <mach/mmp2.h>
-#include <mach/pm-mmp2.h>
+#include "addr-map.h"
+#include "regs-apbc.h"
+#include "cputype.h"
+#include "irqs.h"
+#include "mfp.h"
+#include "devices.h"
+#include "mmp2.h"
+#include "pm-mmp2.h"
 
 #include "common.h"
 
diff --git a/arch/arm/mach-mmp/include/mach/mmp2.h b/arch/arm/mach-mmp/mmp2.h
similarity index 99%
rename from arch/arm/mach-mmp/include/mach/mmp2.h
rename to arch/arm/mach-mmp/mmp2.h
index 0764f4ecec82..9b5e75ee9e4d 100644
--- a/arch/arm/mach-mmp/include/mach/mmp2.h
+++ b/arch/arm/mach-mmp/mmp2.h
@@ -10,9 +10,10 @@ extern void mmp2_clear_pmic_int(void);
 
 #include <linux/i2c.h>
 #include <linux/i2c/pxa-i2c.h>
-#include <mach/devices.h>
 #include <linux/platform_data/dma-mmp_tdma.h>
 
+#include "devices.h"
+
 extern struct pxa_device_desc mmp2_device_uart1;
 extern struct pxa_device_desc mmp2_device_uart2;
 extern struct pxa_device_desc mmp2_device_uart3;
diff --git a/arch/arm/mach-mmp/pm-mmp2.c b/arch/arm/mach-mmp/pm-mmp2.c
index 43b1a516957f..17699be3bc3d 100644
--- a/arch/arm/mach-mmp/pm-mmp2.c
+++ b/arch/arm/mach-mmp/pm-mmp2.c
@@ -18,12 +18,12 @@
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <asm/mach-types.h>
-#include <mach/hardware.h>
-#include <mach/cputype.h>
-#include <mach/addr-map.h>
-#include <mach/pm-mmp2.h>
-#include <mach/regs-icu.h>
-#include <mach/irqs.h>
+
+#include "cputype.h"
+#include "addr-map.h"
+#include "pm-mmp2.h"
+#include "regs-icu.h"
+#include "irqs.h"
 
 int mmp2_set_wake(struct irq_data *d, unsigned int on)
 {
diff --git a/arch/arm/mach-mmp/include/mach/pm-mmp2.h b/arch/arm/mach-mmp/pm-mmp2.h
similarity index 98%
rename from arch/arm/mach-mmp/include/mach/pm-mmp2.h
rename to arch/arm/mach-mmp/pm-mmp2.h
index 98bd66ce8006..486e0590cd8d 100644
--- a/arch/arm/mach-mmp/include/mach/pm-mmp2.h
+++ b/arch/arm/mach-mmp/pm-mmp2.h
@@ -11,7 +11,7 @@
 #ifndef __MMP2_PM_H__
 #define __MMP2_PM_H__
 
-#include <mach/addr-map.h>
+#include "addr-map.h"
 
 #define APMU_PJ_IDLE_CFG			APMU_REG(0x018)
 #define APMU_PJ_IDLE_CFG_PJ_IDLE		(1 << 1)
diff --git a/arch/arm/mach-mmp/pm-pxa910.c b/arch/arm/mach-mmp/pm-pxa910.c
index 7db5870d127f..8b47600b3cdf 100644
--- a/arch/arm/mach-mmp/pm-pxa910.c
+++ b/arch/arm/mach-mmp/pm-pxa910.c
@@ -19,12 +19,12 @@
 #include <linux/irq.h>
 #include <asm/mach-types.h>
 #include <asm/outercache.h>
-#include <mach/hardware.h>
-#include <mach/cputype.h>
-#include <mach/addr-map.h>
-#include <mach/pm-pxa910.h>
-#include <mach/regs-icu.h>
-#include <mach/irqs.h>
+
+#include "cputype.h"
+#include "addr-map.h"
+#include "pm-pxa910.h"
+#include "regs-icu.h"
+#include "irqs.h"
 
 int pxa910_set_wake(struct irq_data *data, unsigned int on)
 {
diff --git a/arch/arm/mach-mmp/include/mach/pm-pxa910.h b/arch/arm/mach-mmp/pm-pxa910.h
similarity index 100%
rename from arch/arm/mach-mmp/include/mach/pm-pxa910.h
rename to arch/arm/mach-mmp/pm-pxa910.h
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 7367f4b079e4..0f5f16fb8c66 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -16,22 +16,22 @@
 #include <linux/clk/mmp.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/mv_usb.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/mach/time.h>
 #include <asm/system_misc.h>
-#include <mach/cputype.h>
-#include <mach/addr-map.h>
-#include <mach/regs-apbc.h>
-#include <mach/regs-apmu.h>
-#include <mach/irqs.h>
-#include <mach/devices.h>
-#include <mach/mfp.h>
-#include <linux/dma-mapping.h>
-#include <mach/pxa168.h>
-#include <mach/regs-usb.h>
 
-#include "common.h"
+#include "addr-map.h"
 #include "clock.h"
+#include "common.h"
+#include "cputype.h"
+#include "devices.h"
+#include "irqs.h"
+#include "mfp.h"
+#include "pxa168.h"
+#include "regs-apbc.h"
+#include "regs-apmu.h"
+#include "regs-usb.h"
 
 #define MFPR_VIRT_BASE	(APB_VIRT_BASE + 0x1e000)
 
diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h b/arch/arm/mach-mmp/pxa168.h
similarity index 98%
rename from arch/arm/mach-mmp/include/mach/pxa168.h
rename to arch/arm/mach-mmp/pxa168.h
index a83ba7cb525d..75841e9ccd73 100644
--- a/arch/arm/mach-mmp/include/mach/pxa168.h
+++ b/arch/arm/mach-mmp/pxa168.h
@@ -11,14 +11,15 @@ extern void pxa168_clear_keypad_wakeup(void);
 
 #include <linux/i2c.h>
 #include <linux/i2c/pxa-i2c.h>
-#include <mach/devices.h>
 #include <linux/platform_data/mtd-nand-pxa3xx.h>
 #include <video/pxa168fb.h>
 #include <linux/platform_data/keypad-pxa27x.h>
-#include <mach/cputype.h>
 #include <linux/pxa168_eth.h>
 #include <linux/platform_data/mv_usb.h>
 
+#include "devices.h"
+#include "cputype.h"
+
 extern struct pxa_device_desc pxa168_device_uart1;
 extern struct pxa_device_desc pxa168_device_uart2;
 extern struct pxa_device_desc pxa168_device_uart3;
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index 15f7be01fed8..1ccbba9ac495 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -19,14 +19,14 @@
 
 #include <asm/hardware/cache-tauros2.h>
 #include <asm/mach/time.h>
-#include <mach/addr-map.h>
-#include <mach/regs-apbc.h>
-#include <mach/cputype.h>
-#include <mach/irqs.h>
-#include <mach/mfp.h>
-#include <mach/devices.h>
-#include <mach/pm-pxa910.h>
-#include <mach/pxa910.h>
+#include "addr-map.h"
+#include "regs-apbc.h"
+#include "cputype.h"
+#include "irqs.h"
+#include "mfp.h"
+#include "devices.h"
+#include "pm-pxa910.h"
+#include "pxa910.h"
 
 #include "common.h"
 
diff --git a/arch/arm/mach-mmp/include/mach/pxa910.h b/arch/arm/mach-mmp/pxa910.h
similarity index 98%
rename from arch/arm/mach-mmp/include/mach/pxa910.h
rename to arch/arm/mach-mmp/pxa910.h
index 92253203f5b4..a211e81e5a08 100644
--- a/arch/arm/mach-mmp/include/mach/pxa910.h
+++ b/arch/arm/mach-mmp/pxa910.h
@@ -7,10 +7,11 @@ extern void __init pxa910_init_irq(void);
 
 #include <linux/i2c.h>
 #include <linux/i2c/pxa-i2c.h>
-#include <mach/devices.h>
 #include <linux/platform_data/mtd-nand-pxa3xx.h>
 #include <video/mmp_disp.h>
 
+#include "devices.h"
+
 extern struct pxa_device_desc pxa910_device_uart1;
 extern struct pxa_device_desc pxa910_device_uart2;
 extern struct pxa_device_desc pxa910_device_twsi0;
diff --git a/arch/arm/mach-mmp/include/mach/regs-apbc.h b/arch/arm/mach-mmp/regs-apbc.h
similarity index 88%
rename from arch/arm/mach-mmp/include/mach/regs-apbc.h
rename to arch/arm/mach-mmp/regs-apbc.h
index ddc812f40341..704bcae3fc26 100644
--- a/arch/arm/mach-mmp/include/mach/regs-apbc.h
+++ b/arch/arm/mach-mmp/regs-apbc.h
@@ -1,6 +1,4 @@
 /*
- * linux/arch/arm/mach-mmp/include/mach/regs-apbc.h
- *
  *   Application Peripheral Bus Clock Unit
  *
  * This program is free software; you can redistribute it and/or modify
@@ -11,7 +9,7 @@
 #ifndef __ASM_MACH_REGS_APBC_H
 #define __ASM_MACH_REGS_APBC_H
 
-#include <mach/addr-map.h>
+#include "addr-map.h"
 
 /* Common APB clock register bit definitions */
 #define APBC_APBCLK	(1 << 0)  /* APB Bus Clock Enable */
diff --git a/arch/arm/mach-mmp/include/mach/regs-apmu.h b/arch/arm/mach-mmp/regs-apmu.h
similarity index 91%
rename from arch/arm/mach-mmp/include/mach/regs-apmu.h
rename to arch/arm/mach-mmp/regs-apmu.h
index 93c8d0e29bb9..23f6209b65aa 100644
--- a/arch/arm/mach-mmp/include/mach/regs-apmu.h
+++ b/arch/arm/mach-mmp/regs-apmu.h
@@ -1,6 +1,4 @@
 /*
- * linux/arch/arm/mach-mmp/include/mach/regs-apmu.h
- *
  *   Application Subsystem Power Management Unit
  *
  * This program is free software; you can redistribute it and/or modify
@@ -11,7 +9,7 @@
 #ifndef __ASM_MACH_REGS_APMU_H
 #define __ASM_MACH_REGS_APMU_H
 
-#include <mach/addr-map.h>
+#include "addr-map.h"
 
 #define APMU_FNCLK_EN	(1 << 4)
 #define APMU_AXICLK_EN	(1 << 3)
diff --git a/arch/arm/mach-mmp/include/mach/regs-icu.h b/arch/arm/mach-mmp/regs-icu.h
similarity index 96%
rename from arch/arm/mach-mmp/include/mach/regs-icu.h
rename to arch/arm/mach-mmp/regs-icu.h
index f882d91894be..0328abe340a4 100644
--- a/arch/arm/mach-mmp/include/mach/regs-icu.h
+++ b/arch/arm/mach-mmp/regs-icu.h
@@ -1,6 +1,4 @@
 /*
- * linux/arch/arm/mach-mmp/include/mach/regs-icu.h
- *
  *   Interrupt Control Unit
  *
  * This program is free software; you can redistribute it and/or modify
@@ -11,7 +9,7 @@
 #ifndef __ASM_MACH_ICU_H
 #define __ASM_MACH_ICU_H
 
-#include <mach/addr-map.h>
+#include "addr-map.h"
 
 #define ICU_VIRT_BASE	(AXI_VIRT_BASE + 0x82000)
 #define ICU_REG(x)	(ICU_VIRT_BASE + (x))
diff --git a/arch/arm/mach-mmp/include/mach/regs-timers.h b/arch/arm/mach-mmp/regs-timers.h
similarity index 93%
rename from arch/arm/mach-mmp/include/mach/regs-timers.h
rename to arch/arm/mach-mmp/regs-timers.h
index 45589fec9fc7..d3611c0becf0 100644
--- a/arch/arm/mach-mmp/include/mach/regs-timers.h
+++ b/arch/arm/mach-mmp/regs-timers.h
@@ -1,6 +1,4 @@
 /*
- * linux/arch/arm/mach-mmp/include/mach/regs-timers.h
- *
  *   Timers Module
  *
  * This program is free software; you can redistribute it and/or modify
@@ -11,7 +9,7 @@
 #ifndef __ASM_MACH_REGS_TIMERS_H
 #define __ASM_MACH_REGS_TIMERS_H
 
-#include <mach/addr-map.h>
+#include "addr-map.h"
 
 #define TIMERS1_VIRT_BASE	(APB_VIRT_BASE + 0x14000)
 #define TIMERS2_VIRT_BASE	(APB_VIRT_BASE + 0x16000)
diff --git a/arch/arm/mach-mmp/include/mach/regs-usb.h b/arch/arm/mach-mmp/regs-usb.h
similarity index 100%
rename from arch/arm/mach-mmp/include/mach/regs-usb.h
rename to arch/arm/mach-mmp/regs-usb.h
diff --git a/arch/arm/mach-mmp/tavorevb.c b/arch/arm/mach-mmp/tavorevb.c
index cdfc9bfee1a4..efe35fadeb60 100644
--- a/arch/arm/mach-mmp/tavorevb.c
+++ b/arch/arm/mach-mmp/tavorevb.c
@@ -16,10 +16,10 @@
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <mach/addr-map.h>
-#include <mach/mfp-pxa910.h>
-#include <mach/pxa910.h>
-#include <mach/irqs.h>
+#include "addr-map.h"
+#include "mfp-pxa910.h"
+#include "pxa910.h"
+#include "irqs.h"
 
 #include "common.h"
 
diff --git a/arch/arm/mach-mmp/teton_bga.c b/arch/arm/mach-mmp/teton_bga.c
index 6aa53fb29d26..cf038eb3bb4b 100644
--- a/arch/arm/mach-mmp/teton_bga.c
+++ b/arch/arm/mach-mmp/teton_bga.c
@@ -23,11 +23,11 @@
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <mach/addr-map.h>
-#include <mach/mfp-pxa168.h>
-#include <mach/pxa168.h>
-#include <mach/teton_bga.h>
-#include <mach/irqs.h>
+#include "addr-map.h"
+#include "mfp-pxa168.h"
+#include "pxa168.h"
+#include "teton_bga.h"
+#include "irqs.h"
 
 #include "common.h"
 
diff --git a/arch/arm/mach-mmp/include/mach/teton_bga.h b/arch/arm/mach-mmp/teton_bga.h
similarity index 92%
rename from arch/arm/mach-mmp/include/mach/teton_bga.h
rename to arch/arm/mach-mmp/teton_bga.h
index 61a539b2cc98..019730f5aa56 100644
--- a/arch/arm/mach-mmp/include/mach/teton_bga.h
+++ b/arch/arm/mach-mmp/teton_bga.h
@@ -1,6 +1,4 @@
 /*
- *  linux/arch/arm/mach-mmp/include/mach/teton_bga.h
- *
  *  Support for the Marvell PXA168 Teton BGA Development Platform.
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index dbc697b2fda1..3c2c92aaa0ae 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -29,14 +29,13 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/sched_clock.h>
-
-#include <mach/addr-map.h>
-#include <mach/regs-timers.h>
-#include <mach/regs-apbc.h>
-#include <mach/irqs.h>
-#include <mach/cputype.h>
 #include <asm/mach/time.h>
 
+#include "addr-map.h"
+#include "regs-timers.h"
+#include "regs-apbc.h"
+#include "irqs.h"
+#include "cputype.h"
 #include "clock.h"
 
 #ifdef CONFIG_CPU_MMP2
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index ac4af81de3ea..d90c74fa614d 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -26,11 +26,11 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
-#include <mach/addr-map.h>
-#include <mach/mfp-pxa910.h>
-#include <mach/pxa910.h>
-#include <mach/irqs.h>
-#include <mach/regs-usb.h>
+#include "addr-map.h"
+#include "mfp-pxa910.h"
+#include "pxa910.h"
+#include "irqs.h"
+#include "regs-usb.h"
 
 #include "common.h"
 
-- 
2.1.0.rc2
