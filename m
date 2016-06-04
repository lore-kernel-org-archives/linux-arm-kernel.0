From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  4 Jun 2016 10:10:00 +0300
Subject: [PATCH 08/22] gpio: syscon: Changing the compatibility string to
 match with the smallest supported chip
In-Reply-To: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
References: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
Message-ID: <1465024214-22120-9-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the compatibility string to match with the smallest
supported chip (EP7209). Since the DT-support for this CPU is not yet
announced, this change is safe.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 Documentation/devicetree/bindings/gpio/cirrus,clps711x-mctrl-gpio.txt | 4 ++--
 drivers/gpio/gpio-syscon.c                                            | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/cirrus,clps711x-mctrl-gpio.txt b/Documentation/devicetree/bindings/gpio/cirrus,clps711x-mctrl-gpio.txt
index 94ae9f8..fd42e72 100644
--- a/Documentation/devicetree/bindings/gpio/cirrus,clps711x-mctrl-gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/cirrus,clps711x-mctrl-gpio.txt
@@ -1,7 +1,7 @@
 * ARM Cirrus Logic CLPS711X SYSFLG1 MCTRL GPIOs
 
 Required properties:
-- compatible: Should contain "cirrus,clps711x-mctrl-gpio".
+- compatible: Should contain "cirrus,ep7209-mctrl-gpio".
 - gpio-controller: Marks the device node as a gpio controller.
 - #gpio-cells: Should be two. The first cell is the pin number and
   the second cell is used to specify the gpio polarity:
@@ -11,7 +11,7 @@ Required properties:
 Example:
 	sysgpio: sysgpio {
 		compatible = "cirrus,ep7312-mctrl-gpio",
-			     "cirrus,clps711x-mctrl-gpio";
+			     "cirrus,ep7209-mctrl-gpio";
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
index 24b6d64..537cec7 100644
--- a/drivers/gpio/gpio-syscon.c
+++ b/drivers/gpio/gpio-syscon.c
@@ -129,7 +129,7 @@ static int syscon_gpio_dir_out(struct gpio_chip *chip, unsigned offset, int val)
 
 static const struct syscon_gpio_data clps711x_mctrl_gpio = {
 	/* ARM CLPS711X SYSFLG1 Bits 8-10 */
-	.compatible	= "cirrus,clps711x-syscon1",
+	.compatible	= "cirrus,ep7209-syscon1",
 	.flags		= GPIO_SYSCON_FEAT_IN,
 	.bit_count	= 3,
 	.dat_bit_offset	= 0x40 * 8 + 8,
@@ -168,7 +168,7 @@ static const struct syscon_gpio_data keystone_dsp_gpio = {
 
 static const struct of_device_id syscon_gpio_ids[] = {
 	{
-		.compatible	= "cirrus,clps711x-mctrl-gpio",
+		.compatible	= "cirrus,ep7209-mctrl-gpio",
 		.data		= &clps711x_mctrl_gpio,
 	},
 	{
-- 
2.4.9
