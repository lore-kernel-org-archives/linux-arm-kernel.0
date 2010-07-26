From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 26 Jul 2010 14:00:08 +0200
Subject: Pull request mxc
In-Reply-To: <20100726103219.GB20737@n2100.arm.linux.org.uk>
References: <20100726090014.GQ14113@pengutronix.de>
	<20100726092855.GA20737@n2100.arm.linux.org.uk>
	<20100726103219.GB20737@n2100.arm.linux.org.uk>
Message-ID: <20100726120008.GR14113@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Added Guennadi, Baruch and linux-media to cc]

On Mon, Jul 26, 2010 at 11:32:19AM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 26, 2010 at 10:28:55AM +0100, Russell King - ARM Linux wrote:
> > On Mon, Jul 26, 2010 at 11:00:14AM +0200, Sascha Hauer wrote:
> > >  160 files changed, 6547 insertions(+), 3276 deletions(-)
> > 
> > I get:
> > 
> > 160 files changed, 6530 insertions(+), 3265 deletions
> > 
> > which seems to be down to this difference between your diffstat and mine:
> > 
> > > arch/arm/mach-mx3/mach-mx31lilly.c                 |   48 +-
> > 
> >  arch/arm/mach-mx3/mach-mx31lilly.c                 |   20 +-
> > 
> > This seems to be down to 4d5d859 (ARM: mx3: mx31lilly: fix build error for
> > !CONFIG_USB_ULPI).
> 
> Err...
> 
> commit 10ee61384e444133e4d2cf2a1f21fdd50c2be297
> Author: Baruch Siach <baruch@tkos.co.il>
> Date:   Sun Jul 4 07:55:10 2010 +0300
> 
>     mx2_camera: Add soc_camera support for i.MX25/i.MX27
> 
>     This is the soc_camera support developed by Sascha Hauer for the i.MX27.  Alan
>     Carvalho de Assis modified the original driver to get it working on more recent
>     kernels. I modified it further to add support for i.MX25. This driver has been
>     tested on i.MX25 and i.MX27 based platforms.
> 
>     Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>     Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>     Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Why has no one from the V4L community reviewed this patch?

It was posted to linux-media and reviewed there. I put it in my tree to
prevent problems due to missing platform_data declarations when board
support for the camera gets added.

> 
> Why are you using void __iomem * with the virtual address returned from
> dma_alloc_coherent()?  It doesn't return IOMEM addresses!

Baruch, can you fix this?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
