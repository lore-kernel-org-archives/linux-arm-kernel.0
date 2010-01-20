From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 20 Jan 2010 13:06:05 +0000
Subject: [PATCH 2/2] SAMSUNG: Staticise gpiolib implementation functions
In-Reply-To: <1263992765-28479-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1263992765-28479-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1263992765-28479-2-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

They are not exported, they are referenced via vtables.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/plat-samsung/gpiolib.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-samsung/gpiolib.c b/arch/arm/plat-samsung/gpiolib.c
index 3419b67..8a8ba8b 100644
--- a/arch/arm/plat-samsung/gpiolib.c
+++ b/arch/arm/plat-samsung/gpiolib.c
@@ -44,7 +44,8 @@
  * the output.
 */
 
-int samsung_gpiolib_4bit_input(struct gpio_chip *chip, unsigned int offset)
+static int samsung_gpiolib_4bit_input(struct gpio_chip *chip,
+				      unsigned int offset)
 {
 	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
 	void __iomem *base = ourchip->base;
@@ -59,8 +60,8 @@ int samsung_gpiolib_4bit_input(struct gpio_chip *chip, unsigned int offset)
 	return 0;
 }
 
-int samsung_gpiolib_4bit_output(struct gpio_chip *chip,
-				unsigned int offset, int value)
+static int samsung_gpiolib_4bit_output(struct gpio_chip *chip,
+				       unsigned int offset, int value)
 {
 	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
 	void __iomem *base = ourchip->base;
@@ -106,9 +107,10 @@ int samsung_gpiolib_4bit_output(struct gpio_chip *chip,
  * To allow us to use the s3c_gpiolib_get and s3c_gpiolib_set routines we
  * store the 'base + 0x4' address so that these routines see the data
  * register at ourchip->base + 0x04.
-*/
+ */
 
-int samsung_gpiolib_4bit2_input(struct gpio_chip *chip, unsigned int offset)
+static int samsung_gpiolib_4bit2_input(struct gpio_chip *chip,
+				       unsigned int offset)
 {
 	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
 	void __iomem *base = ourchip->base;
@@ -129,8 +131,8 @@ int samsung_gpiolib_4bit2_input(struct gpio_chip *chip, unsigned int offset)
 	return 0;
 }
 
-int samsung_gpiolib_4bit2_output(struct gpio_chip *chip,
-				 unsigned int offset, int value)
+static int samsung_gpiolib_4bit2_output(struct gpio_chip *chip,
+					unsigned int offset, int value)
 {
 	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
 	void __iomem *base = ourchip->base;
-- 
1.6.6
