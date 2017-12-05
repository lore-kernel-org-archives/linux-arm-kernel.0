From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue,  5 Dec 2017 15:46:39 +0100
Subject: [PATCH v5 1/9] gpio: axp209: switch unsigned variables to unsigned int
In-Reply-To: <20171205144647.17594-1-quentin.schulz@free-electrons.com>
References: <20171205144647.17594-1-quentin.schulz@free-electrons.com>
Message-ID: <20171205144647.17594-2-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Checkpatch complains with the following message:
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Let's make it happy by switching over to unsigned int.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/gpio/gpio-axp209.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-axp209.c b/drivers/gpio/gpio-axp209.c
index 4a346b7b4172..6ee7dc1418fa 100644
--- a/drivers/gpio/gpio-axp209.c
+++ b/drivers/gpio/gpio-axp209.c
@@ -32,7 +32,7 @@ struct axp20x_gpio {
 	struct regmap		*regmap;
 };
 
-static int axp20x_gpio_get_reg(unsigned offset)
+static int axp20x_gpio_get_reg(unsigned int offset)
 {
 	switch (offset) {
 	case 0:
@@ -46,7 +46,7 @@ static int axp20x_gpio_get_reg(unsigned offset)
 	return -EINVAL;
 }
 
-static int axp20x_gpio_input(struct gpio_chip *chip, unsigned offset)
+static int axp20x_gpio_input(struct gpio_chip *chip, unsigned int offset)
 {
 	struct axp20x_gpio *gpio = gpiochip_get_data(chip);
 	int reg;
@@ -60,7 +60,7 @@ static int axp20x_gpio_input(struct gpio_chip *chip, unsigned offset)
 				  AXP20X_GPIO_FUNCTION_INPUT);
 }
 
-static int axp20x_gpio_get(struct gpio_chip *chip, unsigned offset)
+static int axp20x_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct axp20x_gpio *gpio = gpiochip_get_data(chip);
 	unsigned int val;
@@ -73,7 +73,8 @@ static int axp20x_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return !!(val & BIT(offset + 4));
 }
 
-static int axp20x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
+static int axp20x_gpio_get_direction(struct gpio_chip *chip,
+				     unsigned int offset)
 {
 	struct axp20x_gpio *gpio = gpiochip_get_data(chip);
 	unsigned int val;
@@ -102,7 +103,7 @@ static int axp20x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
 	return val & 2;
 }
 
-static int axp20x_gpio_output(struct gpio_chip *chip, unsigned offset,
+static int axp20x_gpio_output(struct gpio_chip *chip, unsigned int offset,
 			      int value)
 {
 	struct axp20x_gpio *gpio = gpiochip_get_data(chip);
@@ -118,7 +119,7 @@ static int axp20x_gpio_output(struct gpio_chip *chip, unsigned offset,
 				  : AXP20X_GPIO_FUNCTION_OUT_LOW);
 }
 
-static void axp20x_gpio_set(struct gpio_chip *chip, unsigned offset,
+static void axp20x_gpio_set(struct gpio_chip *chip, unsigned int offset,
 			    int value)
 {
 	axp20x_gpio_output(chip, offset, value);
-- 
2.14.1
