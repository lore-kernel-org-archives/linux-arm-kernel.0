From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 Sep 2012 20:07:37 +0900
Subject: [PATCH 3/7] ARM: EXYNOS: Change MIPI-CSIS device regulator supply
 names
In-Reply-To: <1347879100-30150-3-git-send-email-s.nawrocki@samsung.com>
References: <1347878888-30001-1-git-send-email-s.nawrocki@samsung.com>
 <1347879100-30150-1-git-send-email-s.nawrocki@samsung.com>
 <1347879100-30150-3-git-send-email-s.nawrocki@samsung.com>
Message-ID: <050f01cd94c4$a59a5bf0$f0cf13d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> Rename MIPI-CSIS regulator supply names to match definitions in
> the driver after commit "s5p-csis: Change regulator supply names".
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
> ---
>  arch/arm/mach-exynos/mach-nuri.c           | 4 ++--
>  arch/arm/mach-exynos/mach-origen.c         | 4 ++--
>  arch/arm/mach-exynos/mach-universal_c210.c | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-
> nuri.c
> index da6e7ce..bfe6955 100644
> --- a/arch/arm/mach-exynos/mach-nuri.c
> +++ b/arch/arm/mach-exynos/mach-nuri.c
> @@ -378,10 +378,10 @@ static struct regulator_consumer_supply __initdata
> max8997_ldo1_[] = {
>  };
>  static struct regulator_consumer_supply __initdata max8997_ldo3_[] = {
>  	REGULATOR_SUPPLY("vusb_d", "s3c-hsotg"), /* USB */
> -	REGULATOR_SUPPLY("vdd11", "s5p-mipi-csis.0"), /* MIPI */
> +	REGULATOR_SUPPLY("vddcore", "s5p-mipi-csis.0"), /* MIPI */
>  };
>  static struct regulator_consumer_supply __initdata max8997_ldo4_[] = {
> -	REGULATOR_SUPPLY("vdd18", "s5p-mipi-csis.0"), /* MIPI */
> +	REGULATOR_SUPPLY("vddio", "s5p-mipi-csis.0"), /* MIPI */
>  };
>  static struct regulator_consumer_supply __initdata max8997_ldo5_[] = {
>  	REGULATOR_SUPPLY("vhsic", "modemctl"), /* MODEM */
> diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-
> exynos/mach-origen.c
> index 65ac45b..b58bbca 100644
> --- a/arch/arm/mach-exynos/mach-origen.c
> +++ b/arch/arm/mach-exynos/mach-origen.c
> @@ -96,12 +96,12 @@ static struct s3c2410_uartcfg origen_uartcfgs[]
> __initdata = {
>  };
> 
>  static struct regulator_consumer_supply __initdata ldo3_consumer[] = {
> -	REGULATOR_SUPPLY("vdd11", "s5p-mipi-csis.0"), /* MIPI */
> +	REGULATOR_SUPPLY("vddcore", "s5p-mipi-csis.0"), /* MIPI */
>  	REGULATOR_SUPPLY("vdd", "exynos4-hdmi"), /* HDMI */
>  	REGULATOR_SUPPLY("vdd_pll", "exynos4-hdmi"), /* HDMI */
>  };
>  static struct regulator_consumer_supply __initdata ldo6_consumer[] = {
> -	REGULATOR_SUPPLY("vdd18", "s5p-mipi-csis.0"), /* MIPI */
> +	REGULATOR_SUPPLY("vddio", "s5p-mipi-csis.0"), /* MIPI */
>  };
>  static struct regulator_consumer_supply __initdata ldo7_consumer[] = {
>  	REGULATOR_SUPPLY("avdd", "alc5625"), /* Realtek ALC5625 */
> diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-
> exynos/mach-universal_c210.c
> index 0b0a2d0..ac00757 100644
> --- a/arch/arm/mach-exynos/mach-universal_c210.c
> +++ b/arch/arm/mach-exynos/mach-universal_c210.c
> @@ -211,7 +211,7 @@ static struct regulator_consumer_supply
> lp3974_ldo3_consumer[] = {
>  	REGULATOR_SUPPLY("vusb_a", "s3c-hsotg"),
>  	REGULATOR_SUPPLY("vdd", "exynos4-hdmi"),
>  	REGULATOR_SUPPLY("vdd_pll", "exynos4-hdmi"),
> -	REGULATOR_SUPPLY("vdd11", "s5p-mipi-csis.0"),
> +	REGULATOR_SUPPLY("vddcore", "s5p-mipi-csis.0"),
>  };
> 
>  static struct regulator_init_data lp3974_ldo3_data = {
> @@ -275,7 +275,7 @@ static struct regulator_init_data lp3974_ldo6_data = {
>  };
> 
>  static struct regulator_consumer_supply lp3974_ldo7_consumer[] = {
> -	REGULATOR_SUPPLY("vdd18", "s5p-mipi-csis.0"),
> +	REGULATOR_SUPPLY("vddio", "s5p-mipi-csis.0"),
>  };
> 
>  static struct regulator_init_data lp3974_ldo7_data = {
> --
> 1.7.11.3
