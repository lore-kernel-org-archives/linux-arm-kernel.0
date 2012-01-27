From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 27 Jan 2012 10:33:56 +0900
Subject: [PATCH] ARM: S3C64XX: Fix mismerge of Littemill device in
 Cragganmore
In-Reply-To: <1327439095-28151-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1327439095-28151-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <016701ccdc93$bc1e3020$345a9060$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> The -next s3c64xx tree appears to have acquired a duplicate copy of
> the commit adding Littlemill which is already in mainline causing two
> copies of the device definition to be in the code. Either the duplicate
> should be dropped or this commit should be applied on top of it to remove
> one of the duplicates.
> 

Mark, maybe the duplication commit has been fixed now -next. I can't find it
now. So I think, we can drop this. If any other problems, please kindly let
me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/mach-crag6410.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-
> s3c64xx/mach-crag6410.c
> index fe7f3be..d5a7982 100644
> --- a/arch/arm/mach-s3c64xx/mach-crag6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
> @@ -299,11 +299,6 @@ static struct platform_device littlemill_device = {
>  	.id		= -1,
>  };
> 
> -static struct platform_device littlemill_device = {
> -	.name		= "littlemill",
> -	.id		= -1,
> -};
> -
>  static struct regulator_consumer_supply wallvdd_consumers[] = {
>  	REGULATOR_SUPPLY("SPKVDD", "1-001a"),
>  	REGULATOR_SUPPLY("SPKVDD1", "1-001a"),
> --
> 1.7.9.rc1
