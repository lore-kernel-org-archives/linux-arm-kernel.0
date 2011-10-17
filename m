From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 17 Oct 2011 10:20:28 +0100
Subject: [PATCH v2 1/7] clk: Add a generic clock infrastructure
In-Reply-To: <20111017084851.GB20184@b20223-02.ap.freescale.net>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-2-git-send-email-mturquette@ti.com>
	<20111014081024.GA9485@b20223-02.ap.freescale.net>
	<20111014100504.GC2966@opensource.wolfsonmicro.com>
	<20111014103233.GB9485@b20223-02.ap.freescale.net>
	<20111016175521.GA13565@pengutronix.de>
	<20111017084851.GB20184@b20223-02.ap.freescale.net>
Message-ID: <20111017092028.GA3042@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2011 at 04:48:52PM +0800, Richard Zhao wrote:

> For example, devices that possible access to on-chip RAM, depend on OCRAM clock. 
> On imx53, VPU depends on OCRAM clock, even when VPU does not use OCRAM.

So if the VPU depends on OCRAM the VPU should be enabling the OCRAM
clock.  The function of a given clock isn't terribly relevant, and
certainly grouping clocks together doesn't seem to be the obvious
solution from what you've said - if the driver doesn't know about the
clock it seems like the core ought to be enabling it transparently
rather than gluing it together with some other random clock.

Either way the point here is that individual drivers shouldn't be hand
coding this stuff, it should be being handled by core code.
