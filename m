From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 25 Feb 2013 11:49:35 +0800
Subject: [PATCH v5 06/12] gpio: pxa: define nr gpios in platform data
In-Reply-To: <1361764181-26647-1-git-send-email-haojian.zhuang@linaro.org>
References: <1361764181-26647-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1361764181-26647-7-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid to identify gpio numbers in gpio driver. Identify it in platform data
instead. So we can remove code of identifying cpu.

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
 arch/arm/mach-pxa/pxa25x.c        |    3 +++
 arch/arm/mach-pxa/pxa27x.c        |    1 +
 arch/arm/mach-pxa/pxa3xx.c        |   17 ++++++++++--
 drivers/gpio/gpio-pxa.c           |   53 ++++++++-----------------------------
 include/linux/gpio-pxa.h          |    1 +
 13 files changed, 39 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 36f5781..a3e42dc 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -112,6 +112,7 @@ static unsigned long common_pin_config[] __initdata = {
 };
 
 static struct pxa_gpio_platform_data pxa168_gpio_pdata = {
+	.nr_gpios	= 128,
 	.ed_mask	= true,
 };
 
diff --git a/arch/arm/mach-mmp/avengers_lite.c b/arch/arm/mach-mmp/avengers_lite.c
index b8fe447..1ea6502 100644
--- a/arch/arm/mach-mmp/avengers_lite.c
+++ b/arch/arm/mach-mmp/avengers_lite.c
@@ -34,6 +34,7 @@ static unsigned long avengers_lite_pin_config_V16F[] __initdata = {
 };
 
 static struct pxa_gpio_platform_data pxa168_gpio_pdata = {
+	.nr_gpios	= 128,
 	.ed_mask	= true,
 };
 
diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index d6ea5c4..a32156f 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -106,6 +106,7 @@ static unsigned long brownstone_pin_config[] __initdata = {
 };
 
 static struct pxa_gpio_platform_data mmp2_gpio_pdata = {
+	.nr_gpios	= 192,
 	.ed_mask	= true,
 };
 
diff --git a/arch/arm/mach-mmp/flint.c b/arch/arm/mach-mmp/flint.c
index 0955f44..3f301b5 100644
--- a/arch/arm/mach-mmp/flint.c
+++ b/arch/arm/mach-mmp/flint.c
@@ -79,6 +79,7 @@ static unsigned long flint_pin_config[] __initdata = {
 };
 
 static struct pxa_gpio_platform_data mmp2_gpio_pdata = {
+	.nr_gpios	= 192,
 	.ed_mask	= true,
 };
 
diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
index 2315cce..019b178 100644
--- a/arch/arm/mach-mmp/gplugd.c
+++ b/arch/arm/mach-mmp/gplugd.c
@@ -129,6 +129,7 @@ static unsigned long gplugd_pin_config[] __initdata = {
 };
 
 static struct pxa_gpio_platform_data pxa168_gpio_pdata = {
+	.nr_gpios	= 128,
 	.ed_mask	= true,
 };
 
diff --git a/arch/arm/mach-mmp/tavorevb.c b/arch/arm/mach-mmp/tavorevb.c
index eaec649..6e8cf80 100644
--- a/arch/arm/mach-mmp/tavorevb.c
+++ b/arch/arm/mach-mmp/tavorevb.c
@@ -62,6 +62,7 @@ static unsigned long tavorevb_pin_config[] __initdata = {
 };
 
 static struct pxa_gpio_platform_data ttc_dkb_gpio_pdata = {
+	.nr_gpios	= 128,
 	.ed_mask	= true,
 };
 
diff --git a/arch/arm/mach-mmp/teton_bga.c b/arch/arm/mach-mmp/teton_bga.c
index 6682100..b5146bb 100644
--- a/arch/arm/mach-mmp/teton_bga.c
+++ b/arch/arm/mach-mmp/teton_bga.c
@@ -51,6 +51,7 @@ static unsigned long teton_bga_pin_config[] __initdata = {
 };
 
 static struct pxa_gpio_platform_data pxa168_gpio_pdata = {
+	.nr_gpios	= 128,
 	.ed_mask	= true,
 };
 
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index d8df90b..387e3f8 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -77,6 +77,7 @@ static unsigned long ttc_dkb_pin_config[] __initdata = {
 };
 
 static struct pxa_gpio_platform_data ttc_dkb_gpio_pdata = {
+	.nr_gpios	= 128,
 	.ed_mask	= true,
 };
 
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index ef1bb41..52f94f3 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -342,6 +342,9 @@ void __init pxa25x_map_io(void)
 static struct pxa_gpio_platform_data pxa25x_gpio_info __initdata = {
 #ifdef CONFIG_CPU_PXA26x
 	.inverted = true,
+	.nr_gpios = 90,
+#else
+	.nr_gpios = 85,
 #endif
 	.gafr = true,
 	.gpio_set_wake = gpio_set_wake,
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 7f1f18a..619b2f2 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -432,6 +432,7 @@ void __init pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *info)
 
 static struct pxa_gpio_platform_data pxa27x_gpio_info __initdata = {
 	.gafr = true,
+	.nr_gpios = 121,
 	.gpio_set_wake = gpio_set_wake,
 };
 
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 656a1bb..f6bff16 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/gpio-pxa.h>
 #include <linux/pm.h>
 #include <linux/platform_device.h>
 #include <linux/irq.h>
@@ -435,6 +436,10 @@ void __init pxa3xx_set_i2c_power_info(struct i2c_pxa_platform_data *info)
 	pxa_register_device(&pxa3xx_device_i2c_power, info);
 }
 
+static struct pxa_gpio_platform_data pxa3xx_gpio_info __initdata = {
+	.nr_gpios = 128,
+};
+
 static struct platform_device *devices[] __initdata = {
 	&pxa_device_gpio,
 	&pxa27x_device_udc,
@@ -482,8 +487,16 @@ static int __init pxa3xx_init(void)
 		register_syscore_ops(&pxa3xx_mfp_syscore_ops);
 		register_syscore_ops(&pxa3xx_clock_syscore_ops);
 
-		if (!of_have_populated_dt())
-			ret = platform_add_devices(devices, ARRAY_SIZE(devices));
+		if (!of_have_populated_dt()) {
+			if (cpu_is_pxa93x())
+				pxa3xx_gpio_info.nr_gpios = 192;
+			ret = platform_device_add_data(&pxa_device_gpio,
+					&pxa3xx_gpio_info,
+					sizeof(struct pxa_gpio_platform_data));
+			if (!ret)
+				ret = platform_add_devices(devices,
+							   ARRAY_SIZE(devices));
+		}
 	}
 
 	return ret;
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 8584fc0..65839a7 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -413,36 +413,6 @@ static struct irq_chip pxa_muxed_gpio_chip = {
 	.irq_set_wake	= pxa_gpio_set_wake,
 };
 
-static int pxa_gpio_nums(void)
-{
-	int count = 0;
-
-#ifdef CONFIG_ARCH_PXA
-	if (cpu_is_pxa25x()) {
-#ifdef CONFIG_CPU_PXA26x
-		count = 89;
-#elif defined(CONFIG_PXA25x)
-		count = 84;
-#endif /* CONFIG_CPU_PXA26x */
-	} else if (cpu_is_pxa27x()) {
-		count = 120;
-	} else if (cpu_is_pxa93x()) {
-		count = 191;
-	} else if (cpu_is_pxa3xx()) {
-		count = 127;
-	}
-#endif /* CONFIG_ARCH_PXA */
-
-#ifdef CONFIG_ARCH_MMP
-	if (cpu_is_pxa168() || cpu_is_pxa910()) {
-		count = 127;
-	} else if (cpu_is_mmp2()) {
-		count = 191;
-	}
-#endif /* CONFIG_ARCH_MMP */
-	return count;
-}
-
 #ifdef CONFIG_OF
 static struct of_device_id pxa_gpio_dt_ids[] = {
 	{ .compatible = "mrvl,pxa-gpio" },
@@ -466,7 +436,7 @@ const struct irq_domain_ops pxa_irq_domain_ops = {
 
 static int pxa_gpio_probe_dt(struct platform_device *pdev)
 {
-	int nr_banks, nr_gpios;
+	int ret, nr_banks;
 	struct pxa_gpio_platform_data *pdata;
 	struct device_node *prev, *next, *np = pdev->dev.of_node;
 	const struct of_device_id *of_id =
@@ -482,6 +452,11 @@ static int pxa_gpio_probe_dt(struct platform_device *pdev)
 	pdata->ed_mask = of_property_read_bool(np, "marvell,gpio-ed-mask");
 	/* It's only valid for PXA26x */
 	pdata->inverted = of_property_read_bool(np, "marvell,gpio-inverted");
+	ret = of_property_read_u32(np, "marvell,nr-gpios", &pdata->nr_gpios);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "nr-gpios isn't specified\n");
+		return -ENOTSUPP;
+	}
 	/* set the platform data */
 	pdev->dev.platform_data = pdata;
 
@@ -498,15 +473,13 @@ static int pxa_gpio_probe_dt(struct platform_device *pdev)
 		prev = next;
 	}
 	of_node_put(prev);
-	nr_gpios = nr_banks << 5;
-	pxa_last_gpio = nr_gpios - 1;
 
-	irq_base = irq_alloc_descs(-1, 0, nr_gpios, 0);
+	irq_base = irq_alloc_descs(-1, 0, pdata->nr_gpios, 0);
 	if (irq_base < 0) {
 		dev_err(&pdev->dev, "Failed to allocate IRQ numbers\n");
 		return -EINVAL;
 	}
-	domain = irq_domain_add_legacy(np, nr_gpios, irq_base, 0,
+	domain = irq_domain_add_legacy(np, pdata->nr_gpios, irq_base, 0,
 				       &pxa_irq_domain_ops, NULL);
 	pxa_gpio_of_node = np;
 	return 0;
@@ -521,12 +494,11 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct clk *clk;
 	struct pxa_gpio_platform_data *info;
-	int gpio, irq, ret, use_of = 0;
+	int gpio, irq, ret, use_of = 1;
 	int irq0 = 0, irq1 = 0, irq_mux, gpio_offset = 0;
 
 	ret = pxa_gpio_probe_dt(pdev);
 	if (ret < 0) {
-		pxa_last_gpio = pxa_gpio_nums();
 #ifdef CONFIG_ARCH_PXA
 		irq_base = PXA_GPIO_TO_IRQ(0);
 #elif defined(CONFIG_ARCH_MMP)
@@ -534,13 +506,9 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 #else
 #error "gpio-pxa driver can't be used for your architecture"
 #endif
-	} else {
-		use_of = 1;
+		use_of = 0;
 	}
 
-	if (!pxa_last_gpio)
-		return -EINVAL;
-
 	irq0 = platform_get_irq_byname(pdev, "gpio0");
 	irq1 = platform_get_irq_byname(pdev, "gpio1");
 	irq_mux = platform_get_irq_byname(pdev, "gpio_mux");
@@ -573,6 +541,7 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 
 	/* Initialize GPIO chips */
 	info = dev_get_platdata(&pdev->dev);
+	pxa_last_gpio = info->nr_gpios - 1;
 	pxa_init_gpio_chip(pdev, pxa_last_gpio);
 
 	/* clear all GPIO edge detects */
diff --git a/include/linux/gpio-pxa.h b/include/linux/gpio-pxa.h
index a5670c5..d2fa8e0 100644
--- a/include/linux/gpio-pxa.h
+++ b/include/linux/gpio-pxa.h
@@ -17,6 +17,7 @@ struct pxa_gpio_platform_data {
 	bool ed_mask;	/* true means that ed_mask reg is available */
 	bool inverted;	/* only valid for PXA26x */
 	bool gafr;	/* only valid for PXA25x/PXA26x/PXA27x */
+	unsigned int nr_gpios;
 	int (*gpio_set_wake)(unsigned int gpio, unsigned int on);
 };
 
-- 
1.7.10.4
