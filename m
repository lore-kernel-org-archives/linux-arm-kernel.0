From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 21 Oct 2014 09:20:50 +0200 (CEST)
Subject: [PATCH v7 02/10] ARM: add lolevel debug support for asm9260
In-Reply-To: <1413875672-7894-3-git-send-email-linux@rempel-privat.de>
References: <1413875672-7894-1-git-send-email-linux@rempel-privat.de>
 <1413875672-7894-3-git-send-email-linux@rempel-privat.de>
Message-ID: <alpine.DEB.2.11.1410210920130.5308@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Oct 2014, Oleksij Rempel wrote:
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

What's the point of having this list in Kconfig?

Thanks,

	tglx
