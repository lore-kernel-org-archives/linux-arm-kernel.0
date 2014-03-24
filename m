From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Mon, 24 Mar 2014 13:29:27 +0900
Subject: [PATCH V2] mmc: dw_mmc: exynos: Turn SDIO interrupts on
In-Reply-To: <1395635037-24081-1-git-send-email-yuvaraj.cd@samsung.com>
References: <1395635037-24081-1-git-send-email-yuvaraj.cd@samsung.com>
Message-ID: <532FB4A7.7020700@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Yuvaraj.

NACK. we can use "mmc_of_parese()".

I have sent the patch that use "mmc_of_parse()".
https://patchwork.kernel.org/patch/3750681/

Best Regards,
Jaehoon Chung

On 03/24/2014 01:23 PM, Yuvaraj Kumar C D wrote:
> The mmc part in exynos supports SDIO interrupts and they work fine, so
> turn the capability on.  With this I see download speeds increase
> about 10x. 
> 	
> This V1 of this patch is posted to LKML at
> https://patchwork.kernel.org/patch/2429661/) by Doug Anderson.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 0c56faa..240949d 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2417,6 +2417,9 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>  	if (of_get_property(np, "cd-inverted", NULL))
>  		pdata->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
>  
> +	if (of_find_property(np, "cap-sdio-irq", NULL))
> +		pdata->caps |= MMC_CAP_SDIO_IRQ;
> +
>  	return pdata;
>  }
>  
> 
