From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 25 May 2011 22:47:14 +0200
Subject: [PATCH 1/5] dmaengine: add ep93xx DMA support
In-Reply-To: <20110525195413.GC2996@acer>
References: <cover.1306082097.git.mika.westerberg@iki.fi>
	<e6777eb9f7228ee1dadec1f0c9f16c3afc44c307.1306082097.git.mika.westerberg@iki.fi>
	<BANLkTi=3z3kO5VEe2up8Mfm+bNXkY3baUw@mail.gmail.com>
	<20110525195413.GC2996@acer>
Message-ID: <BANLkTin8Trn-44Op+GbxrgocFrnPuXUZ2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/25 Mika Westerberg <mika.westerberg@iki.fi>:

> I re-checked the specs and indeed, as discussed previously, it is clear that
> Cirrus (or ARM) copied the interface from other. Even the wording in the
> document is identical in many places. However, in ep93xx User's Guide, there
> is no mention about SSP being AMBA PrimeCell peripheral. For UARTs it is
> mentioned... go figure.
>
> There are differences also, some of the bits in control registers are in
> different places. Interrupt registers are completely different and there is no
> DMA control register at all. The same things we discussed before.

But it really does not matter. The amba-pl022.c driver has all the same
deviations for things called "PL023" that are not pure PL022 either.
I just made the driver a bit more flexible, supporting both.

If the people doing drivers/usb/musb/* had done the same thing we
would have had what, 5 drivers for similar hardware?

> Back then, it wasn't known how the M2M DMA interface (the one used
> by SSP and IDE) was going to be implemented.

But I knew, having just written the needed extensions to dmaengine.
And I said so. But I realize I'm maybe not considered an authoritative
source on the subject, and I'm biased.

> IMHO it is better to have ep93xx implementation on its own driver since it is
> not a real AMBA PL022 peripheral but some weird hack made by Cirrus (although
> my opinions are bit biased).

I disagree because it's IMO at first sight no more deviant than our "PL023"
variants that still use the same pl022 driver.

Is there some inexepensive hardware with EP93xx I can get to fix this
myself?

Yours,
Linus Walleij
