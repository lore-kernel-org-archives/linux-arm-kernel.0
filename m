From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 16:56:07 +0530
Subject: [PATCH V6 1/8] ST SPEAr: Reordering #includes in .h & .c files.
In-Reply-To: <cover.1298977691.git.viresh.kumar@st.com>
References: <cover.1298977691.git.viresh.kumar@st.com>
Message-ID: <a27185ddef212f752db6c0fb669e1b4a4b44a220.1298977691.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Order of inclusion of .h files must be: <linux/...>, <asm/...>, <plat/...>,
<mach/...>. This patch corrects this ordering whereever it is not followed.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/clock.c                    |    2 +-
 arch/arm/mach-spear3xx/include/mach/entry-macro.S |    2 +-
 arch/arm/mach-spear3xx/include/mach/generic.h     |    4 ++--
 arch/arm/mach-spear3xx/spear300.c                 |    2 +-
 arch/arm/mach-spear3xx/spear310.c                 |    2 +-
 arch/arm/mach-spear3xx/spear320.c                 |    2 +-
 arch/arm/mach-spear6xx/clock.c                    |    2 +-
 arch/arm/mach-spear6xx/include/mach/entry-macro.S |    2 +-
 arch/arm/mach-spear6xx/include/mach/generic.h     |    4 ++--
 arch/arm/mach-spear6xx/spear6xx.c                 |    2 +-
 arch/arm/plat-spear/include/plat/system.h         |    2 +-
 arch/arm/plat-spear/time.c                        |    4 ++--
 12 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
index 8ae4ad0..5bfeb6f 100644
--- a/arch/arm/mach-spear3xx/clock.c
+++ b/arch/arm/mach-spear3xx/clock.c
@@ -13,8 +13,8 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <mach/misc_regs.h>
 #include <plat/clock.h>
+#include <mach/misc_regs.h>
 
 /* root clks */
 /* 32 KHz oscillator clock */
diff --git a/arch/arm/mach-spear3xx/include/mach/entry-macro.S b/arch/arm/mach-spear3xx/include/mach/entry-macro.S
index 947625d..e8e7dc0 100644
--- a/arch/arm/mach-spear3xx/include/mach/entry-macro.S
+++ b/arch/arm/mach-spear3xx/include/mach/entry-macro.S
@@ -11,9 +11,9 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <asm/hardware/vic.h>
 #include <mach/hardware.h>
 #include <mach/spear.h>
-#include <asm/hardware/vic.h>
 
 		.macro	disable_fiq
 		.endm
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index e7d2de8..aaaa046 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -14,11 +14,11 @@
 #ifndef __MACH_GENERIC_H
 #define __MACH_GENERIC_H
 
-#include <asm/mach/time.h>
-#include <asm/mach/map.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/amba/bus.h>
+#include <asm/mach/time.h>
+#include <asm/mach/map.h>
 #include <plat/padmux.h>
 
 /* spear3xx declarations */
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index 7e01677..80ca04a 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -15,9 +15,9 @@
 #include <linux/amba/pl061.h>
 #include <linux/ptrace.h>
 #include <asm/irq.h>
+#include <plat/shirq.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
-#include <plat/shirq.h>
 
 /* pad multiplexing support */
 /* muxing registers */
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index f38eb21..ca1109d 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -13,9 +13,9 @@
 
 #include <linux/ptrace.h>
 #include <asm/irq.h>
+#include <plat/shirq.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
-#include <plat/shirq.h>
 
 /* pad multiplexing support */
 /* muxing registers */
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 456bb33..ceb04e8 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -13,9 +13,9 @@
 
 #include <linux/ptrace.h>
 #include <asm/irq.h>
+#include <plat/shirq.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
-#include <plat/shirq.h>
 
 /* pad multiplexing support */
 /* muxing registers */
diff --git a/arch/arm/mach-spear6xx/clock.c b/arch/arm/mach-spear6xx/clock.c
index 9171952..4f351b4 100644
--- a/arch/arm/mach-spear6xx/clock.c
+++ b/arch/arm/mach-spear6xx/clock.c
@@ -13,8 +13,8 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <mach/misc_regs.h>
 #include <plat/clock.h>
+#include <mach/misc_regs.h>
 
 /* root clks */
 /* 32 KHz oscillator clock */
diff --git a/arch/arm/mach-spear6xx/include/mach/entry-macro.S b/arch/arm/mach-spear6xx/include/mach/entry-macro.S
index 9eaecae..bc55e8b 100644
--- a/arch/arm/mach-spear6xx/include/mach/entry-macro.S
+++ b/arch/arm/mach-spear6xx/include/mach/entry-macro.S
@@ -11,9 +11,9 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <asm/hardware/vic.h>
 #include <mach/hardware.h>
 #include <mach/spear.h>
-#include <asm/hardware/vic.h>
 
 		.macro	disable_fiq
 		.endm
diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
index e5967ed..94cf4a6 100644
--- a/arch/arm/mach-spear6xx/include/mach/generic.h
+++ b/arch/arm/mach-spear6xx/include/mach/generic.h
@@ -14,11 +14,11 @@
 #ifndef __MACH_GENERIC_H
 #define __MACH_GENERIC_H
 
-#include <asm/mach/time.h>
-#include <asm/mach/map.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/amba/bus.h>
+#include <asm/mach/time.h>
+#include <asm/mach/map.h>
 
 /*
  * Each GPT has 2 timer channels
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index 9cd3a68..2d95715 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -18,8 +18,8 @@
 #include <asm/hardware/vic.h>
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
-#include <mach/irqs.h>
 #include <mach/generic.h>
+#include <mach/irqs.h>
 #include <mach/spear.h>
 
 /* Add spear6xx machines common devices here */
diff --git a/arch/arm/plat-spear/include/plat/system.h b/arch/arm/plat-spear/include/plat/system.h
index 55a4e40..d52db68 100644
--- a/arch/arm/plat-spear/include/plat/system.h
+++ b/arch/arm/plat-spear/include/plat/system.h
@@ -14,8 +14,8 @@
 #ifndef __PLAT_SYSTEM_H
 #define __PLAT_SYSTEM_H
 
-#include <asm/hardware/sp810.h>
 #include <linux/io.h>
+#include <asm/hardware/sp810.h>
 #include <mach/spear.h>
 
 static inline void arch_idle(void)
diff --git a/arch/arm/plat-spear/time.c b/arch/arm/plat-spear/time.c
index 100672f..de0a81b 100644
--- a/arch/arm/plat-spear/time.c
+++ b/arch/arm/plat-spear/time.c
@@ -20,10 +20,10 @@
 #include <linux/time.h>
 #include <linux/irq.h>
 #include <asm/mach/time.h>
-#include <mach/irqs.h>
+#include <mach/generic.h>
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <mach/spear.h>
-#include <mach/generic.h>
 
 /*
  * We would use TIMER0 and TIMER1 as clockevent and clocksource.
-- 
1.7.2.2
