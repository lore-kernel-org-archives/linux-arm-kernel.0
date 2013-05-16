From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 16 May 2013 13:15:58 +0200
Subject: [PATCH 30/33] arch/arm/plat-samsung: don't check resource with
 devm_ioremap_resource
In-Reply-To: <1368702961-4325-1-git-send-email-wsa@the-dreams.de>
References: <1368702961-4325-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1368702961-4325-31-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

devm_ioremap_resource does sanity checks on the given resource. No need to
duplicate this in the driver.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 arch/arm/plat-samsung/adc.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index ca07cb1..79690f2 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -381,11 +381,6 @@ static int s3c_adc_probe(struct platform_device *pdev)
 	}
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!regs) {
-		dev_err(dev, "failed to find registers\n");
-		return -ENXIO;
-	}
-
 	adc->regs = devm_ioremap_resource(dev, regs);
 	if (IS_ERR(adc->regs))
 		return PTR_ERR(adc->regs);
-- 
1.7.10.4
