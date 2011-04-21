From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 21 Apr 2011 11:13:40 +0100
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <20110421072259.GG31131@pengutronix.de>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421072259.GG31131@pengutronix.de>
Message-ID: <20110421101340.GA16776@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2011 at 09:22:59AM +0200, Uwe Kleine-K?nig wrote:
> On Wed, Apr 20, 2011 at 09:52:15PM +0200, Thomas Gleixner wrote:

> >    - a field for the current clock rate

> Then you need a mechanism to notify the children if the rate or parent
> of a clock changes. I assume you won't allow that for a clock that has
> more than one (enabled) consumer. Knowing only very few platforms I
> don't know if that is something you can forbid.

I suspect you need it - cpufreq style scaling of the core clocks (which
many SoCs can do) involves pretty much the entire clock tree, though
obviously the idea is that the effects get hidden at the edges.
