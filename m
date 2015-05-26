From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 26 May 2015 08:18:50 +0100
Subject: [PATCH 15/21] backlight: Probe backlight devices on demand
In-Reply-To: <1432565608-26036-16-git-send-email-tomeu.vizoso@collabora.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
 <1432565608-26036-16-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150526071850.GA11677@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 May 2015, Tomeu Vizoso wrote:

> When looking up a backlight device through its DT node, ensure that the
> corresponding device has been registered.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>  drivers/video/backlight/backlight.c | 3 +++
>  1 file changed, 3 insertions(+)

Looks reasonable.

Until anyone screams at me, applied thanks.

> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index bddc8b1..fe7833b 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -12,6 +12,7 @@
>  #include <linux/device.h>
>  #include <linux/backlight.h>
>  #include <linux/notifier.h>
> +#include <linux/of_platform.h>
>  #include <linux/ctype.h>
>  #include <linux/err.h>
>  #include <linux/fb.h>
> @@ -559,6 +560,8 @@ struct backlight_device *of_find_backlight_by_node(struct device_node *node)
>  {
>  	struct device *dev;
>  
> +	of_platform_device_ensure(node);
> +
>  	dev = class_find_device(backlight_class, NULL, node, of_parent_match);
>  
>  	return dev ? to_backlight_device(dev) : NULL;

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
