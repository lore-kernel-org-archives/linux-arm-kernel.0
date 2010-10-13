From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 13 Oct 2010 07:15:07 +0200
Subject: [PATCH] ARM: add PrimeCell generic DMA to PL011
In-Reply-To: <20101012193048.GA25259@n2100.arm.linux.org.uk>
References: <1286357526-5570-1-git-send-email-linus.walleij@stericsson.com>
	<20101012193048.GA25259@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinA-hVJeL_Q6c9jQHtBa0ieAy_h9VNS2gayZdSE@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/10/12 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> Unless you can assure me that there will be no breakage through these
> patches without having their dependencies merged first, I think these
> will have to wait another cycle...

It's OK Russell I have all patience in the world :-)

We ended up in a bit of cross-subsystem hell and such things
happen.

We'll have the PL08x driver and other necessary bits in by 2.6.37 and
then we can perhaps look at these just after that merge window.
Then the PL022 that is not in as wide use as the others and which is
still marked experimental is merged, so we'll use that thing as a
guninea pig, if it doesn't blow up it's probably safe to merge the
others as well.

If we then merge them and they seem to work my plan is to move the
DMA channel assignments for the drivers into the struct amba_device
as the final step.

Yours,
Linus Walleij
