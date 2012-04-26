From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 26 Apr 2012 16:25:02 +0200
Subject: [PATCH v2] Convert i.MX architecture to generic clock framework
In-Reply-To: <4F995657.4080505@de.bosch.com>
References: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
 <4F995657.4080505@de.bosch.com>
Message-ID: <20120426142502.GM17184@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 04:06:15PM +0200, Dirk Behme wrote:
> On 25.04.2012 17:27, Sascha Hauer wrote:
> >Hi All,
> >
> >Here is another round of patches to convert i.MX to the generic clock
> >framework. It is based on Mikes recently published for-next branch plus:
> >
> >[PATCH V3 1/8] CLKDEV: Add helper routines to allocate and add clkdevs for given struct clk *
> >[PATCH V3 2/8] clk: add a fixed factor clock
> >clkdev: Implement managed clk_get()
> >
> >The branch is tested on all SoCs I have available, but regressions are more
> >than likely, so please give it a test.
> >
> >I didn't move the clock support to drivers/clk now as the clock control
> >module is shared with several other SoC specific stuff and I need a global
> >spinlock. Accessing this somewhere from drivers/ seems odd. Depending on
> >how things work out we can move it to drivers/ later.
> >
> >The remaining cleanups like removing the old clock support posted in the
> >last series are not included here, I will respin them once it's clear that
> >a series goes in
> >
> >For your convenience a complete series including dependencies (so not
> >meant for upstream) can be pulled here:
> >
> >git://git.pengutronix.de/git/imx/linux-2.6.git work/v3.4-rc4-imx-clk
> 
> Booting this on top of a 3.4-rc4 on a i.MX6 SabreLite gives me
> 
> ..
> Linux video capture interface: v2.00
> Switching to clocksource mxc_timer1
> Clockevents: could not switch to one-shot mode:
> Clockevents: could not switch to one-shot mode:
> Clockevents: could not switch to one-shot mode: dummy_timer is not
> functional.
>  dummy_timer is not functional.
> Clockevents: could not switch to one-shot mode:
> Could not switch to high resolution mode on CPU 0
>  dummy_timer is not functional.
> Could not switch to high resolution mode on CPU 2
> Could not switch to high resolution mode on CPU 1
>  dummy_timer is not functional.
> Could not switch to high resolution mode on CPU 3
> NET: Registered protocol family 2
> ...
> 
> I'm no expert of this, so just in case this is interesting for somebody.

Just rechecked, I can't reproduce this here on a arm2 board

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
