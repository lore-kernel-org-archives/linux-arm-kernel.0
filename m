From: poeschel@lemonage.de (Lars Poeschel)
Date: Fri, 11 Jan 2013 19:14:27 +0100
Subject: [PATCH v4,
 03/14] ARM: edma: add AM33XX support to the private EDMA API
In-Reply-To: <1357883330-5364-4-git-send-email-mporter@ti.com>
References: <1357883330-5364-4-git-send-email-mporter@ti.com>
Message-ID: <201301111914.27712.poeschel@lemonage.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matt,

On Friday 11 January 2013 at 06:48:39, Matt Porter wrote:

> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index a3d189d..1951d63 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -24,6 +24,13 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
> +#include <linux/edma.h>
> +#include <linux/err.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_dma.h>
> +#include <linux/of_irq.h>
> +#include <linux/pm_runtime.h>

You add the include linux/of_dma.h here, but maybe you missed to add the file 
itself. It is not in Linus v3.8-rc3 tree, not in the patches yours depend on 
listed and not in your patchset.

Regards,
Lars
