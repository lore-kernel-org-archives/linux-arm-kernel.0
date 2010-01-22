From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 22 Jan 2010 23:29:16 +0100
Subject: [PATCH] ARM: SAMSUNG: Fix null pointer dereference in ADC driver
Message-ID: <b2e8f9f71001221429l5ea24cd8j3046e7a24546320a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: SAMSUNG: Fix null pointer dereference in ADC driver

Use struct adc_device instead of relying on client (which could be
NULL) when checking for SoC type.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/plat-samsung/adc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index 120b790..c7659b7 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -295,7 +295,7 @@ static irqreturn_t s3c_adc_irq(int irq, void *pw)
 	}

 exit:
-	if (platform_get_device_id(client->pdev)->driver_data == TYPE_S3C64XX) {
+	if (platform_get_device_id(adc->pdev)->driver_data == TYPE_S3C64XX) {
 		/* Clear ADC interrupt */
 		writel(0, adc->regs + S3C64XX_ADCCLRINT);
 	}
-- 
1.6.6.1
