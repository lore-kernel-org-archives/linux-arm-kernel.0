From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 01 Jul 2014 19:21:16 +0900
Subject: [PATCH 08/17] ARM: S5PC100: no more support S5PC100 SoC
In-Reply-To: <1404210076-2362-1-git-send-email-kgene.kim@samsung.com>
References: <1404210076-2362-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1404210076-2362-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes supporting codes for s5pc100 because no more used
now.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
Note: This is resending because previous sending has been rejected from ml
because of big changes so re-created with using -D as per Arnd's suggestion.

 Documentation/arm/Samsung/Overview.txt             |    9 -
 .../arm/Samsung/clksrc-change-registers.awk        |    1 -
 arch/arm/Kconfig                                   |   21 -
 arch/arm/Makefile                                  |    1 -
 arch/arm/configs/s5pc100_defconfig                 |   49 -
 arch/arm/mach-s5pc100/Kconfig                      |   81 --
 arch/arm/mach-s5pc100/Makefile                     |   32 -
 arch/arm/mach-s5pc100/Makefile.boot                |    2 -
 arch/arm/mach-s5pc100/clock.c                      | 1361 --------------------
 arch/arm/mach-s5pc100/common.c                     |  255 ----
 arch/arm/mach-s5pc100/common.h                     |   30 -
 arch/arm/mach-s5pc100/dev-audio.c                  |  239 ----
 arch/arm/mach-s5pc100/dma.c                        |  130 --
 arch/arm/mach-s5pc100/include/mach/debug-macro.S   |   39 -
 arch/arm/mach-s5pc100/include/mach/dma.h           |   26 -
 arch/arm/mach-s5pc100/include/mach/entry-macro.S   |   19 -
 arch/arm/mach-s5pc100/include/mach/gpio.h          |  144 ---
 arch/arm/mach-s5pc100/include/mach/hardware.h      |   14 -
 arch/arm/mach-s5pc100/include/mach/irqs.h          |  115 --
 arch/arm/mach-s5pc100/include/mach/map.h           |  137 --
 arch/arm/mach-s5pc100/include/mach/regs-clock.h    |   80 --
 arch/arm/mach-s5pc100/include/mach/regs-gpio.h     |   38 -
 arch/arm/mach-s5pc100/include/mach/regs-irq.h      |   18 -
 arch/arm/mach-s5pc100/mach-smdkc100.c              |  264 ----
 arch/arm/mach-s5pc100/setup-fb-24bpp.c             |   35 -
 arch/arm/mach-s5pc100/setup-i2c0.c                 |   28 -
 arch/arm/mach-s5pc100/setup-i2c1.c                 |   28 -
 arch/arm/mach-s5pc100/setup-ide.c                  |   57 -
 arch/arm/mach-s5pc100/setup-keypad.c               |   23 -
 arch/arm/mach-s5pc100/setup-sdhci-gpio.c           |   70 -
 arch/arm/mach-s5pc100/setup-spi.c                  |   41 -
 arch/arm/plat-samsung/Kconfig                      |   10 +-
 arch/arm/plat-samsung/adc.c                        |    2 +-
 arch/arm/plat-samsung/include/plat/cpu.h           |   10 -
 arch/arm/plat-samsung/include/plat/devs.h          |    8 -
 arch/arm/plat-samsung/include/plat/fb.h            |    7 -
 arch/arm/plat-samsung/include/plat/s5p-clock.h     |    2 +-
 arch/arm/plat-samsung/include/plat/sdhci.h         |   34 -
 drivers/irqchip/Kconfig                            |    1 -
 39 files changed, 7 insertions(+), 3454 deletions(-)
 delete mode 100644 arch/arm/configs/s5pc100_defconfig
 delete mode 100644 arch/arm/mach-s5pc100/Kconfig
 delete mode 100644 arch/arm/mach-s5pc100/Makefile
 delete mode 100644 arch/arm/mach-s5pc100/Makefile.boot
 delete mode 100644 arch/arm/mach-s5pc100/clock.c
 delete mode 100644 arch/arm/mach-s5pc100/common.c
 delete mode 100644 arch/arm/mach-s5pc100/common.h
 delete mode 100644 arch/arm/mach-s5pc100/dev-audio.c
 delete mode 100644 arch/arm/mach-s5pc100/dma.c
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/dma.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/map.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/regs-clock.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/regs-gpio.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/regs-irq.h
 delete mode 100644 arch/arm/mach-s5pc100/mach-smdkc100.c
 delete mode 100644 arch/arm/mach-s5pc100/setup-fb-24bpp.c
 delete mode 100644 arch/arm/mach-s5pc100/setup-i2c0.c
 delete mode 100644 arch/arm/mach-s5pc100/setup-i2c1.c
 delete mode 100644 arch/arm/mach-s5pc100/setup-ide.c
 delete mode 100644 arch/arm/mach-s5pc100/setup-keypad.c
 delete mode 100644 arch/arm/mach-s5pc100/setup-sdhci-gpio.c
 delete mode 100644 arch/arm/mach-s5pc100/setup-spi.c

diff --git a/Documentation/arm/Samsung/Overview.txt b/Documentation/arm/Samsung/Overview.txt
index 66edb1e..8f7309b 100644
--- a/Documentation/arm/Samsung/Overview.txt
+++ b/Documentation/arm/Samsung/Overview.txt
@@ -13,7 +13,6 @@ Introduction
 
   - S3C24XX: See Documentation/arm/Samsung-S3C24XX/Overview.txt for full list
   - S3C64XX: S3C6400 and S3C6410
-  - S5PC100
   - S5PC110 / S5PV210
 
 
@@ -33,7 +32,6 @@ Configuration
   A number of configurations are supplied, as there is no current way of
   unifying all the SoCs into one kernel.
 
-  s5pc100_defconfig - S5PC100 specific default configuration
   s5pc110_defconfig - S5PC110 specific default configuration
   s5pv210_defconfig - S5PV210 specific default configuration
 
@@ -65,13 +63,6 @@ Layout changes
   where to simplify the include and dependency issues involved with having
   so many different platform directories.
 
-  It was decided to remove plat-s5pc1xx as some of the support was already
-  in plat-s5p or plat-samsung, with the S5PC110 support added with S5PV210
-  the only user was the S5PC100. The S5PC100 specific items where moved to
-  arch/arm/mach-s5pc100.
-
-
-
 
 Port Contributors
 -----------------
diff --git a/Documentation/arm/Samsung/clksrc-change-registers.awk b/Documentation/arm/Samsung/clksrc-change-registers.awk
index 0c50220..d9174fa 100755
--- a/Documentation/arm/Samsung/clksrc-change-registers.awk
+++ b/Documentation/arm/Samsung/clksrc-change-registers.awk
@@ -68,7 +68,6 @@ BEGIN {
 
     while (getline line < ARGV[1] > 0) {
 	if (line ~ /\#define.*_MASK/ &&
-	    !(line ~ /S5PC100_EPLL_MASK/) &&
 	    !(line ~ /USB_SIG_MASK/)) {
 	    splitdefine(line, fields)
 	    name = fields[0]
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 48be04b..f4396fd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -758,24 +758,6 @@ config ARCH_S3C64XX
 	help
 	  Samsung S3C64XX series based systems
 
-config ARCH_S5PC100
-	bool "Samsung S5PC100"
-	select ARCH_REQUIRE_GPIOLIB
-	select ATAGS
-	select CLKDEV_LOOKUP
-	select CLKSRC_SAMSUNG_PWM
-	select CPU_V7
-	select GENERIC_CLOCKEVENTS
-	select GPIO_SAMSUNG
-	select HAVE_S3C2410_I2C if I2C
-	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-	select HAVE_S3C_RTC if RTC_CLASS
-	select NEED_MACH_GPIO_H
-	select SAMSUNG_ATAGS
-	select SAMSUNG_WDT_RESET
-	help
-	  Samsung S5PC100 series based systems
-
 config ARCH_S5PV210
 	bool "Samsung S5PV210/S5PC110"
 	select ARCH_HAS_HOLES_MEMORYMODEL
@@ -986,8 +968,6 @@ source "arch/arm/mach-s3c24xx/Kconfig"
 
 source "arch/arm/mach-s3c64xx/Kconfig"
 
-source "arch/arm/mach-s5pc100/Kconfig"
-
 source "arch/arm/mach-s5pv210/Kconfig"
 
 source "arch/arm/mach-exynos/Kconfig"
@@ -2174,7 +2154,6 @@ menu "Power management options"
 source "kernel/power/Kconfig"
 
 config ARCH_SUSPEND_POSSIBLE
-	depends on !ARCH_S5PC100
 	depends on CPU_ARM920T || CPU_ARM926T || CPU_FEROCEON || CPU_SA1100 || \
 		CPU_V6 || CPU_V6K || CPU_V7 || CPU_V7M || CPU_XSC3 || CPU_XSCALE || CPU_MOHAWK
 	def_bool y
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 826b262..d3f470c 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -187,7 +187,6 @@ machine-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip
 machine-$(CONFIG_ARCH_RPC)		+= rpc
 machine-$(CONFIG_ARCH_S3C24XX)		+= s3c24xx
 machine-$(CONFIG_ARCH_S3C64XX)		+= s3c64xx
-machine-$(CONFIG_ARCH_S5PC100)		+= s5pc100
 machine-$(CONFIG_ARCH_S5PV210)		+= s5pv210
 machine-$(CONFIG_ARCH_SA1100)		+= sa1100
 machine-$(CONFIG_ARCH_SHMOBILE) 	+= shmobile
diff --git a/arch/arm/configs/s5pc100_defconfig b/arch/arm/configs/s5pc100_defconfig
deleted file mode 100644
index 41bafc9..0000000
diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
deleted file mode 100644
index c5e3a96..0000000
diff --git a/arch/arm/mach-s5pc100/Makefile b/arch/arm/mach-s5pc100/Makefile
deleted file mode 100644
index 118c711..0000000
diff --git a/arch/arm/mach-s5pc100/Makefile.boot b/arch/arm/mach-s5pc100/Makefile.boot
deleted file mode 100644
index 79ece40..0000000
diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-s5pc100/clock.c
deleted file mode 100644
index d0dc10e..0000000
diff --git a/arch/arm/mach-s5pc100/common.c b/arch/arm/mach-s5pc100/common.c
deleted file mode 100644
index 6a41bf7..0000000
diff --git a/arch/arm/mach-s5pc100/common.h b/arch/arm/mach-s5pc100/common.h
deleted file mode 100644
index 08d782d..0000000
diff --git a/arch/arm/mach-s5pc100/dev-audio.c b/arch/arm/mach-s5pc100/dev-audio.c
deleted file mode 100644
index 46f488b..0000000
diff --git a/arch/arm/mach-s5pc100/dma.c b/arch/arm/mach-s5pc100/dma.c
deleted file mode 100644
index b141840..0000000
diff --git a/arch/arm/mach-s5pc100/include/mach/debug-macro.S b/arch/arm/mach-s5pc100/include/mach/debug-macro.S
deleted file mode 100644
index 22c2385..0000000
diff --git a/arch/arm/mach-s5pc100/include/mach/dma.h b/arch/arm/mach-s5pc100/include/mach/dma.h
deleted file mode 100644
index 201842a..0000000
diff --git a/arch/arm/mach-s5pc100/include/mach/entry-macro.S b/arch/arm/mach-s5pc100/include/mach/entry-macro.S
deleted file mode 100644
index bad0700..0000000
diff --git a/arch/arm/mach-s5pc100/include/mach/gpio.h b/arch/arm/mach-s5pc100/include/mach/gpio.h
deleted file mode 100644
index 5e1a924..0000000
diff --git a/arch/arm/mach-s5pc100/include/mach/hardware.h b/arch/arm/mach-s5pc100/include/mach/hardware.h
deleted file mode 100644
index 6b38618..0000000
diff --git a/arch/arm/mach-s5pc100/include/mach/irqs.h b/arch/arm/mach-s5pc100/include/mach/irqs.h
deleted file mode 100644
index d2eb475..0000000
diff --git a/arch/arm/mach-s5pc100/include/mach/map.h b/arch/arm/mach-s5pc100/include/mach/map.h
deleted file mode 100644
index 2550b61..0000000
diff --git a/arch/arm/mach-s5pc100/include/mach/regs-clock.h b/arch/arm/mach-s5pc100/include/mach/regs-clock.h
deleted file mode 100644
index bc92da2..0000000
diff --git a/arch/arm/mach-s5pc100/include/mach/regs-gpio.h b/arch/arm/mach-s5pc100/include/mach/regs-gpio.h
deleted file mode 100644
index 0bf7320..0000000
diff --git a/arch/arm/mach-s5pc100/include/mach/regs-irq.h b/arch/arm/mach-s5pc100/include/mach/regs-irq.h
deleted file mode 100644
index 7616278..0000000
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
deleted file mode 100644
index 668af3a..0000000
diff --git a/arch/arm/mach-s5pc100/setup-fb-24bpp.c b/arch/arm/mach-s5pc100/setup-fb-24bpp.c
deleted file mode 100644
index 8978e4c..0000000
diff --git a/arch/arm/mach-s5pc100/setup-i2c0.c b/arch/arm/mach-s5pc100/setup-i2c0.c
deleted file mode 100644
index 89a6a76..0000000
diff --git a/arch/arm/mach-s5pc100/setup-i2c1.c b/arch/arm/mach-s5pc100/setup-i2c1.c
deleted file mode 100644
index faa667e..0000000
diff --git a/arch/arm/mach-s5pc100/setup-ide.c b/arch/arm/mach-s5pc100/setup-ide.c
deleted file mode 100644
index 223aae0..0000000
diff --git a/arch/arm/mach-s5pc100/setup-keypad.c b/arch/arm/mach-s5pc100/setup-keypad.c
deleted file mode 100644
index ada377f..0000000
diff --git a/arch/arm/mach-s5pc100/setup-sdhci-gpio.c b/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
deleted file mode 100644
index 6010c03..0000000
diff --git a/arch/arm/mach-s5pc100/setup-spi.c b/arch/arm/mach-s5pc100/setup-spi.c
deleted file mode 100644
index 1835679..0000000
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index d2d375b..1c629c2 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -15,7 +15,7 @@ config PLAT_SAMSUNG
 
 config PLAT_S5P
 	bool
-	depends on (ARCH_S5PC100 || ARCH_S5PV210)
+	depends on ARCH_S5PV210
 	default y
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_VIC
@@ -78,14 +78,14 @@ config SAMSUNG_CLKSRC
 	  used by newer systems such as the S3C64XX.
 
 config S5P_CLOCK
-	def_bool (ARCH_S5PC100 || ARCH_S5PV210)
+	def_bool ARCH_S5PV210
 	help
 	  Support common clock part for ARCH_S5P and ARCH_EXYNOS SoCs
 
 # options for IRQ support
 
 config S5P_IRQ
-	def_bool (ARCH_S5PC100 || ARCH_S5PV210)
+	def_bool ARCH_S5PV210
 	help
 	  Support common interrupt part for ARCH_S5P SoCs
 
@@ -142,7 +142,7 @@ config S3C_GPIO_TRACK
 
 config S5P_DEV_UART
 	def_bool y
-	depends on (ARCH_S5PC100 || ARCH_S5PV210)
+	depends on ARCH_S5PV210
 
 # ADC driver
 
@@ -396,7 +396,7 @@ config SAMSUNG_PM_GPIO
 
 config SAMSUNG_DMADEV
 	bool "Use legacy Samsung DMA abstraction"
-	depends on CPU_S5PV210 || CPU_S5PC100 || ARCH_S3C64XX
+	depends on CPU_S5PV210 || ARCH_S3C64XX
 	select DMADEVICES
 	default y
 	help
diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index 8033561..4683526 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -43,7 +43,7 @@ enum s3c_cpu_type {
 	TYPE_ADCV1, /* S3C24XX */
 	TYPE_ADCV11, /* S3C2443 */
 	TYPE_ADCV12, /* S3C2416, S3C2450 */
-	TYPE_ADCV2, /* S3C64XX, S5PC100 */
+	TYPE_ADCV2, /* S3C64XX */
 	TYPE_ADCV3, /* S5PV210, S5PC110, EXYNOS4210 */
 };
 
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index 18e4365..d1d4659 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -33,9 +33,6 @@ extern unsigned long samsung_cpu_id;
 #define S3C6410_CPU_ID		0x36410000
 #define S3C64XX_CPU_MASK	0xFFFFF000
 
-#define S5PC100_CPU_ID		0x43100000
-#define S5PC100_CPU_MASK	0xFFFFF000
-
 #define S5PV210_CPU_ID		0x43110000
 #define S5PV210_CPU_MASK	0xFFFFF000
 
@@ -50,7 +47,6 @@ IS_SAMSUNG_CPU(s3c24xx, S3C24XX_CPU_ID, S3C24XX_CPU_MASK)
 IS_SAMSUNG_CPU(s3c2412, S3C2412_CPU_ID, S3C2412_CPU_MASK)
 IS_SAMSUNG_CPU(s3c6400, S3C6400_CPU_ID, S3C64XX_CPU_MASK)
 IS_SAMSUNG_CPU(s3c6410, S3C6410_CPU_ID, S3C64XX_CPU_MASK)
-IS_SAMSUNG_CPU(s5pc100, S5PC100_CPU_ID, S5PC100_CPU_MASK)
 IS_SAMSUNG_CPU(s5pv210, S5PV210_CPU_ID, S5PV210_CPU_MASK)
 
 #if defined(CONFIG_CPU_S3C2410) || defined(CONFIG_CPU_S3C2412) || \
@@ -80,12 +76,6 @@ IS_SAMSUNG_CPU(s5pv210, S5PV210_CPU_ID, S5PV210_CPU_MASK)
 # define soc_is_s3c64xx()	0
 #endif
 
-#if defined(CONFIG_CPU_S5PC100)
-# define soc_is_s5pc100()	is_samsung_s5pc100()
-#else
-# define soc_is_s5pc100()	0
-#endif
-
 #if defined(CONFIG_CPU_S5PV210)
 # define soc_is_s5pv210()	is_samsung_s5pv210()
 #else
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index ca66f51..5f5a28d 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -94,14 +94,6 @@ extern struct platform_device s5p_device_mixer;
 extern struct platform_device s5p_device_onenand;
 extern struct platform_device s5p_device_sdo;
 
-extern struct platform_device s5pc100_device_ac97;
-extern struct platform_device s5pc100_device_iis0;
-extern struct platform_device s5pc100_device_iis1;
-extern struct platform_device s5pc100_device_iis2;
-extern struct platform_device s5pc100_device_pcm0;
-extern struct platform_device s5pc100_device_pcm1;
-extern struct platform_device s5pc100_device_spdif;
-
 extern struct platform_device s5pv210_device_ac97;
 extern struct platform_device s5pv210_device_iis0;
 extern struct platform_device s5pv210_device_iis1;
diff --git a/arch/arm/plat-samsung/include/plat/fb.h b/arch/arm/plat-samsung/include/plat/fb.h
index a400464..5a0e26a 100644
--- a/arch/arm/plat-samsung/include/plat/fb.h
+++ b/arch/arm/plat-samsung/include/plat/fb.h
@@ -41,13 +41,6 @@ extern void s5p_fimd0_set_platdata(struct s3c_fb_platdata *pd);
 extern void s3c64xx_fb_gpio_setup_24bpp(void);
 
 /**
- * s5pc100_fb_gpio_setup_24bpp() - S5PC100 setup function for 24bpp LCD
- *
- * Initialise the GPIO for an 24bpp LCD display on the RGB interface.
- */
-extern void s5pc100_fb_gpio_setup_24bpp(void);
-
-/**
  * s5pv210_fb_gpio_setup_24bpp() - S5PV210/S5PC110 setup function for 24bpp LCD
  *
  * Initialise the GPIO for an 24bpp LCD display on the RGB interface.
diff --git a/arch/arm/plat-samsung/include/plat/s5p-clock.h b/arch/arm/plat-samsung/include/plat/s5p-clock.h
index 8364b4b..acacc4b 100644
--- a/arch/arm/plat-samsung/include/plat/s5p-clock.h
+++ b/arch/arm/plat-samsung/include/plat/s5p-clock.h
@@ -57,7 +57,7 @@ extern int s5p_gatectrl(void __iomem *reg, struct clk *clk, int enable);
 extern int s5p_epll_enable(struct clk *clk, int enable);
 extern unsigned long s5p_epll_get_rate(struct clk *clk);
 
-/* SPDIF clk operations common for S5PC100/V210/C110 and Exynos4 */
+/* SPDIF clk operations common for S5PV210/C110 and Exynos4 */
 extern int s5p_spdif_set_rate(struct clk *clk, unsigned long rate);
 extern unsigned long s5p_spdif_get_rate(struct clk *clk);
 
diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index 7b2332f..f84b6cb 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -56,9 +56,6 @@ extern void s3c2416_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
 extern void s3c2416_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
 extern void s3c64xx_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
 extern void s3c64xx_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
-extern void s5pc100_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
-extern void s5pc100_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
-extern void s5pc100_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
 extern void s3c64xx_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
 extern void s5pv210_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
 extern void s5pv210_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
@@ -147,37 +144,6 @@ static inline void s3c6400_default_sdhci2(void) { }
 
 #endif /* CONFIG_S3C64XX_SETUP_SDHCI */
 
-/* S5PC100 SDHCI setup */
-
-#ifdef CONFIG_S5PC100_SETUP_SDHCI
-static inline void s5pc100_default_sdhci0(void)
-{
-#ifdef CONFIG_S3C_DEV_HSMMC
-	s3c_hsmmc0_def_platdata.cfg_gpio = s5pc100_setup_sdhci0_cfg_gpio;
-#endif
-}
-
-static inline void s5pc100_default_sdhci1(void)
-{
-#ifdef CONFIG_S3C_DEV_HSMMC1
-	s3c_hsmmc1_def_platdata.cfg_gpio = s5pc100_setup_sdhci1_cfg_gpio;
-#endif
-}
-
-static inline void s5pc100_default_sdhci2(void)
-{
-#ifdef CONFIG_S3C_DEV_HSMMC2
-	s3c_hsmmc2_def_platdata.cfg_gpio = s5pc100_setup_sdhci2_cfg_gpio;
-#endif
-}
-
-#else
-static inline void s5pc100_default_sdhci0(void) { }
-static inline void s5pc100_default_sdhci1(void) { }
-static inline void s5pc100_default_sdhci2(void) { }
-
-#endif /* CONFIG_S5PC100_SETUP_SDHCI */
-
 /* S5PV210 SDHCI setup */
 
 #ifdef CONFIG_S5PV210_SETUP_SDHCI
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index bbb746e..e702868 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -23,7 +23,6 @@ config ARM_VIC
 config ARM_VIC_NR
 	int
 	default 4 if ARCH_S5PV210
-	default 3 if ARCH_S5PC100
 	default 2
 	depends on ARM_VIC
 	help
-- 
1.7.10.4
