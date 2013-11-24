From: mgr@pengutronix.de (Michael Grzeschik)
Date: Sun, 24 Nov 2013 17:05:00 +0100
Subject: [PATCH 2/4 V2] ARM: mx28: Add USB PHY overcurrent pinmux
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A64980411E0AF@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1345852300-2213-1-git-send-email-marex@denx.de>
 <1345852300-2213-2-git-send-email-marex@denx.de>
 <20131122154947.GE24508@pengutronix.de>
 <F281D0F91ED19E4D8E63A7504E8A64980411E0AF@039-SN2MPN1-021.039d.mgd.msft.net>
Message-ID: <20131124160459.GG24508@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 23, 2013 at 02:48:48PM +0000, Peter Chen wrote:
> 
>  
> > >
> > > diff --git a/arch/arm/boot/dts/imx28.dtsi
> > b/arch/arm/boot/dts/imx28.dtsi
> > > index b996c2d..3cba62d 100644
> > > --- a/arch/arm/boot/dts/imx28.dtsi
> > > +++ b/arch/arm/boot/dts/imx28.dtsi
> > > @@ -520,6 +520,36 @@
> > >  					fsl,voltage = <1>;
> > >  					fsl,pull-up = <1>;
> > >  				};
> > > +
> > > +				usbphy0_pins_a: usbphy0 at 0 {
> > > +					reg = <0>;
> > > +					fsl,pinmux-ids = <
> > > +						0x2152 /*
> > MX28_PAD_SSP2_SS2__USB0_OVERCURRENT */
> > > +					>;
> > > +					fsl,drive-strength = <2>;
> > > +					fsl,voltage = <1>;
> > > +					fsl,pull-up = <0>;
> > > +				};
> > > +
> > > +				usbphy0_pins_b: usbphy0 at 1 {
> > > +					reg = <0>;
> > > +					fsl,pinmux-ids = <
> > > +						0x3061 /*
> > MX28_PAD_AUART1_CTS__USB0_OVERCURRENT */
> > > +					>;
> > > +					fsl,drive-strength = <2>;
> > > +					fsl,voltage = <1>;
> > > +					fsl,pull-up = <0>;
> > > +				};
> > > +
> > > +				usbphy1_pins_a: usbphy1 at 0 {
> > > +					reg = <0>;
> > > +					fsl,pinmux-ids = <
> > > +						0x2142 /*
> > MX28_PAD_SSP2_SS1__USB1_OVERCURRENT */
> > > +					>;
> > > +					fsl,drive-strength = <2>;
> > > +					fsl,voltage = <1>;
> > > +					fsl,pull-up = <0>;
> > > +				};
> > >  			};
> > >
> > >  			digctl at 8001c000 {
> > > --
> > > 1.7.10.4
> > 
> > 
> > @Marek: Did you test the overcurrent functionality with the MX28 and this
> > pinmux?
> > 
> > I currently can not trigger any overcurrent events and also don't
> > see changes in the PORTSC register after pulling the OC pin to 3V3.
> > 
> 
> I haven't checked pinmux detail, have you enabled oc and
> set oc's polarity (HW_DIGCTL_CTRL - 8001_C000h)?

No, I was not aware those DIG*DEEP*CTL bits exist. :)

Thank you Peter!

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
