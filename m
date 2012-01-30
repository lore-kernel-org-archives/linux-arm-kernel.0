From: tony@atomide.com (Tony Lindgren)
Date: Mon, 30 Jan 2012 09:49:10 -0800
Subject: Pinmux bindings proposal V2
In-Reply-To: <20120130031346.GD10470@S2101-09.ap.freescale.net>
References: <74CDBE0F657A3D45AFBB94109FB122FF1780DAB4CE@HQMAIL01.nvidia.com>
 <CAPnjgZ3Xhebn1x1A-Vdy78DWbDd=cp0AK6tL-R1SRzS4GdF97g@mail.gmail.com>
 <20120127022111.GK29812@atomide.com>
 <CAPnjgZ2EkvTMsOkWyf4pfwRpvcvYs=WaKy5Gi8fdkAUQmvt=ig@mail.gmail.com>
 <20120130031346.GD10470@S2101-09.ap.freescale.net>
Message-ID: <20120130174910.GG9339@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shawn Guo <shawn.guo@linaro.org> [120129 18:30]:
> On Fri, Jan 27, 2012 at 07:43:36AM -0800, Simon Glass wrote:
> ...
> > The cost of the pmx at dta node is about 12 bytes for the header (it
> > depends on the length of the name), and each of the properties above
> > is 16 bytes. So in total this node is 76 bytes. If we have 250 pins
> > being muxed as Tegra3 then this is about 20KB (including a bit of
> > slack for longer names). My point about being able to 'optimise out'
> > some of these remains, though, but probably not for the kernel.
> > 
> > Stephen's 'mux' property uses 12 bytes plus 8 bytes per pin/group (I
> > am removing the prefixes):
> > 
> >                        mux =
> >                                <PG_DTA   MUX_SDIO1>
> >                                <PG_DTD   MUX_SDIO1>;
> > 
> > so 28 bytes. What I proposed would use (12 + 2 * 16) per pin/group, or
> > 44 bytes (60% bigger):
> > 
> It's not only about size but also run-time tree travelling efficiency.
> Your proposal requires every single pin show as a node in device tree.
> Looking at these for_each_node_by_*() APIs in include/linux/of.h, you
> might agree we should avoid bloating device tree with so many nodes.

And that's why I'm suggesting two bindings: A minimal pinctrl-static
binding and more verbose pinctrl-dynamic binding.

AFAIK the number of pinctrl-dynamic bindings needed are just a fraction
of the pinctrl-static bindings. So the extra parsing needed for a few
pinctrl-dynamic bindings should not matter.

Sure it would be nice to have it all in a single binding, but these
bindings have conflicting requirements. So it may not be possible to
do it in a single binding in an efficient way.

Regards,

Tony
