From: jbe@pengutronix.de (Juergen Beisert)
Date: Wed, 21 Oct 2009 11:29:25 +0200
Subject: [PATCH] ARM:S3C2440: MINI2440 Remove some improper __initdata
	qualifiers
In-Reply-To: <1256095984.1600.109.camel@shinel>
References: <1256095984.1600.109.camel@shinel>
Message-ID: <200910211129.26044.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mittwoch, 21. Oktober 2009, Shine Liu wrote:
>[...]
>> @@ -144,7 +144,7 @@ 
>  	.type		= (S3C2410_LCDCON1_TFT16BPP |\
>  			   S3C2410_LCDCON1_TFT)
>
> -struct s3c2410fb_display mini2440_lcd_cfg[] __initdata = {
> +struct s3c2410fb_display mini2440_lcd_cfg[] = {
>  	[0] = {	/* mini2440 + 3.5" TFT + touchscreen */
>  		_LCD_DECLARE(
>  			7,			/* The 3.5 is quite fast */
> @@ -191,7 +191,7 @@
>  #define S3C2410_GPCCON_MASK(x)	(3 << ((x) * 2))
>  #define S3C2410_GPDCON_MASK(x)	(3 << ((x) * 2))
>
> -struct s3c2410fb_mach_info mini2440_fb_info __initdata = {
> +struct s3c2410fb_mach_info mini2440_fb_info = {
>  	.displays	 = &mini2440_lcd_cfg[0], /* not constant! see init */
>  	.num_displays	 = 1,
>  	.default_display = 0,

But the other implementations in this directory are also using __initdata for 
these structures. Do they also need to remove the __initdata?

> [...]
> @@ -498,14 +498,14 @@
>  	.page_size	= 16,
>  };
>
> -static struct i2c_board_info mini2440_i2c_devs[] __initdata = {
> +static struct i2c_board_info mini2440_i2c_devs[] = {
>  	{
>  		I2C_BOARD_INFO("24c08", 0x50),
>  		.platform_data = &at24c08,
>  	},
>  };
>
> -static struct platform_device *mini2440_devices[] __initdata = {
> +static struct platform_device *mini2440_devices[] = {

You can keep this __initdata. mini2440_devices[] its used only once from a 
__init marked function.

jbe

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-8766-939 228     |
Vertretung Sued/Muenchen, Germany             | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
