From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 14 Aug 2017 14:26:08 +0000
Subject: [PATCH 1/2] ARM: dts: iwg20d-q7: Add RTC support
In-Reply-To: <CAMuHMdUU5fb6G7Wc9ZzfFhLxcUuZFakPdVGh3q_cfUzxZ1AarA@mail.gmail.com>
References: <1502197465-61546-1-git-send-email-biju.das@bp.renesas.com>
 <1502197465-61546-2-git-send-email-biju.das@bp.renesas.com>
 <CAMuHMdUU5fb6G7Wc9ZzfFhLxcUuZFakPdVGh3q_cfUzxZ1AarA@mail.gmail.com>
Message-ID: <KL1PR06MB1702571F2F9B75205A11280AB88C0@KL1PR06MB1702.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: geert.uytterhoeven at gmail.com [mailto:geert.uytterhoeven at gmail.com]
> On Behalf Of Geert Uytterhoeven
> Sent: 14 August 2017 15:12
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: Rob Herring <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Simon Horman <horms@verge.net.au>; Magnus
> Damm <magnus.damm@gmail.com>; Russell King <linux@armlinux.org.uk>;
> Chris Paterson <Chris.Paterson2@renesas.com>; devicetree at vger.kernel.org;
> Linux-Renesas <linux-renesas-soc@vger.kernel.org>; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH 1/2] ARM: dts: iwg20d-q7: Add RTC support
>
> On Tue, Aug 8, 2017 at 3:04 PM, Biju Das <biju.das@bp.renesas.com> wrote:
> > Define the iWave RainboW-G20D-Qseven board dependent part of the RTC
> > device node.
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
>
> > @@ -54,3 +59,16 @@
> >                 micrel,led-mode = <1>;
> >         };
> >  };
> > +
> > +&i2c2 {
> > +       pinctrl-0 = <&i2c2_pins>;
> > +       pinctrl-names = "default";
> > +
> > +       status = "okay";
> > +       clock-frequency = <400000>;
> > +
> > +       rtc at 68 {
> > +               compatible = "bq32000";
>
> "ti,bq32000"

Thanks. I will change this.

> > +               reg = <0x68>;
> > +       };
> > +};
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
