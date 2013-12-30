From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Dec 2013 17:09:29 +0100
Subject: [PATCH 15/17] ARM: imx: Remove deprecated IRQF_DISABLED flag
In-Reply-To: <1388419771-30075-1-git-send-email-daniel.lezcano@linaro.org>
References: <1388419771-30075-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1388419771-30075-15-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This flag is a NOOP and scheduled to be removed

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-imx/mach-pca100.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index c5f9567..a3ab282 100644
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
 			"pca100: Failed to reuest irq for sd/mmc detection\n");
-- 
1.7.9.5
