From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 10 Feb 2014 18:44:04 +0100
Subject: [PATCH 07/11] ARM: mvebu: add initial support for the Armada
 380/385 SOCs
In-Reply-To: <1392053002-19831-8-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392053002-19831-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1392053002-19831-8-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140210174404.GC9995@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas

> +config MACH_ARMADA_380

Should this maybe be MACH_ARMADA_38X. You have PINCTRL_ARMADA_38X, so
it seems a bit inconsistent.

> +
> +static void __init armada_380_timer_and_clk_init(void)
> +{
> +	of_clk_init(NULL);
> +	clocksource_of_init();
> +	BUG_ON(mvebu_mbus_dt_init());
> +	l2x0_of_init(0, ~0UL);
> +}
> +
> +static const char * const armada_380_dt_compat[] = {
> +	"marvell,armada380",
> +	"marvell,armada385",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(ARMADA_XP_DT, "Marvell Armada 380/385 (Device Tree)")
> +	.init_time	= armada_380_timer_and_clk_init,
> +	.restart	= mvebu_restart,
> +	.dt_compat	= armada_380_dt_compat,
> +MACHINE_END

This looks very similar to the 375 code. Could they be combined?

     Andrew
