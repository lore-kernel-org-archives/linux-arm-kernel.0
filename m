From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sun, 17 Mar 2013 14:06:27 +0100
Subject: [PATCH v3 3/6] irqchip: s3c24xx: fix irqlist of second s3c2416
 controller
In-Reply-To: <201303171404.06146.heiko@sntech.de>
References: <201303171404.06146.heiko@sntech.de>
Message-ID: <201303171406.27999.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The list in used was from the s3c2450, a close cousin of the s3c2416.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/irqchip/irq-s3c24xx.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
index 84afbc1..a565eb8 100644
--- a/drivers/irqchip/irq-s3c24xx.c
+++ b/drivers/irqchip/irq-s3c24xx.c
@@ -835,13 +835,12 @@ static struct s3c_irq_data init_s3c2416subint[32] = {
 
 static struct s3c_irq_data init_s3c2416_second[32] = {
 	{ .type = S3C_IRQTYPE_EDGE }, /* 2D */
-	{ .type = S3C_IRQTYPE_EDGE }, /* IIC1 */
+	{ .type = S3C_IRQTYPE_NONE }, /* reserved */
 	{ .type = S3C_IRQTYPE_NONE }, /* reserved */
 	{ .type = S3C_IRQTYPE_NONE }, /* reserved */
 	{ .type = S3C_IRQTYPE_EDGE }, /* PCM0 */
-	{ .type = S3C_IRQTYPE_EDGE }, /* PCM1 */
+	{ .type = S3C_IRQTYPE_NONE }, /* reserved */
 	{ .type = S3C_IRQTYPE_EDGE }, /* I2S0 */
-	{ .type = S3C_IRQTYPE_EDGE }, /* I2S1 */
 };
 
 void __init s3c2416_init_irq(void)
-- 
1.7.2.3
