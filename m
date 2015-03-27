From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 27 Mar 2015 10:21:44 +0100
Subject: [PATCH 4/6] clk: mediatek: Add basic clocks for Mediatek MT8135.
In-Reply-To: <20150327073950.GF18059@codeaurora.org>
References: <1426754530-3137-1-git-send-email-s.hauer@pengutronix.de>
 <1426754530-3137-5-git-send-email-s.hauer@pengutronix.de>
 <20150327073950.GF18059@codeaurora.org>
Message-ID: <20150327092144.GW9742@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 27, 2015 at 12:39:50AM -0700, Stephen Boyd wrote:
> On 03/19, Sascha Hauer wrote:
> > diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
> > new file mode 100644
> > index 0000000..a22f6fa
> > --- /dev/null
> > +++ b/drivers/clk/mediatek/clk-mt8135.c
> > @@ -0,0 +1,640 @@
> > +/*
> > + * Copyright (c) 2014 MediaTek Inc.
> > + * Author: James Liao <jamesjj.liao@mediatek.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/slab.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <dt-bindings/clock/mt8135-clk.h>
> > +
> > +#include "clk-mtk.h"
> > +#include "clk-gate.h"
> > +
> > +static DEFINE_SPINLOCK(lock);
> 
> Nitpick: 'lock' is very generic. Lockdep will use the variable
> name in its output, so it's wise to make locks have better names
> if possible. How about mt8135_lock?

I just renamed this to mt8135_clk_lock/mt8173_clk_lock and resent the
series.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
