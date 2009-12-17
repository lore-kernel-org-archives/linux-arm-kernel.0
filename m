From: rubini-list@gnudd.com (Alessandro Rubini)
Date: Thu, 17 Dec 2009 10:34:34 +0100
Subject: [PATCH] nhk8815: fix i2c-gpio initialization
Message-ID: <20091217093434.GA17336@morgana.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alessandro Rubini <rubini@unipv.it>

Signed-off-by: Alessandro Rubini <rubini@unipv.it>
Acked-by: Andrea Gallo <andrea.gallo@stericsson.com>
---
 arch/arm/mach-nomadik/i2c-8815nhk.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-nomadik/i2c-8815nhk.c b/arch/arm/mach-nomadik/i2c-8815nhk.c
index abfe25a..7045ec1 100644
--- a/arch/arm/mach-nomadik/i2c-8815nhk.c
+++ b/arch/arm/mach-nomadik/i2c-8815nhk.c
@@ -43,12 +43,17 @@ static struct platform_device nhk8815_i2c_dev1 = {
 
 static int __init nhk8815_i2c_init(void)
 {
+	/* i2c-gpio switches from out to in and back, so force out data to 0 */
 	nmk_gpio_set_mode(nhk8815_i2c_data0.scl_pin, NMK_GPIO_ALT_GPIO);
 	nmk_gpio_set_mode(nhk8815_i2c_data0.sda_pin, NMK_GPIO_ALT_GPIO);
+	gpio_set_value(nhk8815_i2c_data0.sda_pin, 0);
+	gpio_set_value(nhk8815_i2c_data0.scl_pin, 0);
 	platform_device_register(&nhk8815_i2c_dev0);
 
 	nmk_gpio_set_mode(nhk8815_i2c_data1.scl_pin, NMK_GPIO_ALT_GPIO);
 	nmk_gpio_set_mode(nhk8815_i2c_data1.sda_pin, NMK_GPIO_ALT_GPIO);
+	gpio_set_value(nhk8815_i2c_data1.sda_pin, 0);
+	gpio_set_value(nhk8815_i2c_data1.scl_pin, 0);
 	platform_device_register(&nhk8815_i2c_dev1);
 
 	return 0;
-- 
1.6.0.2
