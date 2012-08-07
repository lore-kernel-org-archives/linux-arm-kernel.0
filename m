From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 07 Aug 2012 14:26:18 -0600
Subject: [PATCH] pinctrl/nomadik: add ASIC DB8450 pinctrl driver
In-Reply-To: <1344341538-32223-1-git-send-email-linus.walleij@stericsson.com>
References: <1344341538-32223-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <502179EA.30301@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/2012 06:12 AM, Linus Walleij wrote:
> From: Patrice Chotard <patrice.chotard@stericsson.com>
> 
> This implements a subdriver for the DB8540 ASIC for the
> Nomadik pin controller.

> diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c

> @@ -1722,6 +1722,8 @@ static int __devinit nmk_pinctrl_probe(struct platform_device *pdev)
>  	/* Poke in other ASIC variants here */
>  	if (version == PINCTRL_NMK_DB8500)
>  		nmk_pinctrl_db8500_init(&npct->soc);
> +	if (platid->driver_data == PINCTRL_NMK_DB8540)
> +		nmk_pinctrl_db8540_init(&npct->soc);

I'm surprised one of those checks "version" and the other
"platid->driver_data".

Aside from that, this looks fine.
