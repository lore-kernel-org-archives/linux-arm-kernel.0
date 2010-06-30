From: siccegge@cs.fau.de (Christoph Egger)
Date: Wed, 30 Jun 2010 17:57:06 +0200
Subject: [PATCH 10/33] Removing dead VIDEO_AT91_ISI
In-Reply-To: <cover.1277911345.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
Message-ID: <ee303ddacab78fe3a1032485d880f313244c0c70.1277911346.git.siccegge@cs.fau.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VIDEO_AT91_ISI doesn't exist in Kconfig, therefore removing all
references for it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 arch/arm/mach-at91/at91sam9263_devices.c |   49 ------------------------------
 1 files changed, 0 insertions(+), 49 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index fb5c23a..511d348 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -862,56 +862,7 @@ void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data)
 void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data) {}
 #endif
 
-
-/* --------------------------------------------------------------------
- *  Image Sensor Interface
- * -------------------------------------------------------------------- */
-
-#if defined(CONFIG_VIDEO_AT91_ISI) || defined(CONFIG_VIDEO_AT91_ISI_MODULE)
-
-struct resource isi_resources[] = {
-	[0] = {
-		.start	= AT91SAM9263_BASE_ISI,
-		.end	= AT91SAM9263_BASE_ISI + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9263_ID_ISI,
-		.end	= AT91SAM9263_ID_ISI,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91sam9263_isi_device = {
-	.name		= "at91_isi",
-	.id		= -1,
-	.resource	= isi_resources,
-	.num_resources	= ARRAY_SIZE(isi_resources),
-};
-
-void __init at91_add_device_isi(void)
-{
-	at91_set_A_periph(AT91_PIN_PE0, 0);	/* ISI_D0 */
-	at91_set_A_periph(AT91_PIN_PE1, 0);	/* ISI_D1 */
-	at91_set_A_periph(AT91_PIN_PE2, 0);	/* ISI_D2 */
-	at91_set_A_periph(AT91_PIN_PE3, 0);	/* ISI_D3 */
-	at91_set_A_periph(AT91_PIN_PE4, 0);	/* ISI_D4 */
-	at91_set_A_periph(AT91_PIN_PE5, 0);	/* ISI_D5 */
-	at91_set_A_periph(AT91_PIN_PE6, 0);	/* ISI_D6 */
-	at91_set_A_periph(AT91_PIN_PE7, 0);	/* ISI_D7 */
-	at91_set_A_periph(AT91_PIN_PE8, 0);	/* ISI_PCK */
-	at91_set_A_periph(AT91_PIN_PE9, 0);	/* ISI_HSYNC */
-	at91_set_A_periph(AT91_PIN_PE10, 0);	/* ISI_VSYNC */
-	at91_set_B_periph(AT91_PIN_PE11, 0);	/* ISI_MCK (PCK3) */
-	at91_set_B_periph(AT91_PIN_PE12, 0);	/* ISI_PD8 */
-	at91_set_B_periph(AT91_PIN_PE13, 0);	/* ISI_PD9 */
-	at91_set_B_periph(AT91_PIN_PE14, 0);	/* ISI_PD10 */
-	at91_set_B_periph(AT91_PIN_PE15, 0);	/* ISI_PD11 */
-}
-#else
 void __init at91_add_device_isi(void) {}
-#endif
-
 
 /* --------------------------------------------------------------------
  *  Timer/Counter block
-- 
1.7.0.4
