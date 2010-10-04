From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 4 Oct 2010 13:32:17 -0600 (MDT)
Subject: [PATCH 08/10] OMAP: split plat-omap/common.c
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE4D9@dbde02.ent.ti.com>
References: <20101001213119.1408.65395.stgit@twilight.localdomain>
	<20101001213532.1408.55832.stgit@twilight.localdomain>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CDFE3C6@dbde02.ent.ti.com>
	<20101004065624.GD2559@legolas.emea.dhcp.ti.com>
	<20101004070040.GE2559@legolas.emea.dhcp.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CDFE4D9@dbde02.ent.ti.com>
Message-ID: <alpine.DEB.2.00.1010041327040.13816@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 4 Oct 2010, Shilimkar, Santosh wrote:

> > -----Original Message-----
> > From: Balbi, Felipe
> > Sent: Monday, October 04, 2010 12:31 PM
> > 
> > On Mon, Oct 04, 2010 at 01:56:24AM -0500, Balbi, Felipe wrote:
> > >
> > >I still have that sitting on my gitorious tree. The patch is attached
> > >to this mail. I compile tested (only) for omap3_defconfig, it probably
> > >needs to start using pm_runtime functions at some point and probably
> > >move to drivers/clocksource instead of arch/arm/plat-omap.
> > >
> > >patch is also available at [1]
> > >
> > >[1] git://gitorious.org/usb/usb.git clksource
> > 
> > I made a few changes to make checkpatch.pl --strict happy. Attached
> > 
> Good !!
> This patch addresses splitting as well as multi-omap builds and probably
> also a better candidate in case we need to convert sync timer to hwmod
> driver.
> 
> Paul, what's your take?

It's great that this is getting cleaned up but it's too late for 2.6.37.  
We stop taking new code after -rc6 comes out so we can try to get all of 
the changes integrated with each other and fix any bugs.

The best thing for you and Felipe to do is to convert the driver to use 
hwmod data and pm_runtime and test on more platforms, then post it to the 
list after 2.6.37 comes out.

- Paul
