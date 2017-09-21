From: horms@verge.net.au (Simon Horman)
Date: Thu, 21 Sep 2017 10:31:16 +0200
Subject: [PATCH 3/8] ARM: dts: iwg22m: Enable SDHI1 controller
In-Reply-To: <TY1PR06MB07026CA91F110214FF170FA3B7610@TY1PR06MB0702.apcprd06.prod.outlook.com>
References: <1505322341-9480-1-git-send-email-chris.paterson2@renesas.com>
 <1505322341-9480-4-git-send-email-chris.paterson2@renesas.com>
 <20170915081144.GI3924@verge.net.au>
 <TY1PR06MB07026CA91F110214FF170FA3B7610@TY1PR06MB0702.apcprd06.prod.outlook.com>
Message-ID: <20170921083116.GE15749@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 01:05:07PM +0000, Chris Paterson wrote:
> Hello Simon,
> 
> > From: devicetree-owner at vger.kernel.org [mailto:devicetree-
> > owner at vger.kernel.org] On Behalf Of Simon Horman
> > Sent: 15 September 2017 09:12
> > To: Chris Paterson <Chris.Paterson2@renesas.com>
> > 
> > On Wed, Sep 13, 2017 at 06:05:36PM +0100, Chris Paterson wrote:
> > > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > >
> > > Enable the SDHI1 controller on iWave RZ/G1E SoM.
> > >
> > > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> > > ---
> > > This patch is based on renesas-devel-20170913-v4.13.
> > >
> > >
> > >  arch/arm/boot/dts/r8a7745-iwg22m.dtsi | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
> > > b/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
> > > index e306e7c..f7f9cef 100644
> > > --- a/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
> > > +++ b/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
> > > @@ -9,6 +9,7 @@
> > >   */
> > >
> > >  #include "r8a7745.dtsi"
> > > +#include <dt-bindings/gpio/gpio.h>
> > >
> > >  / {
> > >  	compatible = "iwave,g22m", "renesas,r8a7745"; @@ -38,6 +39,12
> > @@
> > >  		function = "mmc";
> > >  	};
> > >
> > > +	sdhi1_pins: sd1 {
> > > +		groups = "sdhi1_data4", "sdhi1_ctrl";
> > > +		function = "sdhi1";
> > > +		power-source = <3300>;
> > > +	};
> > > +
> > >  	i2c3_pins: i2c3 {
> > >  		groups = "i2c3_b";
> > >  		function = "i2c3";
> > > @@ -54,6 +61,16 @@
> > >  	status = "okay";
> > >  };
> > >
> > > +&sdhi1 {
> > > +	pinctrl-0 = <&sdhi1_pins>;
> > > +	pinctrl-names = "default";
> > > +
> > > +	vmmc-supply = <&reg_3p3v>;
> > > +	vqmmc-supply = <&reg_3p3v>;
> > > +	cd-gpios = <&gpio3 31 GPIO_ACTIVE_LOW>;
> > 
> > No wp-gpios property means this is a ?SD slot, right?
> 
> Correct
> 
> > 
> > Do you have any plans to enable sdr-50 and sdr-104?
> > Is it not supported for some reason?
> 
> Nope (unless the hardware changes down the line).
> Both vmmc and vqmmc are fixed to 3V3 on the iWave-E SOM module.

Thanks, got it.
