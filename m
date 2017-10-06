From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 6 Oct 2017 09:01:55 +0000
Subject: [PATCH 1/2] ARM: dts: iwg20d-q7: Rework DT architecture
In-Reply-To: <CAMuHMdW-Y7tK28YAGBRMqdgZK7vVqnUcud1FtzQd6wLrKii_AA@mail.gmail.com>
References: <1507108713-10686-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1507108713-10686-2-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdW-Y7tK28YAGBRMqdgZK7vVqnUcud1FtzQd6wLrKii_AA@mail.gmail.com>
Message-ID: <TY1PR06MB0895158D1245B1DF150DC9DAC0710@TY1PR06MB0895.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Geert,

>
> Hi Fabrizio,
>
> On Wed, Oct 4, 2017 at 11:18 AM, Fabrizio Castro
> <fabrizio.castro@bp.renesas.com> wrote:
> > Since the same carrier board may host RZ/G1M and RZ/G1N based
> > Systems on Module, the DT architecture for iwg20d-q7 needs
> > better decoupling. This patch provides:
> > * iwg20d-q7-common.dtsi - its purpose is to define the carrier
> >   board definitions, and its content is basically the same
> >   as the previous version of r8a7743-iwg20d-q7.dts, only it
> >   has no reference to the SoM .dtsi, and that's why the
> >   filename doesn't mention the SoC name any more.
> > * r8a7743-iwg20d-q7.dts - its new purpose is to put together
> >   the SoM .dtsi (r8a7743-iwg20m.dtsi) and the carrier board
> >   .dtsi defined by this very patch, along with "model" and
> >   "compatible" properties.
> > The final DT architecture to describe the board is now:
> > r8a7743-iwg20d-q7.dts           # Carrier Board + SoM
> > ??? r8a7743-iwg20m.dtsi         # SoM
> > ?   ??? r8a7743.dtsi            # SoC
> > ??? iwg20d-q7-common.dtsi       # Carrier Board
> > and maximizes the reuse of the definitions for the carrier board
> > and for the SoM.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
>
> Thanks for your patch!
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
>
> > +&pfc {
> > +       i2c2_pins: i2c2 {
> > +               groups = "i2c2";
> > +               function = "i2c2";
> > +       };
> > +
> > +       scif0_pins: scif0 {
> > +               groups = "scif0_data_d";
> > +               function = "scif0";
> > +       };
> > +
> > +       avb_pins: avb {
> > +               groups = "avb_mdio", "avb_gmii";
> > +               function = "avb";
> > +       };
>
> Perhaps you want to use this opportunity to restore alphabetical sort order?

good idea

>
> > +&scif0 {
>
> [...]
>
> > +};
> > +
> > +&avb {
>
> Likewise.
>
> Can be a separate patch, though.

I'll send a V2 for this.

Thanks,
Fab

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
