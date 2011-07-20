From: lrg@ti.com (Liam Girdwood)
Date: Wed, 20 Jul 2011 17:21:16 +0100
Subject: [PATCH v4 02/10] ASoc: mxs: add mxs-saif driver
In-Reply-To: <1311133306-9496-3-git-send-email-b29396@freescale.com>
References: <1311133306-9496-1-git-send-email-b29396@freescale.com>
	<1311133306-9496-3-git-send-email-b29396@freescale.com>
Message-ID: <4E27007C.6090805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/07/11 04:41, Dong Aisheng wrote:
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Tested-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  sound/soc/mxs/mxs-saif.c |  677 ++++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/mxs/mxs-saif.h |  130 +++++++++
>  2 files changed, 807 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
> new file mode 100644
> index 0000000..0b3adae
> --- /dev/null
> +++ b/sound/soc/mxs/mxs-saif.c
> @@ -0,0 +1,677 @@
> +/*
> + * Copyright 2011 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <mach/dma.h>
> +#include <asm/mach-types.h>
> +#include <mach/hardware.h>
> +#include <mach/mxs.h>
> +
> +#include "mxs-saif.h"
> +
> +static struct mxs_saif *mxs_saif[2];
> +

Is there any reason why this struct cant be part of your DAI private data ?

Thanks

Liam
