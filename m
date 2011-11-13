From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 13 Nov 2011 19:12:22 +0100
Subject: [PATCH 02/12] ARM: at91: make ecc register base soc independent
In-Reply-To: <20111113180954.GD15318@game.jcrosoft.org>
References: <20111113180954.GD15318@game.jcrosoft.org>
Message-ID: <1321207952-13556-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91cap9_devices.c         |    4 ++--
 arch/arm/mach-at91/at91sam9260_devices.c      |    4 ++--
 arch/arm/mach-at91/at91sam9263_devices.c      |    4 ++--
 arch/arm/mach-at91/at91sam9g45_devices.c      |    4 ++--
 arch/arm/mach-at91/at91sam9rl_devices.c       |    4 ++--
 arch/arm/mach-at91/include/mach/at91cap9.h    |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9260.h |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9263.h |    4 ++--
 arch/arm/mach-at91/include/mach/at91sam9g45.h |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9rl.h  |    2 +-
 10 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index adad70d..fb525f4 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -398,8 +398,8 @@ static struct resource nand_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= AT91_BASE_SYS + AT91_ECC,
-		.end	= AT91_BASE_SYS + AT91_ECC + SZ_512 - 1,
+		.start	= AT91CAP9_BASE_ECC,
+		.end	= AT91CAP9_BASE_ECC + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	}
 };
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 25e3464..067c168 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -399,8 +399,8 @@ static struct resource nand_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= AT91_BASE_SYS + AT91_ECC,
-		.end	= AT91_BASE_SYS + AT91_ECC + SZ_512 - 1,
+		.start	= AT91SAM9260_BASE_ECC,
+		.end	= AT91SAM9260_BASE_ECC + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	}
 };
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index ad017eb..0b1a28e 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -473,8 +473,8 @@ static struct resource nand_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= AT91_BASE_SYS + AT91_ECC0,
-		.end	= AT91_BASE_SYS + AT91_ECC0 + SZ_512 - 1,
+		.start	= AT91SAM9263_BASE_ECC0,
+		.end	= AT91SAM9263_BASE_ECC0 + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	}
 };
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 09a16d6..d19d720 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -529,8 +529,8 @@ static struct resource nand_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= AT91_BASE_SYS + AT91_ECC,
-		.end	= AT91_BASE_SYS + AT91_ECC + SZ_512 - 1,
+		.start	= AT91SAM9G45_BASE_ECC,
+		.end	= AT91SAM9G45_BASE_ECC + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	}
 };
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 628eb56..e63ab90 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -248,8 +248,8 @@ static struct resource nand_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= AT91_BASE_SYS + AT91_ECC,
-		.end	= AT91_BASE_SYS + AT91_ECC + SZ_512 - 1,
+		.start	= AT91SAM9RL_BASE_ECC,
+		.end	= AT91SAM9RL_BASE_ECC + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	}
 };
diff --git a/arch/arm/mach-at91/include/mach/at91cap9.h b/arch/arm/mach-at91/include/mach/at91cap9.h
index f65d083..5fd105d 100644
--- a/arch/arm/mach-at91/include/mach/at91cap9.h
+++ b/arch/arm/mach-at91/include/mach/at91cap9.h
@@ -79,7 +79,6 @@
 /*
  * System Peripherals (offset from AT91_BASE_SYS)
  */
-#define AT91_ECC	(0xffffe200 - AT91_BASE_SYS)
 #define AT91_BCRAMC	(0xffffe400 - AT91_BASE_SYS)
 #define AT91_DDRSDRC0	(0xffffe600 - AT91_BASE_SYS)
 #define AT91_SMC	(0xffffe800 - AT91_BASE_SYS)
@@ -98,6 +97,7 @@
 			(0xfffffd50 - AT91_BASE_SYS) :	\
 			(0xfffffd60 - AT91_BASE_SYS))
 
+#define AT91CAP9_BASE_ECC	0xffffe200
 #define AT91CAP9_BASE_PIOA	0xfffff200
 #define AT91CAP9_BASE_PIOB	0xfffff400
 #define AT91CAP9_BASE_PIOC	0xfffff600
diff --git a/arch/arm/mach-at91/include/mach/at91sam9260.h b/arch/arm/mach-at91/include/mach/at91sam9260.h
index 1bea3dc..6974656 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9260.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9260.h
@@ -80,7 +80,6 @@
 /*
  * System Peripherals (offset from AT91_BASE_SYS)
  */
-#define AT91_ECC	(0xffffe800 - AT91_BASE_SYS)
 #define AT91_SDRAMC0	(0xffffea00 - AT91_BASE_SYS)
 #define AT91_SMC	(0xffffec00 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
@@ -95,6 +94,7 @@
 #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
 
+#define AT91SAM9260_BASE_ECC	0xffffe800
 #define AT91SAM9260_BASE_PIOA	0xfffff400
 #define AT91SAM9260_BASE_PIOB	0xfffff600
 #define AT91SAM9260_BASE_PIOC	0xfffff800
diff --git a/arch/arm/mach-at91/include/mach/at91sam9263.h b/arch/arm/mach-at91/include/mach/at91sam9263.h
index dd54079..a668538 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9263.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9263.h
@@ -74,10 +74,8 @@
 /*
  * System Peripherals (offset from AT91_BASE_SYS)
  */
-#define AT91_ECC0	(0xffffe000 - AT91_BASE_SYS)
 #define AT91_SDRAMC0	(0xffffe200 - AT91_BASE_SYS)
 #define AT91_SMC0	(0xffffe400 - AT91_BASE_SYS)
-#define AT91_ECC1	(0xffffe600 - AT91_BASE_SYS)
 #define AT91_SDRAMC1	(0xffffe800 - AT91_BASE_SYS)
 #define AT91_SMC1	(0xffffea00 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffec00 - AT91_BASE_SYS)
@@ -93,6 +91,8 @@
 #define AT91_RTT1	(0xfffffd50 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
 
+#define AT91SAM9263_BASE_ECC0	0xffffe000
+#define AT91SAM9263_BASE_ECC1	0xffffe600
 #define AT91SAM9263_BASE_PIOA	0xfffff200
 #define AT91SAM9263_BASE_PIOB	0xfffff400
 #define AT91SAM9263_BASE_PIOC	0xfffff600
diff --git a/arch/arm/mach-at91/include/mach/at91sam9g45.h b/arch/arm/mach-at91/include/mach/at91sam9g45.h
index a487af5..3c0b7c1 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9g45.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9g45.h
@@ -86,7 +86,6 @@
 /*
  * System Peripherals (offset from AT91_BASE_SYS)
  */
-#define AT91_ECC	(0xffffe200 - AT91_BASE_SYS)
 #define AT91_DDRSDRC1	(0xffffe400 - AT91_BASE_SYS)
 #define AT91_DDRSDRC0	(0xffffe600 - AT91_BASE_SYS)
 #define AT91_SMC	(0xffffe800 - AT91_BASE_SYS)
@@ -103,6 +102,7 @@
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
 #define AT91_RTC	(0xfffffdb0 - AT91_BASE_SYS)
 
+#define AT91SAM9G45_BASE_ECC	0xffffe200
 #define AT91SAM9G45_BASE_PIOA	0xfffff200
 #define AT91SAM9G45_BASE_PIOB	0xfffff400
 #define AT91SAM9G45_BASE_PIOC	0xfffff600
diff --git a/arch/arm/mach-at91/include/mach/at91sam9rl.h b/arch/arm/mach-at91/include/mach/at91sam9rl.h
index d3ef11a..d9efe5a 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9rl.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9rl.h
@@ -70,7 +70,6 @@
  * System Peripherals (offset from AT91_BASE_SYS)
  */
 #define AT91_DMA	(0xffffe600 - AT91_BASE_SYS)
-#define AT91_ECC	(0xffffe800 - AT91_BASE_SYS)
 #define AT91_SDRAMC0	(0xffffea00 - AT91_BASE_SYS)
 #define AT91_SMC	(0xffffec00 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
@@ -87,6 +86,7 @@
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
 #define AT91_RTC	(0xfffffe00 - AT91_BASE_SYS)
 
+#define AT91SAM9RL_BASE_ECC	0xffffe800
 #define AT91SAM9RL_BASE_PIOA	0xfffff400
 #define AT91SAM9RL_BASE_PIOB	0xfffff600
 #define AT91SAM9RL_BASE_PIOC	0xfffff800
-- 
1.7.7
