From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Thu, 19 Apr 2018 16:56:28 +0200
Subject: [linux-sunxi] [PATCH 5/9] media: platform: Add Sunxi Cedrus
 decoder driver
In-Reply-To: <a133f4f9-8b99-323f-5e57-c2c6966d3ecb@iki.fi>
References: <20180309100933.15922-3-paul.kocialkowski@bootlin.com>
 <20180309101445.16190-3-paul.kocialkowski@bootlin.com>
 <a133f4f9-8b99-323f-5e57-c2c6966d3ecb@iki.fi>
Message-ID: <79645e203d414109f885a8fc032588c27a0b8af9.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 2018-03-12 at 17:15 +0000, Joonas Kylm?l? wrote:
> Paul Kocialkowski:
> > diff --git a/drivers/media/platform/sunxi-cedrus/sunxi_cedrus_regs.h 
> > b/drivers/media/platform/sunxi-cedrus/sunxi_cedrus_regs.h
> > new file mode 100644
> > index 000000000000..7384daa94737
> > --- /dev/null
> > +++ b/drivers/media/platform/sunxi-cedrus/sunxi_cedrus_regs.h
> > @@ -0,0 +1,170 @@
> > +/*
> > + * Sunxi Cedrus codec driver
> > + *
> > + * Copyright (C) 2016 Florent Revest
> > + * Florent Revest <florent.revest@free-electrons.com>
> > + *
> > + * Based on Cedrus
> > + *
> > + * Copyright (c) 2013 Jens Kuske <jenskuske@gmail.com>
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
> > +#ifndef SUNXI_CEDRUS_REGS_H
> > +#define SUNXI_CEDRUS_REGS_H
> > +
> > +/*
> > + * For more information consult http://linux-sunxi.org/VE_Register_
> > guide
> > + */
> > +
> > +/* Special registers values */
> > +
> > +/* VE_CTRL:
> > + * The first 3 bits indicate the engine (0 for MPEG, 1 for H264, b
> > for AVC...)
> > + * The 16th and 17th bits indicate the memory type (3 for DDR3 32
> > bits)
> > + * The 20th bit is unknown but needed
> > + */
> > +#define VE_CTRL_MPEG		0x130000
> > +#define VE_CTRL_H264		0x130001
> > +#define VE_CTRL_AVC		0x13000b
> > +#define VE_CTRL_REINIT		0x130007
> > +
> > +/* VE_MPEG_CTRL:
> > + * The bit 3 (0x8) is used to enable IRQs
> > + * The other bits are unknown but needed
> > + */
> > +#define VE_MPEG_CTRL_MPEG2	0x800001b8
> > +#define VE_MPEG_CTRL_MPEG4	(0x80084118 | BIT(7))
> > +#define VE_MPEG_CTRL_MPEG4_P	(VE_MPEG_CTRL_MPEG4 | BIT(12))
> > +
> > +/* VE_MPEG_VLD_ADDR:
> > + * The bits 27 to 4 are used for the address
> > + * The bits 31 to 28 (0x7) are used to select the MPEG or JPEG
> > engine
> > + */
> > +#define VE_MPEG_VLD_ADDR_VAL(x)	((x & 0x0ffffff0) | (x >>
> > 28) | (0x7 << 28))
> > +
> > +/* VE_MPEG_TRIGGER:
> > + * The first three bits are used to trigger the engine
> > + * The bits 24 to 26 are used to select the input format (1 for
> > MPEG1, 2 for 
> 
> Trailing whitespace.

Will fix in v2, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180419/a03bf7b0/attachment-0001.sig>
