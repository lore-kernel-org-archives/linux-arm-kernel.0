From: david.lanzendoerfer@o2s.ch (David =?ISO-8859-1?Q?Lanzend=F6rfer?=)
Date: Wed, 20 Aug 2014 16:10:14 +0200
Subject: [PATCH] mmc: sunxi: Declare ERASE capability
In-Reply-To: <1408541960-14788-1-git-send-email-wens@csie.org>
References: <1408541960-14788-1-git-send-email-wens@csie.org>
Message-ID: <3728016.4j3Ljjy6eM@dizzy-6.o2s.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
> Declare ERASE capability so we can use filesystems with the discard
> option and the fstrim tool.
I totally agree with you that information about such capabilities should be
exposed but maybe it would be wiser to use DT instead of hardcoding it?
I mean a WiFi device won't support erase functionality...
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-October/068210.html

> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 024f67c..7bf5c1c 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -990,7 +990,8 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
> /* 400kHz ~ 50MHz */
>  	mmc->f_min		=   400000;
>  	mmc->f_max		= 50000000;
> -	mmc->caps	       |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED;
> +	mmc->caps	       |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
> +				  MMC_CAP_ERASE;
> 
>  	ret = mmc_of_parse(mmc);
>  	if (ret)

-- 
David Lanzend?rfer
OpenSourceSupport GmbH
System engineer and supporter
http://www.o2s.ch/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140820/f6b553d1/attachment.sig>
