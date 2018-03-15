From: adrian.hunter@intel.com (Adrian Hunter)
Date: Thu, 15 Mar 2018 16:27:19 +0200
Subject: [PATCH v3 04/11] mmc: sdhci-omap: Invoke sdhci_get_of_property to
 read sdhci dt properties
In-Reply-To: <20180307132020.30951-5-kishon@ti.com>
References: <20180307132020.30951-1-kishon@ti.com>
 <20180307132020.30951-5-kishon@ti.com>
Message-ID: <e7c61727-0ff5-edb5-b3eb-679f07afbce6@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/18 15:20, Kishon Vijay Abraham I wrote:
> Invoke sdhci_get_of_property defined in sdhci-pltfm.c to read
> sdhci specific properties from dt node.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-omap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index fbc20a4fbb23..314dbe4d7412 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -893,6 +893,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>  	host->ioaddr += offset;
>  
>  	mmc = host->mmc;
> +	sdhci_get_of_property(pdev);
>  	ret = mmc_of_parse(mmc);
>  	if (ret)
>  		goto err_pltfm_free;
> 
