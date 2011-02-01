From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Feb 2011 19:56:04 +0000
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
Message-ID: <20110201195604.GS31216@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 01, 2011 at 08:32:01PM +0100, Uwe Kleine-K?nig wrote:
> On Tue, Feb 01, 2011 at 05:06:37PM +0000, Russell King - ARM Linux wrote:
> > So?  You're not _supposed_ to call it from any atomic context ever.
>
> My motivation for a more complicated clk_prepare was to make clk_prepare
> atomic when that's possible (i.e. when the clk is already prepared) and
> call it before the enable callback in clk_enable.  Then everything
> behaves nicely even if clk_enable is called from atomic context provided
> that the clock was prepared before (or doesn't need to).

You really don't get the point of clk_prepare() do you.  I'm not
going to bother trying to educate you anymore.

Hopefully someone with more patience can give you the necessary
teaching to make you understand.
