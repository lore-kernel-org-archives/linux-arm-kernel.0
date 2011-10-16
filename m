From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 16 Oct 2011 21:09:10 +0200
Subject: [PATCH 01/11] ARM: at91/gpio: make gpio register base soc independant
In-Reply-To: <20111016190528.GI1459@game.jcrosoft.org>
References: <20111016190528.GI1459@game.jcrosoft.org>
Message-ID: <1318792160-23279-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Reviewed-by: Ryan Mallon <rmallon@gmail.com>
---
 arch/arm/mach-at91/at91cap9.c                 |    8 ++++----
 arch/arm/mach-at91/at91rm9200.c               |    8 ++++----
 arch/arm/mach-at91/at91sam9260.c              |    6 +++---
 arch/arm/mach-at91/at91sam9261.c              |    6 +++---
 arch/arm/mach-at91/at91sam9263.c              |   10 +++++-----
 arch/arm/mach-at91/at91sam9g45.c              |   10 +++++-----
 arch/arm/mach-at91/at91sam9rl.c               |    8 ++++----
 arch/arm/mach-at91/generic.h                  |    2 +-
 arch/arm/mach-at91/gpio.c                     |    8 ++++++--
 arch/arm/mach-at91/include/mach/at91cap9.h    |    9 +++++----
 arch/arm/mach-at91/include/mach/at91rm9200.h  |    9 +++++----
 arch/arm/mach-at91/include/mach/at91sam9260.h |    7 ++++---
 arch/arm/mach-at91/include/mach/at91sam9261.h |    7 ++++---
 arch/arm/mach-at91/include/mach/at91sam9263.h |   11 ++++++-----
 arch/arm/mach-at91/include/mach/at91sam9g45.h |   11 ++++++-----
 arch/arm/mach-at91/include/mach/at91sam9rl.h  |    9 +++++----
 16 files changed, 70 insertions(+), 59 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index ecdd54d..fe00dce 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -296,19 +296,19 @@ void __init at91cap9_set_console_clock(int id)
 static struct at91_gpio_bank at91cap9_gpio[] = {
 	{
 		.id		= AT91CAP9_ID_PIOABCD,
-		.offset		= AT91_PIOA,
+		.regbase	= AT91CAP9_BASE_PIOA,
 		.clock		= &pioABCD_clk,
 	}, {
 		.id		= AT91CAP9_ID_PIOABCD,
-		.offset		= AT91_PIOB,
+		.regbase	= AT91CAP9_BASE_PIOB,
 		.clock		= &pioABCD_clk,
 	}, {
 		.id		= AT91CAP9_ID_PIOABCD,
-		.offset		= AT91_PIOC,
+		.regbase	= AT91CAP9_BASE_PIOC,
 		.clock		= &pioABCD_clk,
 	}, {
 		.id		= AT91CAP9_ID_PIOABCD,
-		.offset		= AT91_PIOD,
+		.regbase	= AT91CAP9_BASE_PIOD,
 		.clock		= &pioABCD_clk,
 	}
 };
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 713d3bd..8ce8675 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -271,19 +271,19 @@ void __init at91rm9200_set_console_clock(int id)
 static struct at91_gpio_bank at91rm9200_gpio[] = {
 	{
 		.id		= AT91RM9200_ID_PIOA,
-		.offset		= AT91_PIOA,
+		.regbase	= AT91RM9200_BASE_PIOA,
 		.clock		= &pioA_clk,
 	}, {
 		.id		= AT91RM9200_ID_PIOB,
-		.offset		= AT91_PIOB,
+		.regbase	= AT91RM9200_BASE_PIOB,
 		.clock		= &pioB_clk,
 	}, {
 		.id		= AT91RM9200_ID_PIOC,
-		.offset		= AT91_PIOC,
+		.regbase	= AT91RM9200_BASE_PIOC,
 		.clock		= &pioC_clk,
 	}, {
 		.id		= AT91RM9200_ID_PIOD,
-		.offset		= AT91_PIOD,
+		.regbase	= AT91RM9200_BASE_PIOD,
 		.clock		= &pioD_clk,
 	}
 };
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index a9be758..d7ad3e0 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -265,15 +265,15 @@ void __init at91sam9260_set_console_clock(int id)
 static struct at91_gpio_bank at91sam9260_gpio[] = {
 	{
 		.id		= AT91SAM9260_ID_PIOA,
-		.offset		= AT91_PIOA,
+		.regbase	= AT91SAM9260_BASE_PIOA,
 		.clock		= &pioA_clk,
 	}, {
 		.id		= AT91SAM9260_ID_PIOB,
-		.offset		= AT91_PIOB,
+		.regbase	= AT91SAM9260_BASE_PIOB,
 		.clock		= &pioB_clk,
 	}, {
 		.id		= AT91SAM9260_ID_PIOC,
-		.offset		= AT91_PIOC,
+		.regbase	= AT91SAM9260_BASE_PIOC,
 		.clock		= &pioC_clk,
 	}
 };
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 658a518..574aa6b 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -254,15 +254,15 @@ void __init at91sam9261_set_console_clock(int id)
 static struct at91_gpio_bank at91sam9261_gpio[] = {
 	{
 		.id		= AT91SAM9261_ID_PIOA,
-		.offset		= AT91_PIOA,
+		.regbase	= AT91SAM9261_BASE_PIOA,
 		.clock		= &pioA_clk,
 	}, {
 		.id		= AT91SAM9261_ID_PIOB,
-		.offset		= AT91_PIOB,
+		.regbase	= AT91SAM9261_BASE_PIOB,
 		.clock		= &pioB_clk,
 	}, {
 		.id		= AT91SAM9261_ID_PIOC,
-		.offset		= AT91_PIOC,
+		.regbase	= AT91SAM9261_BASE_PIOC,
 		.clock		= &pioC_clk,
 	}
 };
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index f83fbb0..dee0ed7 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -266,23 +266,23 @@ void __init at91sam9263_set_console_clock(int id)
 static struct at91_gpio_bank at91sam9263_gpio[] = {
 	{
 		.id		= AT91SAM9263_ID_PIOA,
-		.offset		= AT91_PIOA,
+		.regbase	= AT91SAM9263_BASE_PIOA,
 		.clock		= &pioA_clk,
 	}, {
 		.id		= AT91SAM9263_ID_PIOB,
-		.offset		= AT91_PIOB,
+		.regbase	= AT91SAM9263_BASE_PIOB,
 		.clock		= &pioB_clk,
 	}, {
 		.id		= AT91SAM9263_ID_PIOCDE,
-		.offset		= AT91_PIOC,
+		.regbase	= AT91SAM9263_BASE_PIOC,
 		.clock		= &pioCDE_clk,
 	}, {
 		.id		= AT91SAM9263_ID_PIOCDE,
-		.offset		= AT91_PIOD,
+		.regbase	= AT91SAM9263_BASE_PIOD,
 		.clock		= &pioCDE_clk,
 	}, {
 		.id		= AT91SAM9263_ID_PIOCDE,
-		.offset		= AT91_PIOE,
+		.regbase	= AT91SAM9263_BASE_PIOE,
 		.clock		= &pioCDE_clk,
 	}
 };
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 8f5db7b..753df63 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -282,23 +282,23 @@ void __init at91sam9g45_set_console_clock(int id)
 static struct at91_gpio_bank at91sam9g45_gpio[] = {
 	{
 		.id		= AT91SAM9G45_ID_PIOA,
-		.offset		= AT91_PIOA,
+		.regbase	= AT91SAM9G45_BASE_PIOA,
 		.clock		= &pioA_clk,
 	}, {
 		.id		= AT91SAM9G45_ID_PIOB,
-		.offset		= AT91_PIOB,
+		.regbase	= AT91SAM9G45_BASE_PIOB,
 		.clock		= &pioB_clk,
 	}, {
 		.id		= AT91SAM9G45_ID_PIOC,
-		.offset		= AT91_PIOC,
+		.regbase	= AT91SAM9G45_BASE_PIOC,
 		.clock		= &pioC_clk,
 	}, {
 		.id		= AT91SAM9G45_ID_PIODE,
-		.offset		= AT91_PIOD,
+		.regbase	= AT91SAM9G45_BASE_PIOD,
 		.clock		= &pioDE_clk,
 	}, {
 		.id		= AT91SAM9G45_ID_PIODE,
-		.offset		= AT91_PIOE,
+		.regbase	= AT91SAM9G45_BASE_PIOE,
 		.clock		= &pioDE_clk,
 	}
 };
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index a238105..c4004e2 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -246,19 +246,19 @@ void __init at91sam9rl_set_console_clock(int id)
 static struct at91_gpio_bank at91sam9rl_gpio[] = {
 	{
 		.id		= AT91SAM9RL_ID_PIOA,
-		.offset		= AT91_PIOA,
+		.regbase	= AT91SAM9RL_BASE_PIOA,
 		.clock		= &pioA_clk,
 	}, {
 		.id		= AT91SAM9RL_ID_PIOB,
-		.offset		= AT91_PIOB,
+		.regbase	= AT91SAM9RL_BASE_PIOB,
 		.clock		= &pioB_clk,
 	}, {
 		.id		= AT91SAM9RL_ID_PIOC,
-		.offset		= AT91_PIOC,
+		.regbase	= AT91SAM9RL_BASE_PIOC,
 		.clock		= &pioC_clk,
 	}, {
 		.id		= AT91SAM9RL_ID_PIOD,
-		.offset		= AT91_PIOD,
+		.regbase	= AT91SAM9RL_BASE_PIOD,
 		.clock		= &pioD_clk,
 	}
 };
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 938b34f..11d7297 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -65,7 +65,7 @@ extern void at91sam9_alt_reset(void);
 
 struct at91_gpio_bank {
 	unsigned short id;		/* peripheral ID */
-	unsigned long offset;		/* offset from system peripheral base */
+	unsigned long regbase;		/* offset from system peripheral base */
 	struct clk *clock;		/* associated clock */
 };
 extern void __init at91_gpio_init(struct at91_gpio_bank *, int nr_banks);
diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index 4615528..04beff1 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -616,8 +616,12 @@ void __init at91_gpio_init(struct at91_gpio_bank *data, int nr_banks)
 
 		at91_gpio->bank = &data[i];
 		at91_gpio->chip.base = PIN_BASE + i * 32;
-		at91_gpio->regbase = at91_gpio->bank->offset +
-			(void __iomem *)AT91_VA_BASE_SYS;
+
+		at91_gpio->regbase = ioremap(at91_gpio->bank->regbase, 512);
+		if (!at91_gpio->regbase) {
+			pr_err("at91_gpio.%d, failed to map registers, ignoring.\n", i);
+			continue;
+		}
 
 		/* enable PIO controller's clock */
 		clk_enable(at91_gpio->bank->clock);
diff --git a/arch/arm/mach-at91/include/mach/at91cap9.h b/arch/arm/mach-at91/include/mach/at91cap9.h
index c5df1e8..f65d083 100644
--- a/arch/arm/mach-at91/include/mach/at91cap9.h
+++ b/arch/arm/mach-at91/include/mach/at91cap9.h
@@ -88,10 +88,6 @@
 #define AT91_DMA	(0xffffec00 - AT91_BASE_SYS)
 #define AT91_DBGU	(0xffffee00 - AT91_BASE_SYS)
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
-#define AT91_PIOA	(0xfffff200 - AT91_BASE_SYS)
-#define AT91_PIOB	(0xfffff400 - AT91_BASE_SYS)
-#define AT91_PIOC	(0xfffff600 - AT91_BASE_SYS)
-#define AT91_PIOD	(0xfffff800 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
@@ -102,6 +98,11 @@
 			(0xfffffd50 - AT91_BASE_SYS) :	\
 			(0xfffffd60 - AT91_BASE_SYS))
 
+#define AT91CAP9_BASE_PIOA	0xfffff200
+#define AT91CAP9_BASE_PIOB	0xfffff400
+#define AT91CAP9_BASE_PIOC	0xfffff600
+#define AT91CAP9_BASE_PIOD	0xfffff800
+
 #define AT91_USART0	AT91CAP9_BASE_US0
 #define AT91_USART1	AT91CAP9_BASE_US1
 #define AT91_USART2	AT91CAP9_BASE_US2
diff --git a/arch/arm/mach-at91/include/mach/at91rm9200.h b/arch/arm/mach-at91/include/mach/at91rm9200.h
index e4037b5..5740954 100644
--- a/arch/arm/mach-at91/include/mach/at91rm9200.h
+++ b/arch/arm/mach-at91/include/mach/at91rm9200.h
@@ -81,15 +81,16 @@
  */
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)	/* Advanced Interrupt Controller */
 #define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)	/* Debug Unit */
-#define AT91_PIOA	(0xfffff400 - AT91_BASE_SYS)	/* PIO Controller A */
-#define AT91_PIOB	(0xfffff600 - AT91_BASE_SYS)	/* PIO Controller B */
-#define AT91_PIOC	(0xfffff800 - AT91_BASE_SYS)	/* PIO Controller C */
-#define AT91_PIOD	(0xfffffa00 - AT91_BASE_SYS)	/* PIO Controller D */
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)	/* Power Management Controller */
 #define AT91_ST		(0xfffffd00 - AT91_BASE_SYS)	/* System Timer */
 #define AT91_RTC	(0xfffffe00 - AT91_BASE_SYS)	/* Real-Time Clock */
 #define AT91_MC		(0xffffff00 - AT91_BASE_SYS)	/* Memory Controllers */
 
+#define AT91RM9200_BASE_PIOA	0xfffff400	/* PIO Controller A */
+#define AT91RM9200_BASE_PIOB	0xfffff600	/* PIO Controller B */
+#define AT91RM9200_BASE_PIOC	0xfffff800	/* PIO Controller C */
+#define AT91RM9200_BASE_PIOD	0xfffffa00	/* PIO Controller D */
+
 #define AT91_USART0	AT91RM9200_BASE_US0
 #define AT91_USART1	AT91RM9200_BASE_US1
 #define AT91_USART2	AT91RM9200_BASE_US2
diff --git a/arch/arm/mach-at91/include/mach/at91sam9260.h b/arch/arm/mach-at91/include/mach/at91sam9260.h
index 9a79116..1bea3dc 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9260.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9260.h
@@ -87,9 +87,6 @@
 #define AT91_CCFG	(0xffffef10 - AT91_BASE_SYS)
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
 #define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
-#define AT91_PIOA	(0xfffff400 - AT91_BASE_SYS)
-#define AT91_PIOB	(0xfffff600 - AT91_BASE_SYS)
-#define AT91_PIOC	(0xfffff800 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
@@ -98,6 +95,10 @@
 #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
 
+#define AT91SAM9260_BASE_PIOA	0xfffff400
+#define AT91SAM9260_BASE_PIOB	0xfffff600
+#define AT91SAM9260_BASE_PIOC	0xfffff800
+
 #define AT91_USART0	AT91SAM9260_BASE_US0
 #define AT91_USART1	AT91SAM9260_BASE_US1
 #define AT91_USART2	AT91SAM9260_BASE_US2
diff --git a/arch/arm/mach-at91/include/mach/at91sam9261.h b/arch/arm/mach-at91/include/mach/at91sam9261.h
index ce59620..17ae9c7 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9261.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9261.h
@@ -70,9 +70,6 @@
 #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
 #define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
-#define AT91_PIOA	(0xfffff400 - AT91_BASE_SYS)
-#define AT91_PIOB	(0xfffff600 - AT91_BASE_SYS)
-#define AT91_PIOC	(0xfffff800 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
@@ -81,6 +78,10 @@
 #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
 
+#define AT91SAM9261_BASE_PIOA	0xfffff400
+#define AT91SAM9261_BASE_PIOB	0xfffff600
+#define AT91SAM9261_BASE_PIOC	0xfffff800
+
 #define AT91_USART0	AT91SAM9261_BASE_US0
 #define AT91_USART1	AT91SAM9261_BASE_US1
 #define AT91_USART2	AT91SAM9261_BASE_US2
diff --git a/arch/arm/mach-at91/include/mach/at91sam9263.h b/arch/arm/mach-at91/include/mach/at91sam9263.h
index f1b9296..dd54079 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9263.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9263.h
@@ -84,11 +84,6 @@
 #define AT91_CCFG	(0xffffed10 - AT91_BASE_SYS)
 #define AT91_DBGU	(0xffffee00 - AT91_BASE_SYS)
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
-#define AT91_PIOA	(0xfffff200 - AT91_BASE_SYS)
-#define AT91_PIOB	(0xfffff400 - AT91_BASE_SYS)
-#define AT91_PIOC	(0xfffff600 - AT91_BASE_SYS)
-#define AT91_PIOD	(0xfffff800 - AT91_BASE_SYS)
-#define AT91_PIOE	(0xfffffa00 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
@@ -98,6 +93,12 @@
 #define AT91_RTT1	(0xfffffd50 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
 
+#define AT91SAM9263_BASE_PIOA	0xfffff200
+#define AT91SAM9263_BASE_PIOB	0xfffff400
+#define AT91SAM9263_BASE_PIOC	0xfffff600
+#define AT91SAM9263_BASE_PIOD	0xfffff800
+#define AT91SAM9263_BASE_PIOE	0xfffffa00
+
 #define AT91_USART0	AT91SAM9263_BASE_US0
 #define AT91_USART1	AT91SAM9263_BASE_US1
 #define AT91_USART2	AT91SAM9263_BASE_US2
diff --git a/arch/arm/mach-at91/include/mach/at91sam9g45.h b/arch/arm/mach-at91/include/mach/at91sam9g45.h
index 2c611b9..ec370cc 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9g45.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9g45.h
@@ -94,11 +94,6 @@
 #define AT91_DMA	(0xffffec00 - AT91_BASE_SYS)
 #define AT91_DBGU	(0xffffee00 - AT91_BASE_SYS)
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
-#define AT91_PIOA	(0xfffff200 - AT91_BASE_SYS)
-#define AT91_PIOB	(0xfffff400 - AT91_BASE_SYS)
-#define AT91_PIOC	(0xfffff600 - AT91_BASE_SYS)
-#define AT91_PIOD	(0xfffff800 - AT91_BASE_SYS)
-#define AT91_PIOE	(0xfffffa00 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
@@ -108,6 +103,12 @@
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
 #define AT91_RTC	(0xfffffdb0 - AT91_BASE_SYS)
 
+#define AT91SAM9G45_BASE_PIOA	0xfffff200
+#define AT91SAM9G45_BASE_PIOB	0xfffff400
+#define AT91SAM9G45_BASE_PIOC	0xfffff600
+#define AT91SAM9G45_BASE_PIOD	0xfffff800
+#define AT91SAM9G45_BASE_PIOE	0xfffffa00
+
 #define AT91_USART0	AT91SAM9G45_BASE_US0
 #define AT91_USART1	AT91SAM9G45_BASE_US1
 #define AT91_USART2	AT91SAM9G45_BASE_US2
diff --git a/arch/arm/mach-at91/include/mach/at91sam9rl.h b/arch/arm/mach-at91/include/mach/at91sam9rl.h
index 1aabacd..d3ef11a 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9rl.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9rl.h
@@ -77,10 +77,6 @@
 #define AT91_CCFG	(0xffffef10 - AT91_BASE_SYS)
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
 #define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
-#define AT91_PIOA	(0xfffff400 - AT91_BASE_SYS)
-#define AT91_PIOB	(0xfffff600 - AT91_BASE_SYS)
-#define AT91_PIOC	(0xfffff800 - AT91_BASE_SYS)
-#define AT91_PIOD	(0xfffffa00 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
@@ -91,6 +87,11 @@
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
 #define AT91_RTC	(0xfffffe00 - AT91_BASE_SYS)
 
+#define AT91SAM9RL_BASE_PIOA	0xfffff400
+#define AT91SAM9RL_BASE_PIOB	0xfffff600
+#define AT91SAM9RL_BASE_PIOC	0xfffff800
+#define AT91SAM9RL_BASE_PIOD	0xfffffa00
+
 #define AT91_USART0	AT91SAM9RL_BASE_US0
 #define AT91_USART1	AT91SAM9RL_BASE_US1
 #define AT91_USART2	AT91SAM9RL_BASE_US2
-- 
1.7.7
