From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Thu, 19 Apr 2018 16:56:05 +0200
Subject: [linux-sunxi] [PATCH 5/9] media: platform: Add Sunxi Cedrus
 decoder driver
In-Reply-To: <a9cc2e3b-585a-b238-4187-e3c874013d2a@iki.fi>
References: <20180309100933.15922-3-paul.kocialkowski@bootlin.com>
 <20180309101445.16190-3-paul.kocialkowski@bootlin.com>
 <a9cc2e3b-585a-b238-4187-e3c874013d2a@iki.fi>
Message-ID: <e26c30b31aa8a5ae9692dc050b08d2bca85d4536.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 2018-03-12 at 20:29 +0000, Joonas Kylm?l? wrote:
> Paul Kocialkowski:
> > diff --git a/drivers/media/platform/sunxi-cedrus/sunxi_cedrus.c
> > b/drivers/media/platform/sunxi-cedrus/sunxi_cedrus.c
> > new file mode 100644
> > index 000000000000..88624035e0e3
> > --- /dev/null
> > +++ b/drivers/media/platform/sunxi-cedrus/sunxi_cedrus.c
> > @@ -0,0 +1,313 @@
> > +/*
> > + * Sunxi Cedrus codec driver
> > + *
> > + * Copyright (C) 2016 Florent Revest
> > + * Florent Revest <florent.revest@free-electrons.com>
> > + *
> > + * Based on vim2m
> > + *
> > + * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
> > + * Pawel Osciak, <pawel@osciak.com>
> > + * Marek Szyprowski, <m.szyprowski@samsung.com>
> > + *
> > + * This software is licensed under the terms of the GNU General
> > Public
> > + * License version 2, as published by the Free Software Foundation,
> > and
> > + * may be copied, distributed, and modified under those terms.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include "sunxi_cedrus_common.h"
> > +
> > +#include <linux/clk.h>
> > +#include <linux/module.h>
> > +#include <linux/delay.h>
> > +#include <linux/fs.h>
> > +#include <linux/sched.h>
> > +#include <linux/slab.h>
> > +#include <linux/of.h>
> > +
> > +#include <linux/platform_device.h>
> > +#include <linux/videodev2.h>
> > +#include <media/v4l2-mem2mem.h>
> > +#include <media/v4l2-device.h>
> > +#include <media/v4l2-ioctl.h>
> > +#include <media/v4l2-ctrls.h>
> > +#include <media/v4l2-event.h>
> > +#include <media/videobuf2-dma-contig.h>
> 
> I think that the definitions
> 
> #include <linux/clk.h>
> #include <linux/delay.h>
> #include <linux/fs.h>
> #include <linux/sched.h>
> #include <linux/slab.h>
> #include <linux/videodev2.h>
> 
> are not used directly in the sunxi_cedrus.c file. Therefore they
> should be removed.

Thanks for the review, this will be done in v2.

Cheers,

-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180419/4abafd13/attachment.sig>
