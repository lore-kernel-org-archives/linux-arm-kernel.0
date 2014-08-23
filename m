From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 23 Aug 2014 16:11:23 +0200
Subject: [PATCH] mmc: sunxi: Declare ERASE capability
In-Reply-To: <1408541960-14788-1-git-send-email-wens@csie.org>
References: <1408541960-14788-1-git-send-email-wens@csie.org>
Message-ID: <53F8A10B.5090607@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/20/2014 03:39 PM, Chen-Yu Tsai wrote:
> Declare ERASE capability so we can use filesystems with the discard
> option and the fstrim tool.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Good one:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/mmc/host/sunxi-mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 024f67c..7bf5c1c 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -990,7 +990,8 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>  	/* 400kHz ~ 50MHz */
>  	mmc->f_min		=   400000;
>  	mmc->f_max		= 50000000;
> -	mmc->caps	       |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED;
> +	mmc->caps	       |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
> +				  MMC_CAP_ERASE;
>  
>  	ret = mmc_of_parse(mmc);
>  	if (ret)
> 
