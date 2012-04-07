From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 7 Apr 2012 05:19:08 +0200
Subject: [PATCH 1/2] ARM: at91: Export at91_pmc_base
In-Reply-To: <1333747466-5076-1-git-send-email-joachim.eastwood@jotron.com>
References: <1333747466-5076-1-git-send-email-joachim.eastwood@jotron.com>
Message-ID: <20120407031908.GB16641@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23:24 Fri 06 Apr     , Joachim Eastwood wrote:
> After commit b55149529d26 (ARM: at91/PMC: make register base soc independent)
> building atmel_usba_udc as a module fails with following message
>   ERROR: "at91_pmc_base" [drivers/usb/gadget/atmel_usba_udc.ko] undefined!
>   make[1]: *** [__modpost] Error 1
>   make: *** [modules] Error 2
> 
> Export symbol to allow driver to be built as a module again.
> 
> Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>
> ---
>  arch/arm/mach-at91/clock.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
> index a0f4d74..9caaa35 100644
> --- a/arch/arm/mach-at91/clock.c
> +++ b/arch/arm/mach-at91/clock.c
> @@ -35,6 +35,7 @@
>  #include "generic.h"
>  
>  void __iomem *at91_pmc_base;
> +EXPORT_SYMBOL(at91_pmc_base);
EXPORT_SYMBOL_GPL

Best Regards,
J.
