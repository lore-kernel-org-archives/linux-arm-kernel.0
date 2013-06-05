From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 05 Jun 2013 11:22:49 -0600
Subject: [PATCH 1/3] drivers: pinctrl sleep and idle states in the core
In-Reply-To: <1370439873-30053-1-git-send-email-linus.walleij@stericsson.com>
References: <1370439873-30053-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <51AF73E9.90506@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2013 07:44 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> If a device have sleep and idle states in addition to the
> default state, look up these in the core and stash them in
> the pinctrl state container.
> 
> Add accessor functions for pinctrl consumers to put the pins
> into "default", "sleep" and "idle" states passing nothing but
> the struct device * affected.
> 
> Solution suggested by Kevin Hilman, Mark Brown and Dmitry
> Torokhov in response to a patch series from Hebbar
> Gururaja.

> diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c

> +int pinctrl_pm_select_default_state(struct device *dev)

> +int pinctrl_pm_select_sleep_state(struct device *dev)

> +int pinctrl_pm_select_idle_state(struct device *dev)

The implementation of those 3 functions is basically identical. I'd be
inclined to move it to a helper function, and just pass (dev,
pins->xxx_state) to it.
