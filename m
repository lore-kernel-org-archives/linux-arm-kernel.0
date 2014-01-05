From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 5 Jan 2014 20:30:07 +0100
Subject: [PATCH v4 1/4] ARM: BCM5301X: initial support for the
 BCM5301X/BCM470X SoCs with ARM CPU
In-Reply-To: <1388944697-19927-2-git-send-email-hauke@hauke-m.de>
References: <1388944697-19927-1-git-send-email-hauke@hauke-m.de>
 <1388944697-19927-2-git-send-email-hauke@hauke-m.de>
Message-ID: <201401052030.07765.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 05 January 2014, Hauke Mehrtens wrote:
> +static void __init bcm5301x_timer_init(void)
> +{
> +       of_clk_init(NULL);
> +       clocksource_of_init();
> +}
> +
> +static void __init bcm5301x_dt_init(void)
> +{
> +       l2x0_of_init(0, ~0UL);
> +       of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}

I'm pretty sure the first of these two functions is no longer needed,
and there were at least plans to make the second one optional as well.

Can you remove bcm5301x_timer_init() now?

	Arnd
