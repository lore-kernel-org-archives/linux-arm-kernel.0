From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 31 Jan 2018 10:27:29 +0000
Subject: [RFC v3 10/25] dt-bindings: watchdog: renesas-wdt: Add R-Car Gen2
 support
In-Reply-To: <CAMuHMdXkHF9R0XfcG++s0RRup+Mdtam5p=FXw26z86wAOJhZfQ@mail.gmail.com>
References: <1517343778-27902-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517343778-27902-11-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdXkHF9R0XfcG++s0RRup+Mdtam5p=FXw26z86wAOJhZfQ@mail.gmail.com>
Message-ID: <TY1PR06MB089525525DC23EEAEAE97795C0FB0@TY1PR06MB0895.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

> Subject: Re: [RFC v3 10/25] dt-bindings: watchdog: renesas-wdt: Add R-Car Gen2 support
>
> Hi Fabrizio,
>
> On Tue, Jan 30, 2018 at 9:22 PM, Fabrizio Castro
> <fabrizio.castro@bp.renesas.com> wrote:
> > This commit documents the compatibility with R-Car Gen2 and RZ/G
> > devices by defining the generic compatible string "renesas,rcar-gen2-wdt".
> > Also, this patch expands the list of SoC-specific compatible strings to
> > include RZ/G and R-Car Gen2 devices.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
>
> Thanks for your patch!

Thanks for your feedback!

>
> > --- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> > +++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> > @@ -1,17 +1,25 @@
> >  Renesas Watchdog Timer (WDT) Controller
> >
> >  Required properties:
> > -- compatible : Should be "renesas,<soctype>-wdt", and
> > -              "renesas,rcar-gen3-wdt" or "renesas,rza-wdt" as fallback.
> > + - compatible : Must be "renesas,<soctype>-wdt", followed by a generic
> > +               fallback compatible string when compatible with the generic
> > +               version.
> >                Examples with soctypes are:
> > +                - "renesas,r8a7743-wdt" (RZ/G1M)
> > +                - "renesas,r8a7745-wdt" (RZ/G1E)
> > +                - "renesas,r8a7790-wdt" (R-Car H2)
> > +                - "renesas,r8a7791-wdt" (R-Car M2-W)
> > +                - "renesas,r8a7792-wdt" (R-Car V2H)
> > +                - "renesas,r8a7793-wdt" (R-Car M2-N)
> > +                - "renesas,r8a7794-wdt" (R-Car E2)
> >                  - "renesas,r8a7795-wdt" (R-Car H3)
> >                  - "renesas,r8a7796-wdt" (R-Car M3-W)
> >                  - "renesas,r8a77995-wdt" (R-Car D3)
> >                  - "renesas,r7s72100-wdt" (RZ/A1)
> > +               The generic compatible string must be:
> > +                - "renesas,rcar-gen2-wdt" for R-Car Gen2 and RZ/G
> > +                - "renesas,rcar-gen3-wdt" for R-Car Gen3
>
> You've lost the generic "renesas,rza-wdt".

Ooops, I'll fix that.

Cheers,
Fab

>
> With that fixed:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
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
