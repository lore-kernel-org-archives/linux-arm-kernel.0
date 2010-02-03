From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 3 Feb 2010 15:37:23 -0500
Subject: [PATCH] mfd: clean code in max8925
Message-ID: <mailman.183.1265202123.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 include/linux/mfd/max8925.h |   17 -----------------
 1 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/include/linux/mfd/max8925.h b/include/linux/mfd/max8925.h
index 18c1844..5259dfe 100644
--- a/include/linux/mfd/max8925.h
+++ b/include/linux/mfd/max8925.h
@@ -158,11 +158,6 @@ enum {
 #define TSC_IRQ_MASK			(0x03)
 #define RTC_IRQ_MASK			(0x0c)

-#define MAX8925_GPM_NUM_IRQ		(40)
-#define MAX8925_ADC_NUM_IRQ		(8)
-#define MAX8925_NUM_IRQ			(MAX8925_GPM_NUM_IRQ	\
-					+ MAX8925_ADC_NUM_IRQ)
-
 #define MAX8925_MAX_REGULATOR		(23)

 #define MAX8925_NAME_SIZE		(32)
@@ -200,17 +195,11 @@ enum {
 	MAX8925_NR_IRQS,
 };

-struct max8925_irq {
-	irq_handler_t		handler;
-	void			*data;
-};
-
 struct max8925_chip {
 	struct device		*dev;
 	struct i2c_client	*i2c;
 	struct i2c_client	*adc;
 	struct i2c_client	*rtc;
-	struct max8925_irq	irqs[MAX8925_NUM_IRQ];
 	struct mutex		io_lock;
 	struct mutex		irq_lock;

@@ -257,12 +246,6 @@ extern int max8925_bulk_write(struct i2c_client
*, int, int, unsigned char *);
 extern int max8925_set_bits(struct i2c_client *, int, unsigned char,
 			unsigned char);

-extern int max8925_request_irq(struct max8925_chip *, int,
-			irq_handler_t, void *);
-extern int max8925_free_irq(struct max8925_chip *, int);
-extern int max8925_mask_irq(struct max8925_chip *, int);
-extern int max8925_unmask_irq(struct max8925_chip *, int);
-
 extern int max8925_device_init(struct max8925_chip *,
 				struct max8925_platform_data *);
 extern void max8925_device_exit(struct max8925_chip *);
-- 
1.5.6.5
