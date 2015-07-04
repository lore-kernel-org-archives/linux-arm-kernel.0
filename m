From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 04 Jul 2015 21:54:12 +0200
Subject: [PATCH v2 3/9] arm: twr-k70f120m: clock driver for Kinetis SoC
In-Reply-To: <alpine.DEB.2.11.1507030006280.3916@nanos>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
 <alpine.LNX.2.00.1507022338070.28322@localhost.localdomain>
 <alpine.DEB.2.11.1507030006280.3916@nanos>
Message-ID: <2009463.YLtdMegFel@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 July 2015 00:08:27 Thomas Gleixner wrote:
> On Thu, 2 Jul 2015, Paul Osmialowski wrote:
> > On Thu, 2 Jul 2015, Arnd Bergmann wrote:
> > 
> > > I wonder if you could move out the fixed rate clocks into their own
> > > nodes. Are they actually controlled by the same block? If they are
> > > just fixed, you can use the normal binding for fixed rate clocks
> > > and only describe the clocks that are related to the driver.
> > 
> > In my view having these clocks grouped together looks more convincing. After
> > all, they all share the same I/O regs in order to read configuration.
> 
> The fact that they share a register is not making them a group. That's
> just a HW design decision and you need to deal with that by protecting
> the register access, but not by trying to group them artificially at
> the functional level.

I'd disagree with that: The clock controller is the device that owns the
registers and that should be one node in DT, as Paul's first version does.

The part I'm still struggling with is understanding how the fixed-rate
clocks are controlled through those registers. If they are indeed configured
through the registers, the name is probably wrong and should be changed
to whatever kind of non-fixed clock this is.

	Arnd
