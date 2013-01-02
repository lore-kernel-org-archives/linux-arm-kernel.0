From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Jan 2013 14:23:42 -0800
Subject: [PATCH 05/26] ARM: S5P64X0: move s5p64x0-clock.h into local directory
In-Reply-To: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
References: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1357165443-3716-6-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The <mach/s5p64x0-clock.h> can be moved into mach-s5p64x0/.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p64x0/clock-s5p6440.c                         |    2 +-
 arch/arm/mach-s5p64x0/clock-s5p6450.c                         |    2 +-
 .../mach-s5p64x0/{include/mach/s5p64x0-clock.h => clock.h}    |    9 ++++-----
 3 files changed, 6 insertions(+), 7 deletions(-)
 rename arch/arm/mach-s5p64x0/{include/mach/s5p64x0-clock.h => clock.h} (87%)

diff --git a/arch/arm/mach-s5p64x0/clock-s5p6440.c b/arch/arm/mach-s5p64x0/clock-s5p6440.c
index 5112371..35378152 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6440.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6440.c
@@ -23,7 +23,6 @@
 #include <mach/hardware.h>
 #include <mach/map.h>
 #include <mach/regs-clock.h>
-#include <mach/s5p64x0-clock.h>
 
 #include <plat/cpu-freq.h>
 #include <plat/clock.h>
@@ -32,6 +31,7 @@
 #include <plat/s5p-clock.h>
 #include <plat/clock-clksrc.h>
 
+#include "clock.h"
 #include "common.h"
 
 static u32 epll_div[][5] = {
diff --git a/arch/arm/mach-s5p64x0/clock-s5p6450.c b/arch/arm/mach-s5p64x0/clock-s5p6450.c
index 154dea7..af384dd 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6450.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6450.c
@@ -23,7 +23,6 @@
 #include <mach/hardware.h>
 #include <mach/map.h>
 #include <mach/regs-clock.h>
-#include <mach/s5p64x0-clock.h>
 
 #include <plat/cpu-freq.h>
 #include <plat/clock.h>
@@ -32,6 +31,7 @@
 #include <plat/s5p-clock.h>
 #include <plat/clock-clksrc.h>
 
+#include "clock.h"
 #include "common.h"
 
 static struct clksrc_clk clk_mout_dpll = {
diff --git a/arch/arm/mach-s5p64x0/include/mach/s5p64x0-clock.h b/arch/arm/mach-s5p64x0/clock.h
similarity index 87%
rename from arch/arm/mach-s5p64x0/include/mach/s5p64x0-clock.h
rename to arch/arm/mach-s5p64x0/clock.h
index 0ef47d1..28b8e3c 100644
--- a/arch/arm/mach-s5p64x0/include/mach/s5p64x0-clock.h
+++ b/arch/arm/mach-s5p64x0/clock.h
@@ -1,5 +1,4 @@
-/* linux/arch/arm/mach-s5p64x0/include/mach/s5p64x0-clock.h
- *
+/*
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
@@ -10,8 +9,8 @@
  * published by the Free Software Foundation.
 */
 
-#ifndef __ASM_ARCH_CLOCK_H
-#define __ASM_ARCH_CLOCK_H __FILE__
+#ifndef __MACH_S5P64X0_CLOCK_H
+#define __MACH_S5P64X0_CLOCK_H __FILE__
 
 #include <linux/clk.h>
 
@@ -36,4 +35,4 @@ extern int s5p64x0_mem_ctrl(struct clk *clk, int enable);
 
 extern int s5p64x0_clk48m_ctrl(struct clk *clk, int enable);
 
-#endif /* __ASM_ARCH_CLOCK_H */
+#endif /* __MACH_S5P64X0_CLOCK_H */
-- 
1.7.10.4
