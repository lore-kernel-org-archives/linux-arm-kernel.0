From: adrian.hunter@intel.com (Adrian Hunter)
Date: Thu, 15 Mar 2018 16:18:49 +0200
Subject: [PATCH v3 02/11] mmc: sdhci-omap: Remove setting ADMA capability
 in driver
In-Reply-To: <20180307132020.30951-3-kishon@ti.com>
References: <20180307132020.30951-1-kishon@ti.com>
 <20180307132020.30951-3-kishon@ti.com>
Message-ID: <a867eebf-2c32-4a0f-713a-766d81d52c4c@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/18 15:20, Kishon Vijay Abraham I wrote:
> sdhci can directly get ADMA capability from MMCHS_CAPA register.
> Remove explicitly setting ADMA here as some instances might not have
> ADMA enabled. (sdhci_read_caps() is also removed from here since
> sdhci_setup_host() invokes it).
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-omap.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 3cce30584d2f..0c40b13fb67d 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -923,9 +923,6 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>  	host->mmc_host_ops.card_busy = sdhci_omap_card_busy;
>  	host->mmc_host_ops.execute_tuning = sdhci_omap_execute_tuning;
>  
> -	sdhci_read_caps(host);
> -	host->caps |= SDHCI_CAN_DO_ADMA2;
> -
>  	ret = sdhci_setup_host(host);
>  	if (ret)
>  		goto err_put_sync;
> 
