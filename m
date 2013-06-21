From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Fri, 21 Jun 2013 08:54:53 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSCA1LzZdIEFSTTogZHRzOiBpbXgyNyBjcHVmcmVxLWNw?=
 =?UTF-8?B?dTAgZnJlcXVlbmNpZXM=?=
In-Reply-To: <20130621024406.GB24268@S2101-09.ap.freescale.net>
References: <1371739815-6666-1-git-send-email-mpa@pengutronix.de>
 <1371739815-6666-6-git-send-email-mpa@pengutronix.de>
 <20130621024406.GB24268@S2101-09.ap.freescale.net>
Message-ID: <1371790493.32418815@f415.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Thu, Jun 20, 2013 at 04:50:14PM +0200, Markus Pargmann wrote:
> > Set operating-points for imx27. There is no regulator support, so the
> > voltages are 0. The frequencies should be the same for all imx27 boards,
> > so it is defined here and can be overwritten if necessary.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/imx27.dtsi | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> > index e883e77..3ebd98a 100644
> > --- a/arch/arm/boot/dts/imx27.dtsi
> > +++ b/arch/arm/boot/dts/imx27.dtsi
> > @@ -47,6 +47,25 @@
> >  		};
> >  	};
> >  
> > +	cpus {
> > +		#size-cells = <0>;
> > +		#address-cells = <1>;
> > +
> > +		cpu at 0 {
> > +			device_type = "cpu";
> > +			compatible = "fsl,imx27", "arm,arm926ejs";
> 
> From what Documentation/devicetree/bindings/arm/cpus.txt tells, it
> should be "arm,arm926".  Also, why do you put "fsl,imx27" there?
> "imx27" is a SoC name not cpu core.

I think Markus take this ARM property from one of existing DTS.

shc at shc /home/git/linux-mx27/arch/arm/boot/dts $ grep arm926 *.dtsi
at91sam9260.dtsi:                       compatible = "arm,arm926ejs";
at91sam9263.dtsi:                       compatible = "arm,arm926ejs";
at91sam9g45.dtsi:                       compatible = "arm,arm926ejs";
at91sam9n12.dtsi:                       compatible = "arm,arm926ejs";
at91sam9x5.dtsi:                        compatible = "arm,arm926ejs";
imx23.dtsi:                     compatible = "arm,arm926ejs";
imx28.dtsi:                     compatible = "arm,arm926ejs";
lpc32xx.dtsi:                   compatible = "arm,arm926ejs";
s3c2416.dtsi:                   compatible = "arm,arm926ejs";
spear3xx.dtsi:                  compatible = "arm,arm926ejs";
spear600.dtsi:                  compatible = "arm,arm926ejs";
wm8505.dtsi:                    compatible = "arm,arm926ejs";

So, documentation need to be updated or these values should be fixed.
Another solution  is specify compatible string as:
compatible = "arm,arm926ejs", "arm,arm926";
What you think about this?

---
