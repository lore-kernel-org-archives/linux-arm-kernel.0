From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 15 May 2015 09:46:06 +0200
Subject: [PATCH 4/8] clk: sunxi: codec clock support
In-Reply-To: <CAGb2v672-fdVi1iC=OTmYtY+rkzd95-KuVHZKAKA0peNvqBf2Q@mail.gmail.com>
References: <1430565879-28113-1-git-send-email-maxime.ripard@free-electrons.com>
 <1430565879-28113-5-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v672-fdVi1iC=OTmYtY+rkzd95-KuVHZKAKA0peNvqBf2Q@mail.gmail.com>
Message-ID: <20150515074606.GS4004@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 07:03:07PM +0800, Chen-Yu Tsai wrote:
> On Sat, May 2, 2015 at 7:24 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > From: Emilio L?pez <emilio@elopez.com.ar>
> >
> > The codec clock on sun4i, sun5i and sun7i is a simple gate with PLL2 as
> > parent. Add a driver for such a clock.
> >
> > Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/clk/sunxi/Makefile        |  1 +
> >  drivers/clk/sunxi/clk-a10-codec.c | 45 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 46 insertions(+)
> >  create mode 100644 drivers/clk/sunxi/clk-a10-codec.c
> >
> > diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
> > index eb36c38d4120..6fa845e13067 100644
> > --- a/drivers/clk/sunxi/Makefile
> > +++ b/drivers/clk/sunxi/Makefile
> > @@ -3,6 +3,7 @@
> >  #
> >
> >  obj-y += clk-sunxi.o clk-factors.o
> > +obj-y += clk-a10-codec.o
> >  obj-y += clk-a10-hosc.o
> >  obj-y += clk-a10-pll2.o
> >  obj-y += clk-a20-gmac.o
> > diff --git a/drivers/clk/sunxi/clk-a10-codec.c b/drivers/clk/sunxi/clk-a10-codec.c
> > new file mode 100644
> > index 000000000000..aaeccf8cde39
> > --- /dev/null
> > +++ b/drivers/clk/sunxi/clk-a10-codec.c
> > @@ -0,0 +1,45 @@
> > +/*
> > + * Copyright 2013 Emilio L?pez
> > + *
> > + * Emilio L?pez <emilio@elopez.com.ar>
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
> > +#include <linux/clk-provider.h>
> > +#include <linux/clkdev.h>
> 
> This one is not needed.

Right, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150515/664fcc84/attachment-0001.sig>
