From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 3 Aug 2013 10:12:00 -0400
Subject: [PATCH] leds: leds-netxbig: depends on ARCH_KIRKWOOD
In-Reply-To: <1375479274-9942-1-git-send-email-simon.guinot@sequanux.org>
References: <1375369655-1310-8-git-send-email-thomas.petazzoni@free-electrons.com>
 <1375479274-9942-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20130803141200.GI5882@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 11:34:34PM +0200, Simon Guinot wrote:
> With the DT conversion, the board Kconfig symbols MACH_ are going to be
> removed. In order to prepare this removal, this patch replaces alls the
> machines dependencies for leds-netxbig by ARCH_KIRKWOOD.
> 
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> ---
> Thomas,
> 
> Please, insert this patch in your series before the patch named:
> [PATCHv2 7/9] ARM: kirkwood: convert LaCie Net{2, 5}Big v2 platforms to DT

Nah, this should go through linux-leds.

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.

>  drivers/leds/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 0e41460..7226696 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -407,8 +407,8 @@ config LEDS_NS2
>  
>  config LEDS_NETXBIG
>  	tristate "LED support for Big Network series LEDs"
> -	depends on MACH_NET2BIG_V2 || MACH_NET5BIG_V2
>  	depends on LEDS_CLASS
> +	depends on ARCH_KIRKWOOD
>  	default y
>  	help
>  	  This option enable support for LEDs found on the LaCie 2Big
> -- 
> 1.7.10.4
> 
