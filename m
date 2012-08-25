From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 25 Aug 2012 14:35:52 +0200
Subject: [PATCH 4/4] ARM: mxs: Add SchulerControl SPS1 DTS file
In-Reply-To: <20120825083042.GM31998@S2101-09.ap.freescale.net>
References: <1345852300-2213-1-git-send-email-marex@denx.de>
 <1345852300-2213-4-git-send-email-marex@denx.de>
 <20120825083042.GM31998@S2101-09.ap.freescale.net>
Message-ID: <201208251435.52411.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> Please base it on my mxs/dt-for-3.7 branch.
> 
> On Sat, Aug 25, 2012 at 01:51:40AM +0200, Marek Vasut wrote:
> > Add DTS file for this custom board.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > ---
> > 
> >  arch/arm/boot/dts/imx28-sps1.dts |  168
> >  ++++++++++++++++++++++++++++++++++++++ arch/arm/mach-mxs/mach-mxs.c    
> >  |    3 +
> >  2 files changed, 171 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/imx28-sps1.dts
> > 
> > diff --git a/arch/arm/boot/dts/imx28-sps1.dts
> > b/arch/arm/boot/dts/imx28-sps1.dts new file mode 100644
> > index 0000000..d05b1cb
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx28-sps1.dts
> > @@ -0,0 +1,168 @@
> > +/*
> > + * Copyright (C) 2012 Marek Vasut <marex@denx.de>
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
> > +/include/ "imx28.dtsi"
> > +
> > +/ {
> > +	model = "SchulerControl GmbH, SC SPS 1";
> > +	compatible = "schulercontrol,imx28-sps1", "fsl,imx28";
> 
> We should use the short name as prefix if it has one.
> 
> > +
> > +	memory {
> > +		reg = <0x40000000 0x08000000>;
> > +	};
> > +
> > +	apb at 80000000 {
> > +		apbh at 80000000 {
> > +			pinctrl at 80018000 {
> > +				led_pins_sps1: leds at 0 {
> 
> It should be referenced by the pinctrl state directly under node
> pinctrl at 80018000, otherwise the pins will not be set up.
> 
> Also we usually use a generic name here something like
> 
> 				hog_pins_a: hog at 0 {
> 
> so that we do not need to create new node every time we add pins
> for a new module.

So I'll ignore this comment and add pinctrl call into leds-gpio ... can we agree 
on that ?

[...]
