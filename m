From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 15 Nov 2011 21:30:58 +0100
Subject: [PATCH 2/2] ARM: at91: gpio make struct at91_gpio_bank an initdata
In-Reply-To: <1321389058-22525-1-git-send-email-plagnioj@jcrosoft.com>
References: <1321389058-22525-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1321389058-22525-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this will simplify the switch to the DT and later to the platform_device

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/mach-at91/at91cap9.c    |    2 +-
 arch/arm/mach-at91/at91rm9200.c  |    2 +-
 arch/arm/mach-at91/at91sam9260.c |    2 +-
 arch/arm/mach-at91/at91sam9261.c |    2 +-
 arch/arm/mach-at91/at91sam9263.c |    2 +-
 arch/arm/mach-at91/at91sam9g45.c |    2 +-
 arch/arm/mach-at91/at91sam9rl.c  |    2 +-
 arch/arm/mach-at91/gpio.c        |   12 ++++++------
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index bfffaf6..81a9f38 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -296,7 +296,7 @@ void __init at91cap9_set_console_clock(int id)
  *  GPIO
  * -------------------------------------------------------------------- */
 
-static struct at91_gpio_bank at91cap9_gpio[] = {
+static struct at91_gpio_bank at91cap9_gpio[] __initdata = {
 	{
 		.id		= AT91CAP9_ID_PIOABCD,
 		.regbase	= AT91CAP9_BASE_PIOA,
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 7470f63..9163d7d 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -273,7 +273,7 @@ void __init at91rm9200_set_console_clock(int id)
  *  GPIO
  * -------------------------------------------------------------------- */
 
-static struct at91_gpio_bank at91rm9200_gpio[] = {
+static struct at91_gpio_bank at91rm9200_gpio[] __initdata = {
 	{
 		.id		= AT91RM9200_ID_PIOA,
 		.regbase	= AT91RM9200_BASE_PIOA,
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 81f0b76..5e25cef 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -272,7 +272,7 @@ void __init at91sam9260_set_console_clock(int id)
  *  GPIO
  * -------------------------------------------------------------------- */
 
-static struct at91_gpio_bank at91sam9260_gpio[] = {
+static struct at91_gpio_bank at91sam9260_gpio[] __initdata = {
 	{
 		.id		= AT91SAM9260_ID_PIOA,
 		.regbase	= AT91SAM9260_BASE_PIOA,
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index dd7924c..a0538c5 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -253,7 +253,7 @@ void __init at91sam9261_set_console_clock(int id)
  *  GPIO
  * -------------------------------------------------------------------- */
 
-static struct at91_gpio_bank at91sam9261_gpio[] = {
+static struct at91_gpio_bank at91sam9261_gpio[] __initdata = {
 	{
 		.id		= AT91SAM9261_ID_PIOA,
 		.regbase	= AT91SAM9261_BASE_PIOA,
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 646d424..0d90b6a 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -267,7 +267,7 @@ void __init at91sam9263_set_console_clock(int id)
  *  GPIO
  * -------------------------------------------------------------------- */
 
-static struct at91_gpio_bank at91sam9263_gpio[] = {
+static struct at91_gpio_bank at91sam9263_gpio[] __initdata = {
 	{
 		.id		= AT91SAM9263_ID_PIOA,
 		.regbase	= AT91SAM9263_BASE_PIOA,
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 11b31af..72c3cce 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -297,7 +297,7 @@ void __init at91sam9g45_set_console_clock(int id)
  *  GPIO
  * -------------------------------------------------------------------- */
 
-static struct at91_gpio_bank at91sam9g45_gpio[] = {
+static struct at91_gpio_bank at91sam9g45_gpio[] __initdata = {
 	{
 		.id		= AT91SAM9G45_ID_PIOA,
 		.regbase	= AT91SAM9G45_BASE_PIOA,
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 60555d4..96247f6 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -246,7 +246,7 @@ void __init at91sam9rl_set_console_clock(int id)
  *  GPIO
  * -------------------------------------------------------------------- */
 
-static struct at91_gpio_bank at91sam9rl_gpio[] = {
+static struct at91_gpio_bank at91sam9rl_gpio[] __initdata = {
 	{
 		.id		= AT91SAM9RL_ID_PIOA,
 		.regbase	= AT91SAM9RL_BASE_PIOA,
diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index 4059f07..9c58deb 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -29,7 +29,7 @@
 struct at91_gpio_chip {
 	struct gpio_chip	chip;
 	struct at91_gpio_chip	*next;		/* Bank sharing same clock */
-	struct at91_gpio_bank	*bank;		/* Bank definition */
+	int			id;		/* ID of register bank */
 	void __iomem		*regbase;	/* Base of register bank */
 	struct clk		*clock;		/* associated clock */
 };
@@ -286,7 +286,7 @@ static int gpio_irq_set_wake(struct irq_data *d, unsigned state)
 	else
 		wakeups[bank] &= ~mask;
 
-	irq_set_irq_wake(gpio_chip[bank].bank->id, state);
+	irq_set_irq_wake(gpio_chip[bank].id, state);
 
 	return 0;
 }
@@ -498,7 +498,7 @@ void __init at91_gpio_irq_setup(void)
 	for (pioc = 0, pin = PIN_BASE, this = gpio_chip, prev = NULL;
 			pioc++ < gpio_banks;
 			prev = this, this++) {
-		unsigned	id = this->bank->id;
+		unsigned	id = this->id;
 		unsigned	i;
 
 		__raw_writel(~0, this->regbase + PIO_IDR);
@@ -613,10 +613,10 @@ void __init at91_gpio_init(struct at91_gpio_bank *data, int nr_banks)
 	for (i = 0; i < nr_banks; i++) {
 		at91_gpio = &gpio_chip[i];
 
-		at91_gpio->bank = &data[i];
+		at91_gpio->id = data[i].id;
 		at91_gpio->chip.base = PIN_BASE + i * 32;
 
-		at91_gpio->regbase = ioremap(at91_gpio->bank->regbase, 512);
+		at91_gpio->regbase = ioremap(data->regbase, 512);
 		if (!at91_gpio->regbase) {
 			pr_err("at91_gpio.%d, failed to map registers, ignoring.\n", i);
 			continue;
@@ -632,7 +632,7 @@ void __init at91_gpio_init(struct at91_gpio_bank *data, int nr_banks)
 		clk_enable(at91_gpio->clock);
 
 		/* AT91SAM9263_ID_PIOCDE groups PIOC, PIOD, PIOE */
-		if (last && last->bank->id == at91_gpio->bank->id)
+		if (last && last->id == at91_gpio->id)
 			last->next = at91_gpio;
 		last = at91_gpio;
 
-- 
1.7.7
