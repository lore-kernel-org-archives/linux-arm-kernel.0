From: xuwei5@hisilicon.com (Wei Xu)
Date: Tue, 26 Apr 2016 09:30:43 +0100
Subject: [PATCH] ARM: debug: remove extraneous DEBUG_HI3716_UART option
In-Reply-To: <1461590006-1395429-1-git-send-email-arnd@arndb.de>
References: <1461590006-1395429-1-git-send-email-arnd@arndb.de>
Message-ID: <571F2733.6070609@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 25/04/2016 14:13, Arnd Bergmann wrote:
> DEBUG_HI3716_UART was supposed to be renamed to DEBUG_HIX5HD2_UART, but
> accidentally both got left in place, which results in a build error when
> CONFIG_DEBUG_UART_PHYS is not set as it should be.
> 
> This removes the old symbol.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 12aae3097454 ("ARM: debug: Rename Hi3716 to HIX5HD2")
> ---
>  arch/arm/Kconfig.debug | 8 --------
>  1 file changed, 8 deletions(-)

Thanks!
Fine to me.
Should I pick up it and send a pull request or
will you directly pick up it?

Best Regards,
Wei

> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 6993978cfd6f..2afd38766707 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -268,14 +268,6 @@ choice
>  		  Say Y here if you want kernel low-level debugging support
>  		  on HI3620 UART.
>  
> -	config DEBUG_HI3716_UART
> -		bool "Hisilicon Hi3716 Debug UART"
> -		depends on ARCH_HI3xxx
> -		select DEBUG_UART_PL01X
> -		help
> -		  Say Y here if you want kernel low-level debugging support
> -		  on HI3716 UART.
> -
>  	config DEBUG_HIGHBANK_UART
>  		bool "Kernel low-level debugging messages via Highbank UART"
>  		depends on ARCH_HIGHBANK
> 
