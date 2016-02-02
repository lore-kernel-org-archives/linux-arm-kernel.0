From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 02 Feb 2016 22:07:17 +0100
Subject: [PATCH 01/10] serial: mvebu-uart: initial support for Armada-3700
 serial port
In-Reply-To: <1454436468-4241-2-git-send-email-gregory.clement@free-electrons.com>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
 <1454436468-4241-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <5687888.WDl8xbENFR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 February 2016 19:07:39 Gregory CLEMENT wrote:

> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 39721ec4f415..b291f934d51b 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1606,6 +1606,28 @@ config SERIAL_STM32_CONSOLE
>  	depends on SERIAL_STM32=y
>  	select SERIAL_CORE_CONSOLE
>  
> +config SERIAL_MVEBU_UART
> +	bool "Marvell EBU serial port support"

Could this be a loadable module?

> +config SERIAL_MVEBU_CONSOLE
> +	bool "Console on Marvell EBU serial port"
> +	depends on SERIAL_MVEBU_UART

If yes, this would become 

	depends on SERIAL_MVEBU_UART=y

	Arnd
