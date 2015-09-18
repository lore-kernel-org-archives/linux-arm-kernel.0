From: grinberg@compulab.co.il (Igor Grinberg)
Date: Fri, 18 Sep 2015 11:44:53 +0300
Subject: [PATCH] ARM: pxa: add wm9713 codec
In-Reply-To: <1442432561-32722-1-git-send-email-robert.jarzmik@free.fr>
References: <1442432561-32722-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <55FBCF05.2090707@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On 09/16/15 22:42, Robert Jarzmik wrote:
> The mioa701 is using the wm9713 for audio, battery and touchscreen. Add
> the missing audio part, which disappeared.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

The subject is a bit misleading..
I think it is worth specifying mioa701 in subject..

> ---
>  arch/arm/mach-pxa/mioa701.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
> index a7b392415a9e..d8e356d63471 100644
> --- a/arch/arm/mach-pxa/mioa701.c
> +++ b/arch/arm/mach-pxa/mioa701.c
> @@ -680,6 +680,7 @@ MIO_SIMPLE_DEV(mioa701_led,	  "leds-gpio",	    &gpio_led_info)
>  MIO_SIMPLE_DEV(pxa2xx_pcm,	  "pxa2xx-pcm",	    NULL)
>  MIO_SIMPLE_DEV(mioa701_sound,	  "mioa701-wm9713", NULL)
>  MIO_SIMPLE_DEV(mioa701_board,	  "mioa701-board",  NULL)
> +MIO_SIMPLE_DEV(wm9713_acodec,	  "wm9713-codec",   NULL);
>  MIO_SIMPLE_DEV(gpio_vbus,	  "gpio-vbus",      &gpio_vbus_data);
>  MIO_SIMPLE_DEV(mioa701_camera,	  "soc-camera-pdrv",&iclink);
>  
> @@ -687,6 +688,7 @@ static struct platform_device *devices[] __initdata = {
>  	&mioa701_gpio_keys,
>  	&mioa701_backlight,
>  	&mioa701_led,
> +	&wm9713_acodec,
>  	&pxa2xx_pcm,
>  	&mioa701_sound,
>  	&power_dev,
> 

-- 
Regards,
Igor.
