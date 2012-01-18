From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 18 Jan 2012 15:14:10 -0500 (EST)
Subject: [PATCH v2 3/3] ARM: Make the sched_clock framework mandatory
In-Reply-To: <1326903292-15794-4-git-send-email-marc.zyngier@arm.com>
References: <1326903292-15794-1-git-send-email-marc.zyngier@arm.com>
 <1326903292-15794-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.LFD.2.02.1201181513430.19587@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Jan 2012, Marc Zyngier wrote:

> All sched_clock() providers have been converted to the sched_clock
> framework, which also provides a jiffy based implementation for
> the platforms that do not provide a counter.
> 
> It is now possible to make the sched_clock framework mandatory,
> effectively preventing new platforms to add new sched_clock()
> functions, which would be detrimental to the single zImage work.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/Kconfig                |   18 ------------------
>  arch/arm/kernel/Makefile        |    3 +--
>  arch/arm/kernel/time.c          |    2 --
>  arch/arm/plat-nomadik/Kconfig   |    1 -
>  arch/arm/plat-versatile/Kconfig |    1 -
>  5 files changed, 1 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index a18550e..d1fcfe0 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -52,9 +52,6 @@ config MIGHT_HAVE_PCI
>  config SYS_SUPPORTS_APM_EMULATION
>  	bool
>  
> -config HAVE_SCHED_CLOCK
> -	bool
> -
>  config GENERIC_GPIO
>  	bool
>  
> @@ -388,7 +385,6 @@ config ARCH_PRIMA2
>  	select GENERIC_CLOCKEVENTS
>  	select CLKDEV_LOOKUP
>  	select GENERIC_IRQ_CHIP
> -	select HAVE_SCHED_CLOCK
>  	select MIGHT_HAVE_CACHE_L2X0
>  	select USE_OF
>  	select ZONE_DMA
> @@ -439,7 +435,6 @@ config ARCH_MXC
>  	select CLKDEV_LOOKUP
>  	select CLKSRC_MMIO
>  	select GENERIC_IRQ_CHIP
> -	select HAVE_SCHED_CLOCK
>  	select MULTI_IRQ_HANDLER
>  	help
>  	  Support for Freescale MXC/iMX-based family of processors
> @@ -531,7 +526,6 @@ config ARCH_IXP4XX
>  	select CPU_XSCALE
>  	select GENERIC_GPIO
>  	select GENERIC_CLOCKEVENTS
> -	select HAVE_SCHED_CLOCK
>  	select MIGHT_HAVE_PCI
>  	select DMABOUNCE if PCI
>  	help
> @@ -602,7 +596,6 @@ config ARCH_MMP
>  	select CLKDEV_LOOKUP
>  	select GENERIC_CLOCKEVENTS
>  	select GPIO_PXA
> -	select HAVE_SCHED_CLOCK
>  	select TICK_ONESHOT
>  	select PLAT_PXA
>  	select SPARSE_IRQ
> @@ -643,7 +636,6 @@ config ARCH_TEGRA
>  	select GENERIC_CLOCKEVENTS
>  	select GENERIC_GPIO
>  	select HAVE_CLK
> -	select HAVE_SCHED_CLOCK
>  	select HAVE_SMP
>  	select MIGHT_HAVE_CACHE_L2X0
>  	select ARCH_HAS_CPUFREQ
> @@ -660,7 +652,6 @@ config ARCH_PICOXCELL
>  	select DW_APB_TIMER
>  	select GENERIC_CLOCKEVENTS
>  	select GENERIC_GPIO
> -	select HAVE_SCHED_CLOCK
>  	select HAVE_TCM
>  	select NO_IOPORT
>  	select SPARSE_IRQ
> @@ -688,7 +679,6 @@ config ARCH_PXA
>  	select ARCH_REQUIRE_GPIOLIB
>  	select GENERIC_CLOCKEVENTS
>  	select GPIO_PXA
> -	select HAVE_SCHED_CLOCK
>  	select TICK_ONESHOT
>  	select PLAT_PXA
>  	select SPARSE_IRQ
> @@ -756,7 +746,6 @@ config ARCH_SA1100
>  	select CPU_FREQ
>  	select GENERIC_CLOCKEVENTS
>  	select CLKDEV_LOOKUP
> -	select HAVE_SCHED_CLOCK
>  	select TICK_ONESHOT
>  	select ARCH_REQUIRE_GPIOLIB
>  	select HAVE_IDE
> @@ -813,7 +802,6 @@ config ARCH_S5P64X0
>  	select CLKSRC_MMIO
>  	select HAVE_S3C2410_WATCHDOG if WATCHDOG
>  	select GENERIC_CLOCKEVENTS
> -	select HAVE_SCHED_CLOCK
>  	select HAVE_S3C2410_I2C if I2C
>  	select HAVE_S3C_RTC if RTC_CLASS
>  	help
> @@ -846,7 +834,6 @@ config ARCH_S5PV210
>  	select ARM_L1_CACHE_SHIFT_6
>  	select ARCH_HAS_CPUFREQ
>  	select GENERIC_CLOCKEVENTS
> -	select HAVE_SCHED_CLOCK
>  	select HAVE_S3C2410_I2C if I2C
>  	select HAVE_S3C_RTC if RTC_CLASS
>  	select HAVE_S3C2410_WATCHDOG if WATCHDOG
> @@ -889,7 +876,6 @@ config ARCH_U300
>  	depends on MMU
>  	select CLKSRC_MMIO
>  	select CPU_ARM926T
> -	select HAVE_SCHED_CLOCK
>  	select HAVE_TCM
>  	select ARM_AMBA
>  	select ARM_PATCH_PHYS_VIRT
> @@ -933,7 +919,6 @@ config ARCH_DAVINCI
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ZONE_DMA
>  	select HAVE_IDE
> -	select HAVE_SCHED_CLOCK
>  	select CLKDEV_LOOKUP
>  	select GENERIC_ALLOCATOR
>  	select GENERIC_IRQ_CHIP
> @@ -948,7 +933,6 @@ config ARCH_OMAP
>  	select ARCH_HAS_CPUFREQ
>  	select CLKSRC_MMIO
>  	select GENERIC_CLOCKEVENTS
> -	select HAVE_SCHED_CLOCK
>  	select ARCH_HAS_HOLES_MEMORYMODEL
>  	help
>  	  Support for TI's OMAP platform (OMAP1/2/3/4).
> @@ -1114,13 +1098,11 @@ config ARCH_ACORN
>  config PLAT_IOP
>  	bool
>  	select GENERIC_CLOCKEVENTS
> -	select HAVE_SCHED_CLOCK
>  
>  config PLAT_ORION
>  	bool
>  	select CLKSRC_MMIO
>  	select GENERIC_IRQ_CHIP
> -	select HAVE_SCHED_CLOCK
>  
>  config PLAT_PXA
>  	bool
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index 43b740d..92098e6 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -15,7 +15,7 @@ CFLAGS_REMOVE_return_address.o = -pg
>  
>  obj-y		:= elf.o entry-armv.o entry-common.o irq.o opcodes.o \
>  		   process.o ptrace.o return_address.o setup.o signal.o \
> -		   sys_arm.o stacktrace.o time.o traps.o
> +		   sys_arm.o stacktrace.o time.o traps.o sched_clock.o
>  
>  obj-$(CONFIG_DEPRECATED_PARAM_STRUCT) += compat.o
>  
> @@ -30,7 +30,6 @@ obj-$(CONFIG_ARTHUR)		+= arthur.o
>  obj-$(CONFIG_ISA_DMA)		+= dma-isa.o
>  obj-$(CONFIG_PCI)		+= bios32.o isa.o
>  obj-$(CONFIG_ARM_CPU_SUSPEND)	+= sleep.o suspend.o
> -obj-$(CONFIG_HAVE_SCHED_CLOCK)	+= sched_clock.o
>  obj-$(CONFIG_SMP)		+= smp.o smp_tlb.o
>  obj-$(CONFIG_HAVE_ARM_SCU)	+= smp_scu.o
>  obj-$(CONFIG_HAVE_ARM_TWD)	+= smp_twd.o
> diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
> index 8c57dd3..5bff288 100644
> --- a/arch/arm/kernel/time.c
> +++ b/arch/arm/kernel/time.c
> @@ -149,8 +149,6 @@ void __init time_init(void)
>  {
>  	system_timer = machine_desc->timer;
>  	system_timer->init();
> -#ifdef CONFIG_HAVE_SCHED_CLOCK
>  	sched_clock_postinit();
> -#endif
>  }
>  
> diff --git a/arch/arm/plat-nomadik/Kconfig b/arch/arm/plat-nomadik/Kconfig
> index bca4914..4c48c8b 100644
> --- a/arch/arm/plat-nomadik/Kconfig
> +++ b/arch/arm/plat-nomadik/Kconfig
> @@ -23,7 +23,6 @@ config HAS_MTU
>  config NOMADIK_MTU_SCHED_CLOCK
>  	bool
>  	depends on HAS_MTU
> -	select HAVE_SCHED_CLOCK
>  	help
>  	  Use the Multi Timer Unit as the sched_clock.
>  
> diff --git a/arch/arm/plat-versatile/Kconfig b/arch/arm/plat-versatile/Kconfig
> index 52353be..c6f4b96 100644
> --- a/arch/arm/plat-versatile/Kconfig
> +++ b/arch/arm/plat-versatile/Kconfig
> @@ -12,6 +12,5 @@ config PLAT_VERSATILE_LEDS
>  
>  config PLAT_VERSATILE_SCHED_CLOCK
>  	def_bool y if !ARCH_INTEGRATOR_AP
> -	select HAVE_SCHED_CLOCK
>  
>  endif
> -- 
> 1.7.7.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
