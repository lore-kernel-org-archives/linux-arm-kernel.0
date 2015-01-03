From: 21cnbao@gmail.com (Barry Song)
Date: Sat,  3 Jan 2015 16:27:35 +0800
Subject: [PATCH V3 01/10] ARM: sirf: drop MARCO low-level debug port
In-Reply-To: <1420273664-10438-1-git-send-email-21cnbao@gmail.com>
References: <1420273664-10438-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1420273664-10438-2-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

MARCO will not be supported any more. it has been replaced by CSR
atlas7.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug        | 9 +--------
 arch/arm/include/debug/sirf.S | 2 --
 arch/arm/mach-prima2/lluart.c | 2 --
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 5ddd490..e0a3cc9 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -920,13 +920,6 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to the uart1 port on SiRFprimaII devices.
 
-	config DEBUG_SIRFMARCO_UART1
-		bool "Kernel low-level debugging messages via SiRFmarco UART1"
-		depends on ARCH_MARCO
-		help
-		  Say Y here if you want the debug print routines to direct
-		  their output to the uart1 port on SiRFmarco devices.
-
 	config STIH41X_DEBUG_ASC2
 		bool "Use StiH415/416 ASC2 UART for low-level debug"
 		depends on ARCH_STI
@@ -1195,7 +1188,7 @@ config DEBUG_LL_INCLUDE
 	default "debug/renesas-scif.S" if DEBUG_RMOBILE_SCIFA4
 	default "debug/s3c24xx.S" if DEBUG_S3C24XX_UART
 	default "debug/s5pv210.S" if DEBUG_S5PV210_UART
-	default "debug/sirf.S" if DEBUG_SIRFPRIMA2_UART1 || DEBUG_SIRFMARCO_UART1
+	default "debug/sirf.S" if DEBUG_SIRFPRIMA2_UART1
 	default "debug/sti.S" if DEBUG_STI_UART
 	default "debug/tegra.S" if DEBUG_TEGRA_UART
 	default "debug/ux500.S" if DEBUG_UX500_UART
diff --git a/arch/arm/include/debug/sirf.S b/arch/arm/include/debug/sirf.S
index dbf250c..006ec9f 100644
--- a/arch/arm/include/debug/sirf.S
+++ b/arch/arm/include/debug/sirf.S
@@ -8,8 +8,6 @@
 
 #if defined(CONFIG_DEBUG_SIRFPRIMA2_UART1)
 #define SIRFSOC_UART1_PA_BASE          0xb0060000
-#elif defined(CONFIG_DEBUG_SIRFMARCO_UART1)
-#define SIRFSOC_UART1_PA_BASE          0xcc060000
 #else
 #define SIRFSOC_UART1_PA_BASE          0
 #endif
diff --git a/arch/arm/mach-prima2/lluart.c b/arch/arm/mach-prima2/lluart.c
index 99c0c92..20453c1 100644
--- a/arch/arm/mach-prima2/lluart.c
+++ b/arch/arm/mach-prima2/lluart.c
@@ -13,8 +13,6 @@
 
 #if defined(CONFIG_DEBUG_SIRFPRIMA2_UART1)
 #define SIRFSOC_UART1_PA_BASE          0xb0060000
-#elif defined(CONFIG_DEBUG_SIRFMARCO_UART1)
-#define SIRFSOC_UART1_PA_BASE          0xcc060000
 #else
 #define SIRFSOC_UART1_PA_BASE          0
 #endif
-- 
2.2.1
