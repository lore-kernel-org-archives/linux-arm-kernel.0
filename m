From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 28 Mar 2018 13:16:06 +0000
Subject: [PATCH 08/12] ARM: dts: r8a77470: Initial SoC device tree
In-Reply-To: <CAMuHMdVdRKpRXhd=0W3hVRt9MD0NVwBpoYa7dsZ+DAEn=sHD-A@mail.gmail.com>
References: <1522161443-54428-1-git-send-email-biju.das@bp.renesas.com>
 <1522161443-54428-9-git-send-email-biju.das@bp.renesas.com>
 <CAMuHMdVdRKpRXhd=0W3hVRt9MD0NVwBpoYa7dsZ+DAEn=sHD-A@mail.gmail.com>
Message-ID: <OSBPR01MB210391B03FC3FE0A8552547BB8A30@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Thanks for the feedback.

> On Tue, Mar 27, 2018 at 4:37 PM, Biju Das <biju.das@bp.renesas.com> wrote:
> > The initial R8A77470 SoC device tree including CPU0, GIC, timer, SYSC,
> > RST, CPG, and the required clock descriptions.
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/r8a77470.dtsi
> > @@ -0,0 +1,156 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Device Tree Source for the r8a77470 SoC
> > + *
> > + * Copyright (C) 2018 Renesas Electronics Corp.
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/clock/r8a7747x-cpg-mssr.h>
> > +#include <dt-bindings/power/r8a7747x-sysc.h>
>
> It is better to use numerical values for the initial submission, as the dt-bindings
> headers and the DTS files go upstream through different maintainer paths.
>
> > +/ {
> > +       compatible = "renesas,r8a77470";
>
> > +       soc {
>
> > +               icram2: sram at e6300000 {
> > +                       compatible = "mmio-sram";
> > +                       reg = <0 0xe6300000 0 0x40000>;
>
> Size should be 0x20000 (half of other members in the RZ/G1 family)?

Yes, you are correct. Will be fixed in V2.

> With the above fixed:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-
> m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But when
> I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
