From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 28 Nov 2012 08:31:43 +0900
Subject: [PATCH] ARM: S3C64XX: Add registration of WM2200 Bells device
 on Cragganmore
In-Reply-To: <1353944701-5129-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1353944701-5129-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <50B54D5F.3090502@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/12 00:45, Mark Brown wrote:
> Signed-off-by: Mark Brown<broonie@opensource.wolfsonmicro.com>
> ---
>   arch/arm/mach-s3c64xx/mach-crag6410.c |   10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
> index 2abe95d..c06bcfa 100644
> --- a/arch/arm/mach-s3c64xx/mach-crag6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
> @@ -287,16 +287,21 @@ static struct platform_device littlemill_device = {
>   	.id		= -1,
>   };
>
> -static struct platform_device bells_wm5102_device = {
> +static struct platform_device bells_wm2200_device = {
>   	.name		= "bells",
>   	.id		= 0,
>   };
>
> -static struct platform_device bells_wm5110_device = {
> +static struct platform_device bells_wm5102_device = {
>   	.name		= "bells",
>   	.id		= 1,
>   };
>
> +static struct platform_device bells_wm5110_device = {
> +	.name		= "bells",
> +	.id		= 2,
> +};
> +
>   static struct regulator_consumer_supply wallvdd_consumers[] = {
>   	REGULATOR_SUPPLY("SPKVDD", "1-001a"),
>   	REGULATOR_SUPPLY("SPKVDD1", "1-001a"),
> @@ -376,6 +381,7 @@ static struct platform_device *crag6410_devices[] __initdata = {
>   	&tobermory_device,
>   	&littlemill_device,
>   	&lowland_device,
> +	&bells_wm2200_device,
>   	&bells_wm5102_device,
>   	&bells_wm5110_device,
>   	&wallvdd_device,

Applied, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
