From: linux@arm.linux.org.uk (Russell King)
Date: Thu, 04 Mar 2010 19:11:56 +0000
Subject: [PATCH] ARM: Realview/Versatile/Integrator: remove unused
	definitions from platform.h
References: <git-1267729916-e504d2d965ff812d89c7c484276e35e001195fae@rmk-PC>
Message-ID: <git-1267729916-b3f4ccc3dfd1e01b45888a740b2b5638b82e0638@rmk-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-integrator/include/mach/platform.h |   42 +--------------------
 arch/arm/mach-realview/include/mach/platform.h   |   20 ----------
 arch/arm/mach-versatile/include/mach/platform.h  |   26 +------------
 3 files changed, 4 insertions(+), 84 deletions(-)

diff --git a/arch/arm/mach-integrator/include/mach/platform.h b/arch/arm/mach-integrator/include/mach/platform.h
index e00a262..f934227 100644
--- a/arch/arm/mach-integrator/include/mach/platform.h
+++ b/arch/arm/mach-integrator/include/mach/platform.h
@@ -23,9 +23,6 @@
  *
  *   Integrator address map
  *
- * 	NOTE: This is a multi-hosted header file for use with uHAL and
- * 	      supported debuggers.
- *
  * ***********************************************************************/
 
 #ifndef __address_h
@@ -328,20 +325,6 @@
  */
 #define PHYS_PCI_V3_BASE                0x62000000
 
-#define PCI_DRAMSIZE                    INTEGRATOR_SSRAM_SIZE
-
-/* 'export' these to UHAL */
-#define UHAL_PCI_IO                     PCI_IO_BASE
-#define UHAL_PCI_MEM                    PCI_MEM_BASE
-#define UHAL_PCI_ALLOC_IO_BASE          0x00004000
-#define UHAL_PCI_ALLOC_MEM_BASE         PCI_MEM_BASE
-#define UHAL_PCI_MAX_SLOT               20
-
-/* ========================================================================
- *  Start of uHAL definitions
- * ========================================================================
- */
-
 /* ------------------------------------------------------------------------
  *  Integrator Interrupt Controllers
  * ------------------------------------------------------------------------
@@ -389,7 +372,7 @@
  */
 
 /* ------------------------------------------------------------------------
- *  LED's - The header LED is not accessible via the uHAL API
+ *  LED's
  * ------------------------------------------------------------------------
  *
  */
@@ -402,34 +385,18 @@
 #define LED_BANK                        INTEGRATOR_DBG_LEDS
 
 /*
- *  Memory definitions - run uHAL out of SSRAM.
- *
- */
-#define uHAL_MEMORY_SIZE                INTEGRATOR_SSRAM_SIZE
-
-/*
- *  Clean base - dummy
- *
- */
-#define CLEAN_BASE                      INTEGRATOR_BOOT_ROM_HI
-
-/*
  *  Timer definitions
  *
  *  Only use timer 1 & 2
  *  (both run at 24MHz and will need the clock divider set to 16).
  *
- *  Timer 0 runs at bus frequency and therefore could vary and currently
- *  uHAL can't handle that.
- *
+ *  Timer 0 runs at bus frequency
  */
 
 #define INTEGRATOR_TIMER0_BASE          INTEGRATOR_CT_BASE
 #define INTEGRATOR_TIMER1_BASE          (INTEGRATOR_CT_BASE + 0x100)
 #define INTEGRATOR_TIMER2_BASE          (INTEGRATOR_CT_BASE + 0x200)
 
-#define MAX_TIMER                       2
-#define MAX_PERIOD                      699050
 #define TICKS_PER_uSEC                  24
 
 /*
@@ -437,14 +404,9 @@
  *
  */
 #define mSEC_1                          1000
-#define mSEC_5                          (mSEC_1 * 5)
 #define mSEC_10                         (mSEC_1 * 10)
-#define mSEC_25                         (mSEC_1 * 25)
-#define SEC_1                           (mSEC_1 * 1000)
 
 #define INTEGRATOR_CSR_BASE             0x10000000
 #define INTEGRATOR_CSR_SIZE             0x10000000
 
 #endif
-
-/* 	END */
diff --git a/arch/arm/mach-realview/include/mach/platform.h b/arch/arm/mach-realview/include/mach/platform.h
index 86c0c44..1b77a27 100644
--- a/arch/arm/mach-realview/include/mach/platform.h
+++ b/arch/arm/mach-realview/include/mach/platform.h
@@ -231,12 +231,6 @@
 #define REALVIEW_INTREG_OFFSET		0x8	/* Interrupt control */
 #define REALVIEW_DECODE_OFFSET		0xC	/* Fitted logic modules */
 
-/* 
- *  Clean base - dummy
- * 
- */
-#define CLEAN_BASE                      REALVIEW_BOOT_ROM_HI
-
 /*
  * System controller bit assignment
  */
@@ -249,20 +243,6 @@
 #define REALVIEW_TIMER4_EnSel	21
 
 
-#define MAX_TIMER                       2
-#define MAX_PERIOD                      699050
-#define TICKS_PER_uSEC                  1
-
-/* 
- *  These are useconds NOT ticks.  
- * 
- */
-#define mSEC_1                          1000
-#define mSEC_5                          (mSEC_1 * 5)
-#define mSEC_10                         (mSEC_1 * 10)
-#define mSEC_25                         (mSEC_1 * 25)
-#define SEC_1                           (mSEC_1 * 1000)
-
 #define REALVIEW_CSR_BASE             0x10000000
 #define REALVIEW_CSR_SIZE             0x10000000
 
diff --git a/arch/arm/mach-versatile/include/mach/platform.h b/arch/arm/mach-versatile/include/mach/platform.h
index 8320739..ec08740 100644
--- a/arch/arm/mach-versatile/include/mach/platform.h
+++ b/arch/arm/mach-versatile/include/mach/platform.h
@@ -205,7 +205,7 @@
 #define VERSATILE_CLCD_BASE            0x10120000	/* CLCD */
 #define VERSATILE_DMAC_BASE            0x10130000	/* DMA controller */
 #define VERSATILE_VIC_BASE             0x10140000	/* Vectored interrupt controller */
-#define VERSATILE_PERIPH_BASE          0x10150000    /* off-chip peripherals alias from */
+#define VERSATILE_PERIPH_BASE          0x10150000	/* off-chip peripherals alias from */
                                                 /* 0x10000000 - 0x100FFFFF */
 #define VERSATILE_AHBM_BASE            0x101D0000	/* AHB monitor */
 #define VERSATILE_SCTL_BASE            0x101E0000	/* System controller */
@@ -213,7 +213,7 @@
 #define VERSATILE_TIMER0_1_BASE        0x101E2000	/* Timer 0 and 1 */
 #define VERSATILE_TIMER2_3_BASE        0x101E3000	/* Timer 2 and 3 */
 #define VERSATILE_GPIO0_BASE           0x101E4000	/* GPIO port 0 */
-#define VERSATILE_GPIO1_BASE           0x101E5000    /* GPIO port 1 */
+#define VERSATILE_GPIO1_BASE           0x101E5000	/* GPIO port 1 */
 #define VERSATILE_GPIO2_BASE           0x101E6000	/* GPIO port 2 */
 #define VERSATILE_GPIO3_BASE           0x101E7000	/* GPIO port 3 */
 #define VERSATILE_RTC_BASE             0x101E8000	/* Real Time Clock */
@@ -379,12 +379,6 @@
 #define SIC_INT_PCI3                    30
 
 
-/* 
- *  Clean base - dummy
- * 
- */
-#define CLEAN_BASE                      VERSATILE_BOOT_ROM_HI
-
 /*
  * System controller bit assignment
  */
@@ -397,20 +391,6 @@
 #define VERSATILE_TIMER4_EnSel	21
 
 
-#define MAX_TIMER                       2
-#define MAX_PERIOD                      699050
-#define TICKS_PER_uSEC                  1
-
-/* 
- *  These are useconds NOT ticks.  
- * 
- */
-#define mSEC_1                          1000
-#define mSEC_5                          (mSEC_1 * 5)
-#define mSEC_10                         (mSEC_1 * 10)
-#define mSEC_25                         (mSEC_1 * 25)
-#define SEC_1                           (mSEC_1 * 1000)
-
 #define VERSATILE_CSR_BASE             0x10000000
 #define VERSATILE_CSR_SIZE             0x10000000
 
@@ -432,5 +412,3 @@
 #endif
 
 #endif
-
-/* 	END */
