From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 21 Feb 2014 10:58:45 -0500
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <1725547.sbei6Aef3A@wuerfel>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <35719313.JyFlzSVKnx@wuerfel>
 <1392947251.15717.28.camel@deadeye.wl.decadent.org.uk>
 <1725547.sbei6Aef3A@wuerfel>
Message-ID: <20140221155845.GB7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 02:07:40PM +0100, Arnd Bergmann wrote:
> On Friday 21 February 2014 01:47:31 Ben Hutchings wrote:
> > On Thu, 2014-02-20 at 16:19 +0100, Arnd Bergmann wrote:
> > > On Thursday 20 February 2014 14:21:10 Ian Campbell wrote:
> >
> > > For all I know, the only interesting ixp4xx platforms are the consumer
> > > products listed on http://www.nslu2-linux.org/, the other ones you support
> > > are development boards that tend to exist only in very small quantities.
> > > 
> > > The main limitation would be the amount of installed RAM, which is
> > > either 32MB or 64MB depending on the machine for these. Running a
> > > modern Debian with these constraints is probably possible but
> > > doesn't sound like fun. 
> > 
> > Our most pressing constraint has actually been the size of the kernel
> > partition in flash, which is only ~1.4 MB on some of the iop32x and
> > ixp4xx machines (and ~1.5 MB on one of the orion5x machines).  We've
> > modularised as much as possible and turned off some of the features that
> > are otherwise standard across all Debian architectures.
> 
> Makes sense. I'm impressed you actually manage to get a modern kernel
> in 1.5MB and have it boot up a (mostly) full distro. I think we have
> in the past dropped a subarchitecture from the kernel when it turned
> out its defconfig could no longer fit within the 2MB of flash it
> has.
> 
> > But I got fed up with trying to make it fit, and no-one else stepped up
> > to maintain the reduced configurations, so the last time iop32x went
> > over the limit I removed it.  As Ian hinted, ixp4xx might follow.
> 
> Ok. As I mentioned, I believe OpenWRT is really the playground for
> the remaining ixp4xx users that are doing new installs.

fwiw, I have two boards for this arch.  NSLU2 and a Gateworks board.
Both are ixp425 and both are gathering dust in a box.  I probably don't
have time to do anything with them.  So, if Kevin or Olof wants to add
them to the boot farm, or someone actually wants to boot test them, I
would be willing to send them where ever.

iirc, there are hacks to upgrade at least the RAM on the NSLU2.  I'm
pretty sure I maxed out the flash and the RAM on the Gateworks board
when I ordered it.  Also, the Gateworks board has 4 mini-pci slots (not
pcie).  Could be interesting.

hth,

Jason.
