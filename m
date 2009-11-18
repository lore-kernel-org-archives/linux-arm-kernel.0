From: leochen@broadcom.com (Leo (Hao) Chen)
Date: Wed, 18 Nov 2009 14:19:48 -0800
Subject: drivers/rtc/rtc-pl031.c uses __raw_readl()?
In-Reply-To: <20091117100256.GC7407@pengutronix.de>
References: <63386a3d0911110130j2056a355l16cade8d30edb6cd@mail.gmail.com>
	<63386a3d0911120043y2143c7f5w7289bc83b2e31847@mail.gmail.com>
	<20091117100256.GC7407@pengutronix.de>
Message-ID: <20091118221948.GA11579@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2009 at 02:02:56AM -0800, Uwe Kleine-K?nig wrote:
> On Thu, Nov 12, 2009 at 09:43:43AM +0100, Linus Walleij wrote:
> > 2009/11/11 Linus Walleij <linus.ml.walleij@gmail.com>:
> > 
> > > Is there some special reason as to why drivers/rtc/rtc-pl031.c uses
> > > the __raw_[read|write]l() macro instead of plain [read|write]l()?
> > 
> > Reading the macro definitions I come to the conclusion that readl()
> > is always little-endian and __raw_readl() is the machine endianness,
> Actually the readl part is not necessarily true I think.
> 
> At least arch/arm/mach-bcmring/include/mach/io.h has:
> 
> 	/* Do not enable mem_pci for a big endian arm architecture or unexpected byteswaps will */
> 	/* happen in readw/writew etc. */
> 
> 	#define readb(c)        __raw_readb(c)
> 	...
> 
> But maybe this is a bug in mach-bcmring?!  Or a work-around of drivers
> using readb et al in wrong sitatations?

Our code was based on older io.h. No need to keep our own readb
definition any more. We'll clean them up by using the
generic readb defined in asm/io.h.

-- 

Leo Hao Chen

------------------------
Life is short, run long.
