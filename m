From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 20 Feb 2012 19:28:23 +0100
Subject: [PATCH] ARM i.MX5/6: Add dt support for generic boards
In-Reply-To: <20120220064213.GB19668@S2101-09.ap.freescale.net>
References: <1329476820-27066-1-git-send-email-s.hauer@pengutronix.de>
 <20120220064213.GB19668@S2101-09.ap.freescale.net>
Message-ID: <20120220182823.GY3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Mon, Feb 20, 2012 at 02:42:15PM +0800, Shawn Guo wrote:
> On Fri, Feb 17, 2012 at 12:07:00PM +0100, Sascha Hauer wrote:
> > Apart from the iomux setup which may not be needed on custom
> > boards the kernel starts fine using the devicetree, so add
> > generic boards to the dt_compat entries.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  arch/arm/mach-imx/imx51-dt.c   |    1 +
> >  arch/arm/mach-imx/imx53-dt.c   |    1 +
> >  arch/arm/mach-imx/mach-imx6q.c |    1 +
> >  3 files changed, 3 insertions(+), 0 deletions(-)
> > 
> I guess the point that the patch is trying to make is that we do not
> need to touch these files whenever we add a new board booting with
> device tree, if the board does not need any special handling there
> with its compatible string.

Yes.

> 
> But we may still need a specific compatible string for the board in its
> .dts file rather than just specific common like "fsl,imx6q".

Yes, a dts file should definitely have a more specific compatible string
with fsl,imx6q just being the fallback.

>  That
> said, Documentation/devicetree/bindings/arm/fsl.txt needs an update
> anyway whenever a new board support is added.
> 
> Also, isn't it a good thing to have the dt_compat list explicitly show
> all the boards that the dt file supports?

When we add the dts file to the kernel we can update Doc/../fsl.txt
accordingly. I find it very useful to be able to run an unpatched kernel
on various custom boards which are (not yet) in mainline.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
