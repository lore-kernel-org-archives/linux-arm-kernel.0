From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 12 Sep 2009 21:31:15 +0200
Subject: [PATCH 2/2] PalmTreo: add Palm Centro 685 support
In-Reply-To: <1252670222-25233-3-git-send-email-sleep_walker@suse.cz>
References: <1252670222-25233-1-git-send-email-sleep_walker@suse.cz>
	<1252670222-25233-2-git-send-email-sleep_walker@suse.cz>
	<1252670222-25233-3-git-send-email-sleep_walker@suse.cz>
Message-ID: <200909122131.15359.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne P? 11. z??? 2009 13:57:02 Tom?? ?ech napsal(a):
> From: Tom?? ?ech <sleep walker@suse.cz>
>
>
> Signed-off-by: Tom?? ?ech <sleep_walker@suse.cz>
> ---
>  arch/arm/mach-pxa/Kconfig                 |   13 ++-
>  arch/arm/mach-pxa/include/mach/palmtreo.h |    7 ++
>  arch/arm/mach-pxa/palmtreo.c              |  161
> +++++++++++++++++++++++++++++ arch/arm/mm/mmu.c                         |  
>  2 +-
>  4 files changed, 181 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> index ce6519c..57eceb8 100644
> --- a/arch/arm/mach-pxa/Kconfig
> +++ b/arch/arm/mach-pxa/Kconfig
> @@ -425,6 +425,17 @@ config PALM_TREO
>  	bool
>  	depends on ARCH_PXA_PALM
>
> +config MACH_CENTRO
> +	bool "Palm Centro 685 (GSM)"
> +	default y
> +	depends on ARCH_PXA_PALM
> +	select PXA27x
> +	select IWMMXT
> +	select PALM_TREO
> +	help
> +	  Say Y here if you intend to run this kernel on Palm Centro 685 (GSM)
> +	  smartphone.
> +
>  config MACH_TREO680
>  	bool "Palm Treo 680"
>  	default y
> @@ -433,7 +444,7 @@ config MACH_TREO680
>  	select IWMMXT
>  	select PALM_TREO
>  	help
> -	  Say Y here if you intend to run this kernel on Palm Treo 680
> +	  Say Y here if you intend to run this kernel on Palm Treo 680 (GSM)

This change certainly should not be in this patch, maybe in previous one ?

>  	  smartphone.
>
>  config MACH_PALMLD
...
Cheers!
