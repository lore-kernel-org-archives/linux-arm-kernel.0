From: tony@atomide.com (Tony Lindgren)
Date: Fri, 7 Sep 2012 10:33:37 -0700
Subject: [PATCH] ARM: dts: OMAP4: Add reg and interrupts for every nodes
In-Reply-To: <20120907172500.GB9208@arwen.pp.htv.fi>
References: <504A11E4.6000406@ti.com> <20120907170621.GZ1303@atomide.com>
 <20120907172500.GB9208@arwen.pp.htv.fi>
Message-ID: <20120907173337.GC1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [120907 10:30]:
> Hi,
> 
> On Fri, Sep 07, 2012 at 10:06:22AM -0700, Tony Lindgren wrote:
> > * Benoit Cousson <b-cousson@ti.com> [120907 08:26]:
> > > Thanks to Vaibhav <hvaibhav@ti.com> omap_device fix
> > > (ARM: OMAP: omap_device: Fix up resource names when booted with devicetre),
> > > we can now specify reg and interrupts using standard device tree
> > > attributes.
> > > 
> > > Update the OMAP4 dtsi file with missing reg and interrupts attributes.
> > > 
> > > Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> > > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > > Cc: Tony Lindgren <tony@atomide.com>
> > > Cc: Felipe Balbi <balbi@ti.com>
> > > ---
> > > 
> > > Hi Tony,
> > > 
> > > This is the first step toward reduction of the hwmod data inside mach-omap2.
> > > OMAP2/3/4 data still need to be there for legacy boards, but it will allow
> > > OMAP5/AM33XX pure DT board to reduce the amount of data provided by hwmod.
> > 
> > That's good to hear, that should cut down the data by some hundreds of lines :)
> 
> more than you think, I guess :-)

Very cool, we're only two board files away from making omap4 data shrink by:
omap_hwmod_44xx_data.c | 1432 -------------------------------------------------

But basically no need to merge similar data at all for am33xx and omap5.

Regards,

Tony
