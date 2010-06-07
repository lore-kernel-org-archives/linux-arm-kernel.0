From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 8 Jun 2010 01:47:16 +0200
Subject: [PATCH 08/10] [ARM] tegra: harmony: Add harmony board file
In-Reply-To: <1275635441-17378-9-git-send-email-olof@lixom.net>
References: <1275635441-17378-1-git-send-email-olof@lixom.net>
	<1275635441-17378-2-git-send-email-olof@lixom.net>
	<1275635441-17378-3-git-send-email-olof@lixom.net>
	<1275635441-17378-4-git-send-email-olof@lixom.net>
	<1275635441-17378-5-git-send-email-olof@lixom.net>
	<1275635441-17378-6-git-send-email-olof@lixom.net>
	<1275635441-17378-7-git-send-email-olof@lixom.net>
	<1275635441-17378-8-git-send-email-olof@lixom.net>
	<1275635441-17378-9-git-send-email-olof@lixom.net>
Message-ID: <AANLkTim-vAk1f0gLzvk1o0iPhfiRSClRcjZsandp269v@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/4 Olof Johansson <olof@lixom.net>:

> (...)
> +static struct plat_serial8250_port debug_uart_platform_data[] = {
> + ? ? ? {
> + ? ? ? ? ? ? ? .membase ? ? ? ?= IO_ADDRESS(TEGRA_UARTD_BASE),
> + ? ? ? ? ? ? ? .mapbase ? ? ? ?= TEGRA_UARTD_BASE,
> + ? ? ? ? ? ? ? .irq ? ? ? ? ? ?= INT_UARTD,
> + ? ? ? ? ? ? ? .flags ? ? ? ? ?= UPF_BOOT_AUTOCONF,
> + ? ? ? ? ? ? ? .iotype ? ? ? ? = UPIO_MEM,
> + ? ? ? ? ? ? ? .regshift ? ? ? = 2,
> + ? ? ? ? ? ? ? .uartclk ? ? ? ?= 216000000/16 * 16,
> + ? ? ? }, {
> + ? ? ? ? ? ? ? .flags ? ? ? ? ?= 0
> + ? ? ? }
> +};

Ummmm what is this = 216000000/16 * 16?

I think the compiler will optimize that to 216000000 so why not set
it to that.

Yours,
Linus Walleij
