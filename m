From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 26 Jan 2015 12:01:06 +0100
Subject: [PATCH 2/4] ARM: Alpine: early-debug print support
In-Reply-To: <54c5365c.v0Ob21sdO6QYSZZM%tsahee@annapurnalabs.com>
References: <54c5365c.v0Ob21sdO6QYSZZM%tsahee@annapurnalabs.com>
Message-ID: <1504954.Jxbc2j5qJq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 25 January 2015 20:30:52 Tsahee Zidenberg wrote:
> Alpine platform includes UART8250 that can be used for early prints.
> 
> Signed-off-by: Saeed Bishara <saeed@annapurnalabs.com>
> Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>

The entries look ok, but please keep them all sorted in the
respective lists.

> ---
>  arch/arm/Kconfig.debug | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 5ddd490..db6c389 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -1031,6 +1031,14 @@ choice
>  		  This option selects UART0 on VIA/Wondermedia System-on-a-chip
>  		  devices, including VT8500, WM8505, WM8650 and WM8850.
>  
> +	config DEBUG_ALPINE_UART0
> +		bool "Kernel low-level debugging messages via Alpine UART0"
> +		depends on ARCH_ALPINE
> +		select DEBUG_UART_8250
> +		help
> +		  Say Y here if you want kernel low-level debugging support
> +		  on Alpine based platforms.
> +

This one is sorted alphabetically

>  	config DEBUG_LL_UART_NONE
>  		bool "No low-level debugging UART"
>  		depends on !ARCH_MULTIPLATFORM
> @@ -1312,6 +1320,7 @@ config DEBUG_UART_PHYS
>  	default 0xfff36000 if DEBUG_HIGHBANK_UART
>  	default 0xfffe8600 if DEBUG_UART_BCM63XX
>  	default 0xfffff700 if ARCH_IOP33X
> +	default 0xfd883000 if DEBUG_ALPINE_UART0
>  	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
>  		DEBUG_LL_UART_EFM32 || \

And the other two are sorted by address.

	Arnd
