From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 31 May 2010 14:06:39 +0100
Subject: [PATCH] SAMSUNG: Fix unused variable warning in ADC driver
Message-ID: <1275311199-10670-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

flags is not referenced.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/plat-samsung/adc.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index 04d9521..e8f2be2 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -435,7 +435,6 @@ static int s3c_adc_suspend(struct platform_device *pdev, pm_message_t state)
 static int s3c_adc_resume(struct platform_device *pdev)
 {
 	struct adc_device *adc = platform_get_drvdata(pdev);
-	unsigned long flags;
 
 	clk_enable(adc->clk);
 	enable_irq(adc->irq);
-- 
1.7.1
