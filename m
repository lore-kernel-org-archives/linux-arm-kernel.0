From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Mar 2013 14:53:53 -0600
Subject: [PATCH] pinctrl: document the "GPIO mode" pitfall
In-Reply-To: <1363345636-2006-1-git-send-email-linus.walleij@stericsson.com>
References: <1363345636-2006-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <51438A61.2050704@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/15/2013 05:07 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Recently as adoption of the pinctrl framework is reaching
> niches where the pins are reconfigured during system sleep
> and datasheets often talk about something called "GPIO mode",
> some engineers become confused by this, thinking that since
> it is named "GPIO (something something)" it must be modeled
> in the kernel using <linux/gpio.h>.

> +static struct pinctrl_map __initdata pinmap[] = {
> +    PIN_MAP_MUX_GROUP("uart", PINCTRL_STATE_DEFAULT", "pinctrl-foo",

Extra trailing " after PINCTRL_STATE_DEFAULT there.

Otherwise, this sounds plausible, so,
Reviewed-by: Stephen Warren <swarren@nvidia.com>
