From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 22 Oct 2012 14:11:47 -0600
Subject: [PATCH] pinctrl: reserve pins when states are activated
In-Reply-To: <1350893718-12336-1-git-send-email-linus.walleij@stericsson.com>
References: <1350893718-12336-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <5085A883.9010803@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2012 02:15 AM, Linus Walleij wrote:
> This switches the way that pins are reserved for multiplexing:
> 
> We used to do this when the map was parsed, at the creation of
> the settings inside the pinctrl handle, in pinmux_map_to_setting().
> 
> However this does not work for us, because we want to use the
> same set of pins with different devices at different times: the

> diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c

>  void pinmux_free_setting(struct pinctrl_setting const *setting)
...
> +	/* This function is currently unused */

Being picky: It's not unused; it is used by pinctrl_put_locked(), but
just doesn't have to do anything given the implementation of
pinmux_map_to_setting().
