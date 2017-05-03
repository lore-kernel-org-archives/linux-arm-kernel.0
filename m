From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 3 May 2017 12:57:25 +0100
Subject: [PATCH v3 2/3] crypto: inside-secure: add SafeXcel EIP197 crypto
 engine driver
In-Reply-To: <20170424075407.19730-3-antoine.tenart@free-electrons.com>
References: <20170424075407.19730-1-antoine.tenart@free-electrons.com>
 <20170424075407.19730-3-antoine.tenart@free-electrons.com>
Message-ID: <6ed16e7e-7f7a-795f-ee82-d2d97c3a5540@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,

On 24/04/17 08:54, Antoine Tenart wrote:
> Add support for Inside Secure SafeXcel EIP197 cryptographic engine,
> which can be found on Marvell Armada 7k and 8k boards. This driver
> currently implements: ecb(aes), cbc(aes), sha1, sha224, sha256 and
> hmac(sah1) algorithms.
> 
> Two firmwares are needed for this engine to work. Their are mostly used
> for more advanced operations than the ones supported (as of now), but we
> still need them to pass the data to the internal cryptographic engine.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

[...]

> diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
> new file mode 100644
> index 000000000000..9cb3d0832835
> --- /dev/null
> +++ b/drivers/crypto/inside-secure/safexcel.c
> @@ -0,0 +1,925 @@
> +/*
> + * Copyright (C) 2017 Marvell
> + *
> + * Antoine Tenart <antoine.tenart@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/dmapool.h>
> +#include <linux/firmware.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/workqueue.h>
> +
> +#include <asm/dma-mapping.h>

<linux/dma-mapping.h> everywhere, please.

Other than that, the DMA aspects all look much nicer now, thanks.

Robin.
