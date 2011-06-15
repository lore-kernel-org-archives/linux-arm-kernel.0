From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Jun 2011 08:47:50 +0100
Subject: [RFC,PATCH] Cleanup PC parallel port Kconfig
In-Reply-To: <4DF83577.6040903@zytor.com>
References: <20110614190850.GA13526@linux-mips.org>
	<4DF7C3CA.9050902@zytor.com> <201106142333.16203.arnd@arndb.de>
	<4DF83577.6040903@zytor.com>
Message-ID: <20110615074749.GB28989@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2011 at 09:30:47PM -0700, H. Peter Anvin wrote:
> On 06/14/2011 02:33 PM, Arnd Bergmann wrote:
> >>
> >> Why on earth restrict it like that?  It's just a device driver, like
> >> more or less any other device driver...
> > 
> > I'd say any other classic ISA/PC driver, including floppy, gameport or
> > serial-8250. One problem with these is that we never fully worked out
> > the dependencies for these, which we probably should. CONFIG_ISA
> > generally means ISA add-on cards, but that might not be enabled for
> > platforms that have a pc-parport but no ISA slots.
> > 
> 
> OK, serial-8250 is clearly just plain wrong, since the 8250 series UARTs
> are ubiquitous across just about every platform.
> 
> Floppy is special (in the short bus sense), since it is closely tied to
> ISA DMA.  Conditionalizing this on ISA DMA makes total sense.

No it doesn't.  It depends on the ISA DMA API, not that the machine has
ISA DMA.

I have a platform which has no ISA DMA but uses the floppy driver.  Please
don't break it.
