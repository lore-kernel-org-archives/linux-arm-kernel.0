From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Jun 2012 11:15:59 +0100
Subject: [PATCH v2 REBASE] ASoC: fsl_ssi: convert to use devm_clk_get
In-Reply-To: <20120605101413.GJ23408@opensource.wolfsonmicro.com>
References: <1338774174-3960-1-git-send-email-richard.zhao@freescale.com>
 <20120605064714.GL30400@pengutronix.de>
 <20120605100316.GG23408@opensource.wolfsonmicro.com>
 <20120605100851.GI8262@n2100.arm.linux.org.uk>
 <20120605101413.GJ23408@opensource.wolfsonmicro.com>
Message-ID: <20120605101558.GJ8262@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2012 at 11:14:13AM +0100, Mark Brown wrote:
> On Tue, Jun 05, 2012 at 11:08:51AM +0100, Russell King - ARM Linux wrote:
> > On Tue, Jun 05, 2012 at 11:03:16AM +0100, Mark Brown wrote:
> 
> > > I've not, but I guess there will be an issue.  I'd say the fix here is
> > > on the PowerPC side - it's not good to have to have Kconfig bodges for
> > > things like this in individual drivers.  Ideally we'd add clkdev
> > > support...
> 
> > Or get rid of devm_clk_get()'s dependency on CLKDEV (which is in itself
> > silly.)
> 
> That'd work too, of course (providing everyone has been implementing
> clk_put()).  Though getting everyone on the same page with the clock API
> seems much more worthwhile if we can do it.

Why wouldn't clk_put() be implemented?  Drivers call it just like clk_get().

The devm*() stuff should just be a layer on top of clk_get()/clk_put() and
nothing more.
