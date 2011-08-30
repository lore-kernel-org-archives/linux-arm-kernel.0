From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 30 Aug 2011 21:27:29 +0900
Subject: [PATCH 7/7] ARM: SAMSUNG: Remove useless Samsung GPIO related CONFIGs
In-Reply-To: <1314707249-12241-1-git-send-email-kgene.kim@samsung.com>
References: <1314707249-12241-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1314707249-12241-8-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/Kconfig              |    3 ---
 arch/arm/mach-s3c2410/Kconfig |    1 -
 arch/arm/mach-s3c2416/Kconfig |    1 -
 arch/arm/mach-s3c2440/Kconfig |    2 --
 arch/arm/mach-s3c2443/Kconfig |    1 -
 arch/arm/plat-s3c24xx/Kconfig |    1 -
 arch/arm/plat-s5p/Kconfig     |    3 ---
 arch/arm/plat-samsung/Kconfig |   27 ---------------------------
 8 files changed, 0 insertions(+), 39 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5ebc5d9..b6fb00c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -724,9 +724,6 @@ config ARCH_S3C64XX
 	select SAMSUNG_IRQ_VIC_TIMER
 	select SAMSUNG_IRQ_UART
 	select S3C_GPIO_TRACK
-	select S3C_GPIO_PULL_UPDOWN
-	select S3C_GPIO_CFG_S3C24XX
-	select S3C_GPIO_CFG_S3C64XX
 	select S3C_DEV_NAND
 	select USB_ARCH_HAS_OHCI
 	select SAMSUNG_GPIOLIB_4BIT
diff --git a/arch/arm/mach-s3c2410/Kconfig b/arch/arm/mach-s3c2410/Kconfig
index 3700cf3..5261a7e 100644
--- a/arch/arm/mach-s3c2410/Kconfig
+++ b/arch/arm/mach-s3c2410/Kconfig
@@ -6,7 +6,6 @@ config CPU_S3C2410
 	bool
 	depends on ARCH_S3C2410
 	select CPU_ARM920T
-	select S3C_GPIO_PULL_UP
 	select S3C2410_CLOCK
 	select CPU_LLSERIAL_S3C2410
 	select S3C2410_PM if PM
diff --git a/arch/arm/mach-s3c2416/Kconfig b/arch/arm/mach-s3c2416/Kconfig
index 69b48a7..84c7b03 100644
--- a/arch/arm/mach-s3c2416/Kconfig
+++ b/arch/arm/mach-s3c2416/Kconfig
@@ -13,7 +13,6 @@ config CPU_S3C2416
 	select CPU_ARM926T
 	select S3C2416_DMA if S3C2410_DMA
 	select CPU_LLSERIAL_S3C2440
-	select S3C_GPIO_PULL_UPDOWN
 	select SAMSUNG_CLKSRC
 	select S3C2443_CLOCK
 	help
diff --git a/arch/arm/mach-s3c2440/Kconfig b/arch/arm/mach-s3c2440/Kconfig
index c461fb8..914e620 100644
--- a/arch/arm/mach-s3c2440/Kconfig
+++ b/arch/arm/mach-s3c2440/Kconfig
@@ -5,7 +5,6 @@
 config CPU_S3C2440
 	bool
 	select CPU_ARM920T
-	select S3C_GPIO_PULL_UP
 	select S3C2410_CLOCK
 	select S3C2410_PM if PM
 	select S3C2440_DMA if S3C2410_DMA
@@ -17,7 +16,6 @@ config CPU_S3C2440
 config CPU_S3C2442
 	bool
 	select CPU_ARM920T
-	select S3C_GPIO_PULL_DOWN
 	select S3C2410_CLOCK
 	select S3C2410_PM if PM
 	select CPU_S3C244X
diff --git a/arch/arm/mach-s3c2443/Kconfig b/arch/arm/mach-s3c2443/Kconfig
index d8eb868..8814031 100644
--- a/arch/arm/mach-s3c2443/Kconfig
+++ b/arch/arm/mach-s3c2443/Kconfig
@@ -10,7 +10,6 @@ config CPU_S3C2443
 	select CPU_LLSERIAL_S3C2440
 	select SAMSUNG_CLKSRC
 	select S3C2443_CLOCK
-	select S3C_GPIO_PULL_S3C2443
 	help
 	  Support for the S3C2443 SoC from the S3C24XX line
 
diff --git a/arch/arm/plat-s3c24xx/Kconfig b/arch/arm/plat-s3c24xx/Kconfig
index 8c5b302..d8973ac 100644
--- a/arch/arm/plat-s3c24xx/Kconfig
+++ b/arch/arm/plat-s3c24xx/Kconfig
@@ -9,7 +9,6 @@ config PLAT_S3C24XX
 	select NO_IOPORT
 	select ARCH_REQUIRE_GPIOLIB
 	select S3C_DEV_NAND
-	select S3C_GPIO_CFG_S3C24XX
 	help
 	  Base platform code for any Samsung S3C24XX device
 
diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index 9843c95..ac610be 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -16,9 +16,6 @@ config PLAT_S5P
 	select S3C_GPIO_TRACK
 	select S5P_GPIO_DRVSTR
 	select SAMSUNG_GPIOLIB_4BIT
-	select S3C_GPIO_CFG_S3C64XX
-	select S3C_GPIO_PULL_UPDOWN
-	select S3C_GPIO_CFG_S3C24XX
 	select PLAT_SAMSUNG
 	select SAMSUNG_CLKSRC
 	select SAMSUNG_IRQ_VIC_TIMER
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index b3e1065..1f346d2 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -79,39 +79,12 @@ config SAMSUNG_GPIOLIB_4BIT
 	  configuration. GPIOlib shall be compiled only for S3C64XX and S5P
 	  series of processors.
 
-config S3C_GPIO_CFG_S3C24XX
-	bool
-	help
-	  Internal configuration to enable S3C24XX style GPIO configuration
-	  functions.
-
 config S3C_GPIO_CFG_S3C64XX
 	bool
 	help
 	  Internal configuration to enable S3C64XX style GPIO configuration
 	  functions.
 
-config S3C_GPIO_PULL_UPDOWN
-	bool
-	help
-	  Internal configuration to enable the correct GPIO pull helper
-
-config S3C_GPIO_PULL_S3C2443
-	bool
-	select S3C_GPIO_PULL_UPDOWN
-	help
-	  Internal configuration to enable the correct GPIO pull helper for S3C2443-style GPIO
-
-config S3C_GPIO_PULL_DOWN
-	bool
-	help
-	  Internal configuration to enable the correct GPIO pull helper
-
-config S3C_GPIO_PULL_UP
-	bool
-	help
-	  Internal configuration to enable the correct GPIO pull helper
-
 config S5P_GPIO_DRVSTR
 	bool
 	help
-- 
1.7.1
