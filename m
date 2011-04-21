From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 21 Apr 2011 12:50:50 +0100
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <alpine.LFD.2.02.1104211113030.3323@ionos>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421074214.GE15233@pengutronix.de>
	<alpine.LFD.2.02.1104211113030.3323@ionos>
Message-ID: <20110421115050.GC16776@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2011 at 11:21:53AM +0200, Thomas Gleixner wrote:
> On Thu, 21 Apr 2011, Sascha Hauer wrote:
> > On Wed, Apr 20, 2011 at 09:52:15PM +0200, Thomas Gleixner wrote:

> > >    - a field for the base register
> > >    - a struct for the offsets of the most common registers relative to
> > >      base

> > What's wrong with embedding struct clk into a more specific clock and
> > access it with container_of()? It must be done anyway once a field is
> > missing in struct clk, or we end up with a lot of fields in struct clk
> > which are used in only few types of clocks.

> As I explained already, that's the whole purpose of frameworks. See
> clockevents, clocksource, genirq. Lots of stuff is only used by a very
> small subset, but it's better to have that in common code than growing
> warts at all ends.

There's nothing intrinsic about the concept of a clock which means that
it needs to be memory mapped or have a particular set of registers for
us to work with.  This sounds like something that ought to be factored
out but it's not obvious to me that it should be part of the core struct.
