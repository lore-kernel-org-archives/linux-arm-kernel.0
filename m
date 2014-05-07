From: jsm@jsolano.com (Juan Solano)
Date: Wed,  7 May 2014 17:09:59 +0200
Subject: [PATCH] ARM: i.MX27 pca100: remove deprecated IRQF_DISABLED
Message-ID: <1399475399-8770-1-git-send-email-jsm@jsolano.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This flag is a NOOP and can be removed now.

Signed-off-by: Juan Solano <jsm@jsolano.com>
---
 arch/arm/mach-imx/mach-pca100.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index bf3ac51..20e7c33 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -245,8 +245,7 @@ static int pca100_sdhc2_init(struct device *dev, irq_handler_t detect_irq,
 	int ret;
 
 	ret = request_irq(gpio_to_irq(IMX_GPIO_NR(3, 29)), detect_irq,
-			  IRQF_DISABLED | IRQF_TRIGGER_FALLING,
-			  "imx-mmc-detect", data);
+			  IRQF_TRIGGER_FALLING, "imx-mmc-detect", data);
 	if (ret)
 		printk(KERN_ERR
 			"pca100: Failed to request irq for sd/mmc detection\n");
-- 
1.7.9.5
