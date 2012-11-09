From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 09 Nov 2012 19:09:06 +0900
Subject: [PATCH v2] ARM: EXYNOS: origen: Add missing USB regulators
In-Reply-To: <11762974.EgWP4VdH3P@amdc1227>
References: <11762974.EgWP4VdH3P@amdc1227>
Message-ID: <0e8201cdbe62$409dfaa0$c1d9efe0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> This patch adds missing USB OTG regulators needed for s3c-hsotg driver
> to work on Origen board.
> 
> Confirmed with schematics of and tested on Origen board.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  arch/arm/mach-exynos/mach-origen.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-
> exynos/mach-origen.c
> index d8dc6d7..bf34704 100644
> --- a/arch/arm/mach-exynos/mach-origen.c
> +++ b/arch/arm/mach-exynos/mach-origen.c
> @@ -100,6 +100,7 @@ static struct regulator_consumer_supply __initdata
> ldo3_consumer[] = {
>  	REGULATOR_SUPPLY("vddcore", "s5p-mipi-csis.0"), /* MIPI */
>  	REGULATOR_SUPPLY("vdd", "exynos4-hdmi"), /* HDMI */
>  	REGULATOR_SUPPLY("vdd_pll", "exynos4-hdmi"), /* HDMI */
> +	REGULATOR_SUPPLY("vusb_a", "s3c-hsotg"), /* OTG */
>  };
>  static struct regulator_consumer_supply __initdata ldo6_consumer[] = {
>  	REGULATOR_SUPPLY("vddio", "s5p-mipi-csis.0"), /* MIPI */
> @@ -110,6 +111,7 @@ static struct regulator_consumer_supply __initdata
> ldo7_consumer[] = {
>  static struct regulator_consumer_supply __initdata ldo8_consumer[] = {
>  	REGULATOR_SUPPLY("vdd", "s5p-adc"), /* ADC */
>  	REGULATOR_SUPPLY("vdd_osc", "exynos4-hdmi"), /* HDMI */
> +	REGULATOR_SUPPLY("vusb_d", "s3c-hsotg"), /* OTG */
>  };
>  static struct regulator_consumer_supply __initdata ldo9_consumer[] = {
>  	REGULATOR_SUPPLY("dvdd", "swb-a31"), /* AR6003 WLAN & CSR 8810 BT
> */
> --
> 1.8.0

Applied, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
