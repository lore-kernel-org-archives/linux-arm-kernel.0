From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Tue, 10 Jan 2012 23:56:54 +0200
Subject: [PATCH 1/3] ATMEL: fix nand ecc support
In-Reply-To: <1325933370-17475-1-git-send-email-plagnioj@jcrosoft.com>
References: <1325933370-17475-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1326232616.2335.11.camel@koala>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2012-01-07 at 11:49 +0100, Jean-Christophe PLAGNIOL-VILLARD
wrote:
> +#ifndef __ATMEL_NAND_H__
> +#define __ATMEL_NAND_H__
> +
> +#include <linux/mtd/nand.h>
> +
> + /* NAND / SmartMedia */
> +struct atmel_nand_data {
> +	int		enable_pin;		/* chip enable */
> +	int		det_pin;		/* card detect */
> +	int		rdy_pin;		/* ready/busy */
> +	u8		rdy_pin_active_low;	/* rdy_pin value is inverted */
> +	u8		ale;			/* address line number connected to ALE */
> +	u8		cle;			/* address line number connected to CLE */
> +	u8		bus_width_16;		/* buswidth is 16 bit */
> +	u8		ecc_mode;		/* ecc mode */
> +	struct mtd_partition *parts;
> +	unsigned int	num_parts;
> +};
> +
> +#endif /* __ATMEL_NAND_H__ */

The "include/linux" directory, I think, should generally contain only
those headers which define some "userspace-kernel" or "kernel subsystem"
API. This file defines Atmel NAND driver's, so it should not be placed
there.

I am not sure "include/linux" is the best place for this header - is it?

Artem.
