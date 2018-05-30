From: michel.pollet@bp.renesas.com (Michel Pollet)
Date: Wed, 30 May 2018 08:19:54 +0000
Subject: [PATCH v3 2/3] arm: shmobile: Add the R9A06G032 SMP enabler driver
In-Reply-To: <CAMuHMdWv2ZRbX=k5+H_WfAeoQ4QsyQLU9iQ9TJ9OQ0fmwg0GOQ@mail.gmail.com>
References: <1527157834-7747-1-git-send-email-michel.pollet@bp.renesas.com>
 <1527157834-7747-3-git-send-email-michel.pollet@bp.renesas.com>
 <CAMuHMdWv2ZRbX=k5+H_WfAeoQ4QsyQLU9iQ9TJ9OQ0fmwg0GOQ@mail.gmail.com>
Message-ID: <OSBPR01MB20546AE06422C9AD896F8F60D26C0@OSBPR01MB2054.jpnprd01.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 25 May 2018 10:49, Geert wrote:
> Subject: Re: [PATCH v3 2/3] arm: shmobile: Add the R9A06G032 SMP enabler
> driver
>
> Hi Michel,

Hi Geert,

>
> On Thu, May 24, 2018 at 12:30 PM, Michel Pollet
> <michel.pollet@bp.renesas.com> wrote:
> > The Renesas R9A06G032 second CA7 is parked in a ROM pen at boot time,
> > it requires a special enable method to get it started.
> >
> > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
>
> Thanks for your patch!
>
> >  arch/arm/mach-shmobile/smp-r9a06g032.c | 85
> > ++++++++++++++++++++++++++++++++++
>
> I think you can safely call this driver smp-rzn1d.c, or smp-rzn1.c.
> Source files are not covered by the stable DT ABI, and can be reordered later
> at will.
>
> I expect you will just add more CPU_METHOD_OF_DECLARE() lines later
> (perhaps with a little bit of extra code to handle deviations).

Now I am completely confused -- you had me remove the mention of rzn1
from everywhere it mattered to handle 'family' cases, and now you are
telling me that in *this* case where there is not a single chance of that file
covering another part and there's a clear cut case for it to be part specific
.... I should call it rzn1?!?

I even already renamed the symbols on my tree to match the
rest for v4...

I'd like consistency -- I *thought* I had a consistent naming scheme before,
now I've moved to your part specific one (under duress), I'd rather stick to
something that is consistent and keep everything as r9a06g032 now.

>
> > --- /dev/null
> > +++ b/arch/arm/mach-shmobile/smp-r9a06g032.c
> > @@ -0,0 +1,85 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * RZ/N1D Second CA7 enabler.
> > + *
> > + * Copyright (C) 2018 Renesas Electronics Europe Limited
> > + *
> > + * Michel Pollet <michel.pollet@bp.renesas.com>,
> <buserror@gmail.com>
> > + * Derived from action,s500-smp
> > + */
> > +
> > +#include <linux/delay.h>
>
> Do you need this?

Fixed all the other remarks, thanks for that!

Michel




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
