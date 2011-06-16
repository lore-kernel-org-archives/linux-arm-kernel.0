From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 16 Jun 2011 09:32:53 +0200
Subject: [PATCH] mach-h720x: fix build error
In-Reply-To: <1308127401-30734-1-git-send-email-linus.walleij@stericsson.com>
References: <1308127401-30734-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110616073253.GG23771@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2011 at 10:43:21AM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The h7201/h7202 machines did not build since they define
> ARM_DMA_ZONE_OFFSET but do not select ZONE_DMA. Fix it up by
> selecting ZONE_DMA in their Kconfig.
> 
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

I could take this through my i.MX tree, though the topic is quite wrong.
Can you check this into the patch system?

Sascha

> ---
>  arch/arm/mach-h720x/Kconfig |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-h720x/Kconfig b/arch/arm/mach-h720x/Kconfig
> index 9b6982e..abf356c 100644
> --- a/arch/arm/mach-h720x/Kconfig
> +++ b/arch/arm/mach-h720x/Kconfig
> @@ -6,12 +6,14 @@ config ARCH_H7201
>  	bool "gms30c7201"
>  	depends on ARCH_H720X
>  	select CPU_H7201
> +	select ZONE_DMA
>  	help
>  	  Say Y here if you are using the Hynix GMS30C7201 Reference Board
>  
>  config ARCH_H7202
>  	bool "hms30c7202"
>  	select CPU_H7202
> +	select ZONE_DMA
>  	depends on ARCH_H720X
>  	help
>  	  Say Y here if you are using the Hynix HMS30C7202 Reference Board
> -- 
> 1.7.3.2
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
