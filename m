From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 30 May 2011 10:23:23 -0700
Subject: [PATCH] ARM: SMDK6410: Convert to using REGULATOR_SUPPLY()
In-Reply-To: <1306196879-22017-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1306196879-22017-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <4DE3D28B.6080807@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/23/11 17:27, Mark Brown wrote:
> Signed-off-by: Mark Brown<broonie@opensource.wolfsonmicro.com>
> ---
>   arch/arm/mach-s3c64xx/mach-smdk6410.c |   26 ++++++--------------------
>   1 files changed, 6 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
> index b416294..8c318a3 100644
> --- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
> @@ -210,17 +210,9 @@ static struct platform_device smdk6410_smsc911x = {
>   };
>
>   #ifdef CONFIG_REGULATOR
> -static struct regulator_consumer_supply smdk6410_b_pwr_5v_consumers[] = {
> -	{
> -		/* WM8580 */
> -		.supply = "PVDD",
> -		.dev_name = "0-001b",
> -	},
> -	{
> -		/* WM8580 */
> -		.supply = "AVDD",
> -		.dev_name = "0-001b",
> -	},
> +static struct regulator_consumer_supply smdk6410_b_pwr_5v_consumers[] __initdata = {
> +	REGULATOR_SUPPLY("PVDD", "0-001b"),
> +	REGULATOR_SUPPLY("AVDD", "0-001b"),
>   };
>
>   static struct regulator_init_data smdk6410_b_pwr_5v_data = {
> @@ -345,9 +337,7 @@ static struct platform_device *smdk6410_devices[] __initdata = {
>   #ifdef CONFIG_REGULATOR
>   /* ARM core */
>   static struct regulator_consumer_supply smdk6410_vddarm_consumers[] = {
> -	{
> -		.supply = "vddarm",
> -	}
> +	REGULATOR_SUPPLY("vddarm", NULL),
>   };
>
>   /* VDDARM, BUCK1 on J5 */
> @@ -485,11 +475,7 @@ static struct regulator_init_data wm8350_dcdc3_data = {
>
>   /* USB, EXT, PCM, ADC/DAC, USB, MMC */
>   static struct regulator_consumer_supply wm8350_dcdc4_consumers[] = {
> -	{
> -		/* WM8580 */
> -		.supply = "DVDD",
> -		.dev_name = "0-001b",
> -	},
> +	REGULATOR_SUPPLY("DVDD", "0-001b"),
>   };
>
>   static struct regulator_init_data wm8350_dcdc4_data = {
> @@ -603,7 +589,7 @@ static struct regulator_init_data wm1192_dcdc3 = {
>   };
>
>   static struct regulator_consumer_supply wm1192_ldo1_consumers[] = {
> -	{ .supply = "DVDD", .dev_name = "0-001b", },   /* WM8580 */
> +	REGULATOR_SUPPLY("DVDD", "0-001b"),   /* WM8580 */
>   };
>
>   static struct regulator_init_data wm1192_ldo1 = {

Sorry for late response :(
Oops, I missed this...

Looks ok, will apply :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
