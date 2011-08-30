From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 30 Aug 2011 14:45:16 +0200
Subject: [PATCH] ARM: mx53_ard: Add support for the accelerometer
In-Reply-To: <1314635906-18962-1-git-send-email-daiane.angolini@freescale.com>
References: <1314635906-18962-1-git-send-email-daiane.angolini@freescale.com>
Message-ID: <20110830124516.GR16557@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Aug 29, 2011 at 01:38:26PM -0300, Daiane Angolini wrote:
> mx53_ard has a MMA8451 accelerometer connected to i2c2.
> 
> Add support for it.
> 
> Signed-off-by: Daiane Angolini <daiane.angolini@freescale.com>
> ---
>  arch/arm/mach-mx5/board-mx53_ard.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/board-mx53_ard.c
> index ddc3015..b6dc812 100644
> --- a/arch/arm/mach-mx5/board-mx53_ard.c
> +++ b/arch/arm/mach-mx5/board-mx53_ard.c
> @@ -161,6 +161,12 @@ static const struct esdhc_platform_data mx53_ard_sd1_data __initconst = {
>  	.wp_gpio = ARD_SD1_WP,
>  };
>  
> +static struct i2c_board_info mx53ard_i2c_devices[] = {
> +	{
> +		I2C_BOARD_INFO("mma8450", 0x1C),
> +	},
> +};
Can you please name that mx53_ard_i2c2_devices? And I think it should be
possible to have it in .init.rodata (that is, mark it const and
__initconst).

Best regards
Uwe

> +
>  static struct imxi2c_platform_data mx53_ard_i2c2_data = {
>  	.bitrate = 50000,
>  };
> @@ -231,6 +237,8 @@ static void __init mx53_ard_board_init(void)
>  
>  	imx53_add_sdhci_esdhc_imx(0, &mx53_ard_sd1_data);
>  	imx53_add_imx2_wdt(0, NULL);
> +	i2c_register_board_info(2, mx53ard_i2c_devices,
> +				ARRAY_SIZE(mx53ard_i2c_devices));
>  	imx53_add_imx_i2c(1, &mx53_ard_i2c2_data);
>  	imx53_add_imx_i2c(2, &mx53_ard_i2c3_data);
>  	imx_add_gpio_keys(&ard_button_data);
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
