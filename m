From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Thu, 26 May 2011 07:33:44 +0300
Subject: [PATCH 1/5] dmaengine: add ep93xx DMA support
In-Reply-To: <BANLkTin8Trn-44Op+GbxrgocFrnPuXUZ2w@mail.gmail.com>
References: <cover.1306082097.git.mika.westerberg@iki.fi>
	<e6777eb9f7228ee1dadec1f0c9f16c3afc44c307.1306082097.git.mika.westerberg@iki.fi>
	<BANLkTi=3z3kO5VEe2up8Mfm+bNXkY3baUw@mail.gmail.com>
	<20110525195413.GC2996@acer>
	<BANLkTin8Trn-44Op+GbxrgocFrnPuXUZ2w@mail.gmail.com>
Message-ID: <20110526043344.GA2749@acer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2011 at 10:47:14PM +0200, Linus Walleij wrote:
> 
> > IMHO it is better to have ep93xx implementation on its own driver since it is
> > not a real AMBA PL022 peripheral but some weird hack made by Cirrus (although
> > my opinions are bit biased).
> 
> I disagree because it's IMO at first sight no more deviant than our "PL023"
> variants that still use the same pl022 driver.

Ok.

Do you think that we can go forward with this patch series if I drop the last
patch (spi/ep93xx: add DMA support)? This way we will have dmaengine
implementation in place, whatever SPI driver we choose to use with ep93xx.

We can then try to use amba-pl022 driver with ep93xx and see if it works or
not, and how much work is needed. I would like some comments from Hartley and
Ryan also.

> Is there some inexepensive hardware with EP93xx I can get to fix this
> myself?

Check for example Technologic Systems (embeddedarm.com), I have their TS-7260
board which has ep9302.
