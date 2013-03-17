From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sun, 17 Mar 2013 14:09:07 +0100
Subject: [PATCH v3 6/6] irqchip: s3c24xx: add s3c2450 interrupt definitions
In-Reply-To: <201303171404.06146.heiko@sntech.de>
References: <201303171404.06146.heiko@sntech.de>
Message-ID: <201303171409.07774.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The s3c2450 is special in that it shares the cpu identification with the
s3c2416 but provides more interrupts for its additional components.

It also shares the layout of the main interrupt register with the s3c2443
and therefore reuses this definition.

As no non-dt boards are present, the s3c2450 irqs will only be
accessible thru devicetree.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/irqchip/irq-s3c24xx.c |   62 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
index 55cb363..7ddf8e8 100644
--- a/drivers/irqchip/irq-s3c24xx.c
+++ b/drivers/irqchip/irq-s3c24xx.c
@@ -852,6 +852,51 @@ static struct s3c_irq_data init_s3c2416_second[32] = {
 	{ .type = S3C_IRQTYPE_EDGE }, /* I2S0 */
 };
 
+static struct s3c_irq_data init_s3c2450subint[32] = {
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 28 }, /* UART0-RX */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 28 }, /* UART0-TX */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 28 }, /* UART0-ERR */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 23 }, /* UART1-RX */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 23 }, /* UART1-TX */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 23 }, /* UART1-ERR */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 15 }, /* UART2-RX */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 15 }, /* UART2-TX */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 15 }, /* UART2-ERR */
+	{ .type = S3C_IRQTYPE_EDGE, .parent_irq = 31 }, /* TC */
+	{ .type = S3C_IRQTYPE_EDGE, .parent_irq = 31 }, /* ADC */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 6 }, /* CAM_C */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 6 }, /* CAM_P */
+	{ .type = S3C_IRQTYPE_NONE }, /* reserved */
+	{ .type = S3C_IRQTYPE_NONE }, /* reserved */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 16 }, /* LCD2 */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 16 }, /* LCD3 */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 16 }, /* LCD4 */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA0 */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA1 */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA2 */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA3 */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA4 */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA5 */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 18 }, /* UART3-RX */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 18 }, /* UART3-TX */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 18 }, /* UART3-ERR */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 9 }, /* WDT */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 9 }, /* AC97 */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA6 */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA7 */
+};
+
+static struct s3c_irq_data init_s3c2450second[32] = {
+	{ .type = S3C_IRQTYPE_EDGE }, /* 2D */
+	{ .type = S3C_IRQTYPE_EDGE }, /* IIC1 */
+	{ .type = S3C_IRQTYPE_NONE }, /* reserved */
+	{ .type = S3C_IRQTYPE_NONE }, /* reserved */
+	{ .type = S3C_IRQTYPE_EDGE }, /* PCM0 */
+	{ .type = S3C_IRQTYPE_EDGE }, /* PCM1 */
+	{ .type = S3C_IRQTYPE_EDGE }, /* I2S0 */
+	{ .type = S3C_IRQTYPE_EDGE }, /* I2S1 */
+};
+
 void __init s3c2416_init_irq(void)
 {
 	struct s3c_irq_intc *main_intc;
@@ -1024,7 +1069,7 @@ void __init s3c2442_init_irq(void)
 }
 #endif
 
-#ifdef CONFIG_CPU_S3C2443
+#if defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2416)
 static struct s3c_irq_data init_s3c2443base[32] = {
 	{ .type = S3C_IRQTYPE_EINT, }, /* EINT0 */
 	{ .type = S3C_IRQTYPE_EINT, }, /* EINT1 */
@@ -1059,8 +1104,9 @@ static struct s3c_irq_data init_s3c2443base[32] = {
 	{ .type = S3C_IRQTYPE_EDGE, }, /* RTC */
 	{ .type = S3C_IRQTYPE_LEVEL, }, /* ADCPARENT */
 };
+#endif
 
-
+#ifdef CONFIG_CPU_S3C2443
 static struct s3c_irq_data init_s3c2443subint[32] = {
 	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 28 }, /* UART0-RX */
 	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 28 }, /* UART0-TX */
@@ -1172,6 +1218,17 @@ struct s3c24xx_irq_of_data s3c2416_irq_data = {
 	.irq_ctrl = s3c2416_ctrl,
 	.num_ctrl = ARRAY_SIZE(s3c2416_ctrl),
 };
+
+static struct s3c24xx_irq_of_ctrl s3c2450_ctrl[] = {
+	S3C24XX_IRQCTRL("intc", 0, init_s3c2443base, &main_intc, NULL),
+	S3C24XX_IRQCTRL("subintc", 0x18, init_s3c2450subint, NULL, &main_intc),
+	S3C24XX_IRQCTRL("intc2", 0x40, init_s3c2450second, &main_intc2, NULL),
+};
+
+static struct s3c24xx_irq_of_data s3c2450_irq_data = {
+	.irq_ctrl = s3c2450_ctrl,
+	.num_ctrl = ARRAY_SIZE(s3c2450_ctrl),
+};
 #endif
 
 #ifdef CONFIG_CPU_S3C2440
@@ -1219,6 +1276,7 @@ static const struct of_device_id intc_list[] = {
 #endif
 #ifdef CONFIG_CPU_S3C2416
 	{ .compatible = "samsung,s3c2416-irq", .data = &s3c2416_irq_data },
+	{ .compatible = "samsung,s3c2450-irq", .data = &s3c2450_irq_data },
 #endif
 #ifdef CONFIG_CPU_S3C2440
 	{ .compatible = "samsung,s3c2440-irq", .data = &s3c2440_irq_data },
-- 
1.7.2.3
