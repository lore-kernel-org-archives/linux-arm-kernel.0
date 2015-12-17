From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Dec 2015 10:45:08 +0000
Subject: [PATCH 09/10] ARM: debug-ll: reorder Kconfig alphanumerically
In-Reply-To: <1449268242-808553-10-git-send-email-arnd@arndb.de>
References: <1449268242-808553-1-git-send-email-arnd@arndb.de>
 <1449268242-808553-10-git-send-email-arnd@arndb.de>
Message-ID: <20151217104508.GG8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2015 at 11:30:41PM +0100, Arnd Bergmann wrote:
> +	config DEBUG_LL_UART_EFM32
> +		bool "Kernel low-level debugging via efm32 UART"
> +		depends on ARCH_EFM32
> +		help
> +		  Say Y here if you want the debug print routines to direct
> +		  their output to an UART or USART port on efm32 based
> +		  machines. Use the following addresses for DEBUG_UART_PHYS:
> +
> +		    0x4000c000 | USART0
> +		    0x4000c400 | USART1
> +		    0x4000c800 | USART2
> +		    0x4000e000 | UART0
> +		    0x4000e400 | UART1
> +

NAK.  The DEBUG_LL options are _supposed_ to be at the end - this option
was correctly positioned:

>  	config DEBUG_LL_UART_8250
>  		bool "Kernel low-level debugging via 8250 UART"
>  		help
> @@ -1285,20 +1299,6 @@ choice
>  		  options; the platform specific options are deprecated
>  		  and will be soon removed.
>  
> -	config DEBUG_LL_UART_EFM32
> -		bool "Kernel low-level debugging via efm32 UART"
> -		depends on ARCH_EFM32
> -		help
> -		  Say Y here if you want the debug print routines to direct
> -		  their output to an UART or USART port on efm32 based
> -		  machines. Use the following addresses for DEBUG_UART_PHYS:
> -
> -		    0x4000c000 | USART0
> -		    0x4000c400 | USART1
> -		    0x4000c800 | USART2
> -		    0x4000e000 | UART0
> -		    0x4000e400 | UART1
> -
>  	config DEBUG_LL_UART_PL01X
>  		bool "Kernel low-level debugging via ARM Ltd PL01x Primecell UART"
>  		help

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
