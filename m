From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 18 Apr 2011 12:07:57 +0800
Subject: [RFC] sanitizing crazy clock data files
In-Reply-To: <20110415201232.GC14770@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<20110415193654.GP1611@n2100.arm.linux.org.uk>
	<20110415201232.GC14770@pengutronix.de>
Message-ID: <20110418040756.GA18623@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Fri, Apr 15, 2011 at 10:12:32PM +0200, Sascha Hauer wrote:
> On Fri, Apr 15, 2011 at 08:36:54PM +0100, Russell King - ARM Linux wrote:
> > On Fri, Apr 15, 2011 at 09:08:05PM +0200, Sascha Hauer wrote:
> > > The following tries to solve the chicken-egg problem we have with the
> > > common struct clk support and its users.
> > 
> > Thanks for doing this.  This really shows exactly what I wanted to know.
> > 
> > >  drivers/clk/Kconfig                     |    6 +
> > >  drivers/clk/Makefile                    |    2 +
> > >  drivers/clk/clk-divider.c               |  132 +++
> > >  drivers/clk/clk-mux.c                   |   92 ++
> > >  drivers/clk/clk.c                       |  104 ++
> > >  include/linux/clk.h                     |   68 ++
> > >  16 files changed, 1395 insertions(+), 1831 deletions(-)
> > 
> > If we can have more people using the generic mux and divider stuff,
> > that should cut many more hundreds of LOC from arch/arm.
> > 
> > This is exactly the kind of stuff we need to be seeing.
> > 
> > 1. How does this fit in with the other MX stuff?
> 
> The other regular i.MXs should fit into this fine, they have the same
> patterns. mxs is different though, instead of enable bits they have
> disable bits and dividers are one based instead of zero. We can probably
> extend the patterns to handle some additional flags, but I haven't
> looked deeply into it.
> 
I will try to migrate mxs clock to it and let you know where we need
to extend.

-- 
Regards,
Shawn
