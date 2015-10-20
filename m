From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 20 Oct 2015 19:14:28 +0300
Subject: [BISECTED] Nokia 770 framebuffer breakage
In-Reply-To: <20151020160524.GN32536@n2100.arm.linux.org.uk>
References: <20151019193759.GE31069@blackmetal.musicnaut.iki.fi>
 <20151019200522.GJ32536@n2100.arm.linux.org.uk>
 <20151019222413.GG31069@blackmetal.musicnaut.iki.fi>
 <20151019225033.GK32536@n2100.arm.linux.org.uk>
 <20151020085003.GA16268@blackmetal.musicnaut.iki.fi>
 <20151020090700.GL32536@n2100.arm.linux.org.uk>
 <20151020160524.GN32536@n2100.arm.linux.org.uk>
Message-ID: <20151020161428.GB16268@blackmetal.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 20, 2015 at 05:05:24PM +0100, Russell King - ARM Linux wrote:
> On Tue, Oct 20, 2015 at 10:07:00AM +0100, Russell King - ARM Linux wrote:
> > On Tue, Oct 20, 2015 at 11:50:03AM +0300, Aaro Koskinen wrote:
> > > On Mon, Oct 19, 2015 at 11:50:33PM +0100, Russell King - ARM Linux wrote:
> > > > It shouldn't (I've been through the resulting assembly code.)  I wonder
> > > > if this is fixing the problem, but it's now failing elsewhere instead.
> > > > 
> > > > What happens if you change it to:
> > > > 
> > > > 	l = clkdev_create(r, alias, alias_dev_name);
> > > > 
> > > > which should be 100% identical to how older kernels behaved
> > > 
> > > Ok, this and the earlier patch works on top of
> > > 2568999835d7797afce3dcc3a3f368051ffcaf1f, but not on 4.2 or newer - so
> > > it fixes the clk_add_alias issue, and newer kernels have other issues...
> > 
> > Thanks, so this fixes the regression you were seeing with the above
> > mentioned commit, so I'll get that into mainline and stable kernels.
> > 
> > Can I add a tested-by tag for it please?
> 
> Also make that reported-by as well.
> 
> I'll hold the patch back pending a reply...

Yes, both or either are fine.

A.
