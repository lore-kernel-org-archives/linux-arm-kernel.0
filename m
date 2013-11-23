From: Peter.Chen@freescale.com (Peter Chen)
Date: Sat, 23 Nov 2013 14:48:48 +0000
Subject: [PATCH 2/4 V2] ARM: mx28: Add USB PHY overcurrent pinmux
In-Reply-To: <20131122154947.GE24508@pengutronix.de>
References: <1345852300-2213-1-git-send-email-marex@denx.de>
 <1345852300-2213-2-git-send-email-marex@denx.de>
 <20131122154947.GE24508@pengutronix.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A64980411E0AF@039-SN2MPN1-021.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


 
> >
> > diff --git a/arch/arm/boot/dts/imx28.dtsi
> b/arch/arm/boot/dts/imx28.dtsi
> > index b996c2d..3cba62d 100644
> > --- a/arch/arm/boot/dts/imx28.dtsi
> > +++ b/arch/arm/boot/dts/imx28.dtsi
> > @@ -520,6 +520,36 @@
> >  					fsl,voltage = <1>;
> >  					fsl,pull-up = <1>;
> >  				};
> > +
> > +				usbphy0_pins_a: usbphy0 at 0 {
> > +					reg = <0>;
> > +					fsl,pinmux-ids = <
> > +						0x2152 /*
> MX28_PAD_SSP2_SS2__USB0_OVERCURRENT */
> > +					>;
> > +					fsl,drive-strength = <2>;
> > +					fsl,voltage = <1>;
> > +					fsl,pull-up = <0>;
> > +				};
> > +
> > +				usbphy0_pins_b: usbphy0 at 1 {
> > +					reg = <0>;
> > +					fsl,pinmux-ids = <
> > +						0x3061 /*
> MX28_PAD_AUART1_CTS__USB0_OVERCURRENT */
> > +					>;
> > +					fsl,drive-strength = <2>;
> > +					fsl,voltage = <1>;
> > +					fsl,pull-up = <0>;
> > +				};
> > +
> > +				usbphy1_pins_a: usbphy1 at 0 {
> > +					reg = <0>;
> > +					fsl,pinmux-ids = <
> > +						0x2142 /*
> MX28_PAD_SSP2_SS1__USB1_OVERCURRENT */
> > +					>;
> > +					fsl,drive-strength = <2>;
> > +					fsl,voltage = <1>;
> > +					fsl,pull-up = <0>;
> > +				};
> >  			};
> >
> >  			digctl at 8001c000 {
> > --
> > 1.7.10.4
> 
> 
> @Marek: Did you test the overcurrent functionality with the MX28 and this
> pinmux?
> 
> I currently can not trigger any overcurrent events and also don't
> see changes in the PORTSC register after pulling the OC pin to 3V3.
> 

I haven't checked pinmux detail, have you enabled oc and
set oc's polarity (HW_DIGCTL_CTRL - 8001_C000h)?

Peter
