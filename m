From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Wed, 14 Mar 2018 13:58:32 +0800
Subject: [PATCH 1/8] ARM: berlin: extend BG2CD Kconfig entry
In-Reply-To: <20180311160008.22928-2-amonakov@ispras.ru>
References: <20180311160008.22928-1-amonakov@ispras.ru>
 <20180311160008.22928-2-amonakov@ispras.ru>
Message-ID: <20180314135832.0ebdeb66@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 11 Mar 2018 19:00:01 +0300 Alexander Monakov wrote:

> BG2CD SoC uses r3p0 Cortex-A9 MPCore single-CPU cluster. Autoselect
> pertinent errata, the SCU and the global timer, and allow use of the
> local timer on uniprocessor kernels.
> 
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> ---
>  arch/arm/mach-berlin/Kconfig | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
> index 63ab1d368625..d07ed4cd5fd7 100644
> --- a/arch/arm/mach-berlin/Kconfig
> +++ b/arch/arm/mach-berlin/Kconfig
> @@ -23,9 +23,14 @@ config MACH_BERLIN_BG2
>  
>  config MACH_BERLIN_BG2CD
>  	bool "Marvell Armada 1500-mini (BG2CD)"
> +	select ARM_ERRATA_754322
> +	select ARM_ERRATA_775420
> +	select ARM_GLOBAL_TIMER
>  	select CACHE_L2X0
> -	select HAVE_ARM_TWD if SMP
> +	select HAVE_ARM_SCU
> +	select HAVE_ARM_TWD
>  	select PINCTRL_BERLIN_BG2CD
> +	select PL310_ERRATA_769419

IIRC, BG2CD doesn't need this

>  
>  config MACH_BERLIN_BG2Q
>  	bool "Marvell Armada 1500 Pro (BG2-Q)"
