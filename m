From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 18 Nov 2013 14:42:26 +0100
Subject: [RFC 9/9] ARM: DTS: imx5* imx6*, use imx50-ssi
In-Reply-To: <20131118020233.GN11014@S2101-09.ap.freescale.net>
References: <1384530584-31273-1-git-send-email-mpa@pengutronix.de>
 <1384530584-31273-10-git-send-email-mpa@pengutronix.de>
 <20131118020233.GN11014@S2101-09.ap.freescale.net>
Message-ID: <20131118134226.GM30263@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Mon, Nov 18, 2013 at 10:02:35AM +0800, Shawn Guo wrote:
> On Fri, Nov 15, 2013 at 04:49:44PM +0100, Markus Pargmann wrote:
> > imx50-ssi and imx21-ssi are different IPs. imx50-ssi supports online
> > reconfiguration and needs this for correct interaction with SDMA. Move
> > from imx21-ssi to imx50-ssi for all imx5/imx6 SoCs.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/imx51.dtsi   | 6 +++---
> >  arch/arm/boot/dts/imx53.dtsi   | 6 +++---
> >  arch/arm/boot/dts/imx6qdl.dtsi | 6 +++---
> >  arch/arm/boot/dts/imx6sl.dtsi  | 6 +++---
> >  4 files changed, 12 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> > index 54cee65..22d4dbe 100644
> > --- a/arch/arm/boot/dts/imx51.dtsi
> > +++ b/arch/arm/boot/dts/imx51.dtsi
> > @@ -150,7 +150,7 @@
> >  				};
> >  
> >  				ssi2: ssi at 70014000 {
> > -					compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
> > +					compatible = "fsl,imx51-ssi", "fsl,imx50-ssi";
> 
> Instead of replacing "fsl,imx21-ssi" with "fsl,imx50-ssi", we may want
> to just add "fsl,imx50-ssi" in the middle to maintain the compatible
> history.  Note, it only works with the change I suggested on
> of_device_id table order.  The bonus point of doing so is that we will
> not have git bisect issue to worry about with merging this patch and
> others in the series via different tree.

Thanks, I changed the id table order and added imx21-ssi as compatible
again.

Regards,

Markus


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
