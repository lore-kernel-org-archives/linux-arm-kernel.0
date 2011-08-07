From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 6 Aug 2011 22:13:30 -0600
Subject: Shouldn't DT preserve pdev name and id to allow platform_match
	to work?
In-Reply-To: <4E3BE294.2020404@ti.com>
References: <4E396361.3060307@ti.com>
	<CACxGe6vg5NTyiDZqqztjtFEfb7si+-=Y7nEy1Y+YMgA5PVXScw@mail.gmail.com>
	<CAGsJ_4x7LWRGWXsWzMG1FxZPaFYiKSUpSac2PdwH=d6vqFWRfw@mail.gmail.com>
	<4E3BE294.2020404@ti.com>
Message-ID: <20110807041330.GG7667@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 05, 2011 at 02:31:16PM +0200, Cousson, Benoit wrote:
> On 8/5/2011 12:02 PM, Barry Song wrote:
> >>auxdata passes platform_data and overrides the device name when there
> >>is no way easy way to make the driver work without it.  It handles the
> >>the current implementation of clocks and regulators which aren't yet
> >>populated from the device tree.  It will go away when clock&
> >>regulator bindings are implemented.
> >Yes. As OF_DEV_AUXDATA_ID still requires hardware information like
> >0x48000100 as below, it seems it is not
> >consistent with the origin purpose of ARM DT.
> >OF_DEV_AUXDATA_ID("ti,omap-i2c", 0x48000100, "omap-i2c.1", 1,&i2c_pdata)
> >And the information 0x48000100 is something that doesn't want to be in
> >kernel codes.it should be only in dts.
> 
> FWIW, I do not care about the physical address at all. This is just
> used by the of_dev_lookup function to get the proper instance for a
> device compatible type.
> That's the only way for the OF_DEV_AUXDATA to work, but in theory
> you could do the same as soon as you provide the id. So
> OF_DEV_AUXDATA_ID could avoid it.
> 
> Since OF_DEV_AUXDATA_ID seems to be already dead before it even
> reaches the mainline, let's forget about that.

Actually, I'm planning to merge OF_DEV_AUXDATA_ID().  I was hoping to
avoid it but there was enough hard-to-solve-quickly problems that I've
relented.

Adding the match table is not hard-to-solve though, so I'm not
relenting on that point.  :-)

g.
