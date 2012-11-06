From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 06 Nov 2012 14:37:16 -0700
Subject: [PATCH 5/5] gpiolib: separation of pin concerns
In-Reply-To: <1352215028-30381-1-git-send-email-linus.walleij@stericsson.com>
References: <1352215028-30381-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <5099830C.4010703@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2012 08:17 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The fact that of_gpiochip_add_pin_range() and
> gpiochip_add_pin_range() share too much code is fragile and
> will invariably mean that bugs need to be fixed in two places
> instead of one.
> 
> So separate the concerns of gpiolib.c and gpiolib-of.c and
> have the latter call the former as back-end. This is necessary
> also when going forward with other device descriptions such
> as ACPI.

> diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c

> @@ -115,7 +114,6 @@ struct pinctrl_dev *of_pinctrl_add_gpio_range(struct device_node *np,
>  	if (!pctldev)
>  		return NULL;
>  
> -	pinctrl_add_gpio_range(pctldev, range);
>  	return pctldev;
>  }

I think that collapses to just:

	return pctldev;

Aside from that, the series,

Reviewed-by: Stephen Warren <swarren@nvidia.com>
