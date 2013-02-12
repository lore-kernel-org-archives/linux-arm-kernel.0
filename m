From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 12 Feb 2013 01:03:08 +0100
Subject: [PATCH 1/3] ARM: S3C24XX: include first 4 bits of the eint register
 in irq mapping
In-Reply-To: <201302120102.03511.heiko@sntech.de>
References: <201302120102.03511.heiko@sntech.de>
Message-ID: <201302120103.08623.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves the irq numbers starting with EINT4 4 points down to
enable the inclusion of the first 4 bits of EINT register into the mapping
removing the need for special offset handling.

For most S3C24XX architectures this will simply create 4 additional unused
interrupts, but enables the S3C2412 to make use of the new infrastructure
to realize its special handling of the EINT0 to EINT3 interrupts.

All affected parts of the Samsung code (arch + drivers) seem to use the
real interrupt defines (IRQ_something) and not any form of S3C2410_IRQ(x)
whose numbering is changed here starting from S3C2410_IRQ(32).

This patch was runtime-tested on a s3c2416 based board.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/include/mach/irqs.h |   54 ++++++++++++++--------------
 arch/arm/mach-s3c24xx/irq.c               |    9 +----
 2 files changed, 29 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/include/mach/irqs.h b/arch/arm/mach-s3c24xx/include/mach/irqs.h
index b7a9f4d..ea589e4 100644
--- a/arch/arm/mach-s3c24xx/include/mach/irqs.h
+++ b/arch/arm/mach-s3c24xx/include/mach/irqs.h
@@ -59,49 +59,49 @@
 #define IRQ_ADCPARENT  S3C2410_IRQ(31)
 
 /* interrupts generated from the external interrupts sources */
-#define IRQ_EINT4      S3C2410_IRQ(32)	   /* 48 */
-#define IRQ_EINT5      S3C2410_IRQ(33)
-#define IRQ_EINT6      S3C2410_IRQ(34)
-#define IRQ_EINT7      S3C2410_IRQ(35)
-#define IRQ_EINT8      S3C2410_IRQ(36)
-#define IRQ_EINT9      S3C2410_IRQ(37)
-#define IRQ_EINT10     S3C2410_IRQ(38)
-#define IRQ_EINT11     S3C2410_IRQ(39)
-#define IRQ_EINT12     S3C2410_IRQ(40)
-#define IRQ_EINT13     S3C2410_IRQ(41)
-#define IRQ_EINT14     S3C2410_IRQ(42)
-#define IRQ_EINT15     S3C2410_IRQ(43)
-#define IRQ_EINT16     S3C2410_IRQ(44)
-#define IRQ_EINT17     S3C2410_IRQ(45)
-#define IRQ_EINT18     S3C2410_IRQ(46)
-#define IRQ_EINT19     S3C2410_IRQ(47)
-#define IRQ_EINT20     S3C2410_IRQ(48)	   /* 64 */
-#define IRQ_EINT21     S3C2410_IRQ(49)
-#define IRQ_EINT22     S3C2410_IRQ(50)
-#define IRQ_EINT23     S3C2410_IRQ(51)
+#define IRQ_EINT4      S3C2410_IRQ(36)	   /* 52 */
+#define IRQ_EINT5      S3C2410_IRQ(37)
+#define IRQ_EINT6      S3C2410_IRQ(38)
+#define IRQ_EINT7      S3C2410_IRQ(39)
+#define IRQ_EINT8      S3C2410_IRQ(40)
+#define IRQ_EINT9      S3C2410_IRQ(41)
+#define IRQ_EINT10     S3C2410_IRQ(42)
+#define IRQ_EINT11     S3C2410_IRQ(43)
+#define IRQ_EINT12     S3C2410_IRQ(44)
+#define IRQ_EINT13     S3C2410_IRQ(45)
+#define IRQ_EINT14     S3C2410_IRQ(46)
+#define IRQ_EINT15     S3C2410_IRQ(47)
+#define IRQ_EINT16     S3C2410_IRQ(48)
+#define IRQ_EINT17     S3C2410_IRQ(49)
+#define IRQ_EINT18     S3C2410_IRQ(50)
+#define IRQ_EINT19     S3C2410_IRQ(51)
+#define IRQ_EINT20     S3C2410_IRQ(52)	   /* 68 */
+#define IRQ_EINT21     S3C2410_IRQ(53)
+#define IRQ_EINT22     S3C2410_IRQ(54)
+#define IRQ_EINT23     S3C2410_IRQ(55)
 
 #define IRQ_EINT_BIT(x)	((x) - IRQ_EINT4 + 4)
 #define IRQ_EINT(x)    (((x) >= 4) ? (IRQ_EINT4 + (x) - 4) : (IRQ_EINT0 + (x)))
 
-#define IRQ_LCD_FIFO   S3C2410_IRQ(52)
-#define IRQ_LCD_FRAME  S3C2410_IRQ(53)
+#define IRQ_LCD_FIFO   S3C2410_IRQ(56)
+#define IRQ_LCD_FRAME  S3C2410_IRQ(57)
 
 /* IRQs for the interal UARTs, and ADC
  * these need to be ordered in number of appearance in the
  * SUBSRC mask register
 */
 
-#define S3C2410_IRQSUB(x)	S3C2410_IRQ((x)+54)
+#define S3C2410_IRQSUB(x)	S3C2410_IRQ((x)+58)
 
-#define IRQ_S3CUART_RX0		S3C2410_IRQSUB(0)	/* 70 */
+#define IRQ_S3CUART_RX0		S3C2410_IRQSUB(0)	/* 74 */
 #define IRQ_S3CUART_TX0		S3C2410_IRQSUB(1)
 #define IRQ_S3CUART_ERR0	S3C2410_IRQSUB(2)
 
-#define IRQ_S3CUART_RX1		S3C2410_IRQSUB(3)	/* 73 */
+#define IRQ_S3CUART_RX1		S3C2410_IRQSUB(3)	/* 77 */
 #define IRQ_S3CUART_TX1		S3C2410_IRQSUB(4)
 #define IRQ_S3CUART_ERR1	S3C2410_IRQSUB(5)
 
-#define IRQ_S3CUART_RX2		S3C2410_IRQSUB(6)	/* 76 */
+#define IRQ_S3CUART_RX2		S3C2410_IRQSUB(6)	/* 80 */
 #define IRQ_S3CUART_TX2		S3C2410_IRQSUB(7)
 #define IRQ_S3CUART_ERR2	S3C2410_IRQSUB(8)
 
@@ -136,7 +136,7 @@
 
 /* second interrupt-register of s3c2416/s3c2450 */
 
-#define S3C2416_IRQ(x)		S3C2410_IRQ((x) + 54 + 29)
+#define S3C2416_IRQ(x)		S3C2410_IRQ((x) + 58 + 29)
 #define IRQ_S3C2416_2D		S3C2416_IRQ(0)
 #define IRQ_S3C2416_IIC1	S3C2416_IRQ(1)
 #define IRQ_S3C2416_RESERVED2	S3C2416_IRQ(2)
diff --git a/arch/arm/mach-s3c24xx/irq.c b/arch/arm/mach-s3c24xx/irq.c
index 1cb1962..67e8d82 100644
--- a/arch/arm/mach-s3c24xx/irq.c
+++ b/arch/arm/mach-s3c24xx/irq.c
@@ -452,7 +452,6 @@ struct s3c_irq_intc *s3c24xx_init_intc(struct device_node *np,
 	void __iomem *base = (void *)0xf6000000; /* static mapping */
 	int irq_num;
 	int irq_start;
-	int irq_offset;
 	int ret;
 
 	intc = kzalloc(sizeof(struct s3c_irq_intc), GFP_KERNEL);
@@ -476,7 +475,6 @@ struct s3c_irq_intc *s3c24xx_init_intc(struct device_node *np,
 		intc->reg_intpnd = base + 0x10;
 		irq_num = 32;
 		irq_start = S3C2410_IRQ(0);
-		irq_offset = 0;
 		break;
 	case 0x4a000018:
 		pr_debug("irq: found subintc\n");
@@ -484,7 +482,6 @@ struct s3c_irq_intc *s3c24xx_init_intc(struct device_node *np,
 		intc->reg_mask = base + 0x1c;
 		irq_num = 29;
 		irq_start = S3C2410_IRQSUB(0);
-		irq_offset = 0;
 		break;
 	case 0x4a000040:
 		pr_debug("irq: found intc2\n");
@@ -493,7 +490,6 @@ struct s3c_irq_intc *s3c24xx_init_intc(struct device_node *np,
 		intc->reg_intpnd = base + 0x50;
 		irq_num = 8;
 		irq_start = S3C2416_IRQ(0);
-		irq_offset = 0;
 		break;
 	case 0x560000a4:
 		pr_debug("irq: found eintc\n");
@@ -501,9 +497,8 @@ struct s3c_irq_intc *s3c24xx_init_intc(struct device_node *np,
 
 		intc->reg_mask = base + 0xa4;
 		intc->reg_pending = base + 0x08;
-		irq_num = 20;
+		irq_num = 24;
 		irq_start = S3C2410_IRQ(32);
-		irq_offset = 4;
 		break;
 	default:
 		pr_err("irq: unsupported controller address\n");
@@ -514,7 +509,7 @@ struct s3c_irq_intc *s3c24xx_init_intc(struct device_node *np,
 	/* now that all the data is complete, init the irq-domain */
 	s3c24xx_clear_intc(intc);
 	intc->domain = irq_domain_add_legacy(np, irq_num, irq_start,
-					     irq_offset, &s3c24xx_irq_ops,
+					     0, &s3c24xx_irq_ops,
 					     intc);
 	if (!intc->domain) {
 		pr_err("irq: could not create irq-domain\n");
-- 
1.7.2.3
