From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 10 Jul 2017 08:21:45 +0000
Subject: [PATCH v 1/2] ARM: dts: r8a7743: Add Ethernet AVB support
In-Reply-To: <CAMuHMdWsM_FBJ46=U69XptqpyC2cJYx_cqczaHBNq2nxZr68GQ@mail.gmail.com>
References: <1499433165-62475-1-git-send-email-biju.das@bp.renesas.com>
 <1499433165-62475-2-git-send-email-biju.das@bp.renesas.com>
 <CAMuHMdWsM_FBJ46=U69XptqpyC2cJYx_cqczaHBNq2nxZr68GQ@mail.gmail.com>
Message-ID: <KL1PR06MB1702CA5C697C50497F33E587B8A90@KL1PR06MB1702.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,
Thanks for the review.

> -----Original Message-----
> From: geert.uytterhoeven at gmail.com [mailto:geert.uytterhoeven at gmail.com]
> On Behalf Of Geert Uytterhoeven
> Sent: 10 July 2017 08:55
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: Rob Herring <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Russell King <linux@armlinux.org.uk>; Sergei
> Shtylyov <sergei.shtylyov@cogentembedded.com>; Simon Horman
> <horms@verge.net.au>; Magnus Damm <magnus.damm@gmail.com>; Chris
> Paterson <Chris.Paterson2@renesas.com>; devicetree at vger.kernel.org; Linux-
> Renesas <linux-renesas-soc@vger.kernel.org>; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v 1/2] ARM: dts: r8a7743: Add Ethernet AVB support
>
> Hi Biju,
>
> On Fri, Jul 7, 2017 at 3:12 PM, Biju Das <biju.das@bp.renesas.com> wrote:
> > Add Ethernet AVB support for r8a7743 SoC.
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
>
> With the minor nit below fixed:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> > --- a/arch/arm/boot/dts/r8a7743.dtsi
> > +++ b/arch/arm/boot/dts/r8a7743.dtsi
> > @@ -605,6 +605,19 @@
> >                         #size-cells = <0>;
> >                         status = "disabled";
> >                 };
> > +
> > +               avb: ethernet at e6800000 {
> > +                       compatible = "renesas,etheravb-r8a7743",
> > +                                    "renesas,etheravb-rcar-gen2";
> > +                       reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
> > +                       interrupts = <0 163 IRQ_TYPE_LEVEL_HIGH>;
>

OK. I will fix this.
> s/0/GIC_SPI/
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-
> m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
