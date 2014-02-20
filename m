From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Feb 2014 16:19:41 +0100
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <1392906070.30563.11.camel@kazak.uk.xensource.com>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <2127012.W6WnQnXmRo@wuerfel>
 <1392906070.30563.11.camel@kazak.uk.xensource.com>
Message-ID: <35719313.JyFlzSVKnx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 February 2014 14:21:10 Ian Campbell wrote:
> On Thu, 2014-02-20 at 14:53 +0100, Arnd Bergmann wrote:
> > On Thursday 20 February 2014 12:51:04 Ian Campbell wrote:
> > * ixp4xx is too different from the others and I don't think it's
> >   possible to turn it over to multiplatform.
> > * I see a iop32x_defconfig in svn that you didn't mention here,
> >   but it's basically the same problem as ixp4xx.
> 
> This is only in Wheezy and not in trunk (which will become Jessie). AIUI
> support for these has been dropped for the next version of Debian so
> Wheezy is the last one and we don't need to worry about upgrade for
> these.

Ok, I see.

> TBH I'm not sure that ixp4xx isn't in the same boat, I suppose we'll
> see.

For all I know, the only interesting ixp4xx platforms are the consumer
products listed on http://www.nslu2-linux.org/, the other ones you support
are development boards that tend to exist only in very small quantities.

The main limitation would be the amount of installed RAM, which is
either 32MB or 64MB depending on the machine for these. Running a
modern Debian with these constraints is probably possible but
doesn't sound like fun. ;-)

Also, the upstream kernel port isn't that well maintained, a lot
the development seems to have happened in OpenWRT and not mainlined,
including a dozen new machines that were already ported in 2009.

Then again, Martin Michlmayr has instructions for running Wheezy
on the 32MB nslu2, and I guess as long as he's interested in the
hardware, new versions of Debian will keep running on it.

> > The embedded mxs family is probably most interesting among these,
> > but there is also a community around the wondermedia stuff, which is
> > used in cheap tablets and laptops.
> 
> Interesting. I don't know how many of these are supported by Debian --
> mostly these things get added when someone acquires one and scratches
> that itch.
> 
> I suppose if we could remove at least one existing flavour in favour of
> a v5 multiplatform config then there probably wouldn't be many
> objections to doing that.

That will probably come as a natural progression after kirkwood
gets replaced with mvebu.

> > As I said, it may be useful to do multiplatform support for MACH_ORION5x,
> > but for MACH_KIRKWOOD, we have come too far now to turn back.
> 
> Understood. It sounds like mach-kirkwood is very close to being
> removable altogether though (by migrating the last few boards to
> mach-mvebu), which would make distro upgrades much simpler, since we can
> just do a straight swap rather than trying to figure out which one we
> need.

Yes, makes sense.

	Arnd
