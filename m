From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 01 Dec 2011 16:30:28 +0900
Subject: [PATCH 2/2] mmc: sdhci-s3c: Add pm_caps into SD/MMC host
In-Reply-To: <1320685522-17481-3-git-send-email-sangwook.lee@linaro.org>
References: <1320685522-17481-1-git-send-email-sangwook.lee@linaro.org>
 <1320685522-17481-3-git-send-email-sangwook.lee@linaro.org>
Message-ID: <046001ccaffb$1988f580$4c9ae080$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sangwook Lee wrote:
> 
> sdhci-s3c updates pm_caps from platform data for SDIO PM.
> 
> Signed-off-by: Sangwook Lee <sangwook.lee@samsung.com>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Hi Chris,

Could you please pick this up in your tree for v3.3?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> ---
>  drivers/mmc/host/sdhci-s3c.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index fe886d6..f10dd52 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -518,6 +518,9 @@ static int __devinit sdhci_s3c_probe(struct
> platform_device *pdev)
>  	if (pdata->host_caps)
>  		host->mmc->caps |= pdata->host_caps;
> 
> +	if (pdata->pm_caps)
> +		host->mmc->pm_caps |= pdata->pm_caps;
> +
>  	host->quirks |= (SDHCI_QUIRK_32BIT_DMA_ADDR |
>  			 SDHCI_QUIRK_32BIT_DMA_SIZE);
> 
> --
> 1.7.4.1
