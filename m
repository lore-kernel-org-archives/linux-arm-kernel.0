From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 29 Jan 2016 08:30:42 +0100
Subject: [PATCH] pinctrl: nomadik: hide unused functions
In-Reply-To: <1453737557-1960171-1-git-send-email-arnd@arndb.de>
References: <1453737557-1960171-1-git-send-email-arnd@arndb.de>
Message-ID: <20160129073042.GL13664@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On Mon, Jan 25, 2016 at 04:59:09PM +0100, Arnd Bergmann wrote:
> The nomadik pinctrl driver has two functions that are only used
> for debugfs output and are otherwise unused:
> 
> drivers/pinctrl/nomadik/pinctrl-abx500.c:194:12: error: 'abx500_get_pull_updown' defined but not used
> drivers/pinctrl/nomadik/pinctrl-abx500.c:471:12: error: 'abx500_get_mode' defined but not used
> 
> This makes the function definitions conditional to avoid the
> harmless warnings.
> [...]
> +#ifdef CONFIG_DEBUG_FS
>  static int abx500_get_pull_updown(struct abx500_pinctrl *pct, int offset,
>  				  enum abx500_gpio_pull_updown *pull_updown)

an alternative is to mark the functions with __maybe_unused. I just
noticed that Documentation/CodingStyle even mandates to use that instead
of cpp stuff.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
