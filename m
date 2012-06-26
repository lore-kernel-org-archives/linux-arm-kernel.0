From: marex@denx.de (Marek Vasut)
Date: Tue, 26 Jun 2012 14:17:58 +0200
Subject: [PATCH] ARM: mx28: Add LCD pinmux
In-Reply-To: <20120626025216.GK2342@S2101-09.ap.freescale.net>
References: <1340477119-2835-1-git-send-email-marex@denx.de>
 <20120626025216.GK2342@S2101-09.ap.freescale.net>
Message-ID: <201206261417.58300.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Sat, Jun 23, 2012 at 08:45:18PM +0200, Marek Vasut wrote:
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Detlev Zundel <dzu@denx.de>
> > CC: Dong Aisheng <b29396@freescale.com>
> > CC: Fabio Estevam <fabio.estevam@freescale.com>
> > Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
> > CC: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Stefano Babic <sbabic@denx.de>
> > Cc: Wolfgang Denk <wd@denx.de>
> > ---
> > 
> >  arch/arm/boot/dts/imx28.dtsi |   45
> >  ++++++++++++++++++++++++++++++++++++++++++ 1 file changed, 45
> >  insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> > index 464303c..ab29cbe 100644
> > --- a/arch/arm/boot/dts/imx28.dtsi
> > +++ b/arch/arm/boot/dts/imx28.dtsi
> > @@ -221,6 +221,51 @@
> > 
> >  					fsl,pull-up = <0>;
> >  				
> >  				};
> > 
> > +				lcd_data_pins_8bpp_a: lcd at 0 {
> > +					reg = <0>;
> > +					fsl,pinmux-ids = <0x1000 0x1010 0x1020 
0x1030
> > +						0x1040 0x1050 0x1060 0x1070>;
> > +					fsl,drive-strength = <0>;
> > +					fsl,voltage = <1>;
> > +					fsl,pull-up = <0>;
> > +				};
> > +
> > +				lcd_data_pins_16bpp_a: lcd at 1 {
> > +					reg = <0>;
> > +					fsl,pinmux-ids = <0x1000 0x1010 0x1020 
0x1030
> > +						0x1040 0x1050 0x1060 0x1070
> > +						0x1080 0x1090 0x10a0 0x10b0
> > +						0x10c0 0x10d0 0x10e0 0x10f0>;
> > +					fsl,drive-strength = <0>;
> > +					fsl,voltage = <1>;
> > +					fsl,pull-up = <0>;
> > +				};
> > +
> > +				lcd_data_pins_18bpp_a: lcd at 2 {
> > +					reg = <0>;
> > +					fsl,pinmux-ids = <0x1000 0x1010 0x1020 
0x1030
> > +						0x1040 0x1050 0x1060 0x1070
> > +						0x1080 0x1090 0x10a0 0x10b0
> > +						0x10c0 0x10d0 0x10e0 0x10f0
> > +						0x1100 0x1110>;
> > +					fsl,drive-strength = <0>;
> > +					fsl,voltage = <1>;
> > +					fsl,pull-up = <0>;
> > +				};
> > +
> > +				lcd_data_pins_24bpp_a: lcd at 3 {
> > +					reg = <0>;
> > +					fsl,pinmux-ids = <0x1000 0x1010 0x1020 
0x1030
> > +						0x1040 0x1050 0x1060 0x1070
> > +						0x1080 0x1090 0x10a0 0x10b0
> > +						0x10c0 0x10d0 0x10e0 0x10f0
> > +						0x1100 0x1110 0x1120 0x1130
> > +						0x1140 0x1150 0x1160 0x1170>;
> > +					fsl,drive-strength = <0>;
> > +					fsl,voltage = <1>;
> > +					fsl,pull-up = <0>;
> > +				};
> > +
> 
> We do not want to enumerate all the possible mux options.  Instead,
> please add mux setting when there is indeed a user for it.

Well, I'd prefer to have it ready to be used, instead of having partial slabs of 
muxes. But whatever.

Is anyone converting the LCD driver over to DT or not?

Best regards,
Marek Vasut
