From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 10 Jan 2013 08:21:30 +0100
Subject: [PATCH 4/4] ARM i.MX53: dts: add oftree for MBa53 baseboard
In-Reply-To: <20130110024543.GE2265@S2101-09.ap.freescale.net>
References: <1357739065-9153-1-git-send-email-s.trumtrar@pengutronix.de>
 <1357739065-9153-5-git-send-email-s.trumtrar@pengutronix.de>
 <20130110024543.GE2265@S2101-09.ap.freescale.net>
Message-ID: <20130110072130.GA17605@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Thu, Jan 10, 2013 at 10:45:45AM +0800, Shawn Guo wrote:
> On Wed, Jan 09, 2013 at 02:44:25PM +0100, Steffen Trumtrar wrote:
> > The MBa53 is a baseboard for the TQMA53 embedded module. This enables/adds only
> > supported devices, i.e. it is not feature complete, because of missing drivers
> > in mainline linux.
> > 
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/Makefile        |    1 +
> >  arch/arm/boot/dts/imx53-MBa53.dts |  146 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 147 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/imx53-MBa53.dts
> > 
> I do not like the CamelCase in filename, and do not want to be the first
> one doing that in  arch/arm/boot/dts.
> 

Okay, no problem. I will change that.

> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index e44da40..04b05e8 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -84,6 +84,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx51-babbage.dtb \
> >  	imx53-evk.dtb \
> >  	imx53-qsb.dtb \
> >  	imx53-smd.dtb \
> > +	imx53-MBa53.dtb \
> 
> Change it to lower case and sort it properly.
> 

Ditto.

> >  	imx6q-arm2.dtb \
> >  	imx6q-sabreauto.dtb \
> >  	imx6q-sabrelite.dtb \
> > diff --git a/arch/arm/boot/dts/imx53-MBa53.dts b/arch/arm/boot/dts/imx53-MBa53.dts
> > new file mode 100644
> > index 0000000..39ecaeb
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx53-MBa53.dts
> > @@ -0,0 +1,146 @@
> > +/*
> > + * Copyright 2012 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> > +
> > +/dts-v1/;
> > +/include/ "imx53-tqma53.dtsi"
> > +
> > +/ {
> > +	model = "TQ MBa53 starter kit";
> > +	compatible = "tq,mba53", "tq,tqma53", "fsl,imx53";
> > +
> > +	backlight_reg:fixed at 0 {
> 
> The node name is not good.  Also we generally have a space between
> label and node names.
> 
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "lcd-supply";
> > +		gpio = <&gpio2 5 0>;
> > +		startup-delay-us = <5000>;
> > +		enable-active-low;
> > +        };
> 
> Use tab instead of space.
> 
> > +
> > +	backlight {
> > +		compatible = "pwm-backlight";
> > +		pwms = <&pwm2 0 50000 0 0>;
> > +		brightness-levels = <0 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100>;
> > +		default-brightness-level = <10>;
> > +		enable-gpios = <&gpio7 7 0>;
> > +		power-supply = <&backlight_reg>;
> > +        };
> 
> Ditto
> 

Hm, I wonder why my highlighting didn't show that. I will fix that and
will resend this patch.

Thanks,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
