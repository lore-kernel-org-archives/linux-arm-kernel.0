From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Feb 2014 14:16:10 +0100
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <1392948027.15717.36.camel@deadeye.wl.decadent.org.uk>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1392906273.30563.14.camel@kazak.uk.xensource.com>
 <1392948027.15717.36.camel@deadeye.wl.decadent.org.uk>
Message-ID: <1438274.4sq9OA90up@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 February 2014 02:00:27 Ben Hutchings wrote:
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

orion5x is still some time away from being included in mvebu, 3.16 at
the earliest, so it will have to stay separate anyway.

My hope is really that we get very little overhead in enabling
multiplatform on mvebu compared to a orion5x or kirkwood standalone
configuration, so depending on what the platforms have you could
end up with e.g. a 1.5MB "mini" multiplatform kernel that includes
all machines that have 2MB or less for their kernel partitions and
a "everything included" multiplatform kernel for the machines with
larger partititons. For instance kirkwood-rd88f6281 has a 2MB
uImage partition and everything else seems to have at least 4MB.

	Arnd
