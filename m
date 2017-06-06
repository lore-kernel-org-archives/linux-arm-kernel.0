From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 6 Jun 2017 10:31:38 +0000
Subject: [PATCH 3/4] ARM: dts: iwg20m: Add iWave RZG1M Qseven SOM
In-Reply-To: <CAMuHMdV8Ugz_kvHLbV7sii-2v1WdHTSFm3meM8faVtx3jBpC+Q@mail.gmail.com>
References: <1496420523-23506-1-git-send-email-biju.das@bp.renesas.com>
 <1496420523-23506-4-git-send-email-biju.das@bp.renesas.com>
 <CAMuHMdV8Ugz_kvHLbV7sii-2v1WdHTSFm3meM8faVtx3jBpC+Q@mail.gmail.com>
Message-ID: <KL1PR06MB17024AD50F89CF891E16A367B8CB0@KL1PR06MB1702.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Fri, Jun 2, 2017 at 6:22 PM, Biju Das <biju.das@bp.renesas.com> wrote:
> > Add support for iWave RZG1M Qseven System On Module.
> > http://www.iwavesystems.com/rz-g1m-qseven-module.html
>
> Thanks for your patch!
>
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
>
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
> > @@ -0,0 +1,27 @@
> > +/*
> > + * Device Tree Source for the iWave-RZG1M-20M Qseven SOM
> > + *
> > + * Copyright (C) 2017 Renesas Electronics Corp.
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > +License
> > + * version 2.  This program is licensed "as is" without any warranty
> > +of any
> > + * kind, whether express or implied.
> > + */
> > +
> > +#include "r8a7743.dtsi"
> > +
> > +/ {
>
> Given this is a sub-board with many other components, I think it should have
> its own (documented) compatible value, e.g.
>
>     compatible = "iwave,g20m", "renesas,r8a7743";

Thanks for the input. I will document this system on module and apply the above change.

> > +       memory at 40000000 {
> > +               device_type = "memory";
> > +               reg = <0 0x40000000 0 0x20000000>;
> > +       };
> > +
> > +       memory at 200000000 {
> > +               device_type = "memory";
> > +               reg = <2 0x00000000 0 0x20000000>;
> > +       };
> > +};
>

[>]
Regards,
Biju



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
