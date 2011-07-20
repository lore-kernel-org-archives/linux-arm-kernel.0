From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 21 Jul 2011 01:35:25 +0900
Subject: [PATCH] ARM: S3C64XX: Configure backup battery charger on
	Cragganmore
In-Reply-To: <1311179228-9981-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1311179228-9981-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <06c301cc46fb$099977d0$1ccc6770$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/mach-crag6410.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-
> s3c64xx/mach-crag6410.c
> index 3ba6e93..5995c77 100644
> --- a/arch/arm/mach-s3c64xx/mach-crag6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
> @@ -497,6 +497,12 @@ static struct regulator_init_data vddalive __initdata
= {
>  	.supply_regulator = "WALLVDD",
>  };
> 
> +static struct wm831x_backup_pdata banff_backup_pdata __initdata = {
> +	.charger_enable = 1,
> +	.vlim = 2500,  /* mV */
> +	.ilim = 200,   /* uA */
> +};
> +
>  static struct wm831x_status_pdata banff_red_led __initdata = {
>  	.name = "banff:red:",
>  	.default_src = WM831X_STATUS_MANUAL,
> @@ -517,6 +523,8 @@ static struct wm831x_pdata crag_pmic_pdata __initdata
=
> {
>  	.irq_base = BANFF_PMIC_IRQ_BASE,
>  	.gpio_base = GPIO_BOARD_START + 8,
> 
> +	.backup = &banff_backup_pdata,
> +
>  	.gpio_defaults = {
>  		/* GPIO11: Touchscreen data - CMOS, DBVDD, active high*/
>  		[10] = WM831X_GPN_POL | WM831X_GPN_ENA | 0x6,
> --
> 1.7.5.4

Applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
