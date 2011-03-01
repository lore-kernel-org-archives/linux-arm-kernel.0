From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 16:56:08 +0530
Subject: [PATCH V6 2/8] ST SPEAr: Include mach/hardware.h instead of
	mach/spear.h
In-Reply-To: <cover.1298977691.git.viresh.kumar@st.com>
References: <cover.1298977691.git.viresh.kumar@st.com>
Message-ID: <1ab9212beeef0eebf9ce60c8a2f66cc9b59d71e1.1298977691.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes inclusion of hardware.h and spear.h consistent over all spear
variants. Now we will include hardware.h, wherever we need to use hardware
macros. spear.h will be automatically included by hardware.h

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/include/mach/entry-macro.S |    1 -
 arch/arm/mach-spear3xx/include/mach/hardware.h    |    1 +
 arch/arm/mach-spear3xx/include/mach/misc_regs.h   |    2 +-
 arch/arm/mach-spear3xx/include/mach/spear.h       |    1 -
 arch/arm/mach-spear3xx/spear300.c                 |    2 +-
 arch/arm/mach-spear3xx/spear300_evb.c             |    2 +-
 arch/arm/mach-spear3xx/spear310.c                 |    2 +-
 arch/arm/mach-spear3xx/spear310_evb.c             |    2 +-
 arch/arm/mach-spear3xx/spear320.c                 |    2 +-
 arch/arm/mach-spear3xx/spear320_evb.c             |    2 +-
 arch/arm/mach-spear3xx/spear3xx.c                 |    2 +-
 arch/arm/mach-spear6xx/include/mach/entry-macro.S |    1 -
 arch/arm/mach-spear6xx/include/mach/hardware.h    |    1 +
 arch/arm/mach-spear6xx/include/mach/misc_regs.h   |    2 +-
 arch/arm/mach-spear6xx/include/mach/spear.h       |    1 -
 arch/arm/mach-spear6xx/spear600.c                 |    2 +-
 arch/arm/mach-spear6xx/spear600_evb.c             |    2 +-
 arch/arm/mach-spear6xx/spear6xx.c                 |    2 +-
 arch/arm/plat-spear/include/plat/debug-macro.S    |    2 +-
 arch/arm/plat-spear/include/plat/system.h         |    2 +-
 arch/arm/plat-spear/include/plat/uncompress.h     |    2 +-
 arch/arm/plat-spear/time.c                        |    1 -
 22 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-spear3xx/include/mach/entry-macro.S b/arch/arm/mach-spear3xx/include/mach/entry-macro.S
index e8e7dc0..53da422 100644
--- a/arch/arm/mach-spear3xx/include/mach/entry-macro.S
+++ b/arch/arm/mach-spear3xx/include/mach/entry-macro.S
@@ -13,7 +13,6 @@
 
 #include <asm/hardware/vic.h>
 #include <mach/hardware.h>
-#include <mach/spear.h>
 
 		.macro	disable_fiq
 		.endm
diff --git a/arch/arm/mach-spear3xx/include/mach/hardware.h b/arch/arm/mach-spear3xx/include/mach/hardware.h
index 490e86a..4660c0d 100644
--- a/arch/arm/mach-spear3xx/include/mach/hardware.h
+++ b/arch/arm/mach-spear3xx/include/mach/hardware.h
@@ -15,6 +15,7 @@
 #define __MACH_HARDWARE_H
 
 #include <plat/hardware.h>
+#include <mach/spear.h>
 
 /* Vitual to physical translation of statically mapped space */
 #define IO_ADDRESS(x)		(x | 0xF0000000)
diff --git a/arch/arm/mach-spear3xx/include/mach/misc_regs.h b/arch/arm/mach-spear3xx/include/mach/misc_regs.h
index 0b93347..5bd8cd8 100644
--- a/arch/arm/mach-spear3xx/include/mach/misc_regs.h
+++ b/arch/arm/mach-spear3xx/include/mach/misc_regs.h
@@ -14,7 +14,7 @@
 #ifndef __MACH_MISC_REGS_H
 #define __MACH_MISC_REGS_H
 
-#include <mach/spear.h>
+#include <mach/hardware.h>
 
 #define MISC_BASE		IOMEM(VA_SPEAR3XX_ICM3_MISC_REG_BASE)
 
diff --git a/arch/arm/mach-spear3xx/include/mach/spear.h b/arch/arm/mach-spear3xx/include/mach/spear.h
index dcca856..8745802 100644
--- a/arch/arm/mach-spear3xx/include/mach/spear.h
+++ b/arch/arm/mach-spear3xx/include/mach/spear.h
@@ -14,7 +14,6 @@
 #ifndef __MACH_SPEAR3XX_H
 #define __MACH_SPEAR3XX_H
 
-#include <mach/hardware.h>
 #include <mach/spear300.h>
 #include <mach/spear310.h>
 #include <mach/spear320.h>
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index 80ca04a..e15c684 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -17,7 +17,7 @@
 #include <asm/irq.h>
 #include <plat/shirq.h>
 #include <mach/generic.h>
-#include <mach/spear.h>
+#include <mach/hardware.h>
 
 /* pad multiplexing support */
 /* muxing registers */
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index cd23c98..77c9b83 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -14,7 +14,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <mach/generic.h>
-#include <mach/spear.h>
+#include <mach/hardware.h>
 
 /* padmux devices to enable */
 static struct pmx_dev *pmx_devs[] = {
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index ca1109d..5bfab14 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -15,7 +15,7 @@
 #include <asm/irq.h>
 #include <plat/shirq.h>
 #include <mach/generic.h>
-#include <mach/spear.h>
+#include <mach/hardware.h>
 
 /* pad multiplexing support */
 /* muxing registers */
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index 3855431..2d7f333 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -14,7 +14,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <mach/generic.h>
-#include <mach/spear.h>
+#include <mach/hardware.h>
 
 /* padmux devices to enable */
 static struct pmx_dev *pmx_devs[] = {
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index ceb04e8..c25f909 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -15,7 +15,7 @@
 #include <asm/irq.h>
 #include <plat/shirq.h>
 #include <mach/generic.h>
-#include <mach/spear.h>
+#include <mach/hardware.h>
 
 /* pad multiplexing support */
 /* muxing registers */
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 4a7ce35..0b80a15 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -14,7 +14,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <mach/generic.h>
-#include <mach/spear.h>
+#include <mach/hardware.h>
 
 /* padmux devices to enable */
 static struct pmx_dev *pmx_devs[] = {
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index e12a06c..634116f 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -19,7 +19,7 @@
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <mach/generic.h>
-#include <mach/spear.h>
+#include <mach/hardware.h>
 
 /* Add spear3xx machines common devices here */
 /* gpio device registration */
diff --git a/arch/arm/mach-spear6xx/include/mach/entry-macro.S b/arch/arm/mach-spear6xx/include/mach/entry-macro.S
index bc55e8b..8a0b0ed 100644
--- a/arch/arm/mach-spear6xx/include/mach/entry-macro.S
+++ b/arch/arm/mach-spear6xx/include/mach/entry-macro.S
@@ -13,7 +13,6 @@
 
 #include <asm/hardware/vic.h>
 #include <mach/hardware.h>
-#include <mach/spear.h>
 
 		.macro	disable_fiq
 		.endm
diff --git a/arch/arm/mach-spear6xx/include/mach/hardware.h b/arch/arm/mach-spear6xx/include/mach/hardware.h
index 0291476..0b3f96a 100644
--- a/arch/arm/mach-spear6xx/include/mach/hardware.h
+++ b/arch/arm/mach-spear6xx/include/mach/hardware.h
@@ -15,6 +15,7 @@
 #define __MACH_HARDWARE_H
 
 #include <plat/hardware.h>
+#include <mach/spear.h>
 
 /* Vitual to physical translation of statically mapped space */
 #define IO_ADDRESS(x)		(x | 0xF0000000)
diff --git a/arch/arm/mach-spear6xx/include/mach/misc_regs.h b/arch/arm/mach-spear6xx/include/mach/misc_regs.h
index 45571c1..68c20a0 100644
--- a/arch/arm/mach-spear6xx/include/mach/misc_regs.h
+++ b/arch/arm/mach-spear6xx/include/mach/misc_regs.h
@@ -14,7 +14,7 @@
 #ifndef __MACH_MISC_REGS_H
 #define __MACH_MISC_REGS_H
 
-#include <mach/spear.h>
+#include <mach/hardware.h>
 
 #define MISC_BASE		IOMEM(VA_SPEAR6XX_ICM3_MISC_REG_BASE)
 
diff --git a/arch/arm/mach-spear6xx/include/mach/spear.h b/arch/arm/mach-spear6xx/include/mach/spear.h
index a835f5b..17ab5aa 100644
--- a/arch/arm/mach-spear6xx/include/mach/spear.h
+++ b/arch/arm/mach-spear6xx/include/mach/spear.h
@@ -14,7 +14,6 @@
 #ifndef __MACH_SPEAR6XX_H
 #define __MACH_SPEAR6XX_H
 
-#include <mach/hardware.h>
 #include <mach/spear600.h>
 
 #define SPEAR6XX_ML_SDRAM_BASE		0x00000000
diff --git a/arch/arm/mach-spear6xx/spear600.c b/arch/arm/mach-spear6xx/spear600.c
index 5c484c4..d0e6eea 100644
--- a/arch/arm/mach-spear6xx/spear600.c
+++ b/arch/arm/mach-spear6xx/spear600.c
@@ -14,7 +14,7 @@
 #include <linux/ptrace.h>
 #include <asm/irq.h>
 #include <mach/generic.h>
-#include <mach/spear.h>
+#include <mach/hardware.h>
 
 /* Add spear600 specific devices here */
 
diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
index b0ed0df..f19cefe 100644
--- a/arch/arm/mach-spear6xx/spear600_evb.c
+++ b/arch/arm/mach-spear6xx/spear600_evb.c
@@ -14,7 +14,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <mach/generic.h>
-#include <mach/spear.h>
+#include <mach/hardware.h>
 
 static struct amba_device *amba_devs[] __initdata = {
 	&gpio_device[0],
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index 2d95715..378440b 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -19,8 +19,8 @@
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <mach/generic.h>
+#include <mach/hardware.h>
 #include <mach/irqs.h>
-#include <mach/spear.h>
 
 /* Add spear6xx machines common devices here */
 /* uart device registration */
diff --git a/arch/arm/plat-spear/include/plat/debug-macro.S b/arch/arm/plat-spear/include/plat/debug-macro.S
index e91270e..8501bbf 100644
--- a/arch/arm/plat-spear/include/plat/debug-macro.S
+++ b/arch/arm/plat-spear/include/plat/debug-macro.S
@@ -12,7 +12,7 @@
  */
 
 #include <linux/amba/serial.h>
-#include <mach/spear.h>
+#include <mach/hardware.h>
 
 		.macro	addruart, rp, rv
 		mov	\rp, #SPEAR_DBG_UART_BASE		@ Physical base
diff --git a/arch/arm/plat-spear/include/plat/system.h b/arch/arm/plat-spear/include/plat/system.h
index d52db68..a235fa0 100644
--- a/arch/arm/plat-spear/include/plat/system.h
+++ b/arch/arm/plat-spear/include/plat/system.h
@@ -16,7 +16,7 @@
 
 #include <linux/io.h>
 #include <asm/hardware/sp810.h>
-#include <mach/spear.h>
+#include <mach/hardware.h>
 
 static inline void arch_idle(void)
 {
diff --git a/arch/arm/plat-spear/include/plat/uncompress.h b/arch/arm/plat-spear/include/plat/uncompress.h
index 6dd455b..1bf8452 100644
--- a/arch/arm/plat-spear/include/plat/uncompress.h
+++ b/arch/arm/plat-spear/include/plat/uncompress.h
@@ -13,7 +13,7 @@
 
 #include <linux/io.h>
 #include <linux/amba/serial.h>
-#include <mach/spear.h>
+#include <mach/hardware.h>
 
 #ifndef __PLAT_UNCOMPRESS_H
 #define __PLAT_UNCOMPRESS_H
diff --git a/arch/arm/plat-spear/time.c b/arch/arm/plat-spear/time.c
index de0a81b..dbb6e4f 100644
--- a/arch/arm/plat-spear/time.c
+++ b/arch/arm/plat-spear/time.c
@@ -23,7 +23,6 @@
 #include <mach/generic.h>
 #include <mach/hardware.h>
 #include <mach/irqs.h>
-#include <mach/spear.h>
 
 /*
  * We would use TIMER0 and TIMER1 as clockevent and clocksource.
-- 
1.7.2.2
