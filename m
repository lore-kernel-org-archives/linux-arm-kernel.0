From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Mon, 4 Jul 2011 15:32:00 +0200
Subject: [PATCH] arm: mxs: add mmc-device for mach-tx28
In-Reply-To: <1309532041-24452-1-git-send-email-w.sang@pengutronix.de>
References: <1309532041-24452-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <19985.49360.840885.73657@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfram Sang writes:
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  arch/arm/mach-mxs/Kconfig     |    1 +
>  arch/arm/mach-mxs/mach-tx28.c |    6 ++++++
>  2 files changed, 7 insertions(+), 0 deletions(-)
> 
Acked-by: Lothar Wa?mann <LW@KARO-electronics.de>

> diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
> index f114960..73556f0 100644
> --- a/arch/arm/mach-mxs/Kconfig
> +++ b/arch/arm/mach-mxs/Kconfig
> @@ -59,6 +59,7 @@ config MODULE_TX28
>  	select MXS_HAVE_PLATFORM_AUART
>  	select MXS_HAVE_PLATFORM_FEC
>  	select MXS_HAVE_PLATFORM_MXS_I2C
> +	select MXS_HAVE_PLATFORM_MXS_MMC
>  	select MXS_HAVE_PLATFORM_MXS_PWM
>  
>  config MACH_TX28
> diff --git a/arch/arm/mach-mxs/mach-tx28.c b/arch/arm/mach-mxs/mach-tx28.c
> index b65e371..91a4b78 100644
> --- a/arch/arm/mach-mxs/mach-tx28.c
> +++ b/arch/arm/mach-mxs/mach-tx28.c
> @@ -147,6 +147,11 @@ static struct i2c_board_info tx28_stk5v3_i2c_boardinfo[] __initdata = {
>  	},
>  };
>  
> +static struct mxs_mmc_platform_data tx28_mmc0_pdata __initdata = {
> +       .wp_gpio = -EINVAL,
> +       .flags = SLOTF_4_BIT_CAPABLE,
> +};
> +
>  static void __init tx28_stk5v3_init(void)
>  {
>  	mxs_iomux_setup_multiple_pads(tx28_stk5v3_pads,
> @@ -164,6 +169,7 @@ static void __init tx28_stk5v3_init(void)
>  	mx28_add_mxs_i2c(0);
>  	i2c_register_board_info(0, tx28_stk5v3_i2c_boardinfo,
>  			ARRAY_SIZE(tx28_stk5v3_i2c_boardinfo));
> +	mx28_add_mxs_mmc(0, &tx28_mmc0_pdata);
>  }
>  
>  static void __init tx28_timer_init(void)
> -- 
> 1.7.5.3
> 
Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
