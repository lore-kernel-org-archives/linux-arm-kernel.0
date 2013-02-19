From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 19 Feb 2013 15:57:07 +0530
Subject: [PATCH, RFC 5/8] ARM: OMAP2+: am43: Kconfig
In-Reply-To: <5951ba90110b97fb494743e1aedf26aaa92b97a9.1361186097.git.afzal@ti.com>
References: <cover.1361186097.git.afzal@ti.com>
 <5951ba90110b97fb494743e1aedf26aaa92b97a9.1361186097.git.afzal@ti.com>
Message-ID: <5123537B.8050709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 February 2013 05:08 PM, Afzal Mohammed wrote:
> Add Kconfig option for AM43 family of SoC's, these are ARM Cortex A9
> based (SMP configuration with 1 core).
>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>   arch/arm/mach-omap2/Kconfig | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 49ac3df..683fbaa 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -141,6 +141,17 @@ config SOC_AM33XX
>   	select MULTI_IRQ_HANDLER
>   	select COMMON_CLK
>
> +config SOC_AM43
> +	bool "TI AM43"
> +	depends on ARCH_OMAP2PLUS
> +	default y
> +	select CPU_V7
> +	select HAVE_SMP
You don't need this
> +	select LOCAL_TIMERS if SMP
This one as well

> +	select MULTI_IRQ_HANDLER
And this one too I guess.

Rest is fine.

regards,
Santosh
