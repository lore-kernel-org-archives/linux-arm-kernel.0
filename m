From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 2 Apr 2012 11:10:49 +0200
Subject: [PATCH] ARM: mach-mx35_3ds: Fix build warning due to the lack of
 'const' annotation
In-Reply-To: <1332212998-6234-1-git-send-email-festevam@gmail.com>
References: <1332212998-6234-1-git-send-email-festevam@gmail.com>
Message-ID: <20120402091049.GQ3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 20, 2012 at 12:09:58AM -0300, Fabio Estevam wrote:
> Fix the following build warning:
> 
> arch/arm/mach-imx/mach-mx35_3ds.c: In function 'mx35_3ds_lcd_set_power':
> arch/arm/mach-imx/mach-mx35_3ds.c:112: warning: passing argument 2 of 'gpiochip_find' from incompatible pointer type
> include/asm-generic/gpio.h:145: note: expected 'int (*)(struct gpio_chip *, const void *)' but argument is of type 'int (*)(struct gpio_chip *, void *)'
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks

Sascha

> ---
>  arch/arm/mach-imx/mach-mx35_3ds.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
> index e14291d..6ae51c6 100644
> --- a/arch/arm/mach-imx/mach-mx35_3ds.c
> +++ b/arch/arm/mach-imx/mach-mx35_3ds.c
> @@ -97,7 +97,7 @@ static struct i2c_board_info __initdata i2c_devices_3ds[] = {
>  static int lcd_power_gpio = -ENXIO;
>  
>  static int mc9s08dz60_gpiochip_match(struct gpio_chip *chip,
> -						     void *data)
> +						     const void *data)
>  {
>  	return !strcmp(chip->label, data);
>  }
> -- 
> 1.7.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
