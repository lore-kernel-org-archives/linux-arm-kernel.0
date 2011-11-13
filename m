From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 13 Nov 2011 19:12:24 +0100
Subject: [PATCH 04/12] ARM: at91: make rtt register base soc independent
In-Reply-To: <20111113180954.GD15318@game.jcrosoft.org>
References: <20111113180954.GD15318@game.jcrosoft.org>
Message-ID: <1321207952-13556-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91cap9_devices.c         |    4 ++--
 arch/arm/mach-at91/at91sam9260_devices.c      |    4 ++--
 arch/arm/mach-at91/at91sam9261_devices.c      |    4 ++--
 arch/arm/mach-at91/at91sam9263_devices.c      |    8 ++++----
 arch/arm/mach-at91/at91sam9g45_devices.c      |    4 ++--
 arch/arm/mach-at91/at91sam9rl_devices.c       |    4 ++--
 arch/arm/mach-at91/include/mach/at91cap9.h    |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9260.h |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9261.h |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9263.h |    4 ++--
 arch/arm/mach-at91/include/mach/at91sam9g45.h |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9rl.h  |    2 +-
 12 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index fb525f4..3262a7e 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -670,8 +670,8 @@ static void __init at91_add_device_tc(void) { }
 
 static struct resource rtt_resources[] = {
 	{
-		.start	= AT91_BASE_SYS + AT91_RTT,
-		.end	= AT91_BASE_SYS + AT91_RTT + SZ_16 - 1,
+		.start	= AT91CAP9_BASE_RTT,
+		.end	= AT91CAP9_BASE_RTT + SZ_16 - 1,
 		.flags	= IORESOURCE_MEM,
 	}
 };
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 067c168..63cbfb8 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -714,8 +714,8 @@ static void __init at91_add_device_tc(void) { }
 
 static struct resource rtt_resources[] = {
 	{
-		.start	= AT91_BASE_SYS + AT91_RTT,
-		.end	= AT91_BASE_SYS + AT91_RTT + SZ_16 - 1,
+		.start	= AT91SAM9260_BASE_RTT,
+		.end	= AT91SAM9260_BASE_RTT + SZ_16 - 1,
 		.flags	= IORESOURCE_MEM,
 	}
 };
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index ae78f4d..d5bd1e7 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -600,8 +600,8 @@ static void __init at91_add_device_tc(void) { }
 
 static struct resource rtt_resources[] = {
 	{
-		.start	= AT91_BASE_SYS + AT91_RTT,
-		.end	= AT91_BASE_SYS + AT91_RTT + SZ_16 - 1,
+		.start	= AT91SAM9261_BASE_RTT,
+		.end	= AT91SAM9261_BASE_RTT + SZ_16 - 1,
 		.flags	= IORESOURCE_MEM,
 	}
 };
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 0b1a28e..5d2b061 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -956,8 +956,8 @@ static void __init at91_add_device_tc(void) { }
 
 static struct resource rtt0_resources[] = {
 	{
-		.start	= AT91_BASE_SYS + AT91_RTT0,
-		.end	= AT91_BASE_SYS + AT91_RTT0 + SZ_16 - 1,
+		.start	= AT91SAM9263_BASE_RTT0,
+		.end	= AT91SAM9263_BASE_RTT0 + SZ_16 - 1,
 		.flags	= IORESOURCE_MEM,
 	}
 };
@@ -971,8 +971,8 @@ static struct platform_device at91sam9263_rtt0_device = {
 
 static struct resource rtt1_resources[] = {
 	{
-		.start	= AT91_BASE_SYS + AT91_RTT1,
-		.end	= AT91_BASE_SYS + AT91_RTT1 + SZ_16 - 1,
+		.start	= AT91SAM9263_BASE_RTT1,
+		.end	= AT91SAM9263_BASE_RTT1 + SZ_16 - 1,
 		.flags	= IORESOURCE_MEM,
 	}
 };
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 42bf770..bb2ba0c 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -1081,8 +1081,8 @@ void __init at91_add_device_tsadcc(struct at91_tsadcc_data *data) {}
 
 static struct resource rtt_resources[] = {
 	{
-		.start	= AT91_BASE_SYS + AT91_RTT,
-		.end	= AT91_BASE_SYS + AT91_RTT + SZ_16 - 1,
+		.start	= AT91SAM9G45_BASE_RTT,
+		.end	= AT91SAM9G45_BASE_RTT + SZ_16 - 1,
 		.flags	= IORESOURCE_MEM,
 	}
 };
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 34fe5dd..f9b423b 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -685,8 +685,8 @@ static void __init at91_add_device_rtc(void) {}
 
 static struct resource rtt_resources[] = {
 	{
-		.start	= AT91_BASE_SYS + AT91_RTT,
-		.end	= AT91_BASE_SYS + AT91_RTT + SZ_16 - 1,
+		.start	= AT91SAM9RL_BASE_RTT,
+		.end	= AT91SAM9RL_BASE_RTT + SZ_16 - 1,
 		.flags	= IORESOURCE_MEM,
 	}
 };
diff --git a/arch/arm/mach-at91/include/mach/at91cap9.h b/arch/arm/mach-at91/include/mach/at91cap9.h
index a2eccb9..1cb42a6 100644
--- a/arch/arm/mach-at91/include/mach/at91cap9.h
+++ b/arch/arm/mach-at91/include/mach/at91cap9.h
@@ -89,7 +89,6 @@
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
-#define AT91_RTT	(0xfffffd20 - AT91_BASE_SYS)
 #define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
 #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(cpu_is_at91cap9_revB() ?	\
@@ -102,6 +101,7 @@
 #define AT91CAP9_BASE_PIOB	0xfffff400
 #define AT91CAP9_BASE_PIOC	0xfffff600
 #define AT91CAP9_BASE_PIOD	0xfffff800
+#define AT91CAP9_BASE_RTT	0xfffffd20
 
 #define AT91_USART0	AT91CAP9_BASE_US0
 #define AT91_USART1	AT91CAP9_BASE_US1
diff --git a/arch/arm/mach-at91/include/mach/at91sam9260.h b/arch/arm/mach-at91/include/mach/at91sam9260.h
index 6974656..6aa7ca9 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9260.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9260.h
@@ -89,7 +89,6 @@
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
-#define AT91_RTT	(0xfffffd20 - AT91_BASE_SYS)
 #define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
 #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
@@ -98,6 +97,7 @@
 #define AT91SAM9260_BASE_PIOA	0xfffff400
 #define AT91SAM9260_BASE_PIOB	0xfffff600
 #define AT91SAM9260_BASE_PIOC	0xfffff800
+#define AT91SAM9260_BASE_RTT	0xfffffd20
 
 #define AT91_USART0	AT91SAM9260_BASE_US0
 #define AT91_USART1	AT91SAM9260_BASE_US1
diff --git a/arch/arm/mach-at91/include/mach/at91sam9261.h b/arch/arm/mach-at91/include/mach/at91sam9261.h
index 17ae9c7..f84b713 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9261.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9261.h
@@ -73,7 +73,6 @@
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
-#define AT91_RTT	(0xfffffd20 - AT91_BASE_SYS)
 #define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
 #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
@@ -81,6 +80,7 @@
 #define AT91SAM9261_BASE_PIOA	0xfffff400
 #define AT91SAM9261_BASE_PIOB	0xfffff600
 #define AT91SAM9261_BASE_PIOC	0xfffff800
+#define AT91SAM9261_BASE_RTT	0xfffffd20
 
 #define AT91_USART0	AT91SAM9261_BASE_US0
 #define AT91_USART1	AT91SAM9261_BASE_US1
diff --git a/arch/arm/mach-at91/include/mach/at91sam9263.h b/arch/arm/mach-at91/include/mach/at91sam9263.h
index a668538..938965e 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9263.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9263.h
@@ -85,10 +85,8 @@
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
-#define AT91_RTT0	(0xfffffd20 - AT91_BASE_SYS)
 #define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
 #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
-#define AT91_RTT1	(0xfffffd50 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
 
 #define AT91SAM9263_BASE_ECC0	0xffffe000
@@ -98,6 +96,8 @@
 #define AT91SAM9263_BASE_PIOC	0xfffff600
 #define AT91SAM9263_BASE_PIOD	0xfffff800
 #define AT91SAM9263_BASE_PIOE	0xfffffa00
+#define AT91SAM9263_BASE_RTT0	0xfffffd20
+#define AT91SAM9263_BASE_RTT1	0xfffffd50
 
 #define AT91_USART0	AT91SAM9263_BASE_US0
 #define AT91_USART1	AT91SAM9263_BASE_US1
diff --git a/arch/arm/mach-at91/include/mach/at91sam9g45.h b/arch/arm/mach-at91/include/mach/at91sam9g45.h
index 29e577f..00638c6 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9g45.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9g45.h
@@ -95,7 +95,6 @@
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
-#define AT91_RTT	(0xfffffd20 - AT91_BASE_SYS)
 #define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
 #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
@@ -108,6 +107,7 @@
 #define AT91SAM9G45_BASE_PIOC	0xfffff600
 #define AT91SAM9G45_BASE_PIOD	0xfffff800
 #define AT91SAM9G45_BASE_PIOE	0xfffffa00
+#define AT91SAM9G45_BASE_RTT	0xfffffd20
 
 #define AT91_USART0	AT91SAM9G45_BASE_US0
 #define AT91_USART1	AT91SAM9G45_BASE_US1
diff --git a/arch/arm/mach-at91/include/mach/at91sam9rl.h b/arch/arm/mach-at91/include/mach/at91sam9rl.h
index e564650..099cefc 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9rl.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9rl.h
@@ -78,7 +78,6 @@
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
-#define AT91_RTT	(0xfffffd20 - AT91_BASE_SYS)
 #define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
 #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_SCKCR	(0xfffffd50 - AT91_BASE_SYS)
@@ -91,6 +90,7 @@
 #define AT91SAM9RL_BASE_PIOB	0xfffff600
 #define AT91SAM9RL_BASE_PIOC	0xfffff800
 #define AT91SAM9RL_BASE_PIOD	0xfffffa00
+#define AT91SAM9RL_BASE_RTT	0xfffffd20
 
 #define AT91_USART0	AT91SAM9RL_BASE_US0
 #define AT91_USART1	AT91SAM9RL_BASE_US1
-- 
1.7.7
