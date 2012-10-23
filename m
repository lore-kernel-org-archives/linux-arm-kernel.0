From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 23 Oct 2012 21:24:54 +0900
Subject: [PATCH 1/4] ARM: EXYNOS: Kconfig: Rename CPU_EXYNOS4210 to
 SOC_EXYNOS4210
In-Reply-To: <1349701345-2681-2-git-send-email-t.figa@samsung.com>
References: <1349701345-2681-1-git-send-email-t.figa@samsung.com>
 <1349701345-2681-2-git-send-email-t.figa@samsung.com>
Message-ID: <01d301cdb119$6849acd0$38dd0670$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> This patch renames CONFIG_CPU_EXYNOS4210 to CONFIG_SOC_EXYNOS4210 to
> match the convention used by rest of Exynos SoCs and correctly represent
> the reality (Exynos4210 is a SoC, not a CPU).
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>

> ---
>  arch/arm/mach-exynos/Kconfig             | 14 +++++++-------
>  arch/arm/mach-exynos/Makefile            |  2 +-
>  arch/arm/mach-exynos/common.h            |  2 +-
>  arch/arm/plat-samsung/include/plat/cpu.h |  2 +-
>  drivers/cpufreq/Kconfig.arm              |  2 +-
>  drivers/devfreq/Kconfig                  |  2 +-
>  drivers/mmc/host/sdhci-s3c.c             |  2 +-
>  drivers/tty/serial/samsung.c             |  2 +-
>  8 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index 4372075..05dcd07 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -27,7 +27,7 @@ config ARCH_EXYNOS5
> 
>  comment "EXYNOS SoCs"
> 
> -config CPU_EXYNOS4210
> +config SOC_EXYNOS4210
>  	bool "SAMSUNG EXYNOS4210"
>  	default y
>  	depends on ARCH_EXYNOS4
> @@ -188,7 +188,7 @@ config MACH_SMDKC210
> 
>  config MACH_SMDKV310
>  	bool "SMDKV310"
> -	select CPU_EXYNOS4210
> +	select SOC_EXYNOS4210
>  	select S5P_DEV_FIMD0
>  	select S3C_DEV_RTC
>  	select S3C_DEV_WDT
> @@ -227,7 +227,7 @@ config MACH_SMDKV310
> 
>  config MACH_ARMLEX4210
>  	bool "ARMLEX4210"
> -	select CPU_EXYNOS4210
> +	select SOC_EXYNOS4210
>  	select S3C_DEV_RTC
>  	select S3C_DEV_WDT
>  	select S3C_DEV_HSMMC
> @@ -241,7 +241,7 @@ config MACH_ARMLEX4210
> 
>  config MACH_UNIVERSAL_C210
>  	bool "Mobile UNIVERSAL_C210 Board"
> -	select CPU_EXYNOS4210
> +	select SOC_EXYNOS4210
>  	select S5P_HRT
>  	select CLKSRC_MMIO
>  	select HAVE_SCHED_CLOCK
> @@ -282,7 +282,7 @@ config MACH_UNIVERSAL_C210
> 
>  config MACH_NURI
>  	bool "Mobile NURI Board"
> -	select CPU_EXYNOS4210
> +	select SOC_EXYNOS4210
>  	select S5P_GPIO_INT
>  	select S3C_DEV_WDT
>  	select S3C_DEV_RTC
> @@ -323,7 +323,7 @@ config MACH_NURI
> 
>  config MACH_ORIGEN
>  	bool "ORIGEN"
> -	select CPU_EXYNOS4210
> +	select SOC_EXYNOS4210
>  	select S3C_DEV_RTC
>  	select S3C_DEV_WDT
>  	select S3C_DEV_HSMMC
> @@ -404,7 +404,7 @@ comment "Flattened Device Tree based board for EXYNOS
> SoCs"
>  config MACH_EXYNOS4_DT
>  	bool "Samsung Exynos4 Machine using device tree"
>  	depends on ARCH_EXYNOS4
> -	select CPU_EXYNOS4210
> +	select SOC_EXYNOS4210
>  	select USE_OF
>  	select ARM_AMBA
>  	select HAVE_SAMSUNG_KEYPAD if INPUT_KEYBOARD
> diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
> index 9b58024..ceeb8c9 100644
> --- a/arch/arm/mach-exynos/Makefile
> +++ b/arch/arm/mach-exynos/Makefile
> @@ -15,7 +15,7 @@ obj-				:=
>  obj-$(CONFIG_ARCH_EXYNOS)	+= common.o
>  obj-$(CONFIG_ARCH_EXYNOS4)	+= clock-exynos4.o
>  obj-$(CONFIG_ARCH_EXYNOS5)	+= clock-exynos5.o
> -obj-$(CONFIG_CPU_EXYNOS4210)	+= clock-exynos4210.o
> +obj-$(CONFIG_SOC_EXYNOS4210)	+= clock-exynos4210.o
>  obj-$(CONFIG_SOC_EXYNOS4212)	+= clock-exynos4212.o
> 
>  obj-$(CONFIG_PM)		+= pm.o
> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
> index aed2eeb..054c786 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -45,7 +45,7 @@ void exynos5_setup_clocks(void);
>  #define exynos5_setup_clocks()
>  #endif
> 
> -#ifdef CONFIG_CPU_EXYNOS4210
> +#ifdef CONFIG_SOC_EXYNOS4210
>  void exynos4210_register_clocks(void);
> 
>  #else
> diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-
> samsung/include/plat/cpu.h
> index ace4451..021fff0 100644
> --- a/arch/arm/plat-samsung/include/plat/cpu.h
> +++ b/arch/arm/plat-samsung/include/plat/cpu.h
> @@ -102,7 +102,7 @@ IS_SAMSUNG_CPU(exynos5250, EXYNOS5250_SOC_ID,
> EXYNOS5_SOC_MASK)
>  # define soc_is_s5pv210()	0
>  #endif
> 
> -#if defined(CONFIG_CPU_EXYNOS4210)
> +#if defined(CONFIG_SOC_EXYNOS4210)
>  # define soc_is_exynos4210()	is_samsung_exynos4210()
>  #else
>  # define soc_is_exynos4210()	0
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 5961e64..ca4ede3 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -60,7 +60,7 @@ config ARM_EXYNOS_CPUFREQ
>  	  If in doubt, say N.
> 
>  config ARM_EXYNOS4210_CPUFREQ
> -	def_bool CPU_EXYNOS4210
> +	def_bool SOC_EXYNOS4210
>  	help
>  	  This adds the CPUFreq driver for Samsung EXYNOS4210
>  	  SoC (S5PV310 or S5PC210).
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index f6b0a6e2..8545069 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -67,7 +67,7 @@ comment "DEVFREQ Drivers"
> 
>  config ARM_EXYNOS4_BUS_DEVFREQ
>  	bool "ARM Exynos4210/4212/4412 Memory Bus DEVFREQ Driver"
> -	depends on CPU_EXYNOS4210 || CPU_EXYNOS4212 || CPU_EXYNOS4412
> +	depends on SOC_EXYNOS4210 || CPU_EXYNOS4212 || CPU_EXYNOS4412

(+ MyungJoo Ham)

MyungJoo, should be fixed separately with this.

8<--------------------------------------

From: Kukjin Kim <kgene.kim@samsung.com>
Subject: PM / devfreq: fix the dependency for EXYNOS4212 and EXYNOS4412

The CPU_EXYNOS4212 and CPU_EXYNOS4412 should be fixed.

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index f6b0a6e2..e73cede 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -67,7 +67,7 @@ comment "DEVFREQ Drivers"
 
 config ARM_EXYNOS4_BUS_DEVFREQ
 	bool "ARM Exynos4210/4212/4412 Memory Bus DEVFREQ Driver"
-	depends on CPU_EXYNOS4210 || CPU_EXYNOS4212 || CPU_EXYNOS4412
+	depends on CPU_EXYNOS4210 || SOC_EXYNOS4212 || SOC_EXYNOS4412
 	select ARCH_HAS_OPP
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	help
8<--------------------------------------

>  	select ARCH_HAS_OPP
>  	select DEVFREQ_GOV_SIMPLE_ONDEMAND
>  	help
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index a50c205..b090415 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -716,7 +716,7 @@ static const struct dev_pm_ops sdhci_s3c_pmops = {
>  #define SDHCI_S3C_PMOPS NULL
>  #endif
> 
> -#if defined(CONFIG_CPU_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212)
> +#if defined(CONFIG_SOC_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212)
>  static struct sdhci_s3c_drv_data exynos4_sdhci_drv_data = {
>  	.sdhci_quirks = SDHCI_QUIRK_NONSTANDARD_CLOCK,
>  };
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index 02d07bf..175ba6e 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -1594,7 +1594,7 @@ static struct s3c24xx_serial_drv_data
> s5pv210_serial_drv_data = {
>  #define S5PV210_SERIAL_DRV_DATA	(kernel_ulong_t)NULL
>  #endif
> 
> -#if defined(CONFIG_CPU_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212) || \
> +#if defined(CONFIG_SOC_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212) || \
>  	defined(CONFIG_SOC_EXYNOS4412) || defined(CONFIG_SOC_EXYNOS5250)
>  static struct s3c24xx_serial_drv_data exynos4210_serial_drv_data = {
>  	.info = &(struct s3c24xx_uart_info) {
> --
> 1.7.12

Tomasz, looks ok to me but I think, accordingly, following should be updated
together?

8<--------------------------------

diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index a006f0d..3a665ff 100644
--- a/drivers/gpio/gpio-samsung.c
+++ b/drivers/gpio/gpio-samsung.c
@@ -2790,7 +2790,7 @@ static __init void exynos_gpiolib_attach_ofnode(struct
samsung_gpio_chip *chip,
 
 static __init void exynos4_gpiolib_init(void)
 {
-#ifdef CONFIG_CPU_EXYNOS4210
+#ifdef CONFIG_SOC_EXYNOS4210
 	struct samsung_gpio_chip *chip;
 	int i, nr_chips;
 	void __iomem *gpio_base1, *gpio_base2, *gpio_base3;
@@ -2887,7 +2887,7 @@ static __init void exynos4_gpiolib_init(void)
 	samsung_gpiolib_add_4bit_chips(exynos4_gpios_3,
 				       nr_chips, gpio_base3);
 
-#if defined(CONFIG_CPU_EXYNOS4210) && defined(CONFIG_S5P_GPIO_INT)
+#if defined(CONFIG_SOC_EXYNOS4210) && defined(CONFIG_S5P_GPIO_INT)
 	s5p_register_gpioint_bank(IRQ_GPIO_XA, 0, IRQ_GPIO1_NR_GROUPS);
 	s5p_register_gpioint_bank(IRQ_GPIO_XB, IRQ_GPIO1_NR_GROUPS,
IRQ_GPIO2_NR_GROUPS);
 #endif
@@ -2900,7 +2900,7 @@ err_ioremap2:
 	iounmap(gpio_base1);
 err_ioremap1:
 	return;
-#endif	/* CONFIG_CPU_EXYNOS4210 */
+#endif	/* CONFIG_SOC_EXYNOS4210 */
 }
 
 static __init void exynos5_gpiolib_init(void)
diff --git a/drivers/thermal/exynos_thermal.c
b/drivers/thermal/exynos_thermal.c
index fd03e85..8be9282 100644
--- a/drivers/thermal/exynos_thermal.c
+++ b/drivers/thermal/exynos_thermal.c
@@ -728,7 +728,7 @@ static struct thermal_sensor_conf exynos_sensor_conf = {
 	.read_temperature	= (int (*)(void *))exynos_tmu_read,
 };
 
-#if defined(CONFIG_CPU_EXYNOS4210)
+#if defined(CONFIG_SOC_EXYNOS4210)
 static struct exynos_tmu_platform_data const exynos4210_default_tmu_data =
{
 	.threshold = 80,
 	.trigger_levels[0] = 5,
8<--------------------------------

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
