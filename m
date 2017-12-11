From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Mon, 11 Dec 2017 21:04:56 +0900
Subject: [PATCH net-next v5 2/2] net: ethernet: socionext: add AVE
 ethernet driver
In-Reply-To: <CAOFm3uELNTgenR91-QGL1QQ08zA0N0rQbH4hzCzFKtRw6TckLw@mail.gmail.com>
References: <1512979049-15930-3-git-send-email-hayashi.kunihiko@socionext.com>
 <CAOFm3uELNTgenR91-QGL1QQ08zA0N0rQbH4hzCzFKtRw6TckLw@mail.gmail.com>
Message-ID: <20171211210455.170A.4A936039@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Dec 2017 10:19:15 +0100 Phlippe Ombredanne <pombredanne@nexb.com> wrote:

> Dear Kunihiko-san,
> 
> On Mon, Dec 11, 2017 at 8:57 AM, Kunihiko Hayashi
> <hayashi.kunihiko@socionext.com> wrote:
> > The UniPhier platform from Socionext provides the AVE ethernet
> > controller that includes MAC and MDIO bus supporting RGMII/RMII
> > modes. The controller is named AVE.
> >
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> [...]
> > --- /dev/null
> > +++ b/drivers/net/ethernet/socionext/Makefile
> > @@ -0,0 +1,5 @@
> > +# SPDX-License-Identifier: GPL-2.0
> 
> You are correctly using SPDX ids here....
> 
> > +obj-$(CONFIG_SNI_AVE) += sni_ave.o
> > diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
> > new file mode 100644
> > index 0000000..7b293c2
> > --- /dev/null
> > +++ b/drivers/net/ethernet/socionext/sni_ave.c
> > @@ -0,0 +1,1744 @@
> > +/**
> > + * sni_ave.c - Socionext UniPhier AVE ethernet driver
> > + *
> > + * Copyright 2014 Panasonic Corporation
> > + * Copyright 2015-2017 Socionext Inc.
> > + *
> > + * This program is free software: you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2  of
> > + * the License as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> 
> ... then I guess you could also use them here, replacing at least 7
> lines of boilerplate by a single id line?
> 
> > +// SDPX-License-Identifier: GPL-2.0

Thank you for your kindly comment.

It seems there are few ethernet drivers applying SPDX-License-Identifier
to C source, then it has been difficult for me to decide whether to replace
boilerplate.

If it's no problem to apply SPDX to sources of ethernet drivers,
I'll replace it with the single line.

> And if you go C++ style all the way, this could be even more compact:
> 
> > +// SDPX-License-Identifier: GPL-2.0
> > +// sni_ave.c - Socionext UniPhier AVE ethernet driver
> > +// Copyright 2014 Panasonic Corporation
> > +// Copyright 2015-2017 Socionext Inc.

It's much simpler.
If it's reasonable to apply this style here, I can replace it, too.

Thank you,

---
Best Regards,
Kunihiko Hayashi
