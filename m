From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 6 Mar 2012 18:47:54 -0600
Subject: [PATCH 3/9] dmaengine: add private header file
In-Reply-To: <E1S52xe-0002Mn-Pn@rmk-PC.arm.linux.org.uk>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
 <E1S52xe-0002Mn-Pn@rmk-PC.arm.linux.org.uk>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41FF559AA@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 06, 2012 3:34 PM, Russell King wrote:
>
> Add a local private header file to contain definitions and declarations
> which should only be used by DMA engine drivers.
>
> We also fix linux/dmaengine.h to use LINUX_DMAENGINE_H to guard against
> multiple inclusion.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---

<snip>

>  drivers/dma/dmaengine.h     |   10 ++++++++++

<snip>

>  drivers/dma/ep93xx_dma.c    |    2 ++

<snip>

>  include/linux/dmaengine.h   |    4 ++--

<snip>

> diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
> new file mode 100644
> index 0000000..968570d
> --- /dev/null
> +++ b/drivers/dma/dmaengine.h
> @@ -0,0 +1,10 @@
> +/*
> + * The contents of this file are private to DMA engine drivers, and is not
> + * part of the API to be used by DMA engine users.
> + */
> +#ifndef DMAENGINE_H
> +#define DMAENGINE_H
> +
> +#include <linux/dmaengine.h>
> +
> +#endif

<snip>

> diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
> index bc45787..3260198 100644
> --- a/drivers/dma/ep93xx_dma.c
> +++ b/drivers/dma/ep93xx_dma.c
> @@ -28,6 +28,8 @@
>  
>  #include <mach/dma.h>
>  
> +#include "dmaengine.h"
> +
>  /* M2P registers */
>  #define M2P_CONTROL			0x0000
>  #define M2P_CONTROL_STALLINT		BIT(0)

<snip>

> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 41d0f92..4b17ca8 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -18,8 +18,8 @@
>   * The full GNU General Public License is included in this distribution in the
>   * file called COPYING.
>   */
> -#ifndef DMAENGINE_H
> -#define DMAENGINE_H
> +#ifndef LINUX_DMAENGINE_H
> +#define LINUX_DMAENGINE_H
>  
>  #include <linux/device.h>
>  #include <linux/uio.h>

For ep93xx:

Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
