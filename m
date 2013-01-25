From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 23:35:47 +0000
Subject: [PATCH 04/13] ARM: spear: make spear3xx/6xx mach/spear.h files
 identical
In-Reply-To: <1359156956-32404-1-git-send-email-arnd@arndb.de>
References: <1359156956-32404-1-git-send-email-arnd@arndb.de>
Message-ID: <1359156956-32404-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The two files are almost identical already basically just differ
in the identifier names. By changing the identifiers to be the
same, we are able to merge the two as a preparation to building
a combined kernel.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-spear3xx/include/mach/misc_regs.h |  2 +-
 arch/arm/mach-spear3xx/include/mach/spear.h     | 47 ++++++++++---------
 arch/arm/mach-spear3xx/spear300.c               |  2 +-
 arch/arm/mach-spear3xx/spear310.c               |  2 +-
 arch/arm/mach-spear3xx/spear320.c               |  2 +-
 arch/arm/mach-spear3xx/spear3xx.c               |  8 ++--
 arch/arm/mach-spear6xx/include/mach/misc_regs.h |  2 +-
 arch/arm/mach-spear6xx/include/mach/spear.h     | 61 +++++++++++++++----------
 arch/arm/mach-spear6xx/spear6xx.c               | 12 ++---
 9 files changed, 75 insertions(+), 63 deletions(-)

diff --git a/arch/arm/mach-spear3xx/include/mach/misc_regs.h b/arch/arm/mach-spear3xx/include/mach/misc_regs.h
index 6309bf6..075812c 100644
--- a/arch/arm/mach-spear3xx/include/mach/misc_regs.h
+++ b/arch/arm/mach-spear3xx/include/mach/misc_regs.h
@@ -16,7 +16,7 @@
 
 #include <mach/spear.h>
 
-#define MISC_BASE		IOMEM(VA_SPEAR3XX_ICM3_MISC_REG_BASE)
+#define MISC_BASE		IOMEM(VA_SPEAR_ICM3_MISC_REG_BASE)
 #define DMA_CHN_CFG		(MISC_BASE + 0x0A0)
 
 #endif /* __MACH_MISC_REGS_H */
diff --git a/arch/arm/mach-spear3xx/include/mach/spear.h b/arch/arm/mach-spear3xx/include/mach/spear.h
index 8cca951..ee5a774 100644
--- a/arch/arm/mach-spear3xx/include/mach/spear.h
+++ b/arch/arm/mach-spear3xx/include/mach/spear.h
@@ -1,9 +1,8 @@
 /*
- * arch/arm/mach-spear3xx/include/mach/spear.h
+ * SPEAr3xx/6xx Machine family specific definition
  *
- * SPEAr3xx Machine family specific definition
- *
- * Copyright (C) 2009 ST Microelectronics
+ * Copyright (C) 2009,2012 ST Microelectronics
+ * Rajeev Kumar<rajeev-dlh.kumar@st.com>
  * Viresh Kumar <viresh.linux@gmail.com>
  *
  * This file is licensed under the terms of the GNU General Public
@@ -11,38 +10,38 @@
  * warranty of any kind, whether express or implied.
  */
 
-#ifndef __MACH_SPEAR3XX_H
-#define __MACH_SPEAR3XX_H
+#ifndef __MACH_SPEAR_H
+#define __MACH_SPEAR_H
 
 #include <asm/memory.h>
 
 /* ICM1 - Low speed connection */
-#define SPEAR3XX_ICM1_2_BASE		UL(0xD0000000)
-#define VA_SPEAR3XX_ICM1_2_BASE		UL(0xFD000000)
-#define SPEAR3XX_ICM1_UART_BASE		UL(0xD0000000)
-#define VA_SPEAR3XX_ICM1_UART_BASE	(VA_SPEAR3XX_ICM1_2_BASE | SPEAR3XX_ICM1_UART_BASE)
+#define SPEAR_ICM1_2_BASE		UL(0xD0000000)
+#define VA_SPEAR_ICM1_2_BASE		UL(0xFD000000)
+#define SPEAR_ICM1_UART_BASE		UL(0xD0000000)
+#define VA_SPEAR_ICM1_UART_BASE		(VA_SPEAR_ICM1_2_BASE | SPEAR_ICM1_UART_BASE)
 #define SPEAR3XX_ICM1_SSP_BASE		UL(0xD0100000)
 
-/* ML1 - Multi Layer CPU Subsystem */
-#define SPEAR3XX_ICM3_ML1_2_BASE	UL(0xF0000000)
+/* ML-1, 2 - Multi Layer CPU Subsystem */
+#define SPEAR_ICM3_ML1_2_BASE		UL(0xF0000000)
 #define VA_SPEAR6XX_ML_CPU_BASE		UL(0xF0000000)
 
 /* ICM3 - Basic Subsystem */
-#define SPEAR3XX_ICM3_SMI_CTRL_BASE	UL(0xFC000000)
-#define VA_SPEAR3XX_ICM3_SMI_CTRL_BASE	UL(0xFC000000)
-#define SPEAR3XX_ICM3_DMA_BASE		UL(0xFC400000)
-#define SPEAR3XX_ICM3_SYS_CTRL_BASE	UL(0xFCA00000)
-#define VA_SPEAR3XX_ICM3_SYS_CTRL_BASE	(VA_SPEAR3XX_ICM3_SMI_CTRL_BASE | SPEAR3XX_ICM3_SYS_CTRL_BASE)
-#define SPEAR3XX_ICM3_MISC_REG_BASE	UL(0xFCA80000)
-#define VA_SPEAR3XX_ICM3_MISC_REG_BASE	(VA_SPEAR3XX_ICM3_SMI_CTRL_BASE | SPEAR3XX_ICM3_MISC_REG_BASE)
+#define SPEAR_ICM3_SMI_CTRL_BASE	UL(0xFC000000)
+#define VA_SPEAR_ICM3_SMI_CTRL_BASE	UL(0xFC000000)
+#define SPEAR_ICM3_DMA_BASE		UL(0xFC400000)
+#define SPEAR_ICM3_SYS_CTRL_BASE	UL(0xFCA00000)
+#define VA_SPEAR_ICM3_SYS_CTRL_BASE	(VA_SPEAR_ICM3_SMI_CTRL_BASE | SPEAR_ICM3_SYS_CTRL_BASE)
+#define SPEAR_ICM3_MISC_REG_BASE	UL(0xFCA80000)
+#define VA_SPEAR_ICM3_MISC_REG_BASE	(VA_SPEAR_ICM3_SMI_CTRL_BASE | SPEAR_ICM3_MISC_REG_BASE)
 
 /* Debug uart for linux, will be used for debug and uncompress messages */
-#define SPEAR_DBG_UART_BASE		SPEAR3XX_ICM1_UART_BASE
-#define VA_SPEAR_DBG_UART_BASE		VA_SPEAR3XX_ICM1_UART_BASE
+#define SPEAR_DBG_UART_BASE		SPEAR_ICM1_UART_BASE
+#define VA_SPEAR_DBG_UART_BASE		VA_SPEAR_ICM1_UART_BASE
 
 /* Sysctl base for spear platform */
-#define SPEAR_SYS_CTRL_BASE		SPEAR3XX_ICM3_SYS_CTRL_BASE
-#define VA_SPEAR_SYS_CTRL_BASE		VA_SPEAR3XX_ICM3_SYS_CTRL_BASE
+#define SPEAR_SYS_CTRL_BASE		SPEAR_ICM3_SYS_CTRL_BASE
+#define VA_SPEAR_SYS_CTRL_BASE		VA_SPEAR_ICM3_SYS_CTRL_BASE
 
 /* SPEAr320 Macros */
 #define SPEAR320_SOC_CONFIG_BASE	UL(0xB3000000)
@@ -57,4 +56,4 @@
 	#define SPEAR320_UART6_PCLK_SHIFT		12
 	#define SPEAR320_RS485_PCLK_SHIFT		13
 
-#endif /* __MACH_SPEAR3XX_H */
+#endif /* __MACH_SPEAR_H */
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index a69cbfd..7a1d8d9 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -185,7 +185,7 @@ struct pl08x_channel_data spear300_dma_info[] = {
 static struct of_dev_auxdata spear300_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("arm,pl022", SPEAR3XX_ICM1_SSP_BASE, NULL,
 			&pl022_plat_data),
-	OF_DEV_AUXDATA("arm,pl080", SPEAR3XX_ICM3_DMA_BASE, NULL,
+	OF_DEV_AUXDATA("arm,pl080", SPEAR_ICM3_DMA_BASE, NULL,
 			&pl080_plat_data),
 	{}
 };
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index b963ebb..ec3c631 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -217,7 +217,7 @@ static struct amba_pl011_data spear310_uart_data[] = {
 static struct of_dev_auxdata spear310_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("arm,pl022", SPEAR3XX_ICM1_SSP_BASE, NULL,
 			&pl022_plat_data),
-	OF_DEV_AUXDATA("arm,pl080", SPEAR3XX_ICM3_DMA_BASE, NULL,
+	OF_DEV_AUXDATA("arm,pl080", SPEAR_ICM3_DMA_BASE, NULL,
 			&pl080_plat_data),
 	OF_DEV_AUXDATA("arm,pl011", SPEAR310_UART1_BASE, NULL,
 			&spear310_uart_data[0]),
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index bd46f3c..6ccfc89 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -223,7 +223,7 @@ static struct amba_pl011_data spear320_uart_data[] = {
 static struct of_dev_auxdata spear320_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("arm,pl022", SPEAR3XX_ICM1_SSP_BASE, NULL,
 			&pl022_plat_data),
-	OF_DEV_AUXDATA("arm,pl080", SPEAR3XX_ICM3_DMA_BASE, NULL,
+	OF_DEV_AUXDATA("arm,pl080", SPEAR_ICM3_DMA_BASE, NULL,
 			&pl080_plat_data),
 	OF_DEV_AUXDATA("arm,pl022", SPEAR320_SSP0_BASE, NULL,
 			&spear320_ssp_data[0]),
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index 56a9c26..c93f38b 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -71,13 +71,13 @@ struct pl08x_platform_data pl080_plat_data = {
  */
 struct map_desc spear3xx_io_desc[] __initdata = {
 	{
-		.virtual	= VA_SPEAR3XX_ICM1_2_BASE,
-		.pfn		= __phys_to_pfn(SPEAR3XX_ICM1_2_BASE),
+		.virtual	= VA_SPEAR_ICM1_2_BASE,
+		.pfn		= __phys_to_pfn(SPEAR_ICM1_2_BASE),
 		.length		= SZ_16M,
 		.type		= MT_DEVICE
 	}, {
-		.virtual	= VA_SPEAR3XX_ICM3_SMI_CTRL_BASE,
-		.pfn		= __phys_to_pfn(SPEAR3XX_ICM3_SMI_CTRL_BASE),
+		.virtual	= VA_SPEAR_ICM3_SMI_CTRL_BASE,
+		.pfn		= __phys_to_pfn(SPEAR_ICM3_SMI_CTRL_BASE),
 		.length		= SZ_16M,
 		.type		= MT_DEVICE
 	},
diff --git a/arch/arm/mach-spear6xx/include/mach/misc_regs.h b/arch/arm/mach-spear6xx/include/mach/misc_regs.h
index c34acc2..28aa508 100644
--- a/arch/arm/mach-spear6xx/include/mach/misc_regs.h
+++ b/arch/arm/mach-spear6xx/include/mach/misc_regs.h
@@ -16,7 +16,7 @@
 
 #include <mach/spear.h>
 
-#define MISC_BASE		IOMEM(VA_SPEAR6XX_ICM3_MISC_REG_BASE)
+#define MISC_BASE		IOMEM(VA_SPEAR_ICM3_MISC_REG_BASE)
 #define DMA_CHN_CFG		(MISC_BASE + 0x0A0)
 
 #endif /* __MACH_MISC_REGS_H */
diff --git a/arch/arm/mach-spear6xx/include/mach/spear.h b/arch/arm/mach-spear6xx/include/mach/spear.h
index cb8ed2f..ee5a774 100644
--- a/arch/arm/mach-spear6xx/include/mach/spear.h
+++ b/arch/arm/mach-spear6xx/include/mach/spear.h
@@ -1,46 +1,59 @@
 /*
- * arch/arm/mach-spear6xx/include/mach/spear.h
+ * SPEAr3xx/6xx Machine family specific definition
  *
- * SPEAr6xx Machine family specific definition
- *
- * Copyright (C) 2009 ST Microelectronics
+ * Copyright (C) 2009,2012 ST Microelectronics
  * Rajeev Kumar<rajeev-dlh.kumar@st.com>
+ * Viresh Kumar <viresh.linux@gmail.com>
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
 
-#ifndef __MACH_SPEAR6XX_H
-#define __MACH_SPEAR6XX_H
+#ifndef __MACH_SPEAR_H
+#define __MACH_SPEAR_H
 
 #include <asm/memory.h>
 
 /* ICM1 - Low speed connection */
-#define SPEAR6XX_ICM1_BASE		UL(0xD0000000)
-#define VA_SPEAR6XX_ICM1_BASE		UL(0xFD000000)
-#define SPEAR6XX_ICM1_UART0_BASE	UL(0xD0000000)
-#define VA_SPEAR6XX_ICM1_UART0_BASE	(VA_SPEAR6XX_ICM1_2_BASE | SPEAR6XX_ICM1_UART0_BASE)
+#define SPEAR_ICM1_2_BASE		UL(0xD0000000)
+#define VA_SPEAR_ICM1_2_BASE		UL(0xFD000000)
+#define SPEAR_ICM1_UART_BASE		UL(0xD0000000)
+#define VA_SPEAR_ICM1_UART_BASE		(VA_SPEAR_ICM1_2_BASE | SPEAR_ICM1_UART_BASE)
+#define SPEAR3XX_ICM1_SSP_BASE		UL(0xD0100000)
 
 /* ML-1, 2 - Multi Layer CPU Subsystem */
-#define SPEAR6XX_ML_CPU_BASE		UL(0xF0000000)
+#define SPEAR_ICM3_ML1_2_BASE		UL(0xF0000000)
 #define VA_SPEAR6XX_ML_CPU_BASE		UL(0xF0000000)
 
 /* ICM3 - Basic Subsystem */
-#define SPEAR6XX_ICM3_SMI_CTRL_BASE	UL(0xFC000000)
-#define VA_SPEAR6XX_ICM3_SMI_CTRL_BASE	UL(0xFC000000)
-#define SPEAR6XX_ICM3_DMA_BASE		UL(0xFC400000)
-#define SPEAR6XX_ICM3_SYS_CTRL_BASE	UL(0xFCA00000)
-#define VA_SPEAR6XX_ICM3_SYS_CTRL_BASE	(VA_SPEAR6XX_ICM3_SMI_CTRL_BASE | SPEAR6XX_ICM3_SYS_CTRL_BASE)
-#define SPEAR6XX_ICM3_MISC_REG_BASE	UL(0xFCA80000)
-#define VA_SPEAR6XX_ICM3_MISC_REG_BASE	(VA_SPEAR6XX_ICM3_SMI_CTRL_BASE | SPEAR6XX_ICM3_MISC_REG_BASE)
+#define SPEAR_ICM3_SMI_CTRL_BASE	UL(0xFC000000)
+#define VA_SPEAR_ICM3_SMI_CTRL_BASE	UL(0xFC000000)
+#define SPEAR_ICM3_DMA_BASE		UL(0xFC400000)
+#define SPEAR_ICM3_SYS_CTRL_BASE	UL(0xFCA00000)
+#define VA_SPEAR_ICM3_SYS_CTRL_BASE	(VA_SPEAR_ICM3_SMI_CTRL_BASE | SPEAR_ICM3_SYS_CTRL_BASE)
+#define SPEAR_ICM3_MISC_REG_BASE	UL(0xFCA80000)
+#define VA_SPEAR_ICM3_MISC_REG_BASE	(VA_SPEAR_ICM3_SMI_CTRL_BASE | SPEAR_ICM3_MISC_REG_BASE)
 
 /* Debug uart for linux, will be used for debug and uncompress messages */
-#define SPEAR_DBG_UART_BASE		SPEAR6XX_ICM1_UART0_BASE
-#define VA_SPEAR_DBG_UART_BASE		VA_SPEAR6XX_ICM1_UART0_BASE
+#define SPEAR_DBG_UART_BASE		SPEAR_ICM1_UART_BASE
+#define VA_SPEAR_DBG_UART_BASE		VA_SPEAR_ICM1_UART_BASE
 
 /* Sysctl base for spear platform */
-#define SPEAR_SYS_CTRL_BASE		SPEAR6XX_ICM3_SYS_CTRL_BASE
-#define VA_SPEAR_SYS_CTRL_BASE		VA_SPEAR6XX_ICM3_SYS_CTRL_BASE
-
-#endif /* __MACH_SPEAR6XX_H */
+#define SPEAR_SYS_CTRL_BASE		SPEAR_ICM3_SYS_CTRL_BASE
+#define VA_SPEAR_SYS_CTRL_BASE		VA_SPEAR_ICM3_SYS_CTRL_BASE
+
+/* SPEAr320 Macros */
+#define SPEAR320_SOC_CONFIG_BASE	UL(0xB3000000)
+#define VA_SPEAR320_SOC_CONFIG_BASE	UL(0xFE000000)
+#define SPEAR320_CONTROL_REG		IOMEM(VA_SPEAR320_SOC_CONFIG_BASE)
+#define SPEAR320_EXT_CTRL_REG		IOMEM(VA_SPEAR320_SOC_CONFIG_BASE + 0x0018)
+	#define SPEAR320_UARTX_PCLK_MASK		0x1
+	#define SPEAR320_UART2_PCLK_SHIFT		8
+	#define SPEAR320_UART3_PCLK_SHIFT		9
+	#define SPEAR320_UART4_PCLK_SHIFT		10
+	#define SPEAR320_UART5_PCLK_SHIFT		11
+	#define SPEAR320_UART6_PCLK_SHIFT		12
+	#define SPEAR320_RS485_PCLK_SHIFT		13
+
+#endif /* __MACH_SPEAR_H */
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index 5a5a52d..42250e8 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -352,17 +352,17 @@ struct pl08x_platform_data pl080_plat_data = {
 struct map_desc spear6xx_io_desc[] __initdata = {
 	{
 		.virtual	= VA_SPEAR6XX_ML_CPU_BASE,
-		.pfn		= __phys_to_pfn(SPEAR6XX_ML_CPU_BASE),
+		.pfn		= __phys_to_pfn(SPEAR_ICM3_ML1_2_BASE),
 		.length		= 2 * SZ_16M,
 		.type		= MT_DEVICE
 	},	{
-		.virtual	= VA_SPEAR6XX_ICM1_BASE,
-		.pfn		= __phys_to_pfn(SPEAR6XX_ICM1_BASE),
+		.virtual	= VA_SPEAR_ICM1_2_BASE,
+		.pfn		= __phys_to_pfn(SPEAR_ICM1_2_BASE),
 		.length		= SZ_16M,
 		.type		= MT_DEVICE
 	}, {
-		.virtual	= VA_SPEAR6XX_ICM3_SMI_CTRL_BASE,
-		.pfn		= __phys_to_pfn(SPEAR6XX_ICM3_SMI_CTRL_BASE),
+		.virtual	= VA_SPEAR_ICM3_SMI_CTRL_BASE,
+		.pfn		= __phys_to_pfn(SPEAR_ICM3_SMI_CTRL_BASE),
 		.length		= SZ_16M,
 		.type		= MT_DEVICE
 	},
@@ -409,7 +409,7 @@ struct sys_timer spear6xx_timer = {
 
 /* Add auxdata to pass platform data */
 struct of_dev_auxdata spear6xx_auxdata_lookup[] __initdata = {
-	OF_DEV_AUXDATA("arm,pl080", SPEAR6XX_ICM3_DMA_BASE, NULL,
+	OF_DEV_AUXDATA("arm,pl080", SPEAR_ICM3_DMA_BASE, NULL,
 			&pl080_plat_data),
 	{}
 };
-- 
1.8.0
