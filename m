From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 18 Oct 2012 17:33:24 -0600
Subject: [PATCH] pinctrl: reserve pins when states are activated
In-Reply-To: <1350554487-7914-1-git-send-email-linus.walleij@stericsson.com>
References: <1350554487-7914-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <508091C4.9080008@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2012 04:01 AM, Linus Walleij wrote:
> This switches the way that pins are reserved for multiplexing:

The conceptual change makes perfect sense to me.

> diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c

>  void pinmux_free_setting(struct pinctrl_setting const *setting)
...
> +	/*
> +	 * If a setting is active, disable it so that all pins are released
> +	 */
> +	pinmux_disable_setting(setting);

"*If* a setting is active ..." implies there should be a C if statement
here to check if the setting is actually active before trying to disable it?
