From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Feb 2017 14:41:51 +0100
Subject: [PATCH 06/11] tty: serial: Add Actions Semi Owl UART earlycon
In-Reply-To: <20170215165528.10052-7-afaerber@suse.de>
References: <20170215165528.10052-1-afaerber@suse.de>
 <20170215165528.10052-7-afaerber@suse.de>
Message-ID: <3685307.zVcugmQnxp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, February 15, 2017 5:55:23 PM CET Andreas F?rber wrote:
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 6117ac8..9d4213c 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1677,6 +1677,25 @@ config SERIAL_MVEBU_CONSOLE
>           and warnings and which allows logins in single user mode)
>           Otherwise, say 'N'.
>  
> +config SERIAL_OWL
> +       bool "Actions Semi Owl serial port support"
> +       depends on ARCH_OWL || COMPILE_TEST
> +       select SERIAL_CORE
> +       help
> +         This driver is for Actions Semi S500/S900 SoC's UART.
> +         Say 'Y' here if you wish to use the on-board serial port.
> +         Otherwise, say 'N'.
> +
> 

This could maybe use a word of information about how there isn't
actually a uart driver in this series, only an earlycon driver.

Do you plan to add the actual tty driver soon? If not, maybe
only add one Kconfig symbol for the earlycon support.

	Arnd
