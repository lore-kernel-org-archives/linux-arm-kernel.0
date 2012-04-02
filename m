From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 02 Apr 2012 12:05:53 -0700
Subject: [PATCH] ARM: S3C64XX: Hook up new style regulator-regulator
 supplies on Cragganmore
In-Reply-To: <1333366519-7900-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1333366519-7900-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <4F79F891.7050106@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> The regulator API now allows supplies used by regulators to be specified
> as normal supplies - provide the hookup for that mechanism on Cragganmore.
> 
> Signed-off-by: Mark Brown<broonie@opensource.wolfsonmicro.com>
> ---
>   arch/arm/mach-s3c64xx/mach-crag6410.c |   18 ++++++++++++++++++
>   1 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
> index 02fd009..4ee0249 100644
> --- a/arch/arm/mach-s3c64xx/mach-crag6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
> @@ -306,6 +306,24 @@ static struct regulator_consumer_supply wallvdd_consumers[] = {
>   	REGULATOR_SUPPLY("SPKVDD2", "1-001a"),
>   	REGULATOR_SUPPLY("SPKVDDL", "1-001a"),
>   	REGULATOR_SUPPLY("SPKVDDR", "1-001a"),
> +
> +	REGULATOR_SUPPLY("DC1VDD", "0-0034"),
> +	REGULATOR_SUPPLY("DC2VDD", "0-0034"),
> +	REGULATOR_SUPPLY("DC3VDD", "0-0034"),
> +	REGULATOR_SUPPLY("LDO1VDD", "0-0034"),
> +	REGULATOR_SUPPLY("LDO2VDD", "0-0034"),
> +	REGULATOR_SUPPLY("LDO4VDD", "0-0034"),
> +	REGULATOR_SUPPLY("LDO5VDD", "0-0034"),
> +	REGULATOR_SUPPLY("LDO6VDD", "0-0034"),
> +	REGULATOR_SUPPLY("LDO7VDD", "0-0034"),
> +	REGULATOR_SUPPLY("LDO8VDD", "0-0034"),
> +	REGULATOR_SUPPLY("LDO9VDD", "0-0034"),
> +	REGULATOR_SUPPLY("LDO10VDD", "0-0034"),
> +	REGULATOR_SUPPLY("LDO11VDD", "0-0034"),
> +
> +	REGULATOR_SUPPLY("DC1VDD", "1-0034"),
> +	REGULATOR_SUPPLY("DC2VDD", "1-0034"),
> +	REGULATOR_SUPPLY("DC3VDD", "1-0034"),
>   };
> 
>   static struct regulator_init_data wallvdd_data = {

Looks ok to me, will apply.

Mark, is this needed for v3.4?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
