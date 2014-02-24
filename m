From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 24 Feb 2014 11:34:42 -0500
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <1393259176.16570.102.camel@kazak.uk.xensource.com>
References: <1391730137-14814-22-git-send-email-andrew@lunn.ch>
 <52F51922.6030502@gmail.com>
 <1392892217.23342.18.camel@kazak.uk.xensource.com>
 <20140220105854.GL11878@lunn.ch>
 <20140220111913.GZ21483@n2100.arm.linux.org.uk>
 <1392896356.23342.40.camel@kazak.uk.xensource.com>
 <20140220232649.GU7862@titan.lakedaemon.net>
 <1393257630.16570.95.camel@kazak.uk.xensource.com>
 <20140224162413.GE18601@lunn.ch>
 <1393259176.16570.102.camel@kazak.uk.xensource.com>
Message-ID: <20140224163442.GF14250@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 04:26:16PM +0000, Ian Campbell wrote:
> On Mon, 2014-02-24 at 17:24 +0100, Andrew Lunn wrote:
> > > > > > What's wrong with the soc subsystem (drivers/base/soc.c).  This
> > > > > > provides a way to export SoC through standardised interfaces. 
> > > > > 
> > > > > It looks like the thing to use to me.
> > > > > 
> > > > > It seems to have been around only since v3.3 though, which makes it a
> > > > > bit tricky to use when upgrading from running board-file based v3.2
> > > > > system (Debian Wheezy) to a newer DTB based kernel, we need to select
> > > > > the new DTB while running the old system.
> > > > > 
> > > > > I'd prefer to use this thing as the primary mechanism but it seems like
> > > > > I'd have to implement some sort of fallback at least for one Debian
> > > > > release cycle. I'm sure it is doable...
> > > > 
> > > > back in v3.2, lspci should still work.  Would that given you the
> > > > information you need?
> > > 
> > > I expect it will, yes.
> > 
> > 3.14 with the new PCIe driver will also work. The patch was accepted
> > and considered a regression so made it into one of the -rc's.
> 
> Great! Thanks.

fyi:

  322a8e91844f PCI: mvebu: Use Device ID and revision from underlying endpoint

It's in -rc4 and it's flagged for stable from v3.11 on up.  v3.11 is
when the pcie driver was introduced (and thus, the regression).

hth,

Jason.
