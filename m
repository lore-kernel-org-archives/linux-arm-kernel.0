From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 20 Nov 2012 10:24:39 -0700
Subject: [PATCH] gpiolib: let gpiochip_add_pin_range() specify offset
In-Reply-To: <1353411953-27423-1-git-send-email-linus.walleij@stericsson.com>
References: <1353411953-27423-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <50ABBCD7.3000006@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2012 04:45 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Like with commit 3c739ad0df5eb41cd7adad879eda6aa09879eb76
> it is not always enough to specify all the pins of a gpio_chip
> from offset zero to be added to a pin map range, since the
> mapping from GPIO to pin controller may not be linear at all,
> but need to be broken into a few consecutive sub-ranges or
> 1-pin entries for complicated cases. The ranges may also be
> sparse.
> 
> This alters the signature of the function to accept offsets
> into both the GPIO-chip local pinspace and the pin controller
> local pinspace.

Reviewed-by: Stephen Warren <swarren@nvidia.com>

Although perhaps rename the new "offset" parameter to "gpio_base" or
"gpio_offset", just like the existing "pin_base" rather than
pin/base/offset?
