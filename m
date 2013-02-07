From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 06 Feb 2013 17:08:54 -0700
Subject: [PATCH 03/14] mfd: ab8500: ensure new AB8500 pinctrl driver is
 probed correctly
In-Reply-To: <1360093715-6348-4-git-send-email-linus.walleij@stericsson.com>
References: <1360093715-6348-1-git-send-email-linus.walleij@stericsson.com>
 <1360093715-6348-4-git-send-email-linus.walleij@stericsson.com>
Message-ID: <5112F096.7020001@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/2013 12:48 PM, Linus Walleij wrote:
> From: Lee Jones <lee.jones@linaro.org>
> 
> The old, BROKEN AB8500 GPIO driver has been revamped as a shiny
> new pinctrl driver and has been renamed as such. So, if we would
> like to make use of it, we need to register it via its new name.

> diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c

>  static struct mfd_cell ab8500_devs[] = {
>  	{
> -		.name = "ab8500-gpio",
> +		.name = "pinctrl-ab8500",
>  		.of_compatible = "stericsson,ab8500-gpio",
>  	},

I assume that the GPIO/pinctrl driver has already been renamed in some
unrelated patch, so this patch is just fixing it so it works again?

If I'm not understanding correctly, doesn't this patch break "git
bisect", since it's only renaming it in the MFD core and not in the
driver that this expects to instantiate?
