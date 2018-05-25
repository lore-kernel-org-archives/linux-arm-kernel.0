From: lsun@mellanox.com (Liming Sun)
Date: Fri, 25 May 2018 20:18:18 +0000
Subject: [PATCH v1 1/4] soc: Add TmFifo driver for Mellanox BlueField Soc
In-Reply-To: <8c2bfde9-5dd2-c1f9-a7f1-503c6eb8b0fe@arm.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <8c2bfde9-5dd2-c1f9-a7f1-503c6eb8b0fe@arm.com>
Message-ID: <AM2PR05MB0753C0BABE7A5B4C24614744A1690@AM2PR05MB0753.eurprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the comments! Uploaded patch series v2. 
Please also see response inline.

- Liming

> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy at arm.com]
> Sent: Friday, May 25, 2018 1:15 PM
> To: Liming Sun <lsun@mellanox.com>; Olof Johansson <olof@lixom.net>;
> Arnd Bergmann <arnd@arndb.de>; David Woods <dwoods@mellanox.com>
> Cc: devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v1 1/4] soc: Add TmFifo driver for Mellanox BlueField Soc
> 
> On 25/05/18 17:06, Liming Sun wrote:
> [...]
> > diff --git a/drivers/soc/mellanox/tmfifo.c b/drivers/soc/mellanox/tmfifo.c
> > new file mode 100644
> > index 0000000..a3303d1
> > --- /dev/null
> > +++ b/drivers/soc/mellanox/tmfifo.c
> > @@ -0,0 +1,1265 @@
> > +// SPDX-License-Identifier: GPL-2.0
> 
> This tag doesn't match the included license text...

Fixed in patch v2-1/4.

> 
> > +/*
> > + * Copyright (c) 2018, Mellanox Technologies. All rights reserved.
> > + *
> > + * This software is available to you under a choice of one of two
> > + * licenses.  You may choose to be licensed under the terms of the GNU
> > + * General Public License (GPL) Version 2, available from the file
> > + * COPYING in the main directory of this source tree, or the
> > + * OpenIB.org BSD license below:
> > + *
> > + *     Redistribution and use in source and binary forms, with or
> > + *     without modification, are permitted provided that the following
> > + *     conditions are met:
> > + *
> > + *      - Redistributions of source code must retain the above
> > + *        copyright notice, this list of conditions and the following
> > + *        disclaimer.
> > + *
> > + *      - Redistributions in binary form must reproduce the above
> > + *        copyright notice, this list of conditions and the following
> > + *        disclaimer in the documentation and/or other materials
> > + *        provided with the distribution.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> KIND,
> > + * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
> WARRANTIES OF
> > + * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> > + * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
> COPYRIGHT HOLDERS
> > + * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
> AN
> > + * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
> OR IN
> > + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
> IN THE
> > + * SOFTWARE.
> > + */
> 
> [...]
> > +/* Several utility macros to get/set the register fields. */
> > +#define TMFIFO_GET_FIELD(reg, field) \
> > +	(((reg) >> field##_SHIFT) & ((1UL << field##_WIDTH) - 1))
> > +
> > +#define TMFIFO_SET_FIELD(reg, field, value) ({ \
> > +	u64 _mask = ((1UL << field##_WIDTH) - 1) << field##_SHIFT; \
> > +	((reg) & ~_mask) | (((value) << field##_SHIFT) & _mask); \
> > +})
> 
> There's no need to reinvent <linux/bitfield.h>

Updated in patch v2-1/4.

> 
> [...]
> > +MODULE_DESCRIPTION("Mellanox BlueField SoC TMFIFO Driver");
> > +MODULE_AUTHOR("Mellanox Technologies, Ltd");
> > +MODULE_LICENSE("GPL");
> 
> ...and this implies yet another different license (since it indicates
> "GPLv2 or later")

Fixed in patch v2-1/4.

> 
> > +MODULE_VERSION("0.7");
> > diff --git a/drivers/soc/mellanox/tmfifo_regs.h
> b/drivers/soc/mellanox/tmfifo_regs.h
> > new file mode 100644
> > index 0000000..b07f353
> > --- /dev/null
> > +++ b/drivers/soc/mellanox/tmfifo_regs.h
> > @@ -0,0 +1,112 @@
> > +// SPDX-License-Identifier: GPL-2.0
> 
> Again, this doesn't match the included text. Also, the SPDX comment
> style is /* */ for headers.

Updated in patch v2-1/4.

> 
> > +/*
> > + * Copyright (c) 2018, Mellanox Technologies. All rights reserved.
> > + *
> > + * This software is available to you under a choice of one of two
> > + * licenses.  You may choose to be licensed under the terms of the GNU
> > + * General Public License (GPL) Version 2, available from the file
> > + * COPYING in the main directory of this source tree, or the
> > + * OpenIB.org BSD license below:
> > + *
> > + *     Redistribution and use in source and binary forms, with or
> > + *     without modification, are permitted provided that the following
> > + *     conditions are met:
> > + *
> > + *      - Redistributions of source code must retain the above
> > + *        copyright notice, this list of conditions and the following
> > + *        disclaimer.
> > + *
> > + *      - Redistributions in binary form must reproduce the above
> > + *        copyright notice, this list of conditions and the following
> > + *        disclaimer in the documentation and/or other materials
> > + *        provided with the distribution.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> KIND,
> > + * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
> WARRANTIES OF
> > + * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> > + * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
> COPYRIGHT HOLDERS
> > + * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
> AN
> > + * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
> OR IN
> > + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
> IN THE
> > + * SOFTWARE.
> > + */
> 
> [...]
> > +#ifdef __ASSEMBLER__
> > +#define _64bit(x) x
> > +#else /* __ASSEMBLER__ */
> > +#ifdef __tile__
> > +#define _64bit(x) x ## UL
> > +#else /* __tile__ */
> > +#define _64bit(x) x ## ULL
> > +#endif /* __tile__ */
> > +#endif /* __ASSEMBLER */
> > +
> > +#ifdef __KERNEL__
> > +#include <linux/types.h>
> > +#else
> > +#include <stdint.h>
> > +#endif
> > +
> > +#ifndef __DOXYGEN__
> 
> Given that this is a private header under drivers/, is any of that lot
> necessary?

Simplified and updated it in patch v2-1/4.

> 
> Robin.
