From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Aug 2013 11:20:55 +0100
Subject: [PATCH RFC 06/13] ASoC: kirkwood: combine kirkwood-i2s and
 kirkwood-dma drivers
In-Reply-To: <20130805121307.555cb419@armhf>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V63xH-0004lZ-TX@rmk-PC.arm.linux.org.uk> <20130805121307.555cb419@armhf>
Message-ID: <20130805102055.GP23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 12:13:07PM +0200, Jean-Francois Moine wrote:
> On Sun, 04 Aug 2013 20:27:03 +0100
> Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> 
> > These really should be a single driver because they're fully integrated
> > in hardware.  Make them so.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  arch/arm/mach-dove/common.c          |    4 ++--
> >  arch/arm/mach-kirkwood/common.c      |   24 +++++++++---------------
> >  sound/soc/kirkwood/Kconfig           |    5 -----
> >  sound/soc/kirkwood/Makefile          |    4 +---
> >  sound/soc/kirkwood/kirkwood-dma.c    |   30 +-----------------------------
> >  sound/soc/kirkwood/kirkwood-i2s.c    |   21 ++++++++++++++++-----
> >  sound/soc/kirkwood/kirkwood-openrd.c |    4 ++--
> >  sound/soc/kirkwood/kirkwood-t5325.c  |    4 ++--
> >  sound/soc/kirkwood/kirkwood.h        |    2 ++
> >  9 files changed, 35 insertions(+), 63 deletions(-)
> 	[snip]
> 
> Glad to see you got my patch, but why did you changed all the names?

You clearly didn't read the covering email to this series.  I don't know
why I bothered to write it if you don't bother to read it.

> Replacing "kirkwood-pcm-audio" by "kirkwood-i2s" should be enough.

Quite simply, i2s is a bus protocol, just like spdif is.  It can do both.
If we're changing its name, then naming it after just one of the protocols
it does is stupid.  And PCM is also inappropriate - it does more than PCM
because it can also transmit AC3 and MPEG audio over SPDIF to a suitable
decoder (and that does work - I've tested it.)

At the end of the day, this is _just_ a DMA engine which outputs I2S
and/or SPDIF formatted data of unknown type at a known rate.
