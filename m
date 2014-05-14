From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 14 May 2014 09:00:38 +0200
Subject: [PATCH v3 4/6] arm: add basic support for Mediatek MT6589 boards
In-Reply-To: <20140513224732.GJ20486@codeaurora.org>
References: <1399938570-11356-1-git-send-email-matthias.bgg@gmail.com>
 <1399938570-11356-5-git-send-email-matthias.bgg@gmail.com>
 <20140513224732.GJ20486@codeaurora.org>
Message-ID: <20140514070038.GG29258@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Tue, May 13, 2014 at 03:47:32PM -0700, Stephen Boyd wrote:
> On 05/13, Matthias Brugger wrote:
> > diff --git a/arch/arm/mach-mediatek/mediatek.c b/arch/arm/mach-mediatek/mediatek.c
> > new file mode 100644
> > index 0000000..73dfb05
> > --- /dev/null
> > +++ b/arch/arm/mach-mediatek/mediatek.c
> > @@ -0,0 +1,32 @@
> > +/*
> > + * Device Tree support for Mediatek SoCs
> > + *
> > + * Copyright (c) 2014 MundoReader S.L.
> > + * Author: Matthias Brugger <matthias.bgg@gmail.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/irqchip.h>
> > +#include <asm/mach/arch.h>
> > +#include <asm/mach/map.h>
> > +
> > +static const char * const mediatek_board_dt_compat[] = {
> 
> __initconst?
> 
> > +	"mediatek,mt6589",
> > +	NULL,
> > +};
> > +
> > +DT_MACHINE_START(MEDIATEK_DT, "Mediatek Cortex-A7 (Device Tree)")
> > +	.dt_compat	= mediatek_board_dt_compat,
> > +MACHINE_END
> 
> You shouldn't need this file at all if the platform is part of
> the multi-platform kernel.

>From a technical point of view, you don't. But it's interesting to
keep it mostly for two things:
  - You get to see the platform name in /proc/cpuinfo
  - If you ever need to add platform quirks, it's already there

We had a similar discussion two weeks ago for mach-sunxi with Olof and
Arnd, and ended up keeping this minimal machine.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140514/ff66f4e5/attachment.sig>
