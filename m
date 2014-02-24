From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 24 Feb 2014 17:24:13 +0100
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <1393257630.16570.95.camel@kazak.uk.xensource.com>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-22-git-send-email-andrew@lunn.ch>
 <52F51922.6030502@gmail.com>
 <1392892217.23342.18.camel@kazak.uk.xensource.com>
 <20140220105854.GL11878@lunn.ch>
 <20140220111913.GZ21483@n2100.arm.linux.org.uk>
 <1392896356.23342.40.camel@kazak.uk.xensource.com>
 <20140220232649.GU7862@titan.lakedaemon.net>
 <1393257630.16570.95.camel@kazak.uk.xensource.com>
Message-ID: <20140224162413.GE18601@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > What's wrong with the soc subsystem (drivers/base/soc.c).  This
> > > > provides a way to export SoC through standardised interfaces. 
> > > 
> > > It looks like the thing to use to me.
> > > 
> > > It seems to have been around only since v3.3 though, which makes it a
> > > bit tricky to use when upgrading from running board-file based v3.2
> > > system (Debian Wheezy) to a newer DTB based kernel, we need to select
> > > the new DTB while running the old system.
> > > 
> > > I'd prefer to use this thing as the primary mechanism but it seems like
> > > I'd have to implement some sort of fallback at least for one Debian
> > > release cycle. I'm sure it is doable...
> > 
> > back in v3.2, lspci should still work.  Would that given you the
> > information you need?
> 
> I expect it will, yes.

3.14 with the new PCIe driver will also work. The patch was accepted
and considered a regression so made it into one of the -rc's.

     Andrew
