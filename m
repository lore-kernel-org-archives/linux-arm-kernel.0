From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 05 Oct 2010 18:23:19 +0900
Subject: [PATCH 1/7] ARM: S5PC210: Universal OneNAND support
In-Reply-To: <20100930044822.GA16897@july>
References: <20100930044822.GA16897@july>
Message-ID: <003001cb646f$0f492370$2ddb6a50$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> OneNAND device support for Universal board.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv310/Kconfig               |    1 +
>  arch/arm/mach-s5pv310/mach-universal_c210.c |    2 ++
>  2 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
> index 9941852..178eab9 100644
> --- a/arch/arm/mach-s5pv310/Kconfig
> +++ b/arch/arm/mach-s5pv310/Kconfig
> @@ -40,6 +40,7 @@ config MACH_SMDKC210
>  config MACH_UNIVERSAL_C210
>  	bool "Mobile UNIVERSAL_C210 Board"
>  	select CPU_S5PV310
> +	select S5P_DEV_ONENAND
>  	help
>  	  Machine support for Samsung Mobile Universal S5PC210 Reference
>  	  Board. S5PC210(MCP) is one of package option of S5PV310
> diff --git a/arch/arm/mach-s5pv310/mach-universal_c210.c b/arch/arm/mach-
> s5pv310/mach-universal_c210.c
> index b57efae..e169849 100644
> --- a/arch/arm/mach-s5pv310/mach-universal_c210.c
> +++ b/arch/arm/mach-s5pv310/mach-universal_c210.c
> @@ -20,6 +20,7 @@
>  #include <plat/regs-serial.h>
>  #include <plat/s5pv310.h>
>  #include <plat/cpu.h>
> +#include <plat/devs.h>
> 
>  #include <mach/map.h>
> 
> @@ -117,6 +118,7 @@ static struct platform_device universal_gpio_keys = {
> 
>  static struct platform_device *universal_devices[] __initdata = {
>  	&universal_gpio_keys,
> +	&s5p_device_onenand,
>  };
> 
>  static void __init universal_map_io(void)
> --

Ok...will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
