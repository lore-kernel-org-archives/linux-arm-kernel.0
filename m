From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Feb 2016 22:20:51 +0100
Subject: [PATCH v4 03/12] serial: mvebu-uart: initial support for
 Armada-3700 serial port
In-Reply-To: <1455646502-23834-4-git-send-email-gregory.clement@free-electrons.com>
References: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
 <1455646502-23834-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <3647094.zzYms58VAY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 February 2016 19:14:53 Gregory CLEMENT wrote:
> 
> +config SERIAL_MVEBU_UART
> +       bool "Marvell EBU serial port support"
> +       select SERIAL_CORE

It would be nice to make this a tristate option with

	depends on ARCH_MVEBU || COMPILE_TEST

so we can build it in an allmodconfig kernel as a standalone module
like the other drivers.

> +
> +config SERIAL_MVEBU_CONSOLE
> +       bool "Console on Marvell EBU serial port"
> +       depends on SERIAL_MVEBU_UART

then this one must become

	depends on SERIAL_MVEBU_UART

so it does not get enabled if the driver is not builtin.

	Arnd
