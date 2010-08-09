From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Mon, 09 Aug 2010 20:43:58 +0200
Subject: [PATCH 1/8] ARM i.MX dma: implement wrapper for dma functions
In-Reply-To: <1281344743-2029-2-git-send-email-s.hauer@pengutronix.de>
References: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
	<1281344743-2029-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <4C604C6E.3060706@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On 2010-08-09 11:05, Sascha Hauer wrote:
> Currently there is only one i.MX DMA implementation in the tree,
> the one for i.MX1/21/27. The SDMA support for i.MX25/31/35/51 can
> be implemented similarly. This wrapper for the DMA is implemented
> so that drivers do not have to care about the implementation
> present and don't have to #ifdef DMA support
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

> diff --git a/arch/arm/plat-mxc/dma.c b/arch/arm/plat-mxc/dma.c
> new file mode 100644
> index 0000000..1a241ab
> --- /dev/null
> +++ b/arch/arm/plat-mxc/dma.c
> @@ -0,0 +1,112 @@
> +


Remember to add Copyright+License information here!

> +#include <mach/dma.h>
> +
> +static struct imx_dma_operations *imx_dma_ops;
> +
> +static DEFINE_MUTEX(dma_mutex);
> +


Regards, Magnus
