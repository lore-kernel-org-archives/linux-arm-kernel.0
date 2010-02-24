From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 24 Feb 2010 15:35:46 +0100
Subject: [PATCH 3/7] ARM: U300: set f_max to 24 MHz for MMCI
In-Reply-To: <20100224125002.GA19641@n2100.arm.linux.org.uk>
References: <1266537931-12560-1-git-send-email-linus.walleij@stericsson.com>
	<20100221210740.GA3528@n2100.arm.linux.org.uk>
	<A6D19A13FE030A409EC4362C172E091F0E9355A2@eseldmw101.eemea.ericsson.se>
	<20100224125002.GA19641@n2100.arm.linux.org.uk>
Message-ID: <A6D19A13FE030A409EC4362C172E091F0E963F15@eseldmw101.eemea.ericsson.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Russell]

> Pierre used to argue that stopping the clock to the card was a bad
> thing, which is probably based on his experience dealing with SD/SDIO
> cards - so really the overrun/underrun problem is not a bug with the
> hardware.

Yep I heard from earlier discussions, and it's probably not a good
idea at all on SDIO cards atleast.

I don't know how this hardware solution actually works, if it's
really like they're gating the clock, could be something else,
like NACK:in all transactions or whatever the MMC/SD spec permits,
could even be a hidden deep buffer. I will try to dig out the details.

In newer designs like the U8500 we have the PIO IRQ removed even,
so they can only be used without DMA.

> So I'm just going to sit on the AMBA DMA stuff for the time being.

OK no hurries, I do see the problems :-/

If a generic PrimeCell DMA doesn't work out, we will have to fork
the driver instead, since we cannot even use it with the U8500
without DMA support, perhaps this is just as good anyway since
we wouldn't be disturbing RealView etc with our patches. But
it'll lead to some code duplication.

Linus Walleij
