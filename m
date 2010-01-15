From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 15 Jan 2010 01:16:49 +0000
Subject: [PATCH] ARM: MINI2440: Fix mini2440 crash on boot due to
	improper __initdata qualifier
In-Reply-To: <c7df016d1001140206j79bdc36ajda53e632a305107b@mail.gmail.com>
References: <c7df016d1001140206j79bdc36ajda53e632a305107b@mail.gmail.com>
Message-ID: <20100115011649.GT18532@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2010 at 12:06:32PM +0200, Uri Yosef wrote:
> From: Uri Yosef <uri.yosef@gmail.com>
> 
> This patch fix mini2440 crash on boot due to improper __initdata
> qualifier on mini2440_led1_pdata.

I've tried to apply this, but git-am is refusing to belive it is a valid
patch file. The only thing I can see wrong is that something has changed
the TABs in the mail into spaces. However having reduced it to a single
line change it is still refusing to apply.

Applying: ARM: MINI2440: Fix mini2440 crash on boot due to improper __initdata qualifier
error: patch failed: arch/arm/mach-s3c2440/mach-mini2440.c:402
error: arch/arm/mach-s3c2440/mach-mini2440.c: patch does not apply
Patch failed at 0001.

$ git apply -v yuri
Checking patch arch/arm/mach-s3c2440/mach-mini2440.c...
error: while searching for:
static struct s3c24xx_led_platdata mini2440_led1_pdata __initdata = {

error: patch failed: arch/arm/mach-s3c2440/mach-mini2440.c:402
error: arch/arm/mach-s3c2440/mach-mini2440.c: patch does not apply

seems to suggest something else got borked with the formatting.

Please sort this out and re-send.
 
> Signed-off-by: Uri Yosef <uri.yosef@gmail.com>
> ---
> 
> diff -ruN a/arch/arm/mach-s3c2440/mach-mini2440.c
> b/arch/arm/mach-s3c2440/mach-mini2440.c
> --- a/arch/arm/mach-s3c2440/mach-mini2440.c  2010-01-13 07:15:00.000000000 +0200
> +++ b/arch/arm/mach-s3c2440/mach-mini2440.c  2010-01-14 11:45:39.992255745 +0200
> @@ -399,35 +399,35 @@
> 
>  /* LEDS */
> 
> -static struct s3c24xx_led_platdata mini2440_led1_pdata __initdata = {
> +static struct s3c24xx_led_platdata mini2440_led1_pdata = {
>         .name           = "led1",
>         .gpio           = S3C2410_GPB(5),
>         .flags          = S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
>         .def_trigger    = "heartbeat",
>  };
> 
> -static struct s3c24xx_led_platdata mini2440_led2_pdata __initdata = {
> +static struct s3c24xx_led_platdata mini2440_led2_pdata = {
>         .name           = "led2",
>         .gpio           = S3C2410_GPB(6),
>         .flags          = S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
>         .def_trigger    = "nand-disk",
>  };
> 
> -static struct s3c24xx_led_platdata mini2440_led3_pdata __initdata = {
> +static struct s3c24xx_led_platdata mini2440_led3_pdata = {
>         .name           = "led3",
>         .gpio           = S3C2410_GPB(7),
>         .flags          = S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
>         .def_trigger    = "mmc0",
>  };
> 
> -static struct s3c24xx_led_platdata mini2440_led4_pdata __initdata = {
> +static struct s3c24xx_led_platdata mini2440_led4_pdata = {
>         .name           = "led4",
>         .gpio           = S3C2410_GPB(8),
>         .flags          = S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
>         .def_trigger    = "",
>  };
> 
> -static struct s3c24xx_led_platdata mini2440_led_backlight_pdata __initdata = {
> +static struct s3c24xx_led_platdata mini2440_led_backlight_pdata = {
>         .name           = "backlight",
>         .gpio           = S3C2410_GPG(4),
>         .def_trigger    = "backlight",
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
