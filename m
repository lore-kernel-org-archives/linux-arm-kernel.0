From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 17 Oct 2011 21:12:51 +0200
Subject: [RFC] clocktree representation in the devicetree
In-Reply-To: <201110171702.05319.arnd@arndb.de>
References: <20111017102921.GA18141@pengutronix.de>
	<201110171702.05319.arnd@arndb.de>
Message-ID: <20111017191251.GE18141@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2011 at 05:02:05PM +0200, Arnd Bergmann wrote:
> On Monday 17 October 2011, Sascha Hauer wrote:
> > The following is an attempt to represent the clocktree of a i.MX53 in
> > the devicetree. I created this to see how it would look like and to
> > start a discussion whether we want to move in this direction or not.
> 
> Very good, thanks for getting this started!
> 
> > Some things to consider:
> > 
> > - It seems to be very flexible. A board can customize the clock tree
> >   by just adding some clk-parent=<phandle> properties to the muxers.
> > - clocks can easily be associated with devices.
> > 
> > but:
> > 
> > - The following example registers 127 new platform devices and it's
> >   not even complete. This adds significant overhead to initialization.
> 
> I don't understand enough about the clock trees to understand if the
> dts representation is good, but it I don't see a reason to represent
> it as lots of platform devices in linux. We can have lots of device_nodes
> in the device tree that are not a platform_device but we can still
> access them through the of_*() functions. Ideally, we would encapsulate
> all the clock tree parsing in the clk subsystem and provide high-level
> interfaces to clkdev drivers from there.

Still we have to parse the compatible stuff and have to match a clock
entry to the corresponding driver. If we don't use platform devices here
I think we have to be careful to not create something which resembles
the platform devices with similar overhead.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
