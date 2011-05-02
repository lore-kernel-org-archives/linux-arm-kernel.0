From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue,  3 May 2011 00:13:21 +0200
Subject: [PATCH 1/3] at91: factorize common irq ID
Message-ID: <1304374403-28513-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Cc: Andrew Victor <linux@maxim.org.za>
---
 arch/arm/mach-at91/include/mach/at572d940hf.h |    2 --
 arch/arm/mach-at91/include/mach/at91cap9.h    |    2 --
 arch/arm/mach-at91/include/mach/at91rm9200.h  |    2 --
 arch/arm/mach-at91/include/mach/at91sam9260.h |    2 --
 arch/arm/mach-at91/include/mach/at91sam9261.h |    2 --
 arch/arm/mach-at91/include/mach/at91sam9263.h |    2 --
 arch/arm/mach-at91/include/mach/at91sam9g45.h |    2 --
 arch/arm/mach-at91/include/mach/at91sam9rl.h  |    2 --
 arch/arm/mach-at91/include/mach/at91x40.h     |    2 --
 arch/arm/mach-at91/include/mach/hardware.h    |    6 ++++++
 10 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at572d940hf.h b/arch/arm/mach-at91/include/mach/at572d940hf.h
index be510cf..a738dc7 100644
--- a/arch/arm/mach-at91/include/mach/at572d940hf.h
+++ b/arch/arm/mach-at91/include/mach/at572d940hf.h
@@ -26,8 +26,6 @@
 /*
  * Peripheral identifiers/interrupts.
  */
-#define AT91_ID_FIQ		0	/* Advanced Interrupt Controller (FIQ) */
-#define AT91_ID_SYS		1	/* System Peripherals */
 #define AT572D940HF_ID_PIOA	2	/* Parallel IO Controller A */
 #define AT572D940HF_ID_PIOB	3	/* Parallel IO Controller B */
 #define AT572D940HF_ID_PIOC	4	/* Parallel IO Controller C */
diff --git a/arch/arm/mach-at91/include/mach/at91cap9.h b/arch/arm/mach-at91/include/mach/at91cap9.h
index 9c6af97..a043bce 100644
--- a/arch/arm/mach-at91/include/mach/at91cap9.h
+++ b/arch/arm/mach-at91/include/mach/at91cap9.h
@@ -20,8 +20,6 @@
 /*
  * Peripheral identifiers/interrupts.
  */
-#define AT91_ID_FIQ		0	/* Advanced Interrupt Controller (FIQ) */
-#define AT91_ID_SYS		1	/* System Peripherals */
 #define AT91CAP9_ID_PIOABCD	2	/* Parallel IO Controller A, B, C and D */
 #define AT91CAP9_ID_MPB0	3	/* MP Block Peripheral 0 */
 #define AT91CAP9_ID_MPB1	4	/* MP Block Peripheral 1 */
diff --git a/arch/arm/mach-at91/include/mach/at91rm9200.h b/arch/arm/mach-at91/include/mach/at91rm9200.h
index 7898315..99e0f8d 100644
--- a/arch/arm/mach-at91/include/mach/at91rm9200.h
+++ b/arch/arm/mach-at91/include/mach/at91rm9200.h
@@ -19,8 +19,6 @@
 /*
  * Peripheral identifiers/interrupts.
  */
-#define AT91_ID_FIQ		0	/* Advanced Interrupt Controller (FIQ) */
-#define AT91_ID_SYS		1	/* System Peripheral */
 #define AT91RM9200_ID_PIOA	2	/* Parallel IO Controller A */
 #define AT91RM9200_ID_PIOB	3	/* Parallel IO Controller B */
 #define AT91RM9200_ID_PIOC	4	/* Parallel IO Controller C */
diff --git a/arch/arm/mach-at91/include/mach/at91sam9260.h b/arch/arm/mach-at91/include/mach/at91sam9260.h
index 4e79036..8b6bf83 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9260.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9260.h
@@ -20,8 +20,6 @@
 /*
  * Peripheral identifiers/interrupts.
  */
-#define AT91_ID_FIQ		0	/* Advanced Interrupt Controller (FIQ) */
-#define AT91_ID_SYS		1	/* System Peripherals */
 #define AT91SAM9260_ID_PIOA	2	/* Parallel IO Controller A */
 #define AT91SAM9260_ID_PIOB	3	/* Parallel IO Controller B */
 #define AT91SAM9260_ID_PIOC	4	/* Parallel IO Controller C */
diff --git a/arch/arm/mach-at91/include/mach/at91sam9261.h b/arch/arm/mach-at91/include/mach/at91sam9261.h
index 2b56185..eafbdda 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9261.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9261.h
@@ -18,8 +18,6 @@
 /*
  * Peripheral identifiers/interrupts.
  */
-#define AT91_ID_FIQ		0	/* Advanced Interrupt Controller (FIQ) */
-#define AT91_ID_SYS		1	/* System Peripherals */
 #define AT91SAM9261_ID_PIOA	2	/* Parallel IO Controller A */
 #define AT91SAM9261_ID_PIOB	3	/* Parallel IO Controller B */
 #define AT91SAM9261_ID_PIOC	4	/* Parallel IO Controller C */
diff --git a/arch/arm/mach-at91/include/mach/at91sam9263.h b/arch/arm/mach-at91/include/mach/at91sam9263.h
index 2091f1e..e2d3482 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9263.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9263.h
@@ -18,8 +18,6 @@
 /*
  * Peripheral identifiers/interrupts.
  */
-#define AT91_ID_FIQ		0	/* Advanced Interrupt Controller (FIQ) */
-#define AT91_ID_SYS		1	/* System Peripherals */
 #define AT91SAM9263_ID_PIOA	2	/* Parallel IO Controller A */
 #define AT91SAM9263_ID_PIOB	3	/* Parallel IO Controller B */
 #define AT91SAM9263_ID_PIOCDE	4	/* Parallel IO Controller C, D and E */
diff --git a/arch/arm/mach-at91/include/mach/at91sam9g45.h b/arch/arm/mach-at91/include/mach/at91sam9g45.h
index a526869..520b14b 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9g45.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9g45.h
@@ -18,8 +18,6 @@
 /*
  * Peripheral identifiers/interrupts.
  */
-#define AT91_ID_FIQ		0	/* Advanced Interrupt Controller (FIQ) */
-#define AT91_ID_SYS		1	/* System Controller Interrupt */
 #define AT91SAM9G45_ID_PIOA	2	/* Parallel I/O Controller A */
 #define AT91SAM9G45_ID_PIOB	3	/* Parallel I/O Controller B */
 #define AT91SAM9G45_ID_PIOC	4	/* Parallel I/O Controller C */
diff --git a/arch/arm/mach-at91/include/mach/at91sam9rl.h b/arch/arm/mach-at91/include/mach/at91sam9rl.h
index 87ba851..41dbbe6 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9rl.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9rl.h
@@ -17,8 +17,6 @@
 /*
  * Peripheral identifiers/interrupts.
  */
-#define AT91_ID_FIQ		0	/* Advanced Interrupt Controller (FIQ) */
-#define AT91_ID_SYS		1	/* System Controller */
 #define AT91SAM9RL_ID_PIOA	2	/* Parallel IO Controller A */
 #define AT91SAM9RL_ID_PIOB	3	/* Parallel IO Controller B */
 #define AT91SAM9RL_ID_PIOC	4	/* Parallel IO Controller C */
diff --git a/arch/arm/mach-at91/include/mach/at91x40.h b/arch/arm/mach-at91/include/mach/at91x40.h
index 063ac44..a152ff8 100644
--- a/arch/arm/mach-at91/include/mach/at91x40.h
+++ b/arch/arm/mach-at91/include/mach/at91x40.h
@@ -15,8 +15,6 @@
 /*
  *	IRQ list.
  */
-#define AT91_ID_FIQ		0	/* FIQ */
-#define AT91_ID_SYS		1	/* System Peripheral */
 #define AT91X40_ID_USART0	2	/* USART port 0 */
 #define AT91X40_ID_USART1	3	/* USART port 1 */
 #define AT91X40_ID_TC0		4	/* Timer/Counter 0 */
diff --git a/arch/arm/mach-at91/include/mach/hardware.h b/arch/arm/mach-at91/include/mach/hardware.h
index 3d64a75..3522464 100644
--- a/arch/arm/mach-at91/include/mach/hardware.h
+++ b/arch/arm/mach-at91/include/mach/hardware.h
@@ -39,6 +39,12 @@
 #endif
 
 
+/*
+ * Peripheral identifiers/interrupts.
+ */
+#define AT91_ID_FIQ		0	/* Advanced Interrupt Controller (FIQ) */
+#define AT91_ID_SYS		1	/* System Peripherals */
+
 #ifdef CONFIG_MMU
 /*
  * Remap the peripherals from address 0xFFF78000 .. 0xFFFFFFFF
-- 
1.7.4.1
