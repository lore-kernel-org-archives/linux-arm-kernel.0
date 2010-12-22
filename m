From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 22 Dec 2010 22:23:04 +0100
Subject: [PATCH] ARM: add PrimeCell generic DMA to PL011
In-Reply-To: <20101222203439.GF14693@n2100.arm.linux.org.uk>
References: <1286357526-5570-1-git-send-email-linus.walleij@stericsson.com>
	<20101222141006.GA19852@n2100.arm.linux.org.uk>
	<AANLkTi=uhMyDySAxbZK4XKU6Z4AbkjVc29L4idc0sxLf@mail.gmail.com>
	<20101222182041.GE14693@n2100.arm.linux.org.uk>
	<20101222203439.GF14693@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=CpKGq9fcAG+fwn9KWb_uXh6k9b2Xjx09=2g3X@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/22 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> This emptying of the RX UART FIFO of all received data prevents the RX
> timeout condition being satisfied, which in turn prevents any reasonable
> use of the UART port.
>
> I think the answer here is to allow the platform to supply just the TX
> DMA channel, so when a UART is wired up to use the single-character
> request, RX DMA support can be omitted.

Yes atleast that is fully OK until someone comes up with some clever
workaround. I don't know if a software fallback timer flipping the buffers
would work.

There's another reason for not doing UART RX at all: for example
it will occupy one of the channels (PB11MPCores PL081 has only
two!) for good, and then MMCI and AACI cannot use it at the same
time.

Yours,
Linus Walleij
