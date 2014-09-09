From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Sep 2014 13:53:03 +0200
Subject: [PATCHv3 1/6] ARM: dts: Add SoC level device tree support for
 LS1021A
In-Reply-To: <1410253952-15631-2-git-send-email-jingchang.lu@freescale.com>
References: <1410253952-15631-1-git-send-email-jingchang.lu@freescale.com>
 <1410253952-15631-2-git-send-email-jingchang.lu@freescale.com>
Message-ID: <62651744.c71MLsL3Q5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 September 2014 17:12:27 Jingchang Lu wrote:
> +       aliases {
> +               serial0 = &lpuart0;
> +               serial1 = &lpuart1;
> +               serial2 = &lpuart2;
> +               serial3 = &lpuart3;
> +               serial4 = &lpuart4;
> +               serial5 = &lpuart5;
> +               ethernet0 = &enet0;
> +               ethernet1 = &enet1;
> +               ethernet2 = &enet2;
> +               sysclk = &sysclk;
> +       };
> +
> +       memory at 80000000 {
> +               device_type = "memory";
> +               reg = <0x0 0x80000000 0x0 0x20000000>;
> +       };
> +
> 


One more thing: these should all go into the board specific files.

The installed memory is almost always a property of the board, not the
SoC, and a lot of boards only connect a subset of the serial ports,
or they may have them in a different order.

In particular, you only provide aliases for the six out of the
ten available uarts, which seems arbitrary.

	Arnd
