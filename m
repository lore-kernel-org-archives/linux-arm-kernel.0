From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 11 Jan 2012 00:49:28 +0000
Subject: [PATCH 1/3] ATMEL: fix nand ecc support
In-Reply-To: <1326232616.2335.11.camel@koala>
References: <1325933370-17475-1-git-send-email-plagnioj@jcrosoft.com>
 <1326232616.2335.11.camel@koala>
Message-ID: <20120111004928.GE3226@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2012 at 11:56:54PM +0200, Artem Bityutskiy wrote:
> On Sat, 2012-01-07 at 11:49 +0100, Jean-Christophe PLAGNIOL-VILLARD
> wrote:
> > +#ifndef __ATMEL_NAND_H__
> > +#define __ATMEL_NAND_H__
> > +
> > +#include <linux/mtd/nand.h>
> > +
> > + /* NAND / SmartMedia */
> > +struct atmel_nand_data {
> > +	int		enable_pin;		/* chip enable */
> > +	int		det_pin;		/* card detect */
> > +	int		rdy_pin;		/* ready/busy */
> > +	u8		rdy_pin_active_low;	/* rdy_pin value is inverted */
> > +	u8		ale;			/* address line number connected to ALE */
> > +	u8		cle;			/* address line number connected to CLE */
> > +	u8		bus_width_16;		/* buswidth is 16 bit */
> > +	u8		ecc_mode;		/* ecc mode */
> > +	struct mtd_partition *parts;
> > +	unsigned int	num_parts;
> > +};
> > +
> > +#endif /* __ATMEL_NAND_H__ */
> 
> The "include/linux" directory, I think, should generally contain only
> those headers which define some "userspace-kernel" or "kernel subsystem"
> API. This file defines Atmel NAND driver's, so it should not be placed
> there.
> 
> I am not sure "include/linux" is the best place for this header - is it?

If this is platform data, which it looks like to me then 
include/linux/platform_data would be a great home for it.

Jamie
