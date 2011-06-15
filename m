From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Jun 2011 16:21:44 +0100
Subject: [RFC,PATCH] Cleanup PC parallel port Kconfig
In-Reply-To: <4DF8CAD5.1090902@zytor.com>
References: <20110614190850.GA13526@linux-mips.org>
	<4DF7C3CA.9050902@zytor.com> <201106142333.16203.arnd@arndb.de>
	<4DF83577.6040903@zytor.com>
	<20110615074749.GB28989@n2100.arm.linux.org.uk>
	<4DF8CAD5.1090902@zytor.com>
Message-ID: <20110615152144.GE28989@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2011 at 08:08:05AM -0700, H. Peter Anvin wrote:
> On 06/15/2011 12:47 AM, Russell King - ARM Linux wrote:
> >>
> >> OK, serial-8250 is clearly just plain wrong, since the 8250 series UARTs
> >> are ubiquitous across just about every platform.
> >>
> >> Floppy is special (in the short bus sense), since it is closely tied to
> >> ISA DMA.  Conditionalizing this on ISA DMA makes total sense.
> > 
> > No it doesn't.  It depends on the ISA DMA API, not that the machine has
> > ISA DMA.
> > 
> > I have a platform which has no ISA DMA but uses the floppy driver.  Please
> > don't break it.
> 
> OK, even more case in point, then.

It's already been solved - ARCH_MAY_HAVE_PC_FDC is supposed to be
defined to y in the cases where architectures have support for it.

What we do on ARM for example is:

config ARCH_MAY_HAVE_PC_FDC
        bool

and then select that symbol for our platforms which can have the
floppy driver.

And in any case we already have definitions for the presence of the
ISA DMA API vs the common ISA DMA helpers in kernel/.  The presence
of the ISA DMA API is given by CONFIG_ISA_DMA_API, while the
ISA DMA helper CONFIG_GENERIC_ISA_DMA.
