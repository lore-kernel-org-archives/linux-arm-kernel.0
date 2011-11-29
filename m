From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 29 Nov 2011 18:52:38 +0100
Subject: [PATCH 2/6] ARM: at91: merge at91cap9_ddrsdr.h in at91sam9_ddrsdr.h
In-Reply-To: <20111129173514.GW15008@game.jcrosoft.org>
References: <20111129173514.GW15008@game.jcrosoft.org>
Message-ID: <1322589162-5212-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/include/mach/at91cap9_ddrsdr.h |  112 ---------------------
 arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h |   30 ++++--
 arch/arm/mach-at91/pm.h                           |    8 +-
 arch/arm/mach-at91/pm_slowclock.S                 |    5 +-
 4 files changed, 26 insertions(+), 129 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/at91cap9_ddrsdr.h

diff --git a/arch/arm/mach-at91/include/mach/at91cap9_ddrsdr.h b/arch/arm/mach-at91/include/mach/at91cap9_ddrsdr.h
deleted file mode 100644
index d21932d..0000000
--- a/arch/arm/mach-at91/include/mach/at91cap9_ddrsdr.h
+++ /dev/null
@@ -1,112 +0,0 @@
-/*
- * arch/arm/mach-at91/include/mach/at91cap9_ddrsdr.h
- *
- *  (C) 2008 Andrew Victor
- *
- * DDR/SDR Controller (DDRSDRC) - System peripherals registers.
- * Based on AT91CAP9 datasheet revision B.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef AT91CAP9_DDRSDR_H
-#define AT91CAP9_DDRSDR_H
-
-#define AT91_DDRSDRC_MR		0x00	/* Mode Register */
-#define		AT91_DDRSDRC_MODE	(0x7 << 0)		/* Command Mode */
-#define			AT91_DDRSDRC_MODE_NORMAL		0
-#define			AT91_DDRSDRC_MODE_NOP		1
-#define			AT91_DDRSDRC_MODE_PRECHARGE	2
-#define			AT91_DDRSDRC_MODE_LMR		3
-#define			AT91_DDRSDRC_MODE_REFRESH	4
-#define			AT91_DDRSDRC_MODE_EXT_LMR	5
-#define			AT91_DDRSDRC_MODE_DEEP		6
-
-#define AT91_DDRSDRC_RTR	0x04	/* Refresh Timer Register */
-#define		AT91_DDRSDRC_COUNT	(0xfff << 0)		/* Refresh Timer Counter */
-
-#define AT91_DDRSDRC_CR		0x08	/* Configuration Register */
-#define		AT91_DDRSDRC_NC		(3 << 0)		/* Number of Column Bits */
-#define			AT91_DDRSDRC_NC_SDR8	(0 << 0)
-#define			AT91_DDRSDRC_NC_SDR9	(1 << 0)
-#define			AT91_DDRSDRC_NC_SDR10	(2 << 0)
-#define			AT91_DDRSDRC_NC_SDR11	(3 << 0)
-#define			AT91_DDRSDRC_NC_DDR9	(0 << 0)
-#define			AT91_DDRSDRC_NC_DDR10	(1 << 0)
-#define			AT91_DDRSDRC_NC_DDR11	(2 << 0)
-#define			AT91_DDRSDRC_NC_DDR12	(3 << 0)
-#define		AT91_DDRSDRC_NR		(3 << 2)		/* Number of Row Bits */
-#define			AT91_DDRSDRC_NR_11	(0 << 2)
-#define			AT91_DDRSDRC_NR_12	(1 << 2)
-#define			AT91_DDRSDRC_NR_13	(2 << 2)
-#define			AT91_DDRSDRC_NR_14	(3 << 2)
-#define		AT91_DDRSDRC_CAS	(7 << 4)		/* CAS Latency */
-#define			AT91_DDRSDRC_CAS_2	(2 << 4)
-#define			AT91_DDRSDRC_CAS_3	(3 << 4)
-#define			AT91_DDRSDRC_CAS_25	(6 << 4)
-#define		AT91_DDRSDRC_DLL	(1 << 7)		/* Reset DLL */
-#define		AT91_DDRSDRC_DICDS	(1 << 8)		/* Output impedance control */
-
-#define AT91_DDRSDRC_T0PR	0x0C	/* Timing 0 Register */
-#define		AT91_DDRSDRC_TRAS	(0xf <<  0)		/* Active to Precharge delay */
-#define		AT91_DDRSDRC_TRCD	(0xf <<  4)		/* Row to Column delay */
-#define		AT91_DDRSDRC_TWR	(0xf <<  8)		/* Write recovery delay */
-#define		AT91_DDRSDRC_TRC	(0xf << 12)		/* Row cycle delay */
-#define		AT91_DDRSDRC_TRP	(0xf << 16)		/* Row precharge delay */
-#define		AT91_DDRSDRC_TRRD	(0xf << 20)		/* Active BankA to BankB */
-#define		AT91_DDRSDRC_TWTR	(1   << 24)		/* Internal Write to Read delay */
-#define		AT91_DDRSDRC_TMRD	(0xf << 28)		/* Load mode to active/refresh delay */
-
-#define AT91_DDRSDRC_T1PR	0x10	/* Timing 1 Register */
-#define		AT91_DDRSDRC_TRFC	(0x1f << 0)		/* Row Cycle Delay */
-#define		AT91_DDRSDRC_TXSNR	(0xff << 8)		/* Exit self-refresh to non-read */
-#define		AT91_DDRSDRC_TXSRD	(0xff << 16)		/* Exit self-refresh to read */
-#define		AT91_DDRSDRC_TXP	(0xf  << 24)		/* Exit power-down delay */
-
-#define AT91_DDRSDRC_LPR	0x18	/* Low Power Register */
-#define		AT91_DDRSDRC_LPCB		(3 << 0)	/* Low-power Configurations */
-#define			AT91_DDRSDRC_LPCB_DISABLE		0
-#define			AT91_DDRSDRC_LPCB_SELF_REFRESH		1
-#define			AT91_DDRSDRC_LPCB_POWER_DOWN		2
-#define			AT91_DDRSDRC_LPCB_DEEP_POWER_DOWN	3
-#define		AT91_DDRSDRC_CLKFR		(1 << 2)	/* Clock Frozen */
-#define		AT91_DDRSDRC_PASR		(7 << 4)	/* Partial Array Self Refresh */
-#define		AT91_DDRSDRC_TCSR		(3 << 8)	/* Temperature Compensated Self Refresh */
-#define		AT91_DDRSDRC_DS			(3 << 10)	/* Drive Strength */
-#define		AT91_DDRSDRC_TIMEOUT		(3 << 12)	/* Time to define when Low Power Mode is enabled */
-#define			AT91_DDRSDRC_TIMEOUT_0_CLK_CYCLES	(0 << 12)
-#define			AT91_DDRSDRC_TIMEOUT_64_CLK_CYCLES	(1 << 12)
-#define			AT91_DDRSDRC_TIMEOUT_128_CLK_CYCLES	(2 << 12)
-
-#define AT91_DDRSDRC_MDR	0x1C	/* Memory Device Register */
-#define		AT91_DDRSDRC_MD		(3 << 0)		/* Memory Device Type */
-#define			AT91_DDRSDRC_MD_SDR		0
-#define			AT91_DDRSDRC_MD_LOW_POWER_SDR	1
-#define			AT91_DDRSDRC_MD_DDR		2
-#define			AT91_DDRSDRC_MD_LOW_POWER_DDR	3
-#define		AT91_DDRSDRC_DBW	(1 << 4)		/* Data Bus Width */
-#define			AT91_DDRSDRC_DBW_32BITS		(0 <<  4)
-#define			AT91_DDRSDRC_DBW_16BITS		(1 <<  4)
-
-#define AT91_DDRSDRC_DLLR	0x20	/* DLL Information Register */
-#define		AT91_DDRSDRC_MDINC	(1 << 0)		/* Master Delay increment */
-#define		AT91_DDRSDRC_MDDEC	(1 << 1)		/* Master Delay decrement */
-#define		AT91_DDRSDRC_MDOVF	(1 << 2)		/* Master Delay Overflow */
-#define		AT91_DDRSDRC_SDCOVF	(1 << 3)		/* Slave Delay Correction Overflow */
-#define		AT91_DDRSDRC_SDCUDF	(1 << 4)		/* Slave Delay Correction Underflow */
-#define		AT91_DDRSDRC_SDERF	(1 << 5)		/* Slave Delay Correction error */
-#define		AT91_DDRSDRC_MDVAL	(0xff <<  8)		/* Master Delay value */
-#define		AT91_DDRSDRC_SDVAL	(0xff << 16)		/* Slave Delay value */
-#define		AT91_DDRSDRC_SDCVAL	(0xff << 24)		/* Slave Delay Correction value */
-
-/* Register access macros */
-#define at91_ramc_read(num, reg) \
-	at91_sys_read(AT91_DDRSDRC##num + reg)
-#define at91_ramc_write(num, reg, value) \
-	at91_sys_write(AT91_DDRSDRC##num + reg, value)
-
-
-#endif
diff --git a/arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h b/arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h
index d27b15b..e2f8da8 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h
@@ -46,10 +46,10 @@
 #define			AT91_DDRSDRC_CAS_25	(6 << 4)
 #define		AT91_DDRSDRC_RST_DLL	(1 << 7)		/* Reset DLL */
 #define		AT91_DDRSDRC_DICDS	(1 << 8)		/* Output impedance control */
-#define		AT91_DDRSDRC_DIS_DLL	(1 << 9)		/* Disable DLL */
-#define		AT91_DDRSDRC_OCD	(1 << 12)		/* Off-Chip Driver */
-#define		AT91_DDRSDRC_DQMS	(1 << 16)		/* Mask Data is Shared */
-#define		AT91_DDRSDRC_ACTBST	(1 << 18)		/* Active Bank X to Burst Stop Read Access Bank Y */
+#define		AT91_DDRSDRC_DIS_DLL	(1 << 9)		/* Disable DLL [SAM9 Only] */
+#define		AT91_DDRSDRC_OCD	(1 << 12)		/* Off-Chip Driver [SAM9 Only] */
+#define		AT91_DDRSDRC_DQMS	(1 << 16)		/* Mask Data is Shared [SAM9 Only] */
+#define		AT91_DDRSDRC_ACTBST	(1 << 18)		/* Active Bank X to Burst Stop Read Access Bank Y [SAM9 Only] */
 
 #define AT91_DDRSDRC_T0PR	0x0C	/* Timing 0 Register */
 #define		AT91_DDRSDRC_TRAS	(0xf <<  0)		/* Active to Precharge delay */
@@ -59,7 +59,8 @@
 #define		AT91_DDRSDRC_TRP	(0xf << 16)		/* Row precharge delay */
 #define		AT91_DDRSDRC_TRRD	(0xf << 20)		/* Active BankA to BankB */
 #define		AT91_DDRSDRC_TWTR	(0x7 << 24)		/* Internal Write to Read delay */
-#define		AT91_DDRSDRC_RED_WRRD	(0x1 << 27)		/* Reduce Write to Read Delay */
+#define		AT91CAP9_DDRSDRC_TWTR	(1   << 24)		/* Internal Write to Read delay */
+#define		AT91_DDRSDRC_RED_WRRD	(0x1 << 27)		/* Reduce Write to Read Delay [SAM9 Only] */
 #define		AT91_DDRSDRC_TMRD	(0xf << 28)		/* Load mode to active/refresh delay */
 
 #define AT91_DDRSDRC_T1PR	0x10	/* Timing 1 Register */
@@ -68,13 +69,14 @@
 #define		AT91_DDRSDRC_TXSRD	(0xff << 16)		/* Exit self-refresh to read */
 #define		AT91_DDRSDRC_TXP	(0xf  << 24)		/* Exit power-down delay */
 
-#define AT91_DDRSDRC_T2PR	0x14	/* Timing 2 Register */
+#define AT91_DDRSDRC_T2PR	0x14	/* Timing 2 Register [SAM9 Only] */
 #define		AT91_DDRSDRC_TXARD	(0xf  << 0)		/* Exit active power down delay to read command in mode "Fast Exit" */
 #define		AT91_DDRSDRC_TXARDS	(0xf  << 4)		/* Exit active power down delay to read command in mode "Slow Exit" */
 #define		AT91_DDRSDRC_TRPA	(0xf  << 8)		/* Row Precharge All delay */
 #define		AT91_DDRSDRC_TRTP	(0x7  << 12)		/* Read to Precharge delay */
 
 #define AT91_DDRSDRC_LPR	0x1C	/* Low Power Register */
+#define AT91CAP9_DDRSDRC_LPR	0x18	/* Low Power Register */
 #define		AT91_DDRSDRC_LPCB	(3 << 0)		/* Low-power Configurations */
 #define			AT91_DDRSDRC_LPCB_DISABLE		0
 #define			AT91_DDRSDRC_LPCB_SELF_REFRESH		1
@@ -92,32 +94,40 @@
 #define		AT91_DDRSDRC_UPD_MR	(3 << 20)	 /* Update load mode register and extended mode register */
 
 #define AT91_DDRSDRC_MDR	0x20	/* Memory Device Register */
+#define AT91CAP9_DDRSDRC_MDR	0x1C	/* Memory Device Register */
 #define		AT91_DDRSDRC_MD		(3 << 0)		/* Memory Device Type */
 #define			AT91_DDRSDRC_MD_SDR		0
 #define			AT91_DDRSDRC_MD_LOW_POWER_SDR	1
+#define			AT91CAP9_DDRSDRC_MD_DDR		2
 #define			AT91_DDRSDRC_MD_LOW_POWER_DDR	3
-#define			AT91_DDRSDRC_MD_DDR2		6
+#define			AT91_DDRSDRC_MD_DDR2		6	/* [SAM9 Only] */
 #define		AT91_DDRSDRC_DBW	(1 << 4)		/* Data Bus Width */
 #define			AT91_DDRSDRC_DBW_32BITS		(0 <<  4)
 #define			AT91_DDRSDRC_DBW_16BITS		(1 <<  4)
 
 #define AT91_DDRSDRC_DLL	0x24	/* DLL Information Register */
+#define AT91CAP9_DDRSDRC_DLL	0x20	/* DLL Information Register */
 #define		AT91_DDRSDRC_MDINC	(1 << 0)		/* Master Delay increment */
 #define		AT91_DDRSDRC_MDDEC	(1 << 1)		/* Master Delay decrement */
 #define		AT91_DDRSDRC_MDOVF	(1 << 2)		/* Master Delay Overflow */
+#define		AT91CAP9_DDRSDRC_SDCOVF	(1 << 3)		/* Slave Delay Correction Overflow */
+#define		AT91CAP9_DDRSDRC_SDCUDF	(1 << 4)		/* Slave Delay Correction Underflow */
+#define		AT91CAP9_DDRSDRC_SDERF	(1 << 5)		/* Slave Delay Correction error */
 #define		AT91_DDRSDRC_MDVAL	(0xff <<  8)		/* Master Delay value */
+#define		AT91CAP9_DDRSDRC_SDVAL	(0xff << 16)		/* Slave Delay value */
+#define		AT91CAP9_DDRSDRC_SDCVAL	(0xff << 24)		/* Slave Delay Correction value */
 
-#define AT91_DDRSDRC_HS		0x2C	/* High Speed Register */
+#define AT91_DDRSDRC_HS		0x2C	/* High Speed Register [SAM9 Only] */
 #define		AT91_DDRSDRC_DIS_ATCP_RD	(1 << 2)	/* Anticip read access is disabled */
 
 #define AT91_DDRSDRC_DELAY(n)	(0x30 + (0x4 * (n)))	/* Delay I/O Register n */
 
-#define AT91_DDRSDRC_WPMR	0xE4	/* Write Protect Mode Register */
+#define AT91_DDRSDRC_WPMR	0xE4	/* Write Protect Mode Register [SAM9 Only] */
 #define		AT91_DDRSDRC_WP		(1 << 0)		/* Write protect enable */
 #define		AT91_DDRSDRC_WPKEY	(0xffffff << 8)		/* Write protect key */
 #define		AT91_DDRSDRC_KEY	(0x444452 << 8)		/* Write protect key = "DDR" */
 
-#define AT91_DDRSDRC_WPSR	0xE8	/* Write Protect Status Register */
+#define AT91_DDRSDRC_WPSR	0xE8	/* Write Protect Status Register [SAM9 Only] */
 #define		AT91_DDRSDRC_WPVS	(1 << 0)		/* Write protect violation status */
 #define		AT91_DDRSDRC_WPVSRC	(0xffff << 8)		/* Write protect violation source */
 
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index ce9a206..7eb40d2 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -25,21 +25,21 @@ static inline u32 sdram_selfrefresh_enable(void)
 								: : "r" (0))
 
 #elif defined(CONFIG_ARCH_AT91CAP9)
-#include <mach/at91cap9_ddrsdr.h>
+#include <mach/at91sam9_ddrsdr.h>
 
 
 static inline u32 sdram_selfrefresh_enable(void)
 {
 	u32 saved_lpr, lpr;
 
-	saved_lpr = at91_ramc_read(0, AT91_DDRSDRC_LPR);
+	saved_lpr = at91_ramc_read(0, AT91CAP9_DDRSDRC_LPR);
 
 	lpr = saved_lpr & ~AT91_DDRSDRC_LPCB;
-	at91_ramc_write(0, AT91_DDRSDRC_LPR, lpr | AT91_DDRSDRC_LPCB_SELF_REFRESH);
+	at91_ramc_write(0, AT91CAP9_DDRSDRC_LPR, lpr | AT91_DDRSDRC_LPCB_SELF_REFRESH);
 	return saved_lpr;
 }
 
-#define sdram_selfrefresh_disable(saved_lpr)	at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr)
+#define sdram_selfrefresh_disable(saved_lpr)	at91_ramc_write(0, AT91CAP9_DDRSDRC_LPR, saved_lpr)
 #define wait_for_interrupt_enable()		cpu_do_idle()
 
 #elif defined(CONFIG_ARCH_AT91SAM9G45)
diff --git a/arch/arm/mach-at91/pm_slowclock.S b/arch/arm/mach-at91/pm_slowclock.S
index f7922a4..92dfb84 100644
--- a/arch/arm/mach-at91/pm_slowclock.S
+++ b/arch/arm/mach-at91/pm_slowclock.S
@@ -18,9 +18,8 @@
 
 #if defined(CONFIG_ARCH_AT91RM9200)
 #include <mach/at91rm9200_mc.h>
-#elif defined(CONFIG_ARCH_AT91CAP9)
-#include <mach/at91cap9_ddrsdr.h>
-#elif defined(CONFIG_ARCH_AT91SAM9G45)
+#elif defined(CONFIG_ARCH_AT91CAP9) \
+	|| defined(CONFIG_ARCH_AT91SAM9G45)
 #include <mach/at91sam9_ddrsdr.h>
 #else
 #include <mach/at91sam9_sdramc.h>
-- 
1.7.7
