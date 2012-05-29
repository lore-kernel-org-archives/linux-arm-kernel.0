From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 29 May 2012 16:34:14 +0200
Subject: [PATCH] ARM: mx35: add cpufreq support
In-Reply-To: <20120517224205.GA7021@mars>
References: <20120507141437.GA9636@lovely.krouter>
 <20120509072239.GG27341@pengutronix.de>
 <20120509075618.GA4412@lovely.krouter>
 <20120509081306.GK27341@pengutronix.de>
 <1337276960.4970.4.camel@lovely>
 <20120517182036.GK30400@pengutronix.de>
 <1337280058.4970.6.camel@lovely> <20120517224205.GA7021@mars>
Message-ID: <20120529143414.GE16535@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2012 at 12:42:05AM +0200, Christoph Fritz wrote:
> On Thu, May 17, 2012 at 08:40:58PM +0200, Christoph Fritz wrote:
> > On Thu, 2012-05-17 at 20:20 +0200, Sascha Hauer wrote:
> > > On Thu, May 17, 2012 at 07:49:20PM +0200, Christoph Fritz wrote:
> > 
> > > > Is there already a version I can rebase the patch?
> > > > 
> > > > On your repo at git://git.pengutronix.de/git/imx/linux-2.6.git I can't
> > > > find the new clock framework or even a work-in-progress version.
> > > 
> > > They are in linux-next now.
> 
> There changed a lot of stuff: Where should I register the function to
> set/get the cpu frequency?
> 
> To get an idea of how it should be done, I looked at imx51: Is there
> cpufreq-support still implemented/working?  I can see the
> arch/arm/mach-imx/cpu_op-mx51.c but not its correlating
> clk_cpu_set_rate function in arch/arm/mach-imx/clk-imx51-imx53.c.

>From what I see there must be a clkdev registered for the cpu clock.
Seems this got lost during conversion to the generic clock framework.

in arch/arm/plat-mxc/cpufreq.c:

	cpu_clk = clk_get(NULL, "cpu_clk");

should be:

	cpu_clk = clk_get(NULL, "cpu");

I don't know if that's enough though.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
