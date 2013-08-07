From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 7 Aug 2013 21:16:44 +0200
Subject: [PATCH v2] pinctrl: shut up a couple of pinctrl warnings
In-Reply-To: <20130728121300.GF24642@n2100.arm.linux.org.uk>
References: <20130727103811.GD24642@n2100.arm.linux.org.uk>
 <20130728121300.GF24642@n2100.arm.linux.org.uk>
Message-ID: <20130807191644.GK6104@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, Jul 28, 2013 at 01:13:00PM +0100, Russell King - ARM Linux wrote:
> diff --git a/drivers/pinctrl/pinconf.c b/drivers/pinctrl/pinconf.c
> index e875f21..d16ef87 100644
> --- a/drivers/pinctrl/pinconf.c
> +++ b/drivers/pinctrl/pinconf.c
> [...]
> @@ -450,14 +449,8 @@ static int pinconf_dbg_config_print(struct seq_file *s, void *d)
>  		for (j = 0; j < map->data.configs.num_configs; j++) {
>  			if (!strcmp(map->data.configs.group_or_pin,
>  					dbg->pin_name)) {
> -				/*
> -				 * We found the right pin / state, read the
> -				 * config and he pctldev for later use
he?

> -				 */
> -				configs = &map->data.configs;
> -				pctldev = get_pinctrl_dev_from_devname
> -					(map->ctrl_dev_name);
> -				found = true;
> +				/* We found the right pin / state */
> +				found = map;
>  				break;
>  			}
>  		}

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
