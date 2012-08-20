From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 20 Aug 2012 18:26:51 +0200
Subject: [PATCH v2] ARM: at91: select DT support by default
In-Reply-To: <1345477226-23483-1-git-send-email-ludovic.desroches@atmel.com>
References: <1345477226-23483-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20120820162651.GB7456@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:40 Mon 20 Aug     , ludovic.desroches at atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Since at91sam9x5, at91sam9n12 and future SOCs only have device tree
> support, select it by default.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
>  arch/arm/mach-at91/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index c8050b1..5aee940 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -502,6 +502,7 @@ comment "Generic Board Type"
>  
>  config MACH_AT91SAM_DT
>  	bool "Atmel AT91SAM Evaluation Kits with device-tree support"
> +	default y
>  	select USE_OF
no you can not force the USE_OF

force the machine by default if USE_OF ok otherwise no
to this you need to select the USE_OF as SoC level

Best Regards,
J.
