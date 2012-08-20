From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 20 Aug 2012 17:03:35 +0200
Subject: [PATCH] ARM: at91: automatically select DT support for sam9x5
 and sam9n12
In-Reply-To: <1345473840-22141-1-git-send-email-ludovic.desroches@atmel.com>
References: <1345473840-22141-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20120820150335.GH7439@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:44 Mon 20 Aug     , ludovic.desroches at atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> at91sam9x5 and at91sam9n12 only have device tree support so we can
> select device tree support when selecting these chips.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
>  arch/arm/mach-at91/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index c8050b1..db94ec6 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -88,6 +88,7 @@ config SOC_AT91SAM9X5
>  	select HAVE_AT91_DBGU0
>  	select HAVE_FB_ATMEL
>  	select HAVE_NET_MACB
> +	select MACH_AT91SAM_DT
>  	help
>  	  Select this if you are using one of Atmel's AT91SAM9x5 family SoC.
>  	  This means that your SAM9 name finishes with a '5' (except if it is
> @@ -100,6 +101,7 @@ config SOC_AT91SAM9N12
>  	select SOC_AT91SAM9
>  	select HAVE_AT91_DBGU0
>  	select HAVE_FB_ATMEL
> +	select MACH_AT91SAM_DT
as we are goig to have more and more soc put it as default in the
MACH_AT91SAM_DT if the DT is enabled

Best Regards,
J.
