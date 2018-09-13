From: atull@kernel.org (Alan Tull)
Date: Thu, 13 Sep 2018 15:14:45 -0500
Subject: [PATCH v2 1/2] ARM: dts: socfpga: Add fpga2hps and fpga2sdram
 bridges
In-Reply-To: <73lg85luwn.fsf@pengutronix.de>
References: <20180822084110.14969-1-s.trumtrar@pengutronix.de>
 <73lg85luwn.fsf@pengutronix.de>
Message-ID: <CANk1AXRicxbojUmtp8e7wzDcMNOX-Z4-P=oWw4dzfcR69rP+rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2018 at 2:27 AM Steffen Trumtrar
<s.trumtrar@pengutronix.de> wrote:
>
>
> Hi!
>
> Steffen Trumtrar <s.trumtrar@pengutronix.de> writes:
>
> > Add the remaining two bridges on the Cyclone-V SoCFPGA SoCs.
> >
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > ---
> > Changes in v2:
> >   - set status to disabled, so there are no accidental users of
> >   the bridges
> >
> >  arch/arm/boot/dts/socfpga.dtsi | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/socfpga.dtsi
> > b/arch/arm/boot/dts/socfpga.dtsi
> > index b38f8c240558..11781f795de2 100644
> > --- a/arch/arm/boot/dts/socfpga.dtsi
> > +++ b/arch/arm/boot/dts/socfpga.dtsi
> > @@ -543,6 +543,20 @@
> >                       clocks = <&l4_main_clk>;
> >               };
> >
> > +             fpga_bridge2: fpga-bridge at ff600000 {
> > +                     compatible =
> > "altr,socfpga-fpga2hps-bridge";
> > +                     reg = <0xff600000 0x100000>;
> > +                     resets = <&rst FPGA2HPS_RESET>;
> > +                     clocks = <&l4_main_clk>;
> > +                     status = "disabled";
> > +             };
> > +
> > +             fpga_bridge3: fpga-bridge at ffc25080 {
> > +                     compatible =
> > "altr,socfpga-fpga2sdram-bridge";
> > +                     reg = <0xffc25080 0x4>;
> > +                     status = "disabled";
> > +             };
> > +
> >               fpgamgr0: fpgamgr at ff706000 {
> >                       compatible = "altr,socfpga-fpga-mgr";
> >                       reg = <0xff706000 0x1000
>
> Any opinion on this? There shouldn't be any accidental use of the
> bridges now with status=disabled.

Hi Steffen,

Do you have a use case you need this for?

I don't mind leaving it that way it is and letting people who are
actually enabling the bridges in their designs add the whole node.

Alan

>
>
> Best regards,
> Steffen
>
> --
> Pengutronix e.K.                          | Steffen Trumtrar
> |
> Industrial Linux Solutions                |
> http://www.pengutronix.de/ |
> Peiner Str. 6-8, 31137 Hildesheim, Germany| Phone:
> +49-5121-206917-0   |
> Amtsgericht Hildesheim, HRA 2686          | Fax:
> +49-5121-206917-5555|
