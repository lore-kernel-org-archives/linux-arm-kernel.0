From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 17 Jun 2014 16:48:01 +0900
Subject: [PATCH v2 08/08] ARM: shmobile: Move rcar-gen2.h, cleanup r8a7790 case
In-Reply-To: <20140617074658.30008.53021.sendpatchset@w520>
References: <20140617074658.30008.53021.sendpatchset@w520>
Message-ID: <20140617074801.30008.11376.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Change location of rcar-gen2.h so it can be used as #include "rcar-gen2.h"
instead of the old style #include <mach/rcar-gen2.h>. Also clean up
the r8a7790 case to follow the same style as r8a7791.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---

 Changes since V1:
 - rebased to v3.16-rc1

 arch/arm/mach-shmobile/board-koelsch-reference.c |    2 +-
 arch/arm/mach-shmobile/board-koelsch.c           |    2 +-
 arch/arm/mach-shmobile/board-lager-reference.c   |    2 +-
 arch/arm/mach-shmobile/board-lager.c             |    1 +
 arch/arm/mach-shmobile/clock-r8a7790.c           |    1 +
 arch/arm/mach-shmobile/clock-r8a7791.c           |    2 +-
 arch/arm/mach-shmobile/include/mach/r8a7790.h    |    2 --
 arch/arm/mach-shmobile/include/mach/rcar-gen2.h  |    8 --------
 arch/arm/mach-shmobile/rcar-gen2.h               |    8 ++++++++
 arch/arm/mach-shmobile/setup-r8a7790.c           |    1 +
 arch/arm/mach-shmobile/setup-r8a7791.c           |    2 +-
 arch/arm/mach-shmobile/setup-rcar-gen2.c         |    2 +-
 arch/arm/mach-shmobile/smp-r8a7791.c             |    2 +-
 13 files changed, 18 insertions(+), 17 deletions(-)

--- 0006/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ work/arch/arm/mach-shmobile/board-koelsch-reference.c	2014-06-17 16:15:58.000000000 +0900
@@ -23,12 +23,12 @@
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/rcar-du.h>
-#include <mach/rcar-gen2.h>
 #include <mach/r8a7791.h>
 #include <asm/mach/arch.h>
 #include "clock.h"
 #include "common.h"
 #include "irqs.h"
+#include "rcar-gen2.h"
 
 /* DU */
 static struct rcar_du_encoder_data koelsch_du_encoders[] = {
--- 0006/arch/arm/mach-shmobile/board-koelsch.c
+++ work/arch/arm/mach-shmobile/board-koelsch.c	2014-06-17 16:15:58.000000000 +0900
@@ -46,11 +46,11 @@
 #include <linux/spi/rspi.h>
 #include <linux/spi/spi.h>
 #include <mach/r8a7791.h>
-#include <mach/rcar-gen2.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include "common.h"
 #include "irqs.h"
+#include "rcar-gen2.h"
 
 /* DU */
 static struct rcar_du_encoder_data koelsch_du_encoders[] = {
--- 0006/arch/arm/mach-shmobile/board-lager-reference.c
+++ work/arch/arm/mach-shmobile/board-lager-reference.c	2014-06-17 16:15:58.000000000 +0900
@@ -22,12 +22,12 @@
 #include <linux/init.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/rcar-du.h>
-#include <mach/rcar-gen2.h>
 #include <mach/r8a7790.h>
 #include <asm/mach/arch.h>
 #include "clock.h"
 #include "common.h"
 #include "irqs.h"
+#include "rcar-gen2.h"
 
 /* DU */
 static struct rcar_du_encoder_data lager_du_encoders[] = {
--- 0006/arch/arm/mach-shmobile/board-lager.c
+++ work/arch/arm/mach-shmobile/board-lager.c	2014-06-17 16:15:58.000000000 +0900
@@ -58,6 +58,7 @@
 #include <sound/simple_card.h>
 #include "common.h"
 #include "irqs.h"
+#include "rcar-gen2.h"
 
 /*
  * SSI-AK4643
--- 0006/arch/arm/mach-shmobile/clock-r8a7790.c
+++ work/arch/arm/mach-shmobile/clock-r8a7790.c	2014-06-17 16:15:58.000000000 +0900
@@ -25,6 +25,7 @@
 #include <mach/r8a7790.h>
 #include "clock.h"
 #include "common.h"
+#include "rcar-gen2.h"
 
 /*
  *   MD		EXTAL		PLL0	PLL1	PLL3
--- 0006/arch/arm/mach-shmobile/clock-r8a7791.c
+++ work/arch/arm/mach-shmobile/clock-r8a7791.c	2014-06-17 16:15:58.000000000 +0900
@@ -23,9 +23,9 @@
 #include <linux/kernel.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/rcar-gen2.h>
 #include "clock.h"
 #include "common.h"
+#include "rcar-gen2.h"
 
 /*
  *   MD		EXTAL		PLL0	PLL1	PLL3
--- 0001/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7790.h	2014-06-17 16:15:58.000000000 +0900
@@ -1,8 +1,6 @@
 #ifndef __ASM_R8A7790_H__
 #define __ASM_R8A7790_H__
 
-#include <mach/rcar-gen2.h>
-
 /* DMA slave IDs */
 enum {
 	RCAR_DMA_SLAVE_INVALID,
--- 0001/arch/arm/mach-shmobile/include/mach/rcar-gen2.h
+++ /dev/null	2013-06-03 21:41:10.638032047 +0900
@@ -1,8 +0,0 @@
-#ifndef __ASM_RCAR_GEN2_H__
-#define __ASM_RCAR_GEN2_H__
-
-void rcar_gen2_timer_init(void);
-#define MD(nr) BIT(nr)
-u32 rcar_gen2_read_mode_pins(void);
-
-#endif /* __ASM_RCAR_GEN2_H__ */
--- /dev/null
+++ work/arch/arm/mach-shmobile/rcar-gen2.h	2014-06-17 16:15:59.000000000 +0900
@@ -0,0 +1,8 @@
+#ifndef __ASM_RCAR_GEN2_H__
+#define __ASM_RCAR_GEN2_H__
+
+void rcar_gen2_timer_init(void);
+#define MD(nr) BIT(nr)
+u32 rcar_gen2_read_mode_pins(void);
+
+#endif /* __ASM_RCAR_GEN2_H__ */
--- 0006/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2014-06-17 16:15:58.000000000 +0900
@@ -31,6 +31,7 @@
 #include "common.h"
 #include "dma-register.h"
 #include "irqs.h"
+#include "rcar-gen2.h"
 
 /* Audio-DMAC */
 #define AUDIO_DMAC_SLAVE(_id, _addr, t, r)			\
--- 0006/arch/arm/mach-shmobile/setup-r8a7791.c
+++ work/arch/arm/mach-shmobile/setup-r8a7791.c	2014-06-17 16:15:58.000000000 +0900
@@ -27,10 +27,10 @@
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
 #include <mach/r8a7791.h>
-#include <mach/rcar-gen2.h>
 #include <asm/mach/arch.h>
 #include "common.h"
 #include "irqs.h"
+#include "rcar-gen2.h"
 
 static const struct resource pfc_resources[] __initconst = {
 	DEFINE_RES_MEM(0xe6060000, 0x250),
--- 0006/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ work/arch/arm/mach-shmobile/setup-rcar-gen2.c	2014-06-17 16:15:58.000000000 +0900
@@ -22,9 +22,9 @@
 #include <linux/clocksource.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <mach/rcar-gen2.h>
 #include <asm/mach/arch.h>
 #include "common.h"
+#include "rcar-gen2.h"
 
 #define MODEMR 0xe6160060
 
--- 0006/arch/arm/mach-shmobile/smp-r8a7791.c
+++ work/arch/arm/mach-shmobile/smp-r8a7791.c	2014-06-17 16:15:58.000000000 +0900
@@ -19,8 +19,8 @@
 #include <linux/io.h>
 #include <asm/smp_plat.h>
 #include <mach/r8a7791.h>
-#include <mach/rcar-gen2.h>
 #include "common.h"
+#include "rcar-gen2.h"
 
 #define RST		0xe6160000
 #define CA15BAR		0x0020
