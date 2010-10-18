From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 18 Oct 2010 19:50:23 +0900
Subject: [PATCH] ARM: S3C24XX: Fix nand partition table for s3c24XX
In-Reply-To: <1279495515-17265-1-git-send-email-sbkim73@samsung.com>
References: <1279495515-17265-1-git-send-email-sbkim73@samsung.com>
Message-ID: <048301cb6eb2$45e264d0$d1a72e70$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sangbeom Kim wrote:
> 
> From: Atul Dahiya <atul.dahiya@samsung.com>
> 
> This patch fixes the partition table as existing partition table have last
> partition size fixed and can't utilize available memory proprly if size is
> more than 64M.
> 
> Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> ---
>  arch/arm/plat-s3c24xx/common-smdk.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c24xx/common-smdk.c b/arch/arm/plat-
> s3c24xx/common-smdk.c
> index 7b44d0c..bcc43f3 100644
> --- a/arch/arm/plat-s3c24xx/common-smdk.c
> +++ b/arch/arm/plat-s3c24xx/common-smdk.c
> @@ -147,7 +147,7 @@ static struct mtd_partition smdk_default_nand_part[] =
{
>  	[7] = {
>  		.name	= "S3C2410 flash partition 7",
>  		.offset = SZ_1M * 48,
> -		.size	= SZ_16M,
> +		.size	= MTDPART_SIZ_FULL,
>  	}
>  };
> 
> --

Maybe missed this...will apply.

Ben, if any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
