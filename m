From: cjb@laptop.org (Chris Ball)
Date: Mon, 18 Oct 2010 17:13:55 +0100
Subject: [PATCH 5/6] mmc: sdhci-of-esdhc: factor out common stuff
In-Reply-To: <1287138064-21385-6-git-send-email-w.sang@pengutronix.de>
References: <1287138064-21385-1-git-send-email-w.sang@pengutronix.de>
	<1287138064-21385-6-git-send-email-w.sang@pengutronix.de>
Message-ID: <20101018161355.GA21088@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Fri, Oct 15, 2010 at 12:21:03PM +0200, Wolfram Sang wrote:
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index c8623de..277fcb9 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -18,23 +18,7 @@
>  #include <linux/mmc/host.h>
>  #include "sdhci-of.h"
>  #include "sdhci.h"
> -
> -/*
> - * Ops and quirks for the Freescale eSDHC controller.
> - */
> -
> -#define ESDHC_DMA_SYSCTL	0x40c
> -#define ESDHC_DMA_SNOOP		0x00000040
> -
> -#define ESDHC_SYSTEM_CONTROL	0x2c
> -#define ESDHC_CLOCK_MASK	0x0000fff0
> -#define ESDHC_PREDIV_SHIFT	8
> -#define ESDHC_DIVIDER_SHIFT	4
> -#define ESDHC_CLOCK_PEREN	0x00000004
> -#define ESDHC_CLOCK_HCKEN	0x00000002
> -#define ESDHC_CLOCK_IPGEN	0x00000001
> -
> -#define ESDHC_HOST_CONTROL_RES	0x05
> +#include "sdhci-esdhc.c"

Stephen reports a -next build failure after this patch.  Presumably this
should be sdhci-esdhc.h?  It's confusing that no-one else hit this.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
