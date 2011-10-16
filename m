From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 16 Oct 2011 21:50:51 +0200
Subject: [PATCH 1/8] ARM: at91/nand: make ecc register base soc independant
In-Reply-To: <20111016194504.GK1459@game.jcrosoft.org>
References: <20111016194504.GK1459@game.jcrosoft.org>
Message-ID: <1318794658-27907-1-git-send-email-plagnioj@jcrosoft.com>
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
index 97db597..7e2de2f 100644
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
index f00fed4..07a0240 100644
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
index a1b1354..08f1ed8 100644
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
index 3d0957f..c4afe08 100644
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
index 56cb73d..d8131b5 100644
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
index ec370cc..e75c4cc 100644
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
