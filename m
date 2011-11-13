From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 13 Nov 2011 19:12:23 +0100
Subject: [PATCH 03/12] ARM: at91: make dma register base soc independent
In-Reply-To: <20111113180954.GD15318@game.jcrosoft.org>
References: <20111113180954.GD15318@game.jcrosoft.org>
Message-ID: <1321207952-13556-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91sam9g45_devices.c      |    4 ++--
 arch/arm/mach-at91/at91sam9rl_devices.c       |    4 ++--
 arch/arm/mach-at91/include/mach/at91cap9.h    |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9g45.h |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9rl.h  |    2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index d19d720..42bf770 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -44,8 +44,8 @@ static struct at_dma_platform_data atdma_pdata = {
 
 static struct resource hdmac_resources[] = {
 	[0] = {
-		.start	= AT91_BASE_SYS + AT91_DMA,
-		.end	= AT91_BASE_SYS + AT91_DMA + SZ_512 - 1,
+		.start	= AT91SAM9G45_BASE_DMA,
+		.end	= AT91SAM9G45_BASE_DMA + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index e63ab90..34fe5dd 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -39,8 +39,8 @@ static struct at_dma_platform_data atdma_pdata = {
 
 static struct resource hdmac_resources[] = {
 	[0] = {
-		.start	= AT91_BASE_SYS + AT91_DMA,
-		.end	= AT91_BASE_SYS + AT91_DMA + SZ_512 - 1,
+		.start	= AT91SAM9RL_BASE_DMA,
+		.end	= AT91SAM9RL_BASE_DMA + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[2] = {
diff --git a/arch/arm/mach-at91/include/mach/at91cap9.h b/arch/arm/mach-at91/include/mach/at91cap9.h
index 5fd105d..a2eccb9 100644
--- a/arch/arm/mach-at91/include/mach/at91cap9.h
+++ b/arch/arm/mach-at91/include/mach/at91cap9.h
@@ -84,7 +84,6 @@
 #define AT91_SMC	(0xffffe800 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffea00 - AT91_BASE_SYS)
 #define AT91_CCFG	(0xffffeb10 - AT91_BASE_SYS)
-#define AT91_DMA	(0xffffec00 - AT91_BASE_SYS)
 #define AT91_DBGU	(0xffffee00 - AT91_BASE_SYS)
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
@@ -98,6 +97,7 @@
 			(0xfffffd60 - AT91_BASE_SYS))
 
 #define AT91CAP9_BASE_ECC	0xffffe200
+#define AT91CAP9_BASE_DMA	0xffffec00
 #define AT91CAP9_BASE_PIOA	0xfffff200
 #define AT91CAP9_BASE_PIOB	0xfffff400
 #define AT91CAP9_BASE_PIOC	0xfffff600
diff --git a/arch/arm/mach-at91/include/mach/at91sam9g45.h b/arch/arm/mach-at91/include/mach/at91sam9g45.h
index 3c0b7c1..29e577f 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9g45.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9g45.h
@@ -90,7 +90,6 @@
 #define AT91_DDRSDRC0	(0xffffe600 - AT91_BASE_SYS)
 #define AT91_SMC	(0xffffe800 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffea00 - AT91_BASE_SYS)
-#define AT91_DMA	(0xffffec00 - AT91_BASE_SYS)
 #define AT91_DBGU	(0xffffee00 - AT91_BASE_SYS)
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
@@ -103,6 +102,7 @@
 #define AT91_RTC	(0xfffffdb0 - AT91_BASE_SYS)
 
 #define AT91SAM9G45_BASE_ECC	0xffffe200
+#define AT91SAM9G45_BASE_DMA	0xffffec00
 #define AT91SAM9G45_BASE_PIOA	0xfffff200
 #define AT91SAM9G45_BASE_PIOB	0xfffff400
 #define AT91SAM9G45_BASE_PIOC	0xfffff600
diff --git a/arch/arm/mach-at91/include/mach/at91sam9rl.h b/arch/arm/mach-at91/include/mach/at91sam9rl.h
index d9efe5a..e564650 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9rl.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9rl.h
@@ -69,7 +69,6 @@
 /*
  * System Peripherals (offset from AT91_BASE_SYS)
  */
-#define AT91_DMA	(0xffffe600 - AT91_BASE_SYS)
 #define AT91_SDRAMC0	(0xffffea00 - AT91_BASE_SYS)
 #define AT91_SMC	(0xffffec00 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
@@ -86,6 +85,7 @@
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
 #define AT91_RTC	(0xfffffe00 - AT91_BASE_SYS)
 
+#define AT91SAM9RL_BASE_DMA	0xffffe600
 #define AT91SAM9RL_BASE_ECC	0xffffe800
 #define AT91SAM9RL_BASE_PIOA	0xfffff400
 #define AT91SAM9RL_BASE_PIOB	0xfffff600
-- 
1.7.7
