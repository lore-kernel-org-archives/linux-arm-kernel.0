From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 2 Feb 2011 16:47:51 +0100
Subject: [patch 5/5] mx51: add support for efika smartbook
In-Reply-To: <20110202112129.002921139@rtp-net.org>
References: <20110202112104.380352125@rtp-net.org>
	<20110202112129.002921139@rtp-net.org>
Message-ID: <20110202154751.GZ9041@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 02, 2011 at 12:21:09PM +0100, Arnaud Patard wrote:
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> Index: linux-2.6-submit/arch/arm/mach-mx5/board-mx51_efikasb.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6-submit/arch/arm/mach-mx5/board-mx51_efikasb.c	2011-02-02 12:10:03.000000000 +0100

[...]

> +
> +static int __init mx51_efikasb_power_init(void)
> +{
> +	pwgt1 = regulator_get(NULL, "pwgt1");
> +	pwgt2 = regulator_get(NULL, "pwgt2");
> +	if (!IS_ERR(pwgt1) && !IS_ERR(pwgt2)) {
> +		regulator_enable(pwgt1);
> +		regulator_enable(pwgt2);
> +	}
> +	gpio_request(EFIKASB_POWEROFF, "poweroff");
> +	pm_power_off = mx51_efikasb_power_off;
> +
> +	regulator_has_full_constraints();
> +
> +	return 0;
> +}
> +late_initcall(mx51_efikasb_power_init);

This also needs protection against other machines.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
