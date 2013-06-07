From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 7 Jun 2013 10:44:06 -0400
Subject: [PATCH] arm: mvebu: ensure PCIe range is propagated in the
 .dts files
In-Reply-To: <20130607103241.3f82d71d@skate>
References: <1370510483-32419-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370510483-32419-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130606181159.GN23859@titan.lakedaemon.net>
 <20130606190321.GQ23859@titan.lakedaemon.net>
 <20130607103241.3f82d71d@skate>
Message-ID: <20130607144406.GS23859@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 10:32:41AM +0200, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Thu, 6 Jun 2013 15:03:21 -0400, Jason Cooper wrote:
> 
> > > Can you split this in to two patches, please:
> > > 
> > > >  arch/arm/boot/dts/armada-xp-db.dts               | 1 +
> > > 
> > > one for mvebu/dt
> > > 
> > > >  arch/arm/boot/dts/armada-xp-gp.dts               | 5 +++--
> > > >  arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 5 +++--
> > > 
> > > and one for mvebu/fixes?
> > 
> > Nevermind, I've got a few minutes and would like to get it in for the
> > last -next this week.
> 
> I must admit I don't quite get why the patch had to be split. The three
> chunks do exactly the same thing for the three boards.

The _only_ purpose of for-next is to do integration testing against what
everyone else has going on for the merge window.  There will never be a
pull request for it.  As such, no patches ever get directly applied on
top of it.  They need to go against an appropriate branch.

> The only difference is that the part touching armada-xp-gp and
> armada-xp-openblocks-ax3-4 was also adding some comments for each
> range, while the one for armada-xp-db didn't had to do it because the
> comments were already there.
> 
> So really, the armada-xp-db change is as much of a "fix" than the two
> other changes.
> 
> To be honest, as long as they all go in 3.11, I'm fine, but I'm just
> curious as to why it would have had to be split.

the patches in mvebu/fixes:

  8eed481 arm: mvebu: fix the 'ranges' property to handle PCIe
  c6c003a ARM: mvebu: Fix ranges entry on XP GP board
  00ed4a0 ARM: mvebu: Add a ranges entry to translate devbus childs

added the ranges property for openblocks-ax3-4, and the gp, but nothing
for the db.  The patch

  b484ff4 ARM: mvebu: Add support for NOR flash device on Armada XP-DB board

went into mvebu/dt because it was adding new capability.

So the choices are to make mvebu/dt depend on mvebu/fixes because of
your patch, or to split the patch because there is no real dependency
between the two changes.

hth,

Jason.
