From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 01 Jul 2014 19:21:15 +0900
Subject: [PATCH 01/17] ARM: S5P64X0: no more support S5P6440 and S5P6450 SoCs
Message-ID: <1404210076-2362-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes supporting codes for s5p6440 and s5p6450 because
seems no more used now. And if its supporting is required, DT based
codes should be supprted next time.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
Note: This is resending because previous sending has been rejected from ml
because of big changes so re-created with using -D as per Arnd's suggestion.

 Documentation/arm/Samsung/Overview.txt           |    2 -
 arch/arm/Kconfig                                 |   22 +-
 arch/arm/Makefile                                |    1 -
 arch/arm/configs/s5p64x0_defconfig               |   68 ---
 arch/arm/mach-s5p64x0/Kconfig                    |  102 ----
 arch/arm/mach-s5p64x0/Makefile                   |   36 --
 arch/arm/mach-s5p64x0/Makefile.boot              |    2 -
 arch/arm/mach-s5p64x0/clock-s5p6440.c            |  632 -------------------
 arch/arm/mach-s5p64x0/clock-s5p6450.c            |  701 ----------------------
 arch/arm/mach-s5p64x0/clock.c                    |  236 --------
 arch/arm/mach-s5p64x0/clock.h                    |   38 --
 arch/arm/mach-s5p64x0/common.c                   |  490 ---------------
 arch/arm/mach-s5p64x0/common.h                   |   56 --
 arch/arm/mach-s5p64x0/dev-audio.c                |  176 ------
 arch/arm/mach-s5p64x0/dma.c                      |  128 ----
 arch/arm/mach-s5p64x0/i2c.h                      |   16 -
 arch/arm/mach-s5p64x0/include/mach/debug-macro.S |   32 -
 arch/arm/mach-s5p64x0/include/mach/dma.h         |   26 -
 arch/arm/mach-s5p64x0/include/mach/gpio.h        |  132 ----
 arch/arm/mach-s5p64x0/include/mach/hardware.h    |   18 -
 arch/arm/mach-s5p64x0/include/mach/irqs.h        |  148 -----
 arch/arm/mach-s5p64x0/include/mach/map.h         |   96 ---
 arch/arm/mach-s5p64x0/include/mach/pm-core.h     |  119 ----
 arch/arm/mach-s5p64x0/include/mach/regs-clock.h  |   98 ---
 arch/arm/mach-s5p64x0/include/mach/regs-gpio.h   |   68 ---
 arch/arm/mach-s5p64x0/include/mach/regs-irq.h    |   18 -
 arch/arm/mach-s5p64x0/irq-pm.c                   |   98 ---
 arch/arm/mach-s5p64x0/mach-smdk6440.c            |  280 ---------
 arch/arm/mach-s5p64x0/mach-smdk6450.c            |  299 ---------
 arch/arm/mach-s5p64x0/pm.c                       |  202 -------
 arch/arm/mach-s5p64x0/setup-fb-24bpp.c           |   29 -
 arch/arm/mach-s5p64x0/setup-i2c0.c               |   38 --
 arch/arm/mach-s5p64x0/setup-i2c1.c               |   38 --
 arch/arm/mach-s5p64x0/setup-sdhci-gpio.c         |  104 ----
 arch/arm/mach-s5p64x0/setup-spi.c                |   38 --
 arch/arm/plat-samsung/Kconfig                    |   14 +-
 arch/arm/plat-samsung/adc.c                      |    2 +-
 arch/arm/plat-samsung/include/plat/cpu.h         |   19 -
 arch/arm/plat-samsung/include/plat/devs.h        |    9 -
 arch/arm/plat-samsung/include/plat/fb.h          |    7 -
 arch/arm/plat-samsung/include/plat/sdhci.h       |   43 --
 41 files changed, 8 insertions(+), 4673 deletions(-)
 delete mode 100644 arch/arm/configs/s5p64x0_defconfig
 delete mode 100644 arch/arm/mach-s5p64x0/Kconfig
 delete mode 100644 arch/arm/mach-s5p64x0/Makefile
 delete mode 100644 arch/arm/mach-s5p64x0/Makefile.boot
 delete mode 100644 arch/arm/mach-s5p64x0/clock-s5p6440.c
 delete mode 100644 arch/arm/mach-s5p64x0/clock-s5p6450.c
 delete mode 100644 arch/arm/mach-s5p64x0/clock.c
 delete mode 100644 arch/arm/mach-s5p64x0/clock.h
 delete mode 100644 arch/arm/mach-s5p64x0/common.c
 delete mode 100644 arch/arm/mach-s5p64x0/common.h
 delete mode 100644 arch/arm/mach-s5p64x0/dev-audio.c
 delete mode 100644 arch/arm/mach-s5p64x0/dma.c
 delete mode 100644 arch/arm/mach-s5p64x0/i2c.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/dma.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/map.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/pm-core.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/regs-clock.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/regs-gpio.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/regs-irq.h
 delete mode 100644 arch/arm/mach-s5p64x0/irq-pm.c
 delete mode 100644 arch/arm/mach-s5p64x0/mach-smdk6440.c
 delete mode 100644 arch/arm/mach-s5p64x0/mach-smdk6450.c
 delete mode 100644 arch/arm/mach-s5p64x0/pm.c
 delete mode 100644 arch/arm/mach-s5p64x0/setup-fb-24bpp.c
 delete mode 100644 arch/arm/mach-s5p64x0/setup-i2c0.c
 delete mode 100644 arch/arm/mach-s5p64x0/setup-i2c1.c
 delete mode 100644 arch/arm/mach-s5p64x0/setup-sdhci-gpio.c
 delete mode 100644 arch/arm/mach-s5p64x0/setup-spi.c

diff --git a/Documentation/arm/Samsung/Overview.txt b/Documentation/arm/Samsung/Overview.txt
index 658abb2..66edb1e 100644
--- a/Documentation/arm/Samsung/Overview.txt
+++ b/Documentation/arm/Samsung/Overview.txt
@@ -13,7 +13,6 @@ Introduction
 
   - S3C24XX: See Documentation/arm/Samsung-S3C24XX/Overview.txt for full list
   - S3C64XX: S3C6400 and S3C6410
-  - S5P6440
   - S5PC100
   - S5PC110 / S5PV210
 
@@ -34,7 +33,6 @@ Configuration
   A number of configurations are supplied, as there is no current way of
   unifying all the SoCs into one kernel.
 
-  s5p6440_defconfig - S5P6440 specific default configuration
   s5pc100_defconfig - S5PC100 specific default configuration
   s5pc110_defconfig - S5PC110 specific default configuration
   s5pv210_defconfig - S5PV210 specific default configuration
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 245058b..48be04b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -758,24 +758,6 @@ config ARCH_S3C64XX
 	help
 	  Samsung S3C64XX series based systems
 
-config ARCH_S5P64X0
-	bool "Samsung S5P6440 S5P6450"
-	select ATAGS
-	select CLKDEV_LOOKUP
-	select CLKSRC_SAMSUNG_PWM
-	select CPU_V6
-	select GENERIC_CLOCKEVENTS
-	select GPIO_SAMSUNG
-	select HAVE_S3C2410_I2C if I2C
-	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-	select HAVE_S3C_RTC if RTC_CLASS
-	select NEED_MACH_GPIO_H
-	select SAMSUNG_ATAGS
-	select SAMSUNG_WDT_RESET
-	help
-	  Samsung S5P64X0 CPU based systems, such as the Samsung SMDK6440,
-	  SMDK6450.
-
 config ARCH_S5PC100
 	bool "Samsung S5PC100"
 	select ARCH_REQUIRE_GPIOLIB
@@ -1004,8 +986,6 @@ source "arch/arm/mach-s3c24xx/Kconfig"
 
 source "arch/arm/mach-s3c64xx/Kconfig"
 
-source "arch/arm/mach-s5p64x0/Kconfig"
-
 source "arch/arm/mach-s5pc100/Kconfig"
 
 source "arch/arm/mach-s5pv210/Kconfig"
@@ -1569,7 +1549,7 @@ source kernel/Kconfig.preempt
 
 config HZ_FIXED
 	int
-	default 200 if ARCH_EBSA110 || ARCH_S3C24XX || ARCH_S5P64X0 || \
+	default 200 if ARCH_EBSA110 || ARCH_S3C24XX || \
 		ARCH_S5PV210 || ARCH_EXYNOS4
 	default AT91_TIMER_HZ if ARCH_AT91
 	default SHMOBILE_TIMER_HZ if ARCH_SHMOBILE_LEGACY
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 6721fab..826b262 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -187,7 +187,6 @@ machine-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip
 machine-$(CONFIG_ARCH_RPC)		+= rpc
 machine-$(CONFIG_ARCH_S3C24XX)		+= s3c24xx
 machine-$(CONFIG_ARCH_S3C64XX)		+= s3c64xx
-machine-$(CONFIG_ARCH_S5P64X0)		+= s5p64x0
 machine-$(CONFIG_ARCH_S5PC100)		+= s5pc100
 machine-$(CONFIG_ARCH_S5PV210)		+= s5pv210
 machine-$(CONFIG_ARCH_SA1100)		+= sa1100
diff --git a/arch/arm/configs/s5p64x0_defconfig b/arch/arm/configs/s5p64x0_defconfig
deleted file mode 100644
index ad6b61b..0000000
diff --git a/arch/arm/mach-s5p64x0/Kconfig b/arch/arm/mach-s5p64x0/Kconfig
deleted file mode 100644
index 26003e2..0000000
diff --git a/arch/arm/mach-s5p64x0/Makefile b/arch/arm/mach-s5p64x0/Makefile
deleted file mode 100644
index 12bb951..0000000
diff --git a/arch/arm/mach-s5p64x0/Makefile.boot b/arch/arm/mach-s5p64x0/Makefile.boot
deleted file mode 100644
index 79ece40..0000000
diff --git a/arch/arm/mach-s5p64x0/clock-s5p6440.c b/arch/arm/mach-s5p64x0/clock-s5p6440.c
deleted file mode 100644
index ae34a1d..0000000
diff --git a/arch/arm/mach-s5p64x0/clock-s5p6450.c b/arch/arm/mach-s5p64x0/clock-s5p6450.c
deleted file mode 100644
index 0b3ca2e..0000000
diff --git a/arch/arm/mach-s5p64x0/clock.c b/arch/arm/mach-s5p64x0/clock.c
deleted file mode 100644
index 57e7189..0000000
diff --git a/arch/arm/mach-s5p64x0/clock.h b/arch/arm/mach-s5p64x0/clock.h
deleted file mode 100644
index 28b8e3c..0000000
diff --git a/arch/arm/mach-s5p64x0/common.c b/arch/arm/mach-s5p64x0/common.c
deleted file mode 100644
index 9a43be0..0000000
diff --git a/arch/arm/mach-s5p64x0/common.h b/arch/arm/mach-s5p64x0/common.h
deleted file mode 100644
index cbe7f3d..0000000
diff --git a/arch/arm/mach-s5p64x0/dev-audio.c b/arch/arm/mach-s5p64x0/dev-audio.c
deleted file mode 100644
index 723d477..0000000
diff --git a/arch/arm/mach-s5p64x0/dma.c b/arch/arm/mach-s5p64x0/dma.c
deleted file mode 100644
index 9c4ce08..0000000
diff --git a/arch/arm/mach-s5p64x0/i2c.h b/arch/arm/mach-s5p64x0/i2c.h
deleted file mode 100644
index 1e5bb4e..0000000
diff --git a/arch/arm/mach-s5p64x0/include/mach/debug-macro.S b/arch/arm/mach-s5p64x0/include/mach/debug-macro.S
deleted file mode 100644
index 8759e78..0000000
diff --git a/arch/arm/mach-s5p64x0/include/mach/dma.h b/arch/arm/mach-s5p64x0/include/mach/dma.h
deleted file mode 100644
index 5a622af..0000000
diff --git a/arch/arm/mach-s5p64x0/include/mach/gpio.h b/arch/arm/mach-s5p64x0/include/mach/gpio.h
deleted file mode 100644
index 06cd3c9..0000000
diff --git a/arch/arm/mach-s5p64x0/include/mach/hardware.h b/arch/arm/mach-s5p64x0/include/mach/hardware.h
deleted file mode 100644
index d3e8799..0000000
diff --git a/arch/arm/mach-s5p64x0/include/mach/irqs.h b/arch/arm/mach-s5p64x0/include/mach/irqs.h
deleted file mode 100644
index 53982db..0000000
diff --git a/arch/arm/mach-s5p64x0/include/mach/map.h b/arch/arm/mach-s5p64x0/include/mach/map.h
deleted file mode 100644
index 50a6e96..0000000
diff --git a/arch/arm/mach-s5p64x0/include/mach/pm-core.h b/arch/arm/mach-s5p64x0/include/mach/pm-core.h
deleted file mode 100644
index 1e0eb65..0000000
diff --git a/arch/arm/mach-s5p64x0/include/mach/regs-clock.h b/arch/arm/mach-s5p64x0/include/mach/regs-clock.h
deleted file mode 100644
index bd91112..0000000
diff --git a/arch/arm/mach-s5p64x0/include/mach/regs-gpio.h b/arch/arm/mach-s5p64x0/include/mach/regs-gpio.h
deleted file mode 100644
index cfdfa4f..0000000
diff --git a/arch/arm/mach-s5p64x0/include/mach/regs-irq.h b/arch/arm/mach-s5p64x0/include/mach/regs-irq.h
deleted file mode 100644
index d60397d..0000000
diff --git a/arch/arm/mach-s5p64x0/irq-pm.c b/arch/arm/mach-s5p64x0/irq-pm.c
deleted file mode 100644
index 2ed921e..0000000
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
deleted file mode 100644
index 6840e19..0000000
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6450.c b/arch/arm/mach-s5p64x0/mach-smdk6450.c
deleted file mode 100644
index fa1341c..0000000
diff --git a/arch/arm/mach-s5p64x0/pm.c b/arch/arm/mach-s5p64x0/pm.c
deleted file mode 100644
index ec8229c..0000000
diff --git a/arch/arm/mach-s5p64x0/setup-fb-24bpp.c b/arch/arm/mach-s5p64x0/setup-fb-24bpp.c
deleted file mode 100644
index f346ee4..0000000
diff --git a/arch/arm/mach-s5p64x0/setup-i2c0.c b/arch/arm/mach-s5p64x0/setup-i2c0.c
deleted file mode 100644
index 569b76a..0000000
diff --git a/arch/arm/mach-s5p64x0/setup-i2c1.c b/arch/arm/mach-s5p64x0/setup-i2c1.c
deleted file mode 100644
index 867374e..0000000
diff --git a/arch/arm/mach-s5p64x0/setup-sdhci-gpio.c b/arch/arm/mach-s5p64x0/setup-sdhci-gpio.c
deleted file mode 100644
index 8410af0..0000000
diff --git a/arch/arm/mach-s5p64x0/setup-spi.c b/arch/arm/mach-s5p64x0/setup-spi.c
deleted file mode 100644
index 7664356..0000000
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 301b892..d2d375b 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -15,7 +15,7 @@ config PLAT_SAMSUNG
 
 config PLAT_S5P
 	bool
-	depends on (ARCH_S5P64X0 || ARCH_S5PC100 || ARCH_S5PV210)
+	depends on (ARCH_S5PC100 || ARCH_S5PV210)
 	default y
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_VIC
@@ -29,7 +29,7 @@ config PLAT_S5P
 
 config SAMSUNG_PM
 	bool
-	depends on PM && (PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5P64X0 || S5P_PM)
+	depends on PM && (PLAT_S3C24XX || ARCH_S3C64XX || S5P_PM)
 	default y
 	help
 	  Base platform power management code for samsung code
@@ -78,14 +78,14 @@ config SAMSUNG_CLKSRC
 	  used by newer systems such as the S3C64XX.
 
 config S5P_CLOCK
-	def_bool (ARCH_S5P64X0 || ARCH_S5PC100 || ARCH_S5PV210)
+	def_bool (ARCH_S5PC100 || ARCH_S5PV210)
 	help
 	  Support common clock part for ARCH_S5P and ARCH_EXYNOS SoCs
 
 # options for IRQ support
 
 config S5P_IRQ
-	def_bool (ARCH_S5P64X0 || ARCH_S5PC100 || ARCH_S5PV210)
+	def_bool (ARCH_S5PC100 || ARCH_S5PV210)
 	help
 	  Support common interrupt part for ARCH_S5P SoCs
 
@@ -93,7 +93,6 @@ config S5P_EXT_INT
 	bool
 	help
 	  Use the external interrupts (other than GPIO interrupts.)
-	  Note: Do not choose this for S5P6440 and S5P6450.
 
 config S5P_GPIO_INT
 	bool
@@ -143,7 +142,7 @@ config S3C_GPIO_TRACK
 
 config S5P_DEV_UART
 	def_bool y
-	depends on (ARCH_S5P64X0 || ARCH_S5PC100 || ARCH_S5PV210)
+	depends on (ARCH_S5PC100 || ARCH_S5PV210)
 
 # ADC driver
 
@@ -397,7 +396,7 @@ config SAMSUNG_PM_GPIO
 
 config SAMSUNG_DMADEV
 	bool "Use legacy Samsung DMA abstraction"
-	depends on CPU_S5PV210 || CPU_S5PC100 || ARCH_S5P64X0 || ARCH_S3C64XX
+	depends on CPU_S5PV210 || CPU_S5PC100 || ARCH_S3C64XX
 	select DMADEVICES
 	default y
 	help
@@ -474,7 +473,6 @@ config S5P_PM
 	bool
 	help
 	  Common code for power management support on S5P and newer SoCs
-	  Note: Do not select this for S5P6440 and S5P6450.
 
 config S5P_SLEEP
 	bool
diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index 79690f2..8033561 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -43,7 +43,7 @@ enum s3c_cpu_type {
 	TYPE_ADCV1, /* S3C24XX */
 	TYPE_ADCV11, /* S3C2443 */
 	TYPE_ADCV12, /* S3C2416, S3C2450 */
-	TYPE_ADCV2, /* S3C64XX, S5P64X0, S5PC100 */
+	TYPE_ADCV2, /* S3C64XX, S5PC100 */
 	TYPE_ADCV3, /* S5PV210, S5PC110, EXYNOS4210 */
 };
 
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index 5a237db..18e4365 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -33,10 +33,6 @@ extern unsigned long samsung_cpu_id;
 #define S3C6410_CPU_ID		0x36410000
 #define S3C64XX_CPU_MASK	0xFFFFF000
 
-#define S5P6440_CPU_ID		0x56440000
-#define S5P6450_CPU_ID		0x36450000
-#define S5P64XX_CPU_MASK	0xFFFFF000
-
 #define S5PC100_CPU_ID		0x43100000
 #define S5PC100_CPU_MASK	0xFFFFF000
 
@@ -54,8 +50,6 @@ IS_SAMSUNG_CPU(s3c24xx, S3C24XX_CPU_ID, S3C24XX_CPU_MASK)
 IS_SAMSUNG_CPU(s3c2412, S3C2412_CPU_ID, S3C2412_CPU_MASK)
 IS_SAMSUNG_CPU(s3c6400, S3C6400_CPU_ID, S3C64XX_CPU_MASK)
 IS_SAMSUNG_CPU(s3c6410, S3C6410_CPU_ID, S3C64XX_CPU_MASK)
-IS_SAMSUNG_CPU(s5p6440, S5P6440_CPU_ID, S5P64XX_CPU_MASK)
-IS_SAMSUNG_CPU(s5p6450, S5P6450_CPU_ID, S5P64XX_CPU_MASK)
 IS_SAMSUNG_CPU(s5pc100, S5PC100_CPU_ID, S5PC100_CPU_MASK)
 IS_SAMSUNG_CPU(s5pv210, S5PV210_CPU_ID, S5PV210_CPU_MASK)
 
@@ -86,18 +80,6 @@ IS_SAMSUNG_CPU(s5pv210, S5PV210_CPU_ID, S5PV210_CPU_MASK)
 # define soc_is_s3c64xx()	0
 #endif
 
-#if defined(CONFIG_CPU_S5P6440)
-# define soc_is_s5p6440()	is_samsung_s5p6440()
-#else
-# define soc_is_s5p6440()	0
-#endif
-
-#if defined(CONFIG_CPU_S5P6450)
-# define soc_is_s5p6450()	is_samsung_s5p6450()
-#else
-# define soc_is_s5p6450()	0
-#endif
-
 #if defined(CONFIG_CPU_S5PC100)
 # define soc_is_s5pc100()	is_samsung_s5pc100()
 #else
@@ -177,7 +159,6 @@ extern struct bus_type s3c2440_subsys;
 extern struct bus_type s3c2442_subsys;
 extern struct bus_type s3c2443_subsys;
 extern struct bus_type s3c6410_subsys;
-extern struct bus_type s5p64x0_subsys;
 extern struct bus_type s5pv210_subsys;
 
 extern void (*s5pc1xx_idle)(void);
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index eece188..ca66f51 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -94,15 +94,6 @@ extern struct platform_device s5p_device_mixer;
 extern struct platform_device s5p_device_onenand;
 extern struct platform_device s5p_device_sdo;
 
-extern struct platform_device s5p6440_device_iis;
-extern struct platform_device s5p6440_device_pcm;
-
-extern struct platform_device s5p6450_device_iis0;
-extern struct platform_device s5p6450_device_iis1;
-extern struct platform_device s5p6450_device_iis2;
-extern struct platform_device s5p6450_device_pcm0;
-
-
 extern struct platform_device s5pc100_device_ac97;
 extern struct platform_device s5pc100_device_iis0;
 extern struct platform_device s5pc100_device_iis1;
diff --git a/arch/arm/plat-samsung/include/plat/fb.h b/arch/arm/plat-samsung/include/plat/fb.h
index 9ae5072..a400464 100644
--- a/arch/arm/plat-samsung/include/plat/fb.h
+++ b/arch/arm/plat-samsung/include/plat/fb.h
@@ -61,11 +61,4 @@ extern void s5pv210_fb_gpio_setup_24bpp(void);
  */
 extern void exynos4_fimd0_gpio_setup_24bpp(void);
 
-/**
- * s5p64x0_fb_gpio_setup_24bpp() - S5P6440/S5P6450 setup function for 24bpp LCD
- *
- * Initialise the GPIO for an 24bpp LCD display on the RGB interface.
- */
-extern void s5p64x0_fb_gpio_setup_24bpp(void);
-
 #endif /* __PLAT_S3C_FB_H */
diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index bf65021..7b2332f 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -68,10 +68,6 @@ extern void exynos4_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
 extern void exynos4_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
 extern void exynos4_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
 extern void exynos4_setup_sdhci3_cfg_gpio(struct platform_device *, int w);
-extern void s5p64x0_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
-extern void s5p64x0_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
-extern void s5p6440_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
-extern void s5p6450_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
 
 /* S3C2416 SDHCI setup */
 
@@ -151,45 +147,6 @@ static inline void s3c6400_default_sdhci2(void) { }
 
 #endif /* CONFIG_S3C64XX_SETUP_SDHCI */
 
-/* S5P64X0 SDHCI setup */
-
-#ifdef CONFIG_S5P64X0_SETUP_SDHCI_GPIO
-static inline void s5p64x0_default_sdhci0(void)
-{
-#ifdef CONFIG_S3C_DEV_HSMMC
-	s3c_hsmmc0_def_platdata.cfg_gpio = s5p64x0_setup_sdhci0_cfg_gpio;
-#endif
-}
-
-static inline void s5p64x0_default_sdhci1(void)
-{
-#ifdef CONFIG_S3C_DEV_HSMMC1
-	s3c_hsmmc1_def_platdata.cfg_gpio = s5p64x0_setup_sdhci1_cfg_gpio;
-#endif
-}
-
-static inline void s5p6440_default_sdhci2(void)
-{
-#ifdef CONFIG_S3C_DEV_HSMMC2
-	s3c_hsmmc2_def_platdata.cfg_gpio = s5p6440_setup_sdhci2_cfg_gpio;
-#endif
-}
-
-static inline void s5p6450_default_sdhci2(void)
-{
-#ifdef CONFIG_S3C_DEV_HSMMC2
-	s3c_hsmmc2_def_platdata.cfg_gpio = s5p6450_setup_sdhci2_cfg_gpio;
-#endif
-}
-
-#else
-static inline void s5p64x0_default_sdhci0(void) { }
-static inline void s5p64x0_default_sdhci1(void) { }
-static inline void s5p6440_default_sdhci2(void) { }
-static inline void s5p6450_default_sdhci2(void) { }
-
-#endif /* CONFIG_S5P64X0_SETUP_SDHCI_GPIO */
-
 /* S5PC100 SDHCI setup */
 
 #ifdef CONFIG_S5PC100_SETUP_SDHCI
-- 
1.7.10.4
