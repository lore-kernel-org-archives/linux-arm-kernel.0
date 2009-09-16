From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 16 Sep 2009 01:12:20 +0100
Subject: [PATCH 02/10] S3C64XX I2S: declared i2s_v4
In-Reply-To: <1253008954-10473-1-git-send-email-jassi.brar@samsung.com>
References: <1253008954-10473-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <20090916001220.GC24720@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 07:02:34PM +0900, Jassi wrote:
> For now, I2S-v4 is simply enumerated as third I2S controller of S3C6410
> rather than a special device.
> Also, Declared I2S-v4 device for SMDK6410.
> 
> Signed-Off-by: Jassi <jassi.brar@samsung.com>
> ---
>  arch/arm/mach-s3c6410/mach-smdk6410.c |    1 +
>  arch/arm/plat-s3c/dev-audio.c         |    6 ++++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c6410/mach-smdk6410.c b/arch/arm/mach-s3c6410/mach-smdk6410.c
> index bc9a7de..108ba37 100644
> --- a/arch/arm/mach-s3c6410/mach-smdk6410.c
> +++ b/arch/arm/mach-s3c6410/mach-smdk6410.c
> @@ -181,6 +181,7 @@ static struct platform_device *smdk6410_devices[] __initdata = {
>  #endif
>  	&s3c_device_i2c0,
>  	&s3c_device_i2c1,
> +	&s3c64xx_device_iisv4,
>  	&s3c_device_fb,
>  	&s3c_device_usb,
>  	&s3c_device_usb_hsotg,
> diff --git a/arch/arm/plat-s3c/dev-audio.c b/arch/arm/plat-s3c/dev-audio.c
> index 1322beb..28c030c 100644
> --- a/arch/arm/plat-s3c/dev-audio.c
> +++ b/arch/arm/plat-s3c/dev-audio.c
> @@ -51,6 +51,7 @@ struct platform_device s3c64xx_device_iis1 = {
>  };
>  EXPORT_SYMBOL(s3c64xx_device_iis1);
>  
> +#ifdef CONFIG_CPU_S3C6410
>  static struct resource s3c64xx_iisv4_resource[] = {
>  	[0] = {
>  		.start = S3C64XX_PA_IISV4,
> @@ -60,9 +61,10 @@ static struct resource s3c64xx_iisv4_resource[] = {
>  };
>  
>  struct platform_device s3c64xx_device_iisv4 = {
> -	.name		  = "s3c64xx-iis-v4",
> -	.id		  = -1,
> +	.name		  = "s3c64xx-iis",
> +	.id		  = 2,

I'd like to see how much different the two drivers are, and whether they
need to be seperated into their own modules.

Changing the name to s3c64xx-iis means that the module auto-load may end
up loading the wrong module. Holding off on this change until we se what
needs to be done for this block.

>  	.num_resources	  = ARRAY_SIZE(s3c64xx_iisv4_resource),
>  	.resource	  = s3c64xx_iisv4_resource,
>  };
>  EXPORT_SYMBOL(s3c64xx_device_iisv4);
> +#endif
> -- 
> 1.6.2.5
> 

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
