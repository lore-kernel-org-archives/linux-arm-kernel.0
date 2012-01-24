From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 25 Jan 2012 00:56:05 +0100
Subject: [PATCH 1/4] at91 : coding style fixes
Message-ID: <1327449368-29917-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is mindless and does only fix the line length.
The purpose is to facilitate the review of the next patches.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/pm.h |   31 +++++++++++++++++++++----------
 1 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index ce9a206..92d2223 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -20,14 +20,16 @@ static inline u32 sdram_selfrefresh_enable(void)
 	return saved_lpr;
 }
 
-#define sdram_selfrefresh_disable(saved_lpr)	at91_sys_write(AT91_SDRAMC_LPR, saved_lpr)
-#define wait_for_interrupt_enable()		asm volatile ("mcr p15, 0, %0, c7, c0, 4" \
-								: : "r" (0))
+#define sdram_selfrefresh_disable(saved_lpr) \
+	at91_sys_write(AT91_SDRAMC_LPR, saved_lpr)
+
+#define wait_for_interrupt_enable() \
+	asm volatile ("mcr p15, 0, %0, c7, c0, 4" \
+		      : : "r" (0))
 
 #elif defined(CONFIG_ARCH_AT91CAP9)
 #include <mach/at91cap9_ddrsdr.h>
 
-
 static inline u32 sdram_selfrefresh_enable(void)
 {
 	u32 saved_lpr, lpr;
@@ -35,12 +37,16 @@ static inline u32 sdram_selfrefresh_enable(void)
 	saved_lpr = at91_ramc_read(0, AT91_DDRSDRC_LPR);
 
 	lpr = saved_lpr & ~AT91_DDRSDRC_LPCB;
-	at91_ramc_write(0, AT91_DDRSDRC_LPR, lpr | AT91_DDRSDRC_LPCB_SELF_REFRESH);
+	at91_ramc_write(0, AT91_DDRSDRC_LPR, lpr |
+			AT91_DDRSDRC_LPCB_SELF_REFRESH);
 	return saved_lpr;
 }
 
-#define sdram_selfrefresh_disable(saved_lpr)	at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr)
-#define wait_for_interrupt_enable()		cpu_do_idle()
+#define sdram_selfrefresh_disable(saved_lpr) \
+	at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr)
+
+#define wait_for_interrupt_enable() \
+	cpu_do_idle()
 
 #elif defined(CONFIG_ARCH_AT91SAM9G45)
 #include <mach/at91sam9_ddrsdr.h>
@@ -77,6 +83,7 @@ static inline u32 sdram_selfrefresh_enable(void)
 		at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr0); \
 		at91_ramc_write(1, AT91_DDRSDRC_LPR, saved_lpr1); \
 	} while (0)
+
 #define wait_for_interrupt_enable()		cpu_do_idle()
 
 #else
@@ -97,11 +104,15 @@ static inline u32 sdram_selfrefresh_enable(void)
 	saved_lpr = at91_ramc_read(0, AT91_SDRAMC_LPR);
 
 	lpr = saved_lpr & ~AT91_SDRAMC_LPCB;
-	at91_ramc_write(0, AT91_SDRAMC_LPR, lpr | AT91_SDRAMC_LPCB_SELF_REFRESH);
+	at91_ramc_write(0, AT91_SDRAMC_LPR, lpr |
+			AT91_SDRAMC_LPCB_SELF_REFRESH);
 	return saved_lpr;
 }
 
-#define sdram_selfrefresh_disable(saved_lpr)	at91_ramc_write(0, AT91_SDRAMC_LPR, saved_lpr)
-#define wait_for_interrupt_enable()		cpu_do_idle()
+#define sdram_selfrefresh_disable(saved_lpr) \
+	at91_ramc_write(0, AT91_SDRAMC_LPR, saved_lpr)
+
+#define wait_for_interrupt_enable() \
+	cpu_do_idle()
 
 #endif
-- 
1.7.5.4
