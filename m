From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 20 Jun 2013 17:44:01 +0200
Subject: [PATCH 4/6] ARM: dts: imx27: Add 1-wire
In-Reply-To: <1371741454.488712140@f66.mail.ru>
References: <1371739815-6666-1-git-send-email-mpa@pengutronix.de>
 <1371739815-6666-5-git-send-email-mpa@pengutronix.de>
 <1371741454.488712140@f66.mail.ru>
Message-ID: <20130620154401.GD8219@s25.your-server.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 07:17:34PM +0400, Alexander Shiyan wrote:
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/imx27.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> > index 044004a..e883e77 100644
> > --- a/arch/arm/boot/dts/imx27.dtsi
> > +++ b/arch/arm/boot/dts/imx27.dtsi
> > @@ -110,6 +110,14 @@
> >  				clock-names = "ipg", "per";
> >  			};
> >  
> > +			owire: owire at 10009000 {
> > +				compatible = "fsl,imx21-owire";
> 
> I think you should use "fsl,imx27-owire", "fsl,imx21-owire" here.

Fixed, thank you

Markus

> 
> > +				reg = <0x10009000 0x1000>;
> > +				clocks = <&clks 35>;
> > +				clock-names = "ipg";
> > +				status = "disabled";
> > +			};
> > +
> >  			uart1: serial at 1000a000 {
> >  				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
> >  				reg = <0x1000a000 0x1000>;
> > -- 
> 
> 
> ---

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
