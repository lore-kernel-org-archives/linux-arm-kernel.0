From: fabien.dessenne@st.com (Fabien DESSENNE)
Date: Wed, 17 Jun 2015 15:52:47 +0200
Subject: [PATCH] ARM: DT: STiH410: Add bdisp dt nodes
In-Reply-To: <55816455.1030503@st.com>
References: <1434461440-3965-1-git-send-email-fabien.dessenne@st.com>
 <55816455.1030503@st.com>
Message-ID: <15ED7CB7B68B4D4C96C7D27A1A23941201BA003733@SAFEX1MAIL2.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

> -----Original Message-----
> From: Maxime COQUELIN
> Sent: mercredi 17 juin 2015 14:13
> To: Fabien DESSENNE; Srinivas Kandagatla; Patrice CHOTARD; Rob Herring;
> Pawel Moll; Mark Rutland; Ian Campbell; Kumar Gala; Russell King; linux-arm-
> kernel at lists.infradead.org; kernel at stlinux.com;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org
> Cc: Benjamin Gaignard
> Subject: Re: [PATCH] ARM: DT: STiH410: Add bdisp dt nodes
> 
> Hi Fabien,
> 
> On 06/16/2015 03:30 PM, Fabien Dessenne wrote:
> > Add the bdisp (2D blitter for STMicroelectronics SoC) dt nodes for the
> > first of the two bdisp devices, defining register address, interrupt
> > and clock.
> >
> > Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> > ---
> >   arch/arm/boot/dts/stih410.dtsi | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/stih410.dtsi
> > b/arch/arm/boot/dts/stih410.dtsi index 208b5e8..6f40bc9 100644
> > --- a/arch/arm/boot/dts/stih410.dtsi
> > +++ b/arch/arm/boot/dts/stih410.dtsi
> > @@ -10,6 +10,10 @@
> >   #include "stih407-family.dtsi"
> >   #include "stih410-pinctrl.dtsi"
> >   / {
> > +	aliases {
> > +		bdisp0 = &bdisp0;
> > +	};
> > +
> >   	soc {
> >   		usb2_picophy1: phy2 {
> >   			compatible = "st,stih407-usb2-phy"; @@ -218,5
> +222,13 @@
> >   				};
> >   			};
> >   		};
> > +
> > +		bdisp0:bdisp at 9f10000 {
> > +			compatible = "st,stih407-bdisp";
> > +			reg = <0x9f10000 0x1000>;
> > +			interrupts = <GIC_SPI 38 IRQ_TYPE_NONE>;
> > +			clock-names = "bdisp";
> > +			clocks = <&clk_s_c0_flexgen CLK_IC_BDISP_0>;
> > +		};
> 
> Isn't the bdisp also present on STiH407 SoC?
> If so, could you please move this node to stih407-family file?
> 
> Thanks,
> Maxime

For the time being, it is not planned to be supported on STiH407. Maybe one day...

Fabien
