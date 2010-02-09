From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Feb 2010 17:58:57 +0000
Subject: [PATCH 01/14] ARM: LPC32XX: Initial architecture header files
In-Reply-To: <20100209165223.GA11113@pengutronix.de>
References: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
	<1265674295-23996-2-git-send-email-wellsk40@gmail.com>
	<20100209093129.GA2284@pengutronix.de>
	<20100209095934.GA11534@n2100.arm.linux.org.uk>
	<20100209165223.GA11113@pengutronix.de>
Message-ID: <20100209175857.GA20924@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 09, 2010 at 05:52:23PM +0100, Uwe Kleine-K?nig wrote:
> [Added linux-sparse at vger.kernel.org to Cc:]
> 
> On Tue, Feb 09, 2010 at 09:59:34AM +0000, Russell King - ARM Linux wrote:
> > On Tue, Feb 09, 2010 at 10:31:29AM +0100, Uwe Kleine-K?nig wrote:
> > > > +#define io_p2v(x)	((void __iomem *) (unsigned long) IO_ADDRESS(x))
> > > Is this cast to unsigned long needed?  AFAIK IO_ADDRESS(x) has
> > > type unsigned for x in { 0x0 ... 0xffffffff } (provided that int uses a
> > > 32 bit 2s-complement representation).  If unsigned long is really
> > > needed, maybe put it into the IO_ADDRESS macro?
> > 
> > int -> void __iomem * = sparse warning
> > unsigned long -> void __iomem * = no sparse warning
> Ah, OK, I see.  But IMHO it's a poor reason to add the cast.  Either
> the cast is necessary/recommended or sparse is wrong.  In the first case
> the reasoning shouldn't have to do with sparse, in the latter sparse
> should be fixed.

The point is that on 64-bit architectures, a pointer may be representable
by an unsigned long, but not an int.

> Is this intended?  What is the preferred way to define iomem pointers?

Define a numerical address with a UL suffix is the simplest way.
