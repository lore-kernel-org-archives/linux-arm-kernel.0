From: gang.chen@asianux.com (Chen Gang)
Date: Tue, 26 Mar 2013 14:54:40 +0800
Subject: [PATCH] ARM:s3c24xx: beautify code, data->hwirq is unsigned long
 which is always >= 0
Message-ID: <51514630.6090906@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


  data->hwirq is unsigned long which is always >= 0

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/mach-s3c24xx/irq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/irq.c b/arch/arm/mach-s3c24xx/irq.c
index 5c9f8b7..143f57b 100644
--- a/arch/arm/mach-s3c24xx/irq.c
+++ b/arch/arm/mach-s3c24xx/irq.c
@@ -210,7 +210,7 @@ static int s3c_irqext0_type(struct irq_data *data, unsigned int type)
 	void __iomem *gpcon_reg;
 	unsigned long gpcon_offset, extint_offset;
 
-	if ((data->hwirq >= 0) && (data->hwirq <= 3)) {
+	if (data->hwirq <= 3) {
 		gpcon_reg = S3C2410_GPFCON;
 		extint_reg = S3C24XX_EXTINT0;
 		gpcon_offset = (data->hwirq) * 2;
-- 
1.7.7.6
