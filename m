From: xuwei5@hisilicon.com (Wei Xu)
Date: Mon, 5 Sep 2016 11:42:53 +0100
Subject: [PATCH 1/1] mach-hisi: Make Hi3620 explicit, remove wildcard
In-Reply-To: <07dd3b37-3cd9-6f89-4c84-ce534880d200@gmail.com>
References: <07dd3b37-3cd9-6f89-4c84-ce534880d200@gmail.com>
Message-ID: <57CD4C2D.1040406@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marty,

On 30/08/2016 18:38, Marty Plummer wrote:
> 
> Signed-off-by: Marty Plummer <netz.kernel@gmail.com>
> ---
>  arch/arm/Kconfig.debug              |  2 +-
>  arch/arm/boot/dts/Makefile          |  2 +-
>  arch/arm/configs/hisi_defconfig     |  2 +-
>  arch/arm/configs/multi_v7_defconfig |  2 +-
>  arch/arm/mach-hisi/Kconfig          |  6 +++---
>  arch/arm/mach-hisi/core.h           | 10 +++++-----
>  arch/arm/mach-hisi/hisilicon.c      |  4 ++--
>  arch/arm/mach-hisi/hotplug.c        | 16 ++++++++--------
>  arch/arm/mach-hisi/platsmp.c        | 24 ++++++++++++------------

>  drivers/clk/hisilicon/Makefile      |  2 +-
>  drivers/dma/Kconfig                 |  2 +-

Same as Jason, please break down.

>  11 files changed, 36 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index a9693b6..9094ca6 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -280,7 +280,7 @@ choice
>  
>  	config DEBUG_HI3620_UART
>  		bool "Hisilicon HI3620 Debug UART"
> -		depends on ARCH_HI3xxx
> +		depends on ARCH_HI3620
>  		select DEBUG_UART_PL01X
>  		help
>  		  Say Y here if you want kernel low-level debugging support
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index faacd52..7ffd3a3 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -154,7 +154,7 @@ dtb-$(CONFIG_ARCH_EXYNOS5) += \
>  	exynos5440-sd5v1.dtb \
>  	exynos5440-ssdk5440.dtb \
>  	exynos5800-peach-pi.dtb
> -dtb-$(CONFIG_ARCH_HI3xxx) += \
> +dtb-$(CONFIG_ARCH_HI3620) += \
>  	hi3620-hi4511.dtb
>  dtb-$(CONFIG_ARCH_HIGHBANK) += \
>  	highbank.dtb \
> diff --git a/arch/arm/configs/hisi_defconfig b/arch/arm/configs/hisi_defconfig
> index b2e340b..14c8da6 100644
> --- a/arch/arm/configs/hisi_defconfig
> +++ b/arch/arm/configs/hisi_defconfig
> @@ -4,7 +4,7 @@ CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_RD_LZMA=y
>  CONFIG_ARCH_HISI=y
> -CONFIG_ARCH_HI3xxx=y
> +CONFIG_ARCH_HI3620=y
>  CONFIG_PARTITION_ADVANCED=y
>  CONFIG_CMDLINE_PARTITION=y
>  CONFIG_ARCH_HIX5HD2=y
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 2c8665c..a63865e 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -45,7 +45,7 @@ CONFIG_MACH_BERLIN_BG2Q=y
>  CONFIG_ARCH_DIGICOLOR=y
>  CONFIG_ARCH_HIGHBANK=y
>  CONFIG_ARCH_HISI=y
> -CONFIG_ARCH_HI3xxx=y
> +CONFIG_ARCH_HI3620=y
>  CONFIG_ARCH_HIX5HD2=y
>  CONFIG_ARCH_HIP01=y
>  CONFIG_ARCH_HIP04=y
> diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
> index a3b091a..08871e0 100644
> --- a/arch/arm/mach-hisi/Kconfig
> +++ b/arch/arm/mach-hisi/Kconfig
> @@ -12,8 +12,8 @@ if ARCH_HISI
>  
>  menu "Hisilicon platform type"
>  
> -config ARCH_HI3xxx
> -	bool "Hisilicon Hi36xx family"
> +config ARCH_HI3620
> +	bool "Hisilicon Hi3620 family"
>  	depends on ARCH_MULTI_V7
>  	select CACHE_L2X0
>  	select HAVE_ARM_SCU if SMP
> @@ -21,7 +21,7 @@ config ARCH_HI3xxx
>  	select PINCTRL
>  	select PINCTRL_SINGLE
>  	help
> -	  Support for Hisilicon Hi36xx SoC family
> +	  Support for Hisilicon Hi3620 SoC family
>  
>  config ARCH_HIP01
>         bool "Hisilicon HIP01 family"
> diff --git a/arch/arm/mach-hisi/core.h b/arch/arm/mach-hisi/core.h
> index e883583..cb7bc84 100644
> --- a/arch/arm/mach-hisi/core.h
> +++ b/arch/arm/mach-hisi/core.h
> @@ -3,13 +3,13 @@
>  
>  #include <linux/reboot.h>
>  
> -extern void hi3xxx_set_cpu_jump(int cpu, void *jump_addr);
> -extern int hi3xxx_get_cpu_jump(int cpu);
> +extern void hi3620_set_cpu_jump(int cpu, void *jump_addr);
> +extern int hi3620_get_cpu_jump(int cpu);
>  extern void secondary_startup(void);
>  
> -extern void hi3xxx_cpu_die(unsigned int cpu);
> -extern int hi3xxx_cpu_kill(unsigned int cpu);
> -extern void hi3xxx_set_cpu(int cpu, bool enable);
> +extern void hi3620_cpu_die(unsigned int cpu);
> +extern int hi3620_cpu_kill(unsigned int cpu);
> +extern void hi3620_set_cpu(int cpu, bool enable);
>  
>  extern void hix5hd2_set_cpu(int cpu, bool enable);
>  extern void hix5hd2_cpu_die(unsigned int cpu);
> diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
> index c08c44e..0aea7e9 100644
> --- a/arch/arm/mach-hisi/hisilicon.c
> +++ b/arch/arm/mach-hisi/hisilicon.c
> @@ -44,12 +44,12 @@ static void __init hi3620_map_io(void)
>  	iotable_init(hi3620_io_desc, ARRAY_SIZE(hi3620_io_desc));
>  }
>  
> -static const char *const hi3xxx_compat[] __initconst = {
> +static const char *const hi3620_compat[] __initconst = {
>  	"hisilicon,hi3620-hi4511",
>  	NULL,
>  };
>  
>  DT_MACHINE_START(HI3620, "Hisilicon Hi3620 (Flattened Device Tree)")
>  	.map_io		= hi3620_map_io,
> -	.dt_compat	= hi3xxx_compat,
> +	.dt_compat	= hi3620_compat,
>  MACHINE_END
> diff --git a/arch/arm/mach-hisi/hotplug.c b/arch/arm/mach-hisi/hotplug.c
> index a129aae..f06b428 100644
> --- a/arch/arm/mach-hisi/hotplug.c
> +++ b/arch/arm/mach-hisi/hotplug.c
> @@ -143,7 +143,7 @@ static void set_cpu_hi3620(int cpu, bool enable)
>  	}
>  }
>  
> -static int hi3xxx_hotplug_init(void)
> +static int hi3620_hotplug_init(void)
>  {
>  	struct device_node *node;
>  
> @@ -157,10 +157,10 @@ static int hi3xxx_hotplug_init(void)
>  	return -ENOENT;
>  }
>  
> -void hi3xxx_set_cpu(int cpu, bool enable)
> +void hi3620_set_cpu(int cpu, bool enable)
>  {
>  	if (!ctrl_base) {
> -		if (hi3xxx_hotplug_init() < 0)
> +		if (hi3620_hotplug_init() < 0)
>  			return;
>  	}
>  
> @@ -262,24 +262,24 @@ static inline void cpu_enter_lowpower(void)
>  }
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> -void hi3xxx_cpu_die(unsigned int cpu)
> +void hi3620_cpu_die(unsigned int cpu)
>  {
>  	cpu_enter_lowpower();
> -	hi3xxx_set_cpu_jump(cpu, phys_to_virt(0));
> +	hi3620_set_cpu_jump(cpu, phys_to_virt(0));
>  	cpu_do_idle();
>  
>  	/* We should have never returned from idle */
>  	panic("cpu %d unexpectedly exit from shutdown\n", cpu);
>  }
>  
> -int hi3xxx_cpu_kill(unsigned int cpu)
> +int hi3620_cpu_kill(unsigned int cpu)
>  {
>  	unsigned long timeout = jiffies + msecs_to_jiffies(50);
>  
> -	while (hi3xxx_get_cpu_jump(cpu))
> +	while (hi3620_get_cpu_jump(cpu))
>  		if (time_after(jiffies, timeout))
>  			return 0;
> -	hi3xxx_set_cpu(cpu, false);
> +	hi3620_set_cpu(cpu, false);
>  	return 1;
>  }
>  
> diff --git a/arch/arm/mach-hisi/platsmp.c b/arch/arm/mach-hisi/platsmp.c
> index e1d6764..e36783e 100644
> --- a/arch/arm/mach-hisi/platsmp.c
> +++ b/arch/arm/mach-hisi/platsmp.c
> @@ -23,7 +23,7 @@
>  
>  static void __iomem *ctrl_base;
>  
> -void hi3xxx_set_cpu_jump(int cpu, void *jump_addr)
> +void hi3620_set_cpu_jump(int cpu, void *jump_addr)
>  {
>  	cpu = cpu_logical_map(cpu);
>  	if (!cpu || !ctrl_base)
> @@ -31,7 +31,7 @@ void hi3xxx_set_cpu_jump(int cpu, void *jump_addr)
>  	writel_relaxed(virt_to_phys(jump_addr), ctrl_base + ((cpu - 1) << 2));
>  }
>  
> -int hi3xxx_get_cpu_jump(int cpu)
> +int hi3620_get_cpu_jump(int cpu)
>  {
>  	cpu = cpu_logical_map(cpu);
>  	if (!cpu || !ctrl_base)
> @@ -56,7 +56,7 @@ static void __init hisi_enable_scu_a9(void)
>  	}
>  }
>  
> -static void __init hi3xxx_smp_prepare_cpus(unsigned int max_cpus)
> +static void __init hi3620_smp_prepare_cpus(unsigned int max_cpus)
>  {
>  	struct device_node *np = NULL;
>  	u32 offset = 0;
> @@ -81,20 +81,20 @@ static void __init hi3xxx_smp_prepare_cpus(unsigned int max_cpus)
>  	}
>  }
>  
> -static int hi3xxx_boot_secondary(unsigned int cpu, struct task_struct *idle)
> +static int hi3620_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  {
> -	hi3xxx_set_cpu(cpu, true);
> -	hi3xxx_set_cpu_jump(cpu, secondary_startup);
> +	hi3620_set_cpu(cpu, true);
> +	hi3620_set_cpu_jump(cpu, secondary_startup);
>  	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
>  	return 0;
>  }
>  
> -static const struct smp_operations hi3xxx_smp_ops __initconst = {
> -	.smp_prepare_cpus	= hi3xxx_smp_prepare_cpus,
> -	.smp_boot_secondary	= hi3xxx_boot_secondary,
> +static const struct smp_operations hi3620_smp_ops __initconst = {
> +	.smp_prepare_cpus	= hi3620_smp_prepare_cpus,
> +	.smp_boot_secondary	= hi3620_boot_secondary,
>  #ifdef CONFIG_HOTPLUG_CPU
> -	.cpu_die		= hi3xxx_cpu_die,
> -	.cpu_kill		= hi3xxx_cpu_kill,
> +	.cpu_die		= hi3620_cpu_die,
> +	.cpu_kill		= hi3620_cpu_kill,
>  #endif
>  };
>  
> @@ -181,6 +181,6 @@ static const struct smp_operations hip01_smp_ops __initconst = {
>  	.smp_boot_secondary     = hip01_boot_secondary,
>  };
>  
> -CPU_METHOD_OF_DECLARE(hi3xxx_smp, "hisilicon,hi3620-smp", &hi3xxx_smp_ops);
> +CPU_METHOD_OF_DECLARE(hi3620_smp, "hisilicon,hi3620-smp", &hi3620_smp_ops);
>  CPU_METHOD_OF_DECLARE(hix5hd2_smp, "hisilicon,hix5hd2-smp", &hix5hd2_smp_ops);
>  CPU_METHOD_OF_DECLARE(hip01_smp, "hisilicon,hip01-smp", &hip01_smp_ops);
> diff --git a/drivers/clk/hisilicon/Makefile b/drivers/clk/hisilicon/Makefile
> index e169ec7..2edf3b5 100644
> --- a/drivers/clk/hisilicon/Makefile
> +++ b/drivers/clk/hisilicon/Makefile
> @@ -4,7 +4,7 @@
>  
>  obj-y	+= clk.o clkgate-separated.o clkdivider-hi6220.o
>  
> -obj-$(CONFIG_ARCH_HI3xxx)	+= clk-hi3620.o
> +obj-$(CONFIG_ARCH_HI3620)	+= clk-hi3620.o
>  obj-$(CONFIG_ARCH_HIP04)	+= clk-hip04.o
>  obj-$(CONFIG_ARCH_HIX5HD2)	+= clk-hix5hd2.o
>  obj-$(CONFIG_COMMON_CLK_HI3519)	+= clk-hi3519.o
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 739f797..74bab9d0 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -279,7 +279,7 @@ config INTEL_MIC_X100_DMA
>  
>  config K3_DMA
>  	tristate "Hisilicon K3 DMA support"
> -	depends on ARCH_HI3xxx
> +	depends on ARCH_HI3620
>  	select DMA_ENGINE
>  	select DMA_VIRTUAL_CHANNELS
>  	help
> 

Please check with "scripts/checkpatch.pl" for the format as well.
Others is fine to me.
Thanks!

Best Regards,
Wei
