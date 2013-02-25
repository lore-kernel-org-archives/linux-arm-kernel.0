From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 25 Feb 2013 11:49:36 +0800
Subject: [PATCH v5 07/12] gpio: pxa: add irq base in platform data
In-Reply-To: <1361764181-26647-1-git-send-email-haojian.zhuang@linaro.org>
References: <1361764181-26647-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1361764181-26647-8-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Macro PXA_GPIO_TO_IRQ() & MMP_GPIO_TO_IRQ() is used in machine driver
without DT. So move them into machine driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
Tested-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-mmp/aspenite.c      |    1 +
 arch/arm/mach-mmp/avengers_lite.c |    1 +
 arch/arm/mach-mmp/brownstone.c    |    1 +
 arch/arm/mach-mmp/flint.c         |    1 +
 arch/arm/mach-mmp/gplugd.c        |    1 +
 arch/arm/mach-mmp/tavorevb.c      |    1 +
 arch/arm/mach-mmp/teton_bga.c     |    1 +
 arch/arm/mach-mmp/ttc_dkb.c       |    1 +
 arch/arm/mach-pxa/pxa25x.c        |    1 +
 arch/arm/mach-pxa/pxa27x.c        |    1 +
 arch/arm/mach-pxa/pxa3xx.c        |    1 +
 drivers/gpio/gpio-pxa.c           |   22 +++++++++-------------
 include/linux/gpio-pxa.h          |    1 +
 13 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index a3e42dc..5785931 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -113,6 +113,7 @@ static unsigned long common_pin_config[] __initdata = {
 
 static struct pxa_gpio_platform_data pxa168_gpio_pdata = {
 	.nr_gpios	= 128,
+	.irq_base	= MMP_GPIO_TO_IRQ(0),
 	.ed_mask	= true,
 };
 
diff --git a/arch/arm/mach-mmp/avengers_lite.c b/arch/arm/mach-mmp/avengers_lite.c
index 1ea6502..074fbbe 100644
--- a/arch/arm/mach-mmp/avengers_lite.c
+++ b/arch/arm/mach-mmp/avengers_lite.c
@@ -35,6 +35,7 @@ static unsigned long avengers_lite_pin_config_V16F[] __initdata = {
 
 static struct pxa_gpio_platform_data pxa168_gpio_pdata = {
 	.nr_gpios	= 128,
+	.irq_base	= MMP_GPIO_TO_IRQ(0),
 	.ed_mask	= true,
 };
 
diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index a32156f..3b4224c 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -107,6 +107,7 @@ static unsigned long brownstone_pin_config[] __initdata = {
 
 static struct pxa_gpio_platform_data mmp2_gpio_pdata = {
 	.nr_gpios	= 192,
+	.irq_base	= MMP_GPIO_TO_IRQ(0),
 	.ed_mask	= true,
 };
 
diff --git a/arch/arm/mach-mmp/flint.c b/arch/arm/mach-mmp/flint.c
index 3f301b5..00cdf62 100644
--- a/arch/arm/mach-mmp/flint.c
+++ b/arch/arm/mach-mmp/flint.c
@@ -80,6 +80,7 @@ static unsigned long flint_pin_config[] __initdata = {
 
 static struct pxa_gpio_platform_data mmp2_gpio_pdata = {
 	.nr_gpios	= 192,
+	.irq_base	= MMP_GPIO_TO_IRQ(0),
 	.ed_mask	= true,
 };
 
diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
index 019b178..78acca4 100644
--- a/arch/arm/mach-mmp/gplugd.c
+++ b/arch/arm/mach-mmp/gplugd.c
@@ -130,6 +130,7 @@ static unsigned long gplugd_pin_config[] __initdata = {
 
 static struct pxa_gpio_platform_data pxa168_gpio_pdata = {
 	.nr_gpios	= 128,
+	.irq_base	= MMP_GPIO_TO_IRQ(0),
 	.ed_mask	= true,
 };
 
diff --git a/arch/arm/mach-mmp/tavorevb.c b/arch/arm/mach-mmp/tavorevb.c
index 6e8cf80..86ed017 100644
--- a/arch/arm/mach-mmp/tavorevb.c
+++ b/arch/arm/mach-mmp/tavorevb.c
@@ -63,6 +63,7 @@ static unsigned long tavorevb_pin_config[] __initdata = {
 
 static struct pxa_gpio_platform_data ttc_dkb_gpio_pdata = {
 	.nr_gpios	= 128,
+	.irq_base	= MMP_GPIO_TO_IRQ(0),
 	.ed_mask	= true,
 };
 
diff --git a/arch/arm/mach-mmp/teton_bga.c b/arch/arm/mach-mmp/teton_bga.c
index b5146bb..db65631 100644
--- a/arch/arm/mach-mmp/teton_bga.c
+++ b/arch/arm/mach-mmp/teton_bga.c
@@ -52,6 +52,7 @@ static unsigned long teton_bga_pin_config[] __initdata = {
 
 static struct pxa_gpio_platform_data pxa168_gpio_pdata = {
 	.nr_gpios	= 128,
+	.irq_base	= MMP_GPIO_TO_IRQ(0),
 	.ed_mask	= true,
 };
 
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index 387e3f8..0e0ea87 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -78,6 +78,7 @@ static unsigned long ttc_dkb_pin_config[] __initdata = {
 
 static struct pxa_gpio_platform_data ttc_dkb_gpio_pdata = {
 	.nr_gpios	= 128,
+	.irq_base	= MMP_GPIO_TO_IRQ(0),
 	.ed_mask	= true,
 };
 
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 52f94f3..2195e1a 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -346,6 +346,7 @@ static struct pxa_gpio_platform_data pxa25x_gpio_info __initdata = {
 #else
 	.nr_gpios = 85,
 #endif
+	.irq_base = PXA_GPIO_TO_IRQ(0),
 	.gafr = true,
 	.gpio_set_wake = gpio_set_wake,
 };
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 619b2f2..cb3f443 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -433,6 +433,7 @@ void __init pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *info)
 static struct pxa_gpio_platform_data pxa27x_gpio_info __initdata = {
 	.gafr = true,
 	.nr_gpios = 121,
+	.irq_base = PXA_GPIO_TO_IRQ(0),
 	.gpio_set_wake = gpio_set_wake,
 };
 
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index f6bff16..ef0634b 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -438,6 +438,7 @@ void __init pxa3xx_set_i2c_power_info(struct i2c_pxa_platform_data *info)
 
 static struct pxa_gpio_platform_data pxa3xx_gpio_info __initdata = {
 	.nr_gpios = 128,
+	.irq_base = PXA_GPIO_TO_IRQ(0),
 };
 
 static struct platform_device *devices[] __initdata = {
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 65839a7..141190c 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -457,8 +457,6 @@ static int pxa_gpio_probe_dt(struct platform_device *pdev)
 		dev_err(&pdev->dev, "nr-gpios isn't specified\n");
 		return -ENOTSUPP;
 	}
-	/* set the platform data */
-	pdev->dev.platform_data = pdata;
 
 	next = of_get_next_child(np, NULL);
 	prev = next;
@@ -479,6 +477,9 @@ static int pxa_gpio_probe_dt(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Failed to allocate IRQ numbers\n");
 		return -EINVAL;
 	}
+	pdata->irq_base = irq_base;
+	/* set the platform data */
+	pdev->dev.platform_data = pdata;
 	domain = irq_domain_add_legacy(np, pdata->nr_gpios, irq_base, 0,
 				       &pxa_irq_domain_ops, NULL);
 	pxa_gpio_of_node = np;
@@ -498,16 +499,13 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 	int irq0 = 0, irq1 = 0, irq_mux, gpio_offset = 0;
 
 	ret = pxa_gpio_probe_dt(pdev);
-	if (ret < 0) {
-#ifdef CONFIG_ARCH_PXA
-		irq_base = PXA_GPIO_TO_IRQ(0);
-#elif defined(CONFIG_ARCH_MMP)
-		irq_base = MMP_GPIO_TO_IRQ(0);
-#else
-#error "gpio-pxa driver can't be used for your architecture"
-#endif
+	if (ret < 0)
 		use_of = 0;
-	}
+	info = dev_get_platdata(&pdev->dev);
+	pxa_last_gpio = info->nr_gpios - 1;
+	irq_base = info->irq_base;
+	if (pxa_last_gpio <=0 || irq_base <= 0)
+		return -EINVAL;
 
 	irq0 = platform_get_irq_byname(pdev, "gpio0");
 	irq1 = platform_get_irq_byname(pdev, "gpio1");
@@ -540,8 +538,6 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 	}
 
 	/* Initialize GPIO chips */
-	info = dev_get_platdata(&pdev->dev);
-	pxa_last_gpio = info->nr_gpios - 1;
 	pxa_init_gpio_chip(pdev, pxa_last_gpio);
 
 	/* clear all GPIO edge detects */
diff --git a/include/linux/gpio-pxa.h b/include/linux/gpio-pxa.h
index d2fa8e0..82c3e73 100644
--- a/include/linux/gpio-pxa.h
+++ b/include/linux/gpio-pxa.h
@@ -18,6 +18,7 @@ struct pxa_gpio_platform_data {
 	bool inverted;	/* only valid for PXA26x */
 	bool gafr;	/* only valid for PXA25x/PXA26x/PXA27x */
 	unsigned int nr_gpios;
+	unsigned int irq_base;
 	int (*gpio_set_wake)(unsigned int gpio, unsigned int on);
 };
 
-- 
1.7.10.4
