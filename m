From: adrian.hunter@intel.com (Adrian Hunter)
Date: Tue, 10 May 2016 12:30:02 +0300
Subject: [PATCH 11/23] mmc: sdhci-esdhci-imx: remove
 SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
In-Reply-To: <1460741387-23815-12-git-send-email-aisheng.dong@nxp.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-12-git-send-email-aisheng.dong@nxp.com>
Message-ID: <5731AA1A.9000504@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/04/16 20:29, Dong Aisheng wrote:
> The driver has already implemented the private .set_timeout()
> callback for common SDHCI code to do correct timeout value setting,
> it does not need call sdhci_calc_timeout(), so this quirk actually
> is not working. Remove it now.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Pedantically, the subject needs:

	sdhci-esdhci-imx -> sdhci-esdhc-imx

Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 2d300d8..03980db 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1147,8 +1147,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  	if (IS_ERR(imx_data->pins_default))
>  		dev_warn(mmc_dev(host->mmc), "could not get default state\n");
>  
> -	host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> -
>  	if (imx_data->socdata->flags & ESDHC_FLAG_ENGCM07207)
>  		/* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */
>  		host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK
> 
