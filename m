From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 Mar 2014 13:14:57 +0900
Subject: [PATCH 54/62] ARM: samsung: select ATAGS where necessary
In-Reply-To: <1395257399-359545-55-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-55-git-send-email-arnd@arndb.de>
Message-ID: <022e01cf43f2$f423fea0$dc6bfbe0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> Most of the Samsung platforms do not yet allow building with
> DT at all, so we should select CONFIG_ATAGS for now in all
> cases we also select CONFIG_SAMSUNG_ATAGS.
> 
> Found during randconfig testing.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks,
Kukjin

> Cc: Ben Dooks <ben-linux@fluff.org>
> ---
>  arch/arm/Kconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 6ffcadd..3fb9b7e 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -731,6 +731,7 @@ config ARCH_S3C24XX
>  	bool "Samsung S3C24XX SoCs"
>  	select ARCH_HAS_CPUFREQ
>  	select ARCH_REQUIRE_GPIOLIB
> +	select ATAGS
>  	select CLKDEV_LOOKUP
>  	select CLKSRC_SAMSUNG_PWM
>  	select GENERIC_CLOCKEVENTS
> @@ -753,6 +754,7 @@ config ARCH_S3C64XX
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARM_AMBA
>  	select ARM_VIC
> +	select ATAGS
>  	select CLKDEV_LOOKUP
>  	select CLKSRC_SAMSUNG_PWM
>  	select COMMON_CLK
> @@ -776,6 +778,7 @@ config ARCH_S3C64XX
> 
>  config ARCH_S5P64X0
>  	bool "Samsung S5P6440 S5P6450"
> +	select ATAGS
>  	select CLKDEV_LOOKUP
>  	select CLKSRC_SAMSUNG_PWM
>  	select CPU_V6
> @@ -794,6 +797,7 @@ config ARCH_S5P64X0
>  config ARCH_S5PC100
>  	bool "Samsung S5PC100"
>  	select ARCH_REQUIRE_GPIOLIB
> +	select ATAGS
>  	select CLKDEV_LOOKUP
>  	select CLKSRC_SAMSUNG_PWM
>  	select CPU_V7
> @@ -813,6 +817,7 @@ config ARCH_S5PV210
>  	select ARCH_HAS_CPUFREQ
>  	select ARCH_HAS_HOLES_MEMORYMODEL
>  	select ARCH_SPARSEMEM_ENABLE
> +	select ATAGS
>  	select CLKDEV_LOOKUP
>  	select CLKSRC_SAMSUNG_PWM
>  	select CPU_V7
> --
> 1.8.3.2
