From: adrian.hunter@intel.com (Adrian Hunter)
Date: Mon, 10 Apr 2017 15:39:43 +0300
Subject: [v3, 5/7] mmc: sdhci-of-esdhc: add delay between tuning cycles
In-Reply-To: <1490600982-5410-6-git-send-email-yangbo.lu@nxp.com>
References: <1490600982-5410-1-git-send-email-yangbo.lu@nxp.com>
 <1490600982-5410-6-git-send-email-yangbo.lu@nxp.com>
Message-ID: <6f4ebcff-7051-cc3a-98b5-16345c4f9e83@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/03/17 10:49, Yangbo Lu wrote:
> It's observed that eSDHC needed delay between tuning cycles for
> HS200 successful tuning. This patch is to set 1ms delay for that.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes for v2:
> 	- None
> Changes for v3:
> 	- Used a host member for tuning delay instead of a quirk.
> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 8c8e147..0754ef4 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -807,6 +807,7 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
>  	host->mmc_host_ops.start_signal_voltage_switch =
>  		esdhc_signal_voltage_switch;
>  	host->mmc_host_ops.execute_tuning = esdhc_execute_tuning;
> +	host->tuning_delay = 1;
>  
>  	esdhc_init(pdev, host);
>  
> 
