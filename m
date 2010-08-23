From: wellsk40@gmail.com (Kevin Wells)
Date: Mon, 23 Aug 2010 10:30:17 -0700
Subject: [spi-devel-general] [PATCH] SPI: fix APB pclk power regression on
	U300
In-Reply-To: <1282381656-8644-1-git-send-email-linus.walleij@stericsson.com>
References: <1282381656-8644-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <AANLkTik+-YwxU7__QnSC8BhEO0-iqAA+u11BBt-2qo9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> With the introduction of an AMBA PrimeCell per-cell block clock,
> the pclk was left on after probe() unless explicitly disabled.
> This clock is wired to the same clock on PL022 causing it to stay
> always on since.
>
> Fix this up properly by clocking the pclk whenever we want to
> write into any PL022 registers and clocking the external clock
> whenever we want to transmit messages on the bus.
>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> Tested on U300 and U8500, even though the pclk stuff came in from
> the ARM tree it is probably better to carry this through Grants
> tree so as not to disturb other patches going in for PL022.
> ---
> ?drivers/spi/amba-pl022.c | ? 14 ++++++++------
> ?1 files changed, 8 insertions(+), 6 deletions(-)
>

Tested-by : Kevin Wells <wellsk40@gmail.com>
