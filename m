From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 10 Apr 2013 09:18:26 +0800
Subject: [PATCH 3/3] ARM: mmp: add more compatible names in gpio driver
In-Reply-To: <1365556707-9159-1-git-send-email-haojian.zhuang@linaro.org>
References: <1365556707-9159-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1365556707-9159-3-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since more driver names are added into platform id, do the same thing on
compatible names for DT mode.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 .../devicetree/bindings/gpio/mrvl-gpio.txt         |    7 ++++--
 arch/arm/boot/dts/mmp2.dtsi                        |    2 +-
 arch/arm/boot/dts/pxa168.dtsi                      |    2 +-
 arch/arm/boot/dts/pxa910.dtsi                      |    2 +-
 arch/arm/mach-mmp/mmp-dt.c                         |    4 ++--
 arch/arm/mach-mmp/mmp2-dt.c                        |    2 +-
 drivers/gpio/gpio-pxa.c                            |   25 ++++++++++----------
 7 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt b/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
index e137874..9b3f1d4 100644
--- a/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
@@ -1,7 +1,10 @@
 * Marvell PXA GPIO controller
 
 Required properties:
-- compatible : Should be "mrvl,pxa-gpio" or "mrvl,mmp-gpio"
+- compatible : Should be "intel,pxa25x-gpio", "intel,pxa26x-gpio",
+		"intel,pxa27x-gpio", "intel,pxa3xx-gpio",
+		"marvell,pxa93x-gpio", "marvell,mmp-gpio" or
+		"marvell,mmp2-gpio".
 - reg : Address and length of the register set for the device
 - interrupts : Should be the port interrupt shared by all gpio pins.
   There're three gpio interrupts in arch-pxa, and they're gpio0,
@@ -18,7 +21,7 @@ Required properties:
 Example:
 
 	gpio: gpio at d4019000 {
-		compatible = "mrvl,mmp-gpio";
+		compatible = "marvell,mmp-gpio";
 		reg = <0xd4019000 0x1000>;
 		interrupts = <49>;
 		interrupt-name = "gpio_mux";
diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 1429ac0..4e8b08c 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -160,7 +160,7 @@
 			};
 
 			gpio at d4019000 {
-				compatible = "mrvl,mmp-gpio";
+				compatible = "marvell,mmp2-gpio";
 				#address-cells = <1>;
 				#size-cells = <1>;
 				reg = <0xd4019000 0x1000>;
diff --git a/arch/arm/boot/dts/pxa168.dtsi b/arch/arm/boot/dts/pxa168.dtsi
index 31a7186..975dad2 100644
--- a/arch/arm/boot/dts/pxa168.dtsi
+++ b/arch/arm/boot/dts/pxa168.dtsi
@@ -77,7 +77,7 @@
 			};
 
 			gpio at d4019000 {
-				compatible = "mrvl,mmp-gpio";
+				compatible = "marvell,mmp-gpio";
 				#address-cells = <1>;
 				#size-cells = <1>;
 				reg = <0xd4019000 0x1000>;
diff --git a/arch/arm/boot/dts/pxa910.dtsi b/arch/arm/boot/dts/pxa910.dtsi
index 825aaca..0247c62 100644
--- a/arch/arm/boot/dts/pxa910.dtsi
+++ b/arch/arm/boot/dts/pxa910.dtsi
@@ -89,7 +89,7 @@
 			};
 
 			gpio at d4019000 {
-				compatible = "mrvl,mmp-gpio";
+				compatible = "marvell,mmp-gpio";
 				#address-cells = <1>;
 				#size-cells = <1>;
 				reg = <0xd4019000 0x1000>;
diff --git a/arch/arm/mach-mmp/mmp-dt.c b/arch/arm/mach-mmp/mmp-dt.c
index 5b890b6..b37915d 100644
--- a/arch/arm/mach-mmp/mmp-dt.c
+++ b/arch/arm/mach-mmp/mmp-dt.c
@@ -28,7 +28,7 @@ static const struct of_dev_auxdata pxa168_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4026000, "pxa2xx-uart.2", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-twsi", 0xd4011000, "pxa2xx-i2c.0", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-twsi", 0xd4025000, "pxa2xx-i2c.1", NULL),
-	OF_DEV_AUXDATA("mrvl,mmp-gpio", 0xd4019000, "mmp-gpio", NULL),
+	OF_DEV_AUXDATA("marvell,mmp-gpio", 0xd4019000, "mmp-gpio", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-rtc", 0xd4010000, "sa1100-rtc", NULL),
 	{}
 };
@@ -39,7 +39,7 @@ static const struct of_dev_auxdata pxa910_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4036000, "pxa2xx-uart.2", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-twsi", 0xd4011000, "pxa2xx-i2c.0", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-twsi", 0xd4037000, "pxa2xx-i2c.1", NULL),
-	OF_DEV_AUXDATA("mrvl,mmp-gpio", 0xd4019000, "mmp-gpio", NULL),
+	OF_DEV_AUXDATA("marvell,mmp-gpio", 0xd4019000, "mmp-gpio", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-rtc", 0xd4010000, "sa1100-rtc", NULL),
 	{}
 };
diff --git a/arch/arm/mach-mmp/mmp2-dt.c b/arch/arm/mach-mmp/mmp2-dt.c
index 924b6e8..4ac2567 100644
--- a/arch/arm/mach-mmp/mmp2-dt.c
+++ b/arch/arm/mach-mmp/mmp2-dt.c
@@ -31,7 +31,7 @@ static const struct of_dev_auxdata mmp2_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4016000, "pxa2xx-uart.3", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-twsi", 0xd4011000, "pxa2xx-i2c.0", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-twsi", 0xd4025000, "pxa2xx-i2c.1", NULL),
-	OF_DEV_AUXDATA("mrvl,mmp-gpio", 0xd4019000, "mmp2-gpio", NULL),
+	OF_DEV_AUXDATA("marvell,mmp-gpio", 0xd4019000, "mmp2-gpio", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-rtc", 0xd4010000, "sa1100-rtc", NULL),
 	{}
 };
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index f4b0737..bce9e38 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -498,8 +498,13 @@ static int pxa_gpio_nums(struct platform_device *pdev)
 
 #ifdef CONFIG_OF
 static struct of_device_id pxa_gpio_dt_ids[] = {
-	{ .compatible = "mrvl,pxa-gpio" },
-	{ .compatible = "mrvl,mmp-gpio", .data = (void *)MMP_GPIO },
+	{ .compatible = "intel,pxa25x-gpio",	.data = &pxa25x_id, },
+	{ .compatible = "intel,pxa26x-gpio",	.data = &pxa26x_id, },
+	{ .compatible = "intel,pxa27x-gpio",	.data = &pxa27x_id, },
+	{ .compatible = "intel,pxa3xx-gpio",	.data = &pxa3xx_id, },
+	{ .compatible = "marvell,pxa93x-gpio",	.data = &pxa93x_id, },
+	{ .compatible = "marvell,mmp-gpio",	.data = &mmp_id, },
+	{ .compatible = "marvell,mmp2-gpio",	.data = &mmp2_id, },
 	{}
 };
 
@@ -519,16 +524,18 @@ const struct irq_domain_ops pxa_irq_domain_ops = {
 
 static int pxa_gpio_probe_dt(struct platform_device *pdev)
 {
-	int ret, nr_banks, nr_gpios;
+	int ret, nr_gpios;
 	struct device_node *prev, *next, *np = pdev->dev.of_node;
 	const struct of_device_id *of_id =
 				of_match_device(pxa_gpio_dt_ids, &pdev->dev);
+	const struct pxa_gpio_id *gpio_id;
 
-	if (!of_id) {
+	if (!of_id || !of_id->data) {
 		dev_err(&pdev->dev, "Failed to find gpio controller\n");
 		return -EFAULT;
 	}
-	gpio_type = (int)of_id->data;
+	gpio_id = of_id->data;
+	gpio_type = gpio_id->type;
 
 	next = of_get_next_child(np, NULL);
 	prev = next;
@@ -537,14 +544,8 @@ static int pxa_gpio_probe_dt(struct platform_device *pdev)
 		ret = -EINVAL;
 		goto err;
 	}
-	for (nr_banks = 1; ; nr_banks++) {
-		next = of_get_next_child(np, prev);
-		if (!next)
-			break;
-		prev = next;
-	}
 	of_node_put(prev);
-	nr_gpios = nr_banks << 5;
+	nr_gpios = gpio_id->gpio_nums;
 	pxa_last_gpio = nr_gpios - 1;
 
 	irq_base = irq_alloc_descs(-1, 0, nr_gpios, 0);
-- 
1.7.10.4
