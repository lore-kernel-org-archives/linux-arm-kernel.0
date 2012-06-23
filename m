From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Sat, 23 Jun 2012 18:05:35 +0200
Subject: [PATCH v3 3/7] ARM: at91: remove static irq priorities for sam9x5
In-Reply-To: <1340467539-12294-1-git-send-email-ludovic.desroches@atmel.com>
References: <1340467539-12294-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1340467539-12294-4-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Since irq priorites are managed in DT, static ones are no more required for
sam9x5 which only has DT support.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/mach-at91/at91sam9x5.c |   38 --------------------------------------
 1 files changed, 0 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index 537710b..477cf9d 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -319,47 +319,9 @@ void __init at91sam9x5_initialize(void)
 /* --------------------------------------------------------------------
  *  Interrupt initialization
  * -------------------------------------------------------------------- */
-/*
- * The default interrupt priority levels (0 = lowest, 7 = highest).
- */
-static unsigned int at91sam9x5_default_irq_priority[NR_AIC_IRQS] __initdata = {
-	7,	/* Advanced Interrupt Controller (FIQ) */
-	7,	/* System Peripherals */
-	1,	/* Parallel IO Controller A and B */
-	1,	/* Parallel IO Controller C and D */
-	4,	/* Soft Modem */
-	5,	/* USART 0 */
-	5,	/* USART 1 */
-	5,	/* USART 2 */
-	5,	/* USART 3 */
-	6,	/* Two-Wire Interface 0 */
-	6,	/* Two-Wire Interface 1 */
-	6,	/* Two-Wire Interface 2 */
-	0,	/* Multimedia Card Interface 0 */
-	5,	/* Serial Peripheral Interface 0 */
-	5,	/* Serial Peripheral Interface 1 */
-	5,	/* UART 0 */
-	5,	/* UART 1 */
-	0,	/* Timer Counter 0, 1, 2, 3, 4 and 5 */
-	0,	/* Pulse Width Modulation Controller */
-	0,	/* ADC Controller */
-	0,	/* DMA Controller 0 */
-	0,	/* DMA Controller 1 */
-	2,	/* USB Host High Speed port */
-	2,	/* USB Device High speed port */
-	3,	/* Ethernet MAC 0 */
-	3,	/* LDC Controller or Image Sensor Interface */
-	0,	/* Multimedia Card Interface 1 */
-	3,	/* Ethernet MAC 1 */
-	4,	/* Synchronous Serial Interface */
-	4,	/* CAN Controller 0 */
-	4,	/* CAN Controller 1 */
-	0,	/* Advanced Interrupt Controller (IRQ0) */
-};
 
 struct at91_init_soc __initdata at91sam9x5_soc = {
 	.map_io = at91sam9x5_map_io,
-	.default_irq_priority = at91sam9x5_default_irq_priority,
 	.register_clocks = at91sam9x5_register_clocks,
 	.init = at91sam9x5_initialize,
 };
-- 
1.7.5.4
