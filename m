From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 15 Nov 2011 21:40:43 +0100
Subject: [PATCH 10/13 v2] ARM: at91: make watchdog drivers soc independent
In-Reply-To: <20111113180954.GD15318@game.jcrosoft.org>
References: <20111113180954.GD15318@game.jcrosoft.org>
Message-ID: <1321389646-24112-12-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

switch the watchdog drivers to resource and pass it via platform_device

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
---
 arch/arm/mach-at91/at91cap9_devices.c         |   11 ++++++++++-
 arch/arm/mach-at91/at91sam9260_devices.c      |   11 ++++++++++-
 arch/arm/mach-at91/at91sam9261_devices.c      |   11 ++++++++++-
 arch/arm/mach-at91/at91sam9263_devices.c      |   11 ++++++++++-
 arch/arm/mach-at91/at91sam9g45_devices.c      |   11 ++++++++++-
 arch/arm/mach-at91/at91sam9rl_devices.c       |   11 ++++++++++-
 arch/arm/mach-at91/include/mach/at91cap9.h    |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9260.h |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9261.h |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9263.h |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9g45.h |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9rl.h  |    2 +-
 drivers/watchdog/at91sam9_wdt.c               |   22 +++++++++++++++++++---
 drivers/watchdog/at91sam9_wdt.h               |    6 +++---
 14 files changed, 88 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index 3262a7e..019dac0 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -694,10 +694,19 @@ static void __init at91_add_device_rtt(void)
  * -------------------------------------------------------------------- */
 
 #if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
+static struct resource wdt_resources[] = {
+	{
+		.start	= AT91CAP9_BASE_WDT,
+		.end	= AT91CAP9_BASE_WDT + SZ_16 - 1,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
 static struct platform_device at91cap9_wdt_device = {
 	.name		= "at91_wdt",
 	.id		= -1,
-	.num_resources	= 0,
+	.resource	= wdt_resources,
+	.num_resources	= ARRAY_SIZE(wdt_resources),
 };
 
 static void __init at91_add_device_watchdog(void)
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 63cbfb8..9cdaffa 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -738,10 +738,19 @@ static void __init at91_add_device_rtt(void)
  * -------------------------------------------------------------------- */
 
 #if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
+static struct resource wdt_resources[] = {
+	{
+		.start	= AT91SAM9260_BASE_WDT,
+		.end	= AT91SAM9260_BASE_WDT + SZ_16 - 1,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
 static struct platform_device at91sam9260_wdt_device = {
 	.name		= "at91_wdt",
 	.id		= -1,
-	.num_resources	= 0,
+	.resource	= wdt_resources,
+	.num_resources	= ARRAY_SIZE(wdt_resources),
 };
 
 static void __init at91_add_device_watchdog(void)
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index d5bd1e7..c59e1e9 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -624,10 +624,19 @@ static void __init at91_add_device_rtt(void)
  * -------------------------------------------------------------------- */
 
 #if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
+static struct resource wdt_resources[] = {
+	{
+		.start	= AT91SAM9261_BASE_WDT,
+		.end	= AT91SAM9261_BASE_WDT + SZ_16 - 1,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
 static struct platform_device at91sam9261_wdt_device = {
 	.name		= "at91_wdt",
 	.id		= -1,
-	.num_resources	= 0,
+	.resource	= wdt_resources,
+	.num_resources	= ARRAY_SIZE(wdt_resources),
 };
 
 static void __init at91_add_device_watchdog(void)
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 5d2b061..b5f4e25 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -996,10 +996,19 @@ static void __init at91_add_device_rtt(void)
  * -------------------------------------------------------------------- */
 
 #if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
+static struct resource wdt_resources[] = {
+	{
+		.start	= AT91SAM9263_BASE_WDT,
+		.end	= AT91SAM9263_BASE_WDT + SZ_16 - 1,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
 static struct platform_device at91sam9263_wdt_device = {
 	.name		= "at91_wdt",
 	.id		= -1,
-	.num_resources	= 0,
+	.resource	= wdt_resources,
+	.num_resources	= ARRAY_SIZE(wdt_resources),
 };
 
 static void __init at91_add_device_watchdog(void)
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index bb2ba0c..3b91706 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -1133,10 +1133,19 @@ static void __init at91_add_device_trng(void) {}
  * -------------------------------------------------------------------- */
 
 #if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
+static struct resource wdt_resources[] = {
+	{
+		.start	= AT91SAM9G45_BASE_WDT,
+		.end	= AT91SAM9G45_BASE_WDT + SZ_16 - 1,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
 static struct platform_device at91sam9g45_wdt_device = {
 	.name		= "at91_wdt",
 	.id		= -1,
-	.num_resources	= 0,
+	.resource	= wdt_resources,
+	.num_resources	= ARRAY_SIZE(wdt_resources),
 };
 
 static void __init at91_add_device_watchdog(void)
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index f9b423b..c7961b4 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -709,10 +709,19 @@ static void __init at91_add_device_rtt(void)
  * -------------------------------------------------------------------- */
 
 #if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
+static struct resource wdt_resources[] = {
+	{
+		.start	= AT91SAM9RL_BASE_WDT,
+		.end	= AT91SAM9RL_BASE_WDT + SZ_16 - 1,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
 static struct platform_device at91sam9rl_wdt_device = {
 	.name		= "at91_wdt",
 	.id		= -1,
-	.num_resources	= 0,
+	.resource	= wdt_resources,
+	.num_resources	= ARRAY_SIZE(wdt_resources),
 };
 
 static void __init at91_add_device_watchdog(void)
diff --git a/arch/arm/mach-at91/include/mach/at91cap9.h b/arch/arm/mach-at91/include/mach/at91cap9.h
index 5ac468c..750ba85 100644
--- a/arch/arm/mach-at91/include/mach/at91cap9.h
+++ b/arch/arm/mach-at91/include/mach/at91cap9.h
@@ -86,7 +86,6 @@
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
-#define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(cpu_is_at91cap9_revB() ?	\
 			(0xfffffd50 - AT91_BASE_SYS) :	\
 			(0xfffffd60 - AT91_BASE_SYS))
@@ -101,6 +100,7 @@
 #define AT91CAP9_BASE_SHDWC	0xfffffd10
 #define AT91CAP9_BASE_RTT	0xfffffd20
 #define AT91CAP9_BASE_PIT	0xfffffd30
+#define AT91CAP9_BASE_WDT	0xfffffd40
 
 #define AT91_USART0	AT91CAP9_BASE_US0
 #define AT91_USART1	AT91CAP9_BASE_US1
diff --git a/arch/arm/mach-at91/include/mach/at91sam9260.h b/arch/arm/mach-at91/include/mach/at91sam9260.h
index e3c819a..05860c5 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9260.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9260.h
@@ -86,7 +86,6 @@
 #define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
-#define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
 
 #define AT91SAM9260_BASE_ECC	0xffffe800
@@ -97,6 +96,7 @@
 #define AT91SAM9260_BASE_SHDWC	0xfffffd10
 #define AT91SAM9260_BASE_RTT	0xfffffd20
 #define AT91SAM9260_BASE_PIT	0xfffffd30
+#define AT91SAM9260_BASE_WDT	0xfffffd40
 
 #define AT91_USART0	AT91SAM9260_BASE_US0
 #define AT91_USART1	AT91SAM9260_BASE_US1
diff --git a/arch/arm/mach-at91/include/mach/at91sam9261.h b/arch/arm/mach-at91/include/mach/at91sam9261.h
index f9b5163..df2ddfd 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9261.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9261.h
@@ -71,7 +71,6 @@
 #define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
-#define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
 
 #define AT91SAM9261_BASE_SMC	0xffffec00
@@ -81,6 +80,7 @@
 #define AT91SAM9261_BASE_SHDWC	0xfffffd10
 #define AT91SAM9261_BASE_RTT	0xfffffd20
 #define AT91SAM9261_BASE_PIT	0xfffffd30
+#define AT91SAM9261_BASE_WDT	0xfffffd40
 
 #define AT91_USART0	AT91SAM9261_BASE_US0
 #define AT91_USART1	AT91SAM9261_BASE_US1
diff --git a/arch/arm/mach-at91/include/mach/at91sam9263.h b/arch/arm/mach-at91/include/mach/at91sam9263.h
index 28d52d5..0eb614e 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9263.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9263.h
@@ -81,7 +81,6 @@
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
-#define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
 
 #define AT91SAM9263_BASE_ECC0	0xffffe000
@@ -96,6 +95,7 @@
 #define AT91SAM9263_BASE_SHDWC	0xfffffd10
 #define AT91SAM9263_BASE_RTT0	0xfffffd20
 #define AT91SAM9263_BASE_PIT	0xfffffd30
+#define AT91SAM9263_BASE_WDT	0xfffffd40
 #define AT91SAM9263_BASE_RTT1	0xfffffd50
 
 #define AT91_USART0	AT91SAM9263_BASE_US0
diff --git a/arch/arm/mach-at91/include/mach/at91sam9g45.h b/arch/arm/mach-at91/include/mach/at91sam9g45.h
index 5f3453e..65098c3 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9g45.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9g45.h
@@ -93,7 +93,6 @@
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
-#define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
 #define AT91_RTC	(0xfffffdb0 - AT91_BASE_SYS)
 
@@ -108,6 +107,7 @@
 #define AT91SAM9G45_BASE_SHDWC	0xfffffd10
 #define AT91SAM9G45_BASE_RTT	0xfffffd20
 #define AT91SAM9G45_BASE_PIT	0xfffffd30
+#define AT91SAM9G45_BASE_WDT	0xfffffd40
 
 #define AT91_USART0	AT91SAM9G45_BASE_US0
 #define AT91_USART1	AT91SAM9G45_BASE_US1
diff --git a/arch/arm/mach-at91/include/mach/at91sam9rl.h b/arch/arm/mach-at91/include/mach/at91sam9rl.h
index 6f3a4ee..46e136d 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9rl.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9rl.h
@@ -75,7 +75,6 @@
 #define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
-#define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_SCKCR	(0xfffffd50 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
 #define AT91_RTC	(0xfffffe00 - AT91_BASE_SYS)
@@ -90,6 +89,7 @@
 #define AT91SAM9RL_BASE_SHDWC	0xfffffd10
 #define AT91SAM9RL_BASE_RTT	0xfffffd20
 #define AT91SAM9RL_BASE_PIT	0xfffffd30
+#define AT91SAM9RL_BASE_WDT	0xfffffd40
 
 #define AT91_USART0	AT91SAM9RL_BASE_US0
 #define AT91_USART1	AT91SAM9RL_BASE_US1
diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 87445b2..0056256 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -35,6 +35,11 @@
 
 #define DRV_NAME "AT91SAM9 Watchdog"
 
+#define wdt_read(field) \
+	__raw_readl(at91wdt_private.base + field)
+#define wdt_write(field, val) \
+	__raw_writel((val), at91wdt_private.base + field)
+
 /* AT91SAM9 watchdog runs a 12bit counter @ 256Hz,
  * use this to convert a watchdog
  * value from/to milliseconds.
@@ -63,6 +68,7 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
 static void at91_ping(unsigned long data);
 
 static struct {
+	void __iomem *base;
 	unsigned long next_heartbeat;	/* the next_heartbeat for the timer */
 	unsigned long open;
 	char expect_close;
@@ -77,7 +83,7 @@ static struct {
  */
 static inline void at91_wdt_reset(void)
 {
-	at91_sys_write(AT91_WDT_CR, AT91_WDT_KEY | AT91_WDT_WDRSTT);
+	wdt_write(AT91_WDT_CR, AT91_WDT_KEY | AT91_WDT_WDRSTT);
 }
 
 /*
@@ -132,7 +138,7 @@ static int at91_wdt_settimeout(unsigned int timeout)
 	unsigned int mr;
 
 	/* Check if disabled */
-	mr = at91_sys_read(AT91_WDT_MR);
+	mr = wdt_read(AT91_WDT_MR);
 	if (mr & AT91_WDT_WDDIS) {
 		printk(KERN_ERR DRV_NAME": sorry, watchdog is disabled\n");
 		return -EIO;
@@ -149,7 +155,7 @@ static int at91_wdt_settimeout(unsigned int timeout)
 		| AT91_WDT_WDDBGHLT	/* disabled in debug mode */
 		| AT91_WDT_WDD		/* restart at any time */
 		| (timeout & AT91_WDT_WDV);  /* timer value */
-	at91_sys_write(AT91_WDT_MR, reg);
+	wdt_write(AT91_WDT_MR, reg);
 
 	return 0;
 }
@@ -248,12 +254,22 @@ static struct miscdevice at91wdt_miscdev = {
 
 static int __init at91wdt_probe(struct platform_device *pdev)
 {
+	struct resource	*r;
 	int res;
 
 	if (at91wdt_miscdev.parent)
 		return -EBUSY;
 	at91wdt_miscdev.parent = &pdev->dev;
 
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r)
+		return -ENODEV;
+	at91wdt_private.base = ioremap(r->start, resource_size(r));
+	if (!at91wdt_private.base) {
+		dev_err(&pdev->dev, "failed to map registers, aborting.\n");
+		return -ENOMEM;
+	}
+
 	/* Set watchdog */
 	res = at91_wdt_settimeout(ms_to_ticks(WDT_HW_TIMEOUT * 1000));
 	if (res)
diff --git a/drivers/watchdog/at91sam9_wdt.h b/drivers/watchdog/at91sam9_wdt.h
index 757f9ca..c6fbb2e6 100644
--- a/drivers/watchdog/at91sam9_wdt.h
+++ b/drivers/watchdog/at91sam9_wdt.h
@@ -16,11 +16,11 @@
 #ifndef AT91_WDT_H
 #define AT91_WDT_H
 
-#define AT91_WDT_CR		(AT91_WDT + 0x00)	/* Watchdog Control Register */
+#define AT91_WDT_CR		0x00			/* Watchdog Control Register */
 #define		AT91_WDT_WDRSTT		(1    << 0)		/* Restart */
 #define		AT91_WDT_KEY		(0xa5 << 24)		/* KEY Password */
 
-#define AT91_WDT_MR		(AT91_WDT + 0x04)	/* Watchdog Mode Register */
+#define AT91_WDT_MR		0x04			/* Watchdog Mode Register */
 #define		AT91_WDT_WDV		(0xfff << 0)		/* Counter Value */
 #define		AT91_WDT_WDFIEN		(1     << 12)		/* Fault Interrupt Enable */
 #define		AT91_WDT_WDRSTEN	(1     << 13)		/* Reset Processor */
@@ -30,7 +30,7 @@
 #define		AT91_WDT_WDDBGHLT	(1     << 28)		/* Debug Halt */
 #define		AT91_WDT_WDIDLEHLT	(1     << 29)		/* Idle Halt */
 
-#define AT91_WDT_SR		(AT91_WDT + 0x08)	/* Watchdog Status Register */
+#define AT91_WDT_SR		0x08			/* Watchdog Status Register */
 #define		AT91_WDT_WDUNF		(1 << 0)		/* Watchdog Underflow */
 #define		AT91_WDT_WDERR		(1 << 1)		/* Watchdog Error */
 
-- 
1.7.7
