From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 15 Nov 2011 21:40:33 +0100
Subject: [PATCH 1/2] ARM: at91: switch gpio clock to clkdev
In-Reply-To: <20111113180954.GD15318@game.jcrosoft.org>
References: <20111113180954.GD15318@game.jcrosoft.org>
Message-ID: <1321389646-24112-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91cap9.c    |    8 ++++----
 arch/arm/mach-at91/at91rm9200.c  |    8 ++++----
 arch/arm/mach-at91/at91sam9260.c |    6 +++---
 arch/arm/mach-at91/at91sam9261.c |    6 +++---
 arch/arm/mach-at91/at91sam9263.c |   10 +++++-----
 arch/arm/mach-at91/at91sam9g45.c |   10 +++++-----
 arch/arm/mach-at91/at91sam9rl.c  |    8 ++++----
 arch/arm/mach-at91/generic.h     |    1 -
 arch/arm/mach-at91/gpio.c        |   23 +++++++++++++++--------
 9 files changed, 43 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index 652dbe1..bfffaf6 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -220,6 +220,10 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &ohci_clk),
+	CLKDEV_CON_ID("pioA", &pioABCD_clk),
+	CLKDEV_CON_ID("pioB", &pioABCD_clk),
+	CLKDEV_CON_ID("pioC", &pioABCD_clk),
+	CLKDEV_CON_ID("pioD", &pioABCD_clk),
 };
 
 static struct clk_lookup usart_clocks_lookups[] = {
@@ -296,19 +300,15 @@ static struct at91_gpio_bank at91cap9_gpio[] = {
 	{
 		.id		= AT91CAP9_ID_PIOABCD,
 		.regbase	= AT91CAP9_BASE_PIOA,
-		.clock		= &pioABCD_clk,
 	}, {
 		.id		= AT91CAP9_ID_PIOABCD,
 		.regbase	= AT91CAP9_BASE_PIOB,
-		.clock		= &pioABCD_clk,
 	}, {
 		.id		= AT91CAP9_ID_PIOABCD,
 		.regbase	= AT91CAP9_BASE_PIOC,
-		.clock		= &pioABCD_clk,
 	}, {
 		.id		= AT91CAP9_ID_PIOABCD,
 		.regbase	= AT91CAP9_BASE_PIOD,
-		.clock		= &pioABCD_clk,
 	}
 };
 
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index c06c14f..7470f63 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -196,6 +196,10 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("pclk", "ssc.2", &ssc2_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &ohci_clk),
+	CLKDEV_CON_ID("pioA", &pioA_clk),
+	CLKDEV_CON_ID("pioB", &pioB_clk),
+	CLKDEV_CON_ID("pioC", &pioC_clk),
+	CLKDEV_CON_ID("pioD", &pioD_clk),
 };
 
 static struct clk_lookup usart_clocks_lookups[] = {
@@ -273,19 +277,15 @@ static struct at91_gpio_bank at91rm9200_gpio[] = {
 	{
 		.id		= AT91RM9200_ID_PIOA,
 		.regbase	= AT91RM9200_BASE_PIOA,
-		.clock		= &pioA_clk,
 	}, {
 		.id		= AT91RM9200_ID_PIOB,
 		.regbase	= AT91RM9200_BASE_PIOB,
-		.clock		= &pioB_clk,
 	}, {
 		.id		= AT91RM9200_ID_PIOC,
 		.regbase	= AT91RM9200_BASE_PIOC,
-		.clock		= &pioC_clk,
 	}, {
 		.id		= AT91RM9200_ID_PIOD,
 		.regbase	= AT91RM9200_BASE_PIOD,
-		.clock		= &pioD_clk,
 	}
 };
 
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 5a17a23..81f0b76 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -208,6 +208,9 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("usart", "fffd8000.serial", &usart5_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &ohci_clk),
+	CLKDEV_CON_ID("pioA", &pioA_clk),
+	CLKDEV_CON_ID("pioB", &pioB_clk),
+	CLKDEV_CON_ID("pioC", &pioC_clk),
 };
 
 static struct clk_lookup usart_clocks_lookups[] = {
@@ -273,15 +276,12 @@ static struct at91_gpio_bank at91sam9260_gpio[] = {
 	{
 		.id		= AT91SAM9260_ID_PIOA,
 		.regbase	= AT91SAM9260_BASE_PIOA,
-		.clock		= &pioA_clk,
 	}, {
 		.id		= AT91SAM9260_ID_PIOB,
 		.regbase	= AT91SAM9260_BASE_PIOB,
-		.clock		= &pioB_clk,
 	}, {
 		.id		= AT91SAM9260_ID_PIOC,
 		.regbase	= AT91SAM9260_BASE_PIOC,
-		.clock		= &pioC_clk,
 	}
 };
 
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 80e3e0f..dd7924c 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -175,6 +175,9 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.2", &ssc2_clk),
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &hck0),
+	CLKDEV_CON_ID("pioA", &pioA_clk),
+	CLKDEV_CON_ID("pioB", &pioB_clk),
+	CLKDEV_CON_ID("pioC", &pioC_clk),
 };
 
 static struct clk_lookup usart_clocks_lookups[] = {
@@ -254,15 +257,12 @@ static struct at91_gpio_bank at91sam9261_gpio[] = {
 	{
 		.id		= AT91SAM9261_ID_PIOA,
 		.regbase	= AT91SAM9261_BASE_PIOA,
-		.clock		= &pioA_clk,
 	}, {
 		.id		= AT91SAM9261_ID_PIOB,
 		.regbase	= AT91SAM9261_BASE_PIOB,
-		.clock		= &pioB_clk,
 	}, {
 		.id		= AT91SAM9261_ID_PIOC,
 		.regbase	= AT91SAM9261_BASE_PIOC,
-		.clock		= &pioC_clk,
 	}
 };
 
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 2a42b99..646d424 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -190,6 +190,11 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tcb_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &ohci_clk),
+	CLKDEV_CON_ID("pioA", &pioA_clk),
+	CLKDEV_CON_ID("pioB", &pioB_clk),
+	CLKDEV_CON_ID("pioC", &pioCDE_clk),
+	CLKDEV_CON_ID("pioD", &pioCDE_clk),
+	CLKDEV_CON_ID("pioE", &pioCDE_clk),
 };
 
 static struct clk_lookup usart_clocks_lookups[] = {
@@ -266,23 +271,18 @@ static struct at91_gpio_bank at91sam9263_gpio[] = {
 	{
 		.id		= AT91SAM9263_ID_PIOA,
 		.regbase	= AT91SAM9263_BASE_PIOA,
-		.clock		= &pioA_clk,
 	}, {
 		.id		= AT91SAM9263_ID_PIOB,
 		.regbase	= AT91SAM9263_BASE_PIOB,
-		.clock		= &pioB_clk,
 	}, {
 		.id		= AT91SAM9263_ID_PIOCDE,
 		.regbase	= AT91SAM9263_BASE_PIOC,
-		.clock		= &pioCDE_clk,
 	}, {
 		.id		= AT91SAM9263_ID_PIOCDE,
 		.regbase	= AT91SAM9263_BASE_PIOD,
-		.clock		= &pioCDE_clk,
 	}, {
 		.id		= AT91SAM9263_ID_PIOCDE,
 		.regbase	= AT91SAM9263_BASE_PIOE,
-		.clock		= &pioCDE_clk,
 	}
 };
 
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 7fdf964..11b31af 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -230,6 +230,11 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("usart", "fff98000.serial", &usart3_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &uhphs_clk),
+	CLKDEV_CON_ID("pioA", &pioA_clk),
+	CLKDEV_CON_ID("pioB", &pioB_clk),
+	CLKDEV_CON_ID("pioC", &pioC_clk),
+	CLKDEV_CON_ID("pioD", &pioDE_clk),
+	CLKDEV_CON_ID("pioE", &pioDE_clk),
 };
 
 static struct clk_lookup usart_clocks_lookups[] = {
@@ -296,23 +301,18 @@ static struct at91_gpio_bank at91sam9g45_gpio[] = {
 	{
 		.id		= AT91SAM9G45_ID_PIOA,
 		.regbase	= AT91SAM9G45_BASE_PIOA,
-		.clock		= &pioA_clk,
 	}, {
 		.id		= AT91SAM9G45_ID_PIOB,
 		.regbase	= AT91SAM9G45_BASE_PIOB,
-		.clock		= &pioB_clk,
 	}, {
 		.id		= AT91SAM9G45_ID_PIOC,
 		.regbase	= AT91SAM9G45_BASE_PIOC,
-		.clock		= &pioC_clk,
 	}, {
 		.id		= AT91SAM9G45_ID_PIODE,
 		.regbase	= AT91SAM9G45_BASE_PIOD,
-		.clock		= &pioDE_clk,
 	}, {
 		.id		= AT91SAM9G45_ID_PIODE,
 		.regbase	= AT91SAM9G45_BASE_PIOE,
-		.clock		= &pioDE_clk,
 	}
 };
 
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 6856bad..60555d4 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -183,6 +183,10 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t2_clk", "atmel_tcb.0", &tc2_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
+	CLKDEV_CON_ID("pioA", &pioA_clk),
+	CLKDEV_CON_ID("pioB", &pioB_clk),
+	CLKDEV_CON_ID("pioC", &pioC_clk),
+	CLKDEV_CON_ID("pioD", &pioD_clk),
 };
 
 static struct clk_lookup usart_clocks_lookups[] = {
@@ -246,19 +250,15 @@ static struct at91_gpio_bank at91sam9rl_gpio[] = {
 	{
 		.id		= AT91SAM9RL_ID_PIOA,
 		.regbase	= AT91SAM9RL_BASE_PIOA,
-		.clock		= &pioA_clk,
 	}, {
 		.id		= AT91SAM9RL_ID_PIOB,
 		.regbase	= AT91SAM9RL_BASE_PIOB,
-		.clock		= &pioB_clk,
 	}, {
 		.id		= AT91SAM9RL_ID_PIOC,
 		.regbase	= AT91SAM9RL_BASE_PIOC,
-		.clock		= &pioC_clk,
 	}, {
 		.id		= AT91SAM9RL_ID_PIOD,
 		.regbase	= AT91SAM9RL_BASE_PIOD,
-		.clock		= &pioD_clk,
 	}
 };
 
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index bc17764..4030958 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -70,7 +70,6 @@ extern void at91_ioremap_shdwc(u32 base_addr);
 struct at91_gpio_bank {
 	unsigned short id;		/* peripheral ID */
 	unsigned long regbase;		/* offset from system peripheral base */
-	struct clk *clock;		/* associated clock */
 };
 extern void __init at91_gpio_init(struct at91_gpio_bank *, int nr_banks);
 extern void __init at91_gpio_irq_setup(void);
diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index cedb753..4059f07 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -31,6 +31,7 @@ struct at91_gpio_chip {
 	struct at91_gpio_chip	*next;		/* Bank sharing same clock */
 	struct at91_gpio_bank	*bank;		/* Bank definition */
 	void __iomem		*regbase;	/* Base of register bank */
+	struct clk		*clock;		/* associated clock */
 };
 
 #define to_at91_gpio_chip(c) container_of(c, struct at91_gpio_chip, chip)
@@ -58,11 +59,11 @@ static int at91_gpiolib_direction_input(struct gpio_chip *chip,
 	}
 
 static struct at91_gpio_chip gpio_chip[] = {
-	AT91_GPIO_CHIP("A", 0x00 + PIN_BASE, 32),
-	AT91_GPIO_CHIP("B", 0x20 + PIN_BASE, 32),
-	AT91_GPIO_CHIP("C", 0x40 + PIN_BASE, 32),
-	AT91_GPIO_CHIP("D", 0x60 + PIN_BASE, 32),
-	AT91_GPIO_CHIP("E", 0x80 + PIN_BASE, 32),
+	AT91_GPIO_CHIP("pioA", 0x00 + PIN_BASE, 32),
+	AT91_GPIO_CHIP("pioB", 0x20 + PIN_BASE, 32),
+	AT91_GPIO_CHIP("pioC", 0x40 + PIN_BASE, 32),
+	AT91_GPIO_CHIP("pioD", 0x60 + PIN_BASE, 32),
+	AT91_GPIO_CHIP("pioE", 0x80 + PIN_BASE, 32),
 };
 
 static int gpio_banks;
@@ -302,7 +303,7 @@ void at91_gpio_suspend(void)
 		__raw_writel(wakeups[i], pio + PIO_IER);
 
 		if (!wakeups[i])
-			clk_disable(gpio_chip[i].bank->clock);
+			clk_disable(gpio_chip[i].clock);
 		else {
 #ifdef CONFIG_PM_DEBUG
 			printk(KERN_DEBUG "GPIO-%c may wake for %08x\n", 'A'+i, wakeups[i]);
@@ -319,7 +320,7 @@ void at91_gpio_resume(void)
 		void __iomem	*pio = gpio_chip[i].regbase;
 
 		if (!wakeups[i])
-			clk_enable(gpio_chip[i].bank->clock);
+			clk_enable(gpio_chip[i].clock);
 
 		__raw_writel(wakeups[i], pio + PIO_IDR);
 		__raw_writel(backups[i], pio + PIO_IER);
@@ -621,8 +622,14 @@ void __init at91_gpio_init(struct at91_gpio_bank *data, int nr_banks)
 			continue;
 		}
 
+		at91_gpio->clock = clk_get_sys(NULL, at91_gpio->chip.label);
+		if (!at91_gpio->clock) {
+			pr_err("at91_gpio.%d, failed to get clock, ignoring.\n", i);
+			continue;
+		}
+
 		/* enable PIO controller's clock */
-		clk_enable(at91_gpio->bank->clock);
+		clk_enable(at91_gpio->clock);
 
 		/* AT91SAM9263_ID_PIOCDE groups PIOC, PIOD, PIOE */
 		if (last && last->bank->id == at91_gpio->bank->id)
-- 
1.7.7
