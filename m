From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 12 Apr 2013 18:08:40 +0200
Subject: [PATCH 2/2] ARM: remove all trivial init_machine callbacks
In-Reply-To: <1365779468-116419-2-git-send-email-arnd@arndb.de>
References: <1365779468-116419-1-git-send-email-arnd@arndb.de>
 <1365779468-116419-2-git-send-email-arnd@arndb.de>
Message-ID: <20130412160840.GD25242@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:11 Fri 12 Apr     , Arnd Bergmann wrote:
> The call to of_platform_populate(NULL, of_default_bus_match_table, NULL,
> NULL) is now implied by having no init_machine callback in the machine
> descriptor, so we can save a couple of lines in those machines that
> do not need to do anything else.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Nicolas Pitre <nico@linaro.org>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: "Russell King - ARM Linux" <linux@arm.linux.org.uk>
> Cc: Rob Herring <robherring2@gmail.com>
> ---
>  arch/arm/mach-at91/board-dt.c           |  6 ------
>  arch/arm/mach-at91/board-rm9200-dt.c    |  6 ------
on AT91 you have also sama5 file and those file are renaned for 3.10

Best Regards,
J.
>  arch/arm/mach-exynos/mach-exynos4-dt.c  |  7 -------
>  arch/arm/mach-imx/imx25-dt.c            |  6 ------
>  arch/arm/mach-imx/imx31-dt.c            |  6 ------
>  arch/arm/mach-imx/imx51-dt.c            |  6 ------
>  arch/arm/mach-msm/board-dt-8660.c       | 11 -----------
>  arch/arm/mach-msm/board-dt-8960.c       |  6 ------
>  arch/arm/mach-tegra/board-dt-tegra114.c |  6 ------
>  arch/arm/mach-tegra/board-dt-tegra30.c  |  6 ------
>  arch/arm/mach-virt/virt.c               |  6 ------
>  11 files changed, 72 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/board-dt.c b/arch/arm/mach-at91/board-dt.c
> index 8db3013..9903579 100644
> --- a/arch/arm/mach-at91/board-dt.c
> +++ b/arch/arm/mach-at91/board-dt.c
> @@ -37,11 +37,6 @@ static void __init at91_dt_init_irq(void)
>  	of_irq_init(irq_of_match);
>  }
>  
> -static void __init at91_dt_device_init(void)
> -{
> -	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> -}
> -
>  static const char *at91_dt_board_compat[] __initdata = {
>  	"atmel,at91sam9",
>  	NULL
> @@ -54,6 +49,5 @@ DT_MACHINE_START(at91sam_dt, "Atmel AT91SAM (Device Tree)")
>  	.handle_irq	= at91_aic_handle_irq,
>  	.init_early	= at91_dt_initialize,
>  	.init_irq	= at91_dt_init_irq,
> -	.init_machine	= at91_dt_device_init,
>  	.dt_compat	= at91_dt_board_compat,
>  MACHINE_END
> diff --git a/arch/arm/mach-at91/board-rm9200-dt.c b/arch/arm/mach-at91/board-rm9200-dt.c
> index 3fcb662..6b8d260 100644
> --- a/arch/arm/mach-at91/board-rm9200-dt.c
> +++ b/arch/arm/mach-at91/board-rm9200-dt.c
> @@ -36,11 +36,6 @@ static void __init at91rm9200_dt_init_irq(void)
>  	of_irq_init(irq_of_match);
>  }
>  
> -static void __init at91rm9200_dt_device_init(void)
> -{
> -	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> -}
> -
>  static const char *at91rm9200_dt_board_compat[] __initdata = {
>  	"atmel,at91rm9200",
>  	NULL
> @@ -52,6 +47,5 @@ DT_MACHINE_START(at91rm9200_dt, "Atmel AT91RM9200 (Device Tree)")
>  	.handle_irq	= at91_aic_handle_irq,
>  	.init_early	= at91rm9200_dt_initialize,
>  	.init_irq	= at91rm9200_dt_init_irq,
> -	.init_machine	= at91rm9200_dt_device_init,
>  	.dt_compat	= at91rm9200_dt_board_compat,
>  MACHINE_END
> diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
> index 3358088..25038a1 100644
> --- a/arch/arm/mach-exynos/mach-exynos4-dt.c
> +++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
> @@ -122,12 +122,6 @@ static void __init exynos4_dt_map_io(void)
>  	s3c24xx_init_clocks(24000000);
>  }
>  
> -static void __init exynos4_dt_machine_init(void)
> -{
> -	of_platform_populate(NULL, of_default_bus_match_table,
> -				exynos4_auxdata_lookup, NULL);
> -}
> -
>  static char const *exynos4_dt_compat[] __initdata = {
>  	"samsung,exynos4210",
>  	"samsung,exynos4212",
> @@ -140,7 +134,6 @@ DT_MACHINE_START(EXYNOS4210_DT, "Samsung Exynos4 (Flattened Device Tree)")
>  	.smp		= smp_ops(exynos_smp_ops),
>  	.init_irq	= exynos4_init_irq,
>  	.map_io		= exynos4_dt_map_io,
> -	.init_machine	= exynos4_dt_machine_init,
>  	.init_late	= exynos_init_late,
>  	.init_time	= exynos4_timer_init,
>  	.dt_compat	= exynos4_dt_compat,
> diff --git a/arch/arm/mach-imx/imx25-dt.c b/arch/arm/mach-imx/imx25-dt.c
> index 8234839..2ecaa6a 100644
> --- a/arch/arm/mach-imx/imx25-dt.c
> +++ b/arch/arm/mach-imx/imx25-dt.c
> @@ -17,11 +17,6 @@
>  #include "common.h"
>  #include "mx25.h"
>  
> -static void __init imx25_dt_init(void)
> -{
> -	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> -}
> -
>  static const char * const imx25_dt_board_compat[] __initconst = {
>  	"fsl,imx25",
>  	NULL
> @@ -38,7 +33,6 @@ DT_MACHINE_START(IMX25_DT, "Freescale i.MX25 (Device Tree Support)")
>  	.init_irq	= mx25_init_irq,
>  	.handle_irq	= imx25_handle_irq,
>  	.init_time	= imx25_timer_init,
> -	.init_machine	= imx25_dt_init,
>  	.dt_compat	= imx25_dt_board_compat,
>  	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/imx31-dt.c b/arch/arm/mach-imx/imx31-dt.c
> index 67de611..5bb05d5 100644
> --- a/arch/arm/mach-imx/imx31-dt.c
> +++ b/arch/arm/mach-imx/imx31-dt.c
> @@ -18,11 +18,6 @@
>  #include "common.h"
>  #include "mx31.h"
>  
> -static void __init imx31_dt_init(void)
> -{
> -	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> -}
> -
>  static const char *imx31_dt_board_compat[] __initdata = {
>  	"fsl,imx31",
>  	NULL
> @@ -39,7 +34,6 @@ DT_MACHINE_START(IMX31_DT, "Freescale i.MX31 (Device Tree Support)")
>  	.init_irq	= mx31_init_irq,
>  	.handle_irq	= imx31_handle_irq,
>  	.init_time	= imx31_dt_timer_init,
> -	.init_machine	= imx31_dt_init,
>  	.dt_compat	= imx31_dt_board_compat,
>  	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/imx51-dt.c b/arch/arm/mach-imx/imx51-dt.c
> index e2926a8..52985a5 100644
> --- a/arch/arm/mach-imx/imx51-dt.c
> +++ b/arch/arm/mach-imx/imx51-dt.c
> @@ -19,11 +19,6 @@
>  #include "common.h"
>  #include "mx51.h"
>  
> -static void __init imx51_dt_init(void)
> -{
> -	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> -}
> -
>  static const char *imx51_dt_board_compat[] __initdata = {
>  	"fsl,imx51",
>  	NULL
> @@ -40,7 +35,6 @@ DT_MACHINE_START(IMX51_DT, "Freescale i.MX51 (Device Tree Support)")
>  	.init_irq	= mx51_init_irq,
>  	.handle_irq	= imx51_handle_irq,
>  	.init_time	= imx51_timer_init,
> -	.init_machine	= imx51_dt_init,
>  	.init_late	= imx51_init_late,
>  	.dt_compat	= imx51_dt_board_compat,
>  	.restart	= mxc_restart,
> diff --git a/arch/arm/mach-msm/board-dt-8660.c b/arch/arm/mach-msm/board-dt-8660.c
> index 7dcfc53..0c21245 100644
> --- a/arch/arm/mach-msm/board-dt-8660.c
> +++ b/arch/arm/mach-msm/board-dt-8660.c
> @@ -25,16 +25,6 @@ static void __init msm8x60_init_late(void)
>  	smd_debugfs_init();
>  }
>  
> -static struct of_dev_auxdata msm_auxdata_lookup[] __initdata = {
> -	{}
> -};
> -
> -static void __init msm8x60_dt_init(void)
> -{
> -	of_platform_populate(NULL, of_default_bus_match_table,
> -			msm_auxdata_lookup, NULL);
> -}
> -
>  static const char *msm8x60_fluid_match[] __initdata = {
>  	"qcom,msm8660-fluid",
>  	"qcom,msm8660-surf",
> @@ -45,7 +35,6 @@ DT_MACHINE_START(MSM_DT, "Qualcomm MSM (Flattened Device Tree)")
>  	.smp = smp_ops(msm_smp_ops),
>  	.map_io = msm_map_msm8x60_io,
>  	.init_irq = irqchip_init,
> -	.init_machine = msm8x60_dt_init,
>  	.init_late = msm8x60_init_late,
>  	.init_time	= msm_dt_timer_init,
>  	.dt_compat = msm8x60_fluid_match,
> diff --git a/arch/arm/mach-msm/board-dt-8960.c b/arch/arm/mach-msm/board-dt-8960.c
> index 7301936..26461d2 100644
> --- a/arch/arm/mach-msm/board-dt-8960.c
> +++ b/arch/arm/mach-msm/board-dt-8960.c
> @@ -18,11 +18,6 @@
>  
>  #include "common.h"
>  
> -static void __init msm_dt_init(void)
> -{
> -	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> -}
> -
>  static const char * const msm8960_dt_match[] __initconst = {
>  	"qcom,msm8960-cdp",
>  	NULL
> @@ -33,6 +28,5 @@ DT_MACHINE_START(MSM8960_DT, "Qualcomm MSM (Flattened Device Tree)")
>  	.map_io = msm_map_msm8960_io,
>  	.init_irq = irqchip_init,
>  	.init_time	= msm_dt_timer_init,
> -	.init_machine = msm_dt_init,
>  	.dt_compat = msm8960_dt_match,
>  MACHINE_END
> diff --git a/arch/arm/mach-tegra/board-dt-tegra114.c b/arch/arm/mach-tegra/board-dt-tegra114.c
> index 085d636..ec7b8bf 100644
> --- a/arch/arm/mach-tegra/board-dt-tegra114.c
> +++ b/arch/arm/mach-tegra/board-dt-tegra114.c
> @@ -23,11 +23,6 @@
>  #include "board.h"
>  #include "common.h"
>  
> -static void __init tegra114_dt_init(void)
> -{
> -	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> -}
> -
>  static const char * const tegra114_dt_board_compat[] = {
>  	"nvidia,tegra114",
>  	NULL,
> @@ -39,7 +34,6 @@ DT_MACHINE_START(TEGRA114_DT, "NVIDIA Tegra114 (Flattened Device Tree)")
>  	.init_early	= tegra114_init_early,
>  	.init_irq	= tegra_dt_init_irq,
>  	.init_time	= clocksource_of_init,
> -	.init_machine	= tegra114_dt_init,
>  	.init_late	= tegra_init_late,
>  	.restart	= tegra_assert_system_reset,
>  	.dt_compat	= tegra114_dt_board_compat,
> diff --git a/arch/arm/mach-tegra/board-dt-tegra30.c b/arch/arm/mach-tegra/board-dt-tegra30.c
> index bf68567..316bd9f 100644
> --- a/arch/arm/mach-tegra/board-dt-tegra30.c
> +++ b/arch/arm/mach-tegra/board-dt-tegra30.c
> @@ -37,11 +37,6 @@
>  #include "common.h"
>  #include "iomap.h"
>  
> -static void __init tegra30_dt_init(void)
> -{
> -	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> -}
> -
>  static const char *tegra30_dt_board_compat[] = {
>  	"nvidia,tegra30",
>  	NULL
> @@ -53,7 +48,6 @@ DT_MACHINE_START(TEGRA30_DT, "NVIDIA Tegra30 (Flattened Device Tree)")
>  	.init_early	= tegra30_init_early,
>  	.init_irq	= tegra_dt_init_irq,
>  	.init_time	= clocksource_of_init,
> -	.init_machine	= tegra30_dt_init,
>  	.init_late	= tegra_init_late,
>  	.restart	= tegra_assert_system_reset,
>  	.dt_compat	= tegra30_dt_board_compat,
> diff --git a/arch/arm/mach-virt/virt.c b/arch/arm/mach-virt/virt.c
> index 31666f6..7bce0f8 100644
> --- a/arch/arm/mach-virt/virt.c
> +++ b/arch/arm/mach-virt/virt.c
> @@ -27,11 +27,6 @@
>  #include <asm/mach/arch.h>
>  #include <asm/mach/time.h>
>  
> -static void __init virt_init(void)
> -{
> -	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> -}
> -
>  static void __init virt_timer_init(void)
>  {
>  	WARN_ON(arch_timer_of_register() != 0);
> @@ -48,7 +43,6 @@ extern struct smp_operations virt_smp_ops;
>  DT_MACHINE_START(VIRT, "Dummy Virtual Machine")
>  	.init_irq	= irqchip_init,
>  	.init_time	= virt_timer_init,
> -	.init_machine	= virt_init,
>  	.smp		= smp_ops(virt_smp_ops),
>  	.dt_compat	= virt_dt_match,
>  MACHINE_END
> -- 
> 1.8.1.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
