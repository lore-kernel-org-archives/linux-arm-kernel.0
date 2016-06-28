From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 28 Jun 2016 10:30:24 +0200
Subject: [PATCH 1/3] mfd: add support for Allwinner SoCs ADC
In-Reply-To: <1467101897-15946-2-git-send-email-quentin.schulz@free-electrons.com>
References: <1467101897-15946-1-git-send-email-quentin.schulz@free-electrons.com>
 <1467101897-15946-2-git-send-email-quentin.schulz@free-electrons.com>
Message-ID: <20160628083024.GC4472@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Quentin!

A few comments bellow:

On Tue, Jun 28, 2016 at 10:18:15AM +0200, Quentin Schulz wrote:
>
> diff --git a/drivers/mfd/sunxi-gpadc-mfd.c b/drivers/mfd/sunxi-gpadc-mfd.c
> new file mode 100644
> index 0000000..710e297
> --- /dev/null
> +++ b/drivers/mfd/sunxi-gpadc-mfd.c
> @@ -0,0 +1,188 @@

You should add a license statement here.

> +#include <linux/interrupt.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/sunxi-gpadc-mfd.h>
> +#include <linux/mfd/core.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>

Headers are usually included in the alphabetical order.

[...]

> diff --git a/include/linux/mfd/sunxi-gpadc-mfd.h b/include/linux/mfd/sunxi-gpadc-mfd.h
> new file mode 100644
> index 0000000..341f8c3
> --- /dev/null
> +++ b/include/linux/mfd/sunxi-gpadc-mfd.h
> @@ -0,0 +1,14 @@

You should also add a license statement here.

> +#ifndef __SUNXI_GPADC_MFD__H__
> +#define __SUNXI_GPADC_MFD__H__
> +
> +#define TP_INT_FIFOC            0x10
> +#define TP_INT_FIFOS            0x14
> +
> +struct sunxi_gpadc_mfd_dev {
> +	void __iomem			*regs;
> +	struct device			*dev;
> +	struct regmap			*regmap;
> +	struct regmap_irq_chip_data	*regmap_irqc;
> +};
> +
> +#endif

Thanks!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160628/ba8b4749/attachment.sig>
