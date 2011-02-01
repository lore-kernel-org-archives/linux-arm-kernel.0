From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 1 Feb 2011 15:06:09 -0500 (EST)
Subject: Locking in the clk API, part 2: clk_prepare/clk_unprepare
In-Reply-To: <20110201193201.GH1147@pengutronix.de>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<20110201105449.GY1147@pengutronix.de>
	<20110201131512.GH31216@n2100.arm.linux.org.uk>
	<20110201141837.GA1147@pengutronix.de>
	<20110201143932.GK31216@n2100.arm.linux.org.uk>
	<20110201151846.GD1147@pengutronix.de>
	<20110201152458.GP31216@n2100.arm.linux.org.uk>
	<20110201155344.GF1147@pengutronix.de>
	<20110201170637.GR31216@n2100.arm.linux.org.uk>
	<20110201193201.GH1147@pengutronix.de>
Message-ID: <alpine.LFD.2.00.1102011503550.8580@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 1 Feb 2011, Uwe Kleine-K?nig wrote:

> My motivation for a more complicated clk_prepare was to make clk_prepare
> atomic when that's possible (i.e. when the clk is already prepared) and
> call it before the enable callback in clk_enable.  Then everything
> behaves nicely even if clk_enable is called from atomic context provided
> that the clock was prepared before (or doesn't need to).

NOOOOOOOOO!!!

We _do_ want drivers to _always_ call clk_prepare() in sleepable 
context, and _then_ always call clk_enable() in whatever context they 
wish.  Period.


Nicolas
