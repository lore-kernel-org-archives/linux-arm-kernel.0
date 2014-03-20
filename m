From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 20 Mar 2014 21:48:47 +0100
Subject: [PATCH 10/62] ARM: efm32: select AUTO_ZRELADDR
In-Reply-To: <1395257399-359545-11-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-11-git-send-email-arnd@arndb.de>
Message-ID: <20140320204847.GD23076@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On Wed, Mar 19, 2014 at 08:29:07PM +0100, Arnd Bergmann wrote:
> The efm32 platform does not provide a zreladdr-y line its Makefile.boot,
> so we always have to use CONFIG_AUTO_ZRELADDR in order to successfully
> build and link a zImage.
I wonder why you need to AUTO_ZRELADDR (which is there to guess
zreladdr) while efm32 doesn't have an MMU and so there is nothing to
guess. So I think this patch fixes a build problem, but it's not a good
change.

Best regards
Uwe
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Uwe Kleine-K?nig <kernel@pengutronix.de>
> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 62ede9b..5776c12 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -422,6 +422,7 @@ config ARCH_EFM32
>  	bool "Energy Micro efm32"
>  	depends on !MMU
>  	select ARCH_REQUIRE_GPIOLIB
> +	select AUTO_ZRELADDR
>  	select ARM_NVIC
>  	select CLKSRC_OF
>  	select COMMON_CLK
> -- 
> 1.8.3.2
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
