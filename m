From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Oct 2014 15:35:43 +0100
Subject: [PATCH v6 02/10] ARM: add lolevel debug support for asm9260
In-Reply-To: <1413814203-8785-3-git-send-email-linux@rempel-privat.de>
References: <1413814203-8785-1-git-send-email-linux@rempel-privat.de>
 <1413814203-8785-3-git-send-email-linux@rempel-privat.de>
Message-ID: <20141020143543.GW27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 20, 2014 at 04:09:55PM +0200, Oleksij Rempel wrote:
> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
> ---
>  arch/arm/Kconfig.debug           | 33 ++++++++++++++++++++++++++++++---
>  arch/arm/include/debug/asm9260.S | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/include/debug/asm9260.S
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index b11ad54..6902a57 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -953,6 +953,27 @@ choice
>  		  options; the platform specific options are deprecated
>  		  and will be soon removed.
>  
> +	config DEBUG_ASM9260_UART
> +		bool "Kernel low-level debugging via asm9260 UART"
> +		depends on MACH_ASM9260
> +		help
> +		  Say Y here if you want the debug print routines to direct
> +		  their output to an UART or USART port on asm9260 based
> +		  machines.
> +
> +		    DEBUG_UART_PHYS | DEBUG_UART_VIRT
> +
> +		    0x80000000      | 0xf0000000     | UART0
> +		    0x80004000      | 0xf0004000     | UART1
> +		    0x80008000      | 0xf0008000     | UART2
> +		    0x8000c000      | 0xf000c000     | UART3
> +		    0x80010000      | 0xf0010000     | UART4
> +		    0x80014000      | 0xf0014000     | UART5
> +		    0x80018000      | 0xf0018000     | UART6
> +		    0x8001c000      | 0xf001c000     | UART7
> +		    0x80020000      | 0xf0020000     | UART8
> +		    0x80024000      | 0xf0024000     | UART9
> +

Also badly placed.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
