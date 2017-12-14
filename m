From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 14 Dec 2017 12:13:51 +0100
Subject: [PATCH v3 07/11] thermal: armada: Update Kconfig and module
 description
In-Reply-To: <20171214103011.24713-8-miquel.raynal@free-electrons.com> (Miquel
 Raynal's message of "Thu, 14 Dec 2017 11:30:07 +0100")
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
 <20171214103011.24713-8-miquel.raynal@free-electrons.com>
Message-ID: <87po7ho93k.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,
 
 On jeu., d?c. 14 2017, Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> Update Armada thermal driver Kconfig entry as well as the driver's
> MODULE_DESCRIPTION content, now that 64-bit SoCs are also supported,
> eg. Armada 7K and Armada 8K.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> ---
>  drivers/thermal/Kconfig          | 4 ++--
>  drivers/thermal/armada_thermal.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 315ae2926e20..44cad046f272 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -301,13 +301,13 @@ config DB8500_THERMAL
>  	  thermal zone if trip points reached.
>  
>  config ARMADA_THERMAL
> -	tristate "Armada 370/XP thermal management"
> +	tristate "Armada 370/XP/7K/8K thermal management"
if you want to be exhaustive you should also add Armada 375 and 38x.

>  	depends on ARCH_MVEBU || COMPILE_TEST
>  	depends on HAS_IOMEM
>  	depends on OF
>  	help
>  	  Enable this option if you want to have support for thermal management
> -	  controller present in Armada 370 and Armada XP SoC.
> +	  controller present in Armada 370, Armada XP, Armada 7K/8K
> SoCs.

here as well.

Gregory

>  
>  config DA9062_THERMAL
>  	tristate "DA9062/DA9061 Dialog Semiconductor thermal driver"
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index f5c911524656..da58a8961a37 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -403,5 +403,5 @@ static struct platform_driver armada_thermal_driver = {
>  module_platform_driver(armada_thermal_driver);
>  
>  MODULE_AUTHOR("Ezequiel Garcia <ezequiel.garcia@free-electrons.com>");
> -MODULE_DESCRIPTION("Armada 370/XP thermal driver");
> +MODULE_DESCRIPTION("Armada SoCs thermal driver");
>  MODULE_LICENSE("GPL v2");
> -- 
> 2.11.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
