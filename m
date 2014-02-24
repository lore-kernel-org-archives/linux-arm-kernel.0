From: ijc@hellion.org.uk (Ian Campbell)
Date: Mon, 24 Feb 2014 16:03:15 +0000
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <1392948027.15717.36.camel@deadeye.wl.decadent.org.uk>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-22-git-send-email-andrew@lunn.ch>
 <52F51922.6030502@gmail.com>
 <1392892217.23342.18.camel@kazak.uk.xensource.com>
 <20140220105854.GL11878@lunn.ch>
 <1392896076.23342.37.camel@kazak.uk.xensource.com>
 <20140220121821.GO11878@lunn.ch>
 <1392900664.23342.60.camel@kazak.uk.xensource.com>
 <20140220132320.GP11878@lunn.ch>
 <1392906273.30563.14.camel@kazak.uk.xensource.com>
 <1392948027.15717.36.camel@deadeye.wl.decadent.org.uk>
Message-ID: <1393257795.16570.98.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-02-21 at 02:00 +0000, Ben Hutchings wrote:
> On Thu, 2014-02-20 at 14:24 +0000, Ian Campbell wrote:
> > On Thu, 2014-02-20 at 14:23 +0100, Andrew Lunn wrote:
> [...]
> > > What i suspect we will end up doing it dropping the last patch for the
> > > moment and ensuring ARCH_KIRKWOOD still supports all the DT machines.
> > > I think that just needs care with arch/arm/boot/dts/Makefile.
> > > 
> > > Once we have the last four converted over to DT, you can then do a
> > > straight swap, mach-kirkwood for mach-mvebu.
> > 
> > That sounds like a good plan, thanks!
> > 
> > If we are going to do a straight swap I suppose it might as go for a v5
> > multiplatform flavour instead of a mvebu specific one.
> [...]
> 
> I would love it if we could do that.
> 
> By the way, we still have the problem that at least one supported
> orion5x machine (D-Link DNS-323) only has a ~1.5 MB kernel partition.
> So we would probably have to keep a reduced orion5x config for those
> machines, alongside the mvebu or multiplatform kernel.

Sure. I think at worst we should aim to end up with as many flavour as
we have today, in reality I expect we should be able to end up with
fewer (even if only -= 1).

BTW, someone (I forget who) at Debconf in Cambridge last year floated
the idea of putting a stage 2 loader in flash to pull the real kernel
from some larger storage. I don't know if that is realistic here, and in
any case I don't intend to work on it myself.

Ian.
