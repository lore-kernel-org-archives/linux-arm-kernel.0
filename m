From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Tue, 21 Sep 2010 17:01:55 +0400
Subject: [PATCH 1/4] mmc: sdhci-pltfm: Add structure for host-specific data
In-Reply-To: <1285072210-10207-2-git-send-email-w.sang@pengutronix.de>
References: <1285072210-10207-1-git-send-email-w.sang@pengutronix.de>
	<1285072210-10207-2-git-send-email-w.sang@pengutronix.de>
Message-ID: <20100921130155.GA30150@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 21, 2010 at 02:30:07PM +0200, Wolfram Sang wrote:
> We need to carry some information per host, e.g. the clock. Add a
> structure for it and initialize it in the generic part.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
[...]
> diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
> index 900f329..c393289 100644
> --- a/drivers/mmc/host/sdhci-pltfm.h
> +++ b/drivers/mmc/host/sdhci-pltfm.h
> @@ -13,6 +13,11 @@
>  
>  #include <linux/sdhci-pltfm.h>
>  
> +struct sdhci_pltfm_host {
> +	struct clk *clk;

Forward decl for struct clk is needed.

> +	u32 scratchpad; /* to handle quirks across io-accessor calls */

#include <linux/types.h> is needed for u32.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
