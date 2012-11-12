From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Mon, 12 Nov 2012 14:49:25 +0100
Subject: [RFC PATCH 3/4] ARM: S3C24XX: irq_data conversion for s3c_irqsub_*
 functions
In-Reply-To: <201211121446.30167.heiko@sntech.de>
References: <201211121446.30167.heiko@sntech.de>
Message-ID: <201211121449.27870.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't strip off the rest of the irq_data struct when calling one of
the s3c_irqsub_* functions. This enables using its hwirq field
later on.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/irq-s3c2412.c      |    6 +++---
 arch/arm/mach-s3c24xx/irq-s3c2416.c      |   24 ++++++++++++------------
 arch/arm/mach-s3c24xx/irq-s3c2440.c      |    6 +++---
 arch/arm/mach-s3c24xx/irq-s3c2443.c      |   30 +++++++++++++++---------------
 arch/arm/mach-s3c24xx/irq-s3c244x.c      |    6 +++---
 arch/arm/plat-samsung/include/plat/irq.h |   18 +++++++++---------
 drivers/irqchip/irq-s3c24xx.c            |   24 ++++++++++++------------
 7 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/irq-s3c2412.c b/arch/arm/mach-s3c24xx/irq-s3c2412.c
index e65619d..2cee386 100644
--- a/arch/arm/mach-s3c24xx/irq-s3c2412.c
+++ b/arch/arm/mach-s3c24xx/irq-s3c2412.c
@@ -134,17 +134,17 @@ static void s3c2412_irq_demux_cfsdi(unsigned int irq, struct irq_desc *desc)
 
 static void s3c2412_irq_cfsdi_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(data->irq, INTMSK_CFSDI, SUBMSK_CFSDI);
+	s3c_irqsub_mask(data, INTMSK_CFSDI, SUBMSK_CFSDI);
 }
 
 static void s3c2412_irq_cfsdi_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(data->irq, INTMSK_CFSDI);
+	s3c_irqsub_unmask(data, INTMSK_CFSDI);
 }
 
 static void s3c2412_irq_cfsdi_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(data->irq, INTMSK_CFSDI, SUBMSK_CFSDI);
+	s3c_irqsub_maskack(data, INTMSK_CFSDI, SUBMSK_CFSDI);
 }
 
 static struct irq_chip s3c2412_irq_cfsdi = {
diff --git a/arch/arm/mach-s3c24xx/irq-s3c2416.c b/arch/arm/mach-s3c24xx/irq-s3c2416.c
index ff141b0..149d406 100644
--- a/arch/arm/mach-s3c24xx/irq-s3c2416.c
+++ b/arch/arm/mach-s3c24xx/irq-s3c2416.c
@@ -80,17 +80,17 @@ static void s3c2416_irq_demux_wdtac97(unsigned int irq, struct irq_desc *desc)
 
 static void s3c2416_irq_wdtac97_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(data->irq, INTMSK_WDTAC97, SUBMSK_WDTAC97);
+	s3c_irqsub_mask(data, INTMSK_WDTAC97, SUBMSK_WDTAC97);
 }
 
 static void s3c2416_irq_wdtac97_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(data->irq, INTMSK_WDTAC97);
+	s3c_irqsub_unmask(data, INTMSK_WDTAC97);
 }
 
 static void s3c2416_irq_wdtac97_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(data->irq, INTMSK_WDTAC97, SUBMSK_WDTAC97);
+	s3c_irqsub_maskack(data, INTMSK_WDTAC97, SUBMSK_WDTAC97);
 }
 
 static struct irq_chip s3c2416_irq_wdtac97 = {
@@ -111,17 +111,17 @@ static void s3c2416_irq_demux_lcd(unsigned int irq, struct irq_desc *desc)
 
 static void s3c2416_irq_lcd_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(data->irq, INTMSK_LCD, SUBMSK_LCD);
+	s3c_irqsub_mask(data, INTMSK_LCD, SUBMSK_LCD);
 }
 
 static void s3c2416_irq_lcd_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(data->irq, INTMSK_LCD);
+	s3c_irqsub_unmask(data, INTMSK_LCD);
 }
 
 static void s3c2416_irq_lcd_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(data->irq, INTMSK_LCD, SUBMSK_LCD);
+	s3c_irqsub_maskack(data, INTMSK_LCD, SUBMSK_LCD);
 }
 
 static struct irq_chip s3c2416_irq_lcd = {
@@ -143,17 +143,17 @@ static void s3c2416_irq_demux_dma(unsigned int irq, struct irq_desc *desc)
 
 static void s3c2416_irq_dma_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(data->irq, INTMSK_DMA, SUBMSK_DMA);
+	s3c_irqsub_mask(data, INTMSK_DMA, SUBMSK_DMA);
 }
 
 static void s3c2416_irq_dma_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(data->irq, INTMSK_DMA);
+	s3c_irqsub_unmask(data, INTMSK_DMA);
 }
 
 static void s3c2416_irq_dma_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(data->irq, INTMSK_DMA, SUBMSK_DMA);
+	s3c_irqsub_maskack(data, INTMSK_DMA, SUBMSK_DMA);
 }
 
 static struct irq_chip s3c2416_irq_dma = {
@@ -174,17 +174,17 @@ static void s3c2416_irq_demux_uart3(unsigned int irq, struct irq_desc *desc)
 
 static void s3c2416_irq_uart3_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(data->irq, INTMSK_UART3, SUBMSK_UART3);
+	s3c_irqsub_mask(data, INTMSK_UART3, SUBMSK_UART3);
 }
 
 static void s3c2416_irq_uart3_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(data->irq, INTMSK_UART3);
+	s3c_irqsub_unmask(data, INTMSK_UART3);
 }
 
 static void s3c2416_irq_uart3_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(data->irq, INTMSK_UART3, SUBMSK_UART3);
+	s3c_irqsub_maskack(data, INTMSK_UART3, SUBMSK_UART3);
 }
 
 static struct irq_chip s3c2416_irq_uart3 = {
diff --git a/arch/arm/mach-s3c24xx/irq-s3c2440.c b/arch/arm/mach-s3c24xx/irq-s3c2440.c
index 4a18cde..99fada9 100644
--- a/arch/arm/mach-s3c24xx/irq-s3c2440.c
+++ b/arch/arm/mach-s3c24xx/irq-s3c2440.c
@@ -71,19 +71,19 @@ static void s3c_irq_demux_wdtac97(unsigned int irq,
 static void
 s3c_irq_wdtac97_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(data->irq, INTMSK_WDT, 3 << 13);
+	s3c_irqsub_mask(data, INTMSK_WDT, 3 << 13);
 }
 
 static void
 s3c_irq_wdtac97_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(data->irq, INTMSK_WDT);
+	s3c_irqsub_unmask(data, INTMSK_WDT);
 }
 
 static void
 s3c_irq_wdtac97_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(data->irq, INTMSK_WDT, 3 << 13);
+	s3c_irqsub_maskack(data, INTMSK_WDT, 3 << 13);
 }
 
 static struct irq_chip s3c_irq_wdtac97 = {
diff --git a/arch/arm/mach-s3c24xx/irq-s3c2443.c b/arch/arm/mach-s3c24xx/irq-s3c2443.c
index 5e69109..0d9f77a 100644
--- a/arch/arm/mach-s3c24xx/irq-s3c2443.c
+++ b/arch/arm/mach-s3c24xx/irq-s3c2443.c
@@ -77,17 +77,17 @@ static void s3c2443_irq_demux_wdtac97(unsigned int irq, struct irq_desc *desc)
 
 static void s3c2443_irq_wdtac97_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(data->irq, INTMSK_WDTAC97, SUBMSK_WDTAC97);
+	s3c_irqsub_mask(data, INTMSK_WDTAC97, SUBMSK_WDTAC97);
 }
 
 static void s3c2443_irq_wdtac97_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(data->irq, INTMSK_WDTAC97);
+	s3c_irqsub_unmask(data, INTMSK_WDTAC97);
 }
 
 static void s3c2443_irq_wdtac97_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(data->irq, INTMSK_WDTAC97, SUBMSK_WDTAC97);
+	s3c_irqsub_maskack(data, INTMSK_WDTAC97, SUBMSK_WDTAC97);
 }
 
 static struct irq_chip s3c2443_irq_wdtac97 = {
@@ -108,17 +108,17 @@ static void s3c2443_irq_demux_lcd(unsigned int irq, struct irq_desc *desc)
 
 static void s3c2443_irq_lcd_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(data->irq, INTMSK_LCD, SUBMSK_LCD);
+	s3c_irqsub_mask(data, INTMSK_LCD, SUBMSK_LCD);
 }
 
 static void s3c2443_irq_lcd_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(data->irq, INTMSK_LCD);
+	s3c_irqsub_unmask(data, INTMSK_LCD);
 }
 
 static void s3c2443_irq_lcd_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(data->irq, INTMSK_LCD, SUBMSK_LCD);
+	s3c_irqsub_maskack(data, INTMSK_LCD, SUBMSK_LCD);
 }
 
 static struct irq_chip s3c2443_irq_lcd = {
@@ -139,17 +139,17 @@ static void s3c2443_irq_demux_dma(unsigned int irq, struct irq_desc *desc)
 
 static void s3c2443_irq_dma_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(data->irq, INTMSK_DMA, SUBMSK_DMA);
+	s3c_irqsub_mask(data, INTMSK_DMA, SUBMSK_DMA);
 }
 
 static void s3c2443_irq_dma_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(data->irq, INTMSK_DMA);
+	s3c_irqsub_unmask(data, INTMSK_DMA);
 }
 
 static void s3c2443_irq_dma_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(data->irq, INTMSK_DMA, SUBMSK_DMA);
+	s3c_irqsub_maskack(data, INTMSK_DMA, SUBMSK_DMA);
 }
 
 static struct irq_chip s3c2443_irq_dma = {
@@ -170,17 +170,17 @@ static void s3c2443_irq_demux_uart3(unsigned int irq, struct irq_desc *desc)
 
 static void s3c2443_irq_uart3_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(data->irq, INTMSK_UART3, SUBMSK_UART3);
+	s3c_irqsub_mask(data, INTMSK_UART3, SUBMSK_UART3);
 }
 
 static void s3c2443_irq_uart3_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(data->irq, INTMSK_UART3);
+	s3c_irqsub_unmask(data, INTMSK_UART3);
 }
 
 static void s3c2443_irq_uart3_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(data->irq, INTMSK_UART3, SUBMSK_UART3);
+	s3c_irqsub_maskack(data, INTMSK_UART3, SUBMSK_UART3);
 }
 
 static struct irq_chip s3c2443_irq_uart3 = {
@@ -201,17 +201,17 @@ static void s3c2443_irq_demux_cam(unsigned int irq, struct irq_desc *desc)
 
 static void s3c2443_irq_cam_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(data->irq, INTMSK_CAM, SUBMSK_CAM);
+	s3c_irqsub_mask(data, INTMSK_CAM, SUBMSK_CAM);
 }
 
 static void s3c2443_irq_cam_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(data->irq, INTMSK_CAM);
+	s3c_irqsub_unmask(data, INTMSK_CAM);
 }
 
 static void s3c2443_irq_cam_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(data->irq, INTMSK_CAM, SUBMSK_CAM);
+	s3c_irqsub_maskack(data, INTMSK_CAM, SUBMSK_CAM);
 }
 
 static struct irq_chip s3c2443_irq_cam = {
diff --git a/arch/arm/mach-s3c24xx/irq-s3c244x.c b/arch/arm/mach-s3c24xx/irq-s3c244x.c
index 5fe8e58..7a3f53d 100644
--- a/arch/arm/mach-s3c24xx/irq-s3c244x.c
+++ b/arch/arm/mach-s3c24xx/irq-s3c244x.c
@@ -70,19 +70,19 @@ static void s3c_irq_demux_cam(unsigned int irq,
 static void
 s3c_irq_cam_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(data->irq, INTMSK_CAM, 3 << 11);
+	s3c_irqsub_mask(data, INTMSK_CAM, 3 << 11);
 }
 
 static void
 s3c_irq_cam_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(data->irq, INTMSK_CAM);
+	s3c_irqsub_unmask(data, INTMSK_CAM);
 }
 
 static void
 s3c_irq_cam_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(data->irq, INTMSK_CAM, 3 << 11);
+	s3c_irqsub_maskack(data, INTMSK_CAM, 3 << 11);
 }
 
 static struct irq_chip s3c_irq_cam = {
diff --git a/arch/arm/plat-samsung/include/plat/irq.h b/arch/arm/plat-samsung/include/plat/irq.h
index e21a89b..3ae54dc 100644
--- a/arch/arm/plat-samsung/include/plat/irq.h
+++ b/arch/arm/plat-samsung/include/plat/irq.h
@@ -25,7 +25,7 @@
 extern struct irq_chip s3c_irq_level_chip;
 extern struct irq_chip s3c_irq_chip;
 
-static inline void s3c_irqsub_mask(unsigned int irqno,
+static inline void s3c_irqsub_mask(struct irq_data *data,
 				   unsigned int parentbit,
 				   int subcheck)
 {
@@ -35,7 +35,7 @@ static inline void s3c_irqsub_mask(unsigned int irqno,
 	submask = __raw_readl(S3C2410_INTSUBMSK);
 	mask = __raw_readl(S3C2410_INTMSK);
 
-	submask |= (1UL << (irqno - IRQ_S3CUART_RX0));
+	submask |= (1UL << (data->irq - IRQ_S3CUART_RX0));
 
 	/* check to see if we need to mask the parent IRQ */
 
@@ -47,7 +47,7 @@ static inline void s3c_irqsub_mask(unsigned int irqno,
 
 }
 
-static inline void s3c_irqsub_unmask(unsigned int irqno,
+static inline void s3c_irqsub_unmask(struct irq_data *data,
 				     unsigned int parentbit)
 {
 	unsigned long mask;
@@ -56,7 +56,7 @@ static inline void s3c_irqsub_unmask(unsigned int irqno,
 	submask = __raw_readl(S3C2410_INTSUBMSK);
 	mask = __raw_readl(S3C2410_INTMSK);
 
-	submask &= ~(1UL << (irqno - IRQ_S3CUART_RX0));
+	submask &= ~(1UL << (data->irq - IRQ_S3CUART_RX0));
 	mask &= ~parentbit;
 
 	/* write back masks */
@@ -65,13 +65,13 @@ static inline void s3c_irqsub_unmask(unsigned int irqno,
 }
 
 
-static inline void s3c_irqsub_maskack(unsigned int irqno,
+static inline void s3c_irqsub_maskack(struct irq_data *data,
 				      unsigned int parentmask,
 				      unsigned int group)
 {
-	unsigned int bit = 1UL << (irqno - IRQ_S3CUART_RX0);
+	unsigned int bit = 1UL << (data->irq - IRQ_S3CUART_RX0);
 
-	s3c_irqsub_mask(irqno, parentmask, group);
+	s3c_irqsub_mask(data, parentmask, group);
 
 	__raw_writel(bit, S3C2410_SUBSRCPND);
 
@@ -86,11 +86,11 @@ static inline void s3c_irqsub_maskack(unsigned int irqno,
 	}
 }
 
-static inline void s3c_irqsub_ack(unsigned int irqno,
+static inline void s3c_irqsub_ack(struct irq_data *data,
 				  unsigned int parentmask,
 				  unsigned int group)
 {
-	unsigned int bit = 1UL << (irqno - IRQ_S3CUART_RX0);
+	unsigned int bit = 1UL << (data->irq - IRQ_S3CUART_RX0);
 
 	__raw_writel(bit, S3C2410_SUBSRCPND);
 
diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
index cf9d04d..073e614 100644
--- a/drivers/irqchip/irq-s3c24xx.c
+++ b/drivers/irqchip/irq-s3c24xx.c
@@ -258,19 +258,19 @@ static struct irq_chip s3c_irq_eint0t4 = {
 static void
 s3c_irq_uart0_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(data->irq, INTMSK_UART0, 7);
+	s3c_irqsub_mask(data, INTMSK_UART0, 7);
 }
 
 static void
 s3c_irq_uart0_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(data->irq, INTMSK_UART0);
+	s3c_irqsub_unmask(data, INTMSK_UART0);
 }
 
 static void
 s3c_irq_uart0_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(data->irq, INTMSK_UART0, 7);
+	s3c_irqsub_maskack(data, INTMSK_UART0, 7);
 }
 
 static struct irq_chip s3c_irq_uart0 = {
@@ -285,19 +285,19 @@ static struct irq_chip s3c_irq_uart0 = {
 static void
 s3c_irq_uart1_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(data->irq, INTMSK_UART1, 7 << 3);
+	s3c_irqsub_mask(data, INTMSK_UART1, 7 << 3);
 }
 
 static void
 s3c_irq_uart1_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(data->irq, INTMSK_UART1);
+	s3c_irqsub_unmask(data, INTMSK_UART1);
 }
 
 static void
 s3c_irq_uart1_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(data->irq, INTMSK_UART1, 7 << 3);
+	s3c_irqsub_maskack(data, INTMSK_UART1, 7 << 3);
 }
 
 static struct irq_chip s3c_irq_uart1 = {
@@ -312,19 +312,19 @@ static struct irq_chip s3c_irq_uart1 = {
 static void
 s3c_irq_uart2_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(data->irq, INTMSK_UART2, 7 << 6);
+	s3c_irqsub_mask(data, INTMSK_UART2, 7 << 6);
 }
 
 static void
 s3c_irq_uart2_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(data->irq, INTMSK_UART2);
+	s3c_irqsub_unmask(data, INTMSK_UART2);
 }
 
 static void
 s3c_irq_uart2_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(data->irq, INTMSK_UART2, 7 << 6);
+	s3c_irqsub_maskack(data, INTMSK_UART2, 7 << 6);
 }
 
 static struct irq_chip s3c_irq_uart2 = {
@@ -339,19 +339,19 @@ static struct irq_chip s3c_irq_uart2 = {
 static void
 s3c_irq_adc_mask(struct irq_data *d)
 {
-	s3c_irqsub_mask(d->irq, INTMSK_ADCPARENT, 3 << 9);
+	s3c_irqsub_mask(d, INTMSK_ADCPARENT, 3 << 9);
 }
 
 static void
 s3c_irq_adc_unmask(struct irq_data *d)
 {
-	s3c_irqsub_unmask(d->irq, INTMSK_ADCPARENT);
+	s3c_irqsub_unmask(d, INTMSK_ADCPARENT);
 }
 
 static void
 s3c_irq_adc_ack(struct irq_data *d)
 {
-	s3c_irqsub_ack(d->irq, INTMSK_ADCPARENT, 3 << 9);
+	s3c_irqsub_ack(d, INTMSK_ADCPARENT, 3 << 9);
 }
 
 static struct irq_chip s3c_irq_adc = {
-- 
1.7.2.3
