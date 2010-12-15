From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 15 Dec 2010 03:03:50 +0100
Subject: [PATCH 13/16] ARM: mmp: Switch over to gpiolib's version of
	__gpio_to_irq().
In-Reply-To: <cover.1292377339.git.buytenh@wantstofly.org>
References: <cover.1292377339.git.buytenh@wantstofly.org>
Message-ID: <20101215020350.GF15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-mmp/aspenite.c          |    4 ++--
 arch/arm/mach-mmp/flint.c             |    4 ++--
 arch/arm/mach-mmp/include/mach/gpio.h |    3 ++-
 arch/arm/mach-mmp/tavorevb.c          |    4 ++--
 arch/arm/mach-mmp/teton_bga.c         |    2 +-
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 06b5fa8..bae9e65 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -120,8 +120,8 @@ static struct resource smc91x_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gpio_to_irq(27),
-		.end	= gpio_to_irq(27),
+		.start	= IRQ_GPIO_START + 27,
+		.end	= IRQ_GPIO_START + 27,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	}
 };
diff --git a/arch/arm/mach-mmp/flint.c b/arch/arm/mach-mmp/flint.c
index bdeb6db..4c5b63e 100644
--- a/arch/arm/mach-mmp/flint.c
+++ b/arch/arm/mach-mmp/flint.c
@@ -87,8 +87,8 @@ static struct resource smc91x_resources[] = {
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start  = gpio_to_irq(155),
-		.end    = gpio_to_irq(155),
+		.start  = IRQ_GPIO_START + 155,
+		.end    = IRQ_GPIO_START + 155,
 		.flags  = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	}
 };
diff --git a/arch/arm/mach-mmp/include/mach/gpio.h b/arch/arm/mach-mmp/include/mach/gpio.h
index ee8b02e..c3e799f 100644
--- a/arch/arm/mach-mmp/include/mach/gpio.h
+++ b/arch/arm/mach-mmp/include/mach/gpio.h
@@ -12,8 +12,9 @@
 
 #define NR_BUILTIN_GPIO	(192)
 
+#define gpio_to_irq		__gpio_to_irq
+
 #define gpio_to_bank(gpio)	((gpio) >> 5)
-#define gpio_to_irq(gpio)	(IRQ_GPIO_START + (gpio))
 #define irq_to_gpio(irq)	((irq) - IRQ_GPIO_START)
 
 
diff --git a/arch/arm/mach-mmp/tavorevb.c b/arch/arm/mach-mmp/tavorevb.c
index c296b75..dffdcba 100644
--- a/arch/arm/mach-mmp/tavorevb.c
+++ b/arch/arm/mach-mmp/tavorevb.c
@@ -71,8 +71,8 @@ static struct resource smc91x_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gpio_to_irq(80),
-		.end	= gpio_to_irq(80),
+		.start	= IRQ_GPIO_START + 80,
+		.end	= IRQ_GPIO_START + 80,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	}
 };
diff --git a/arch/arm/mach-mmp/teton_bga.c b/arch/arm/mach-mmp/teton_bga.c
index bbe4727..f070603 100644
--- a/arch/arm/mach-mmp/teton_bga.c
+++ b/arch/arm/mach-mmp/teton_bga.c
@@ -66,7 +66,7 @@ static struct pxa27x_keypad_platform_data teton_bga_keypad_info __initdata = {
 static struct i2c_board_info teton_bga_i2c_info[] __initdata = {
 	{
 		I2C_BOARD_INFO("ds1337", 0x68),
-		.irq = gpio_to_irq(RTC_INT_GPIO)
+		.irq = IRQ_GPIO_START + RTC_INT_GPIO,
 	},
 };
 
-- 
1.7.1
